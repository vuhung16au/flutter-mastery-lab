#!/usr/bin/env bash

set -euo pipefail

# Secrets/Sensitive info scanner for the repo
# - Scans for common secret patterns (API keys, tokens, passwords, private keys)
# - Flags sensitive filenames likely to be committed
# - Respects .gitignore for "will be committed" checks
# Output: security_scan_results.txt at repo root

ROOT_DIR="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
REPORT_FILE="$ROOT_DIR/security_scan_results.txt"

cd "$ROOT_DIR"

echo "Running secrets scan in: $ROOT_DIR" | tee "$REPORT_FILE"
echo "Generated: $(date -u)" | tee -a "$REPORT_FILE"
echo "" | tee -a "$REPORT_FILE"

has_cmd() { command -v "$1" >/dev/null 2>&1; }

# Build ignore list (paths that are noisy or vendor/build output)
IGNORE_DIRS=(
  .git
  build
  .dart_tool
  ios/Pods
  android/.gradle
  android/build
  macos/Pods
  linux/flutter
  windows/flutter
)

RG_EXCLUDES=()
GREP_EXCLUDES=()
for d in "${IGNORE_DIRS[@]}"; do
  RG_EXCLUDES+=("--glob=!$d/**")
  GREP_EXCLUDES+=("--exclude-dir=$d")
done

# Patterns to search for (name|regex)
read -r -d '' REGEX_PATTERNS << 'EOF'
AWS Access Key ID|AKIA[0-9A-Z]{16}
AWS Secret Key|(?i)aws(.{0,20})?(secret|access).{0,20}?([A-Za-z0-9/+=]{40})
Google API Key|AIza[0-9A-Za-z\-_]{35}
Firebase Web API Key|AIza[0-9A-Za-z\-_]{35}
Generic API Key|(?i)(api[_-]?key|x-api-key|apikey)[^\n]{0,20}?[:=][^\n]{0,120}
Bearer Token|(?i)authorization[^\n]{0,40}?bearer\s+[A-Za-z0-9\-_.=]+\.[A-Za-z0-9\-_.=]+\.[A-Za-z0-9\-_.=]+
Private RSA Key|-----BEGIN RSA PRIVATE KEY-----
Private Key|-----BEGIN (EC|DSA|OPENSSH) PRIVATE KEY-----
Password Assignments|(?i)password[^\n]{0,10}?[:=][^\n]{0,120}
Secret Assignments|(?i)secret[^\n]{0,10}?[:=][^\n]{0,120}
Client Secret|(?i)client[_-]?secret[^\n]{0,20}?[:=][^\n]{0,120}
Connection String|(?i)(mongodb|postgres|mysql|sqlserver|redis|amqp)(://)[^\s\"']+
JWT|eyJ[A-Za-z0-9_\-]{10,}\.[A-Za-z0-9_\-]{10,}\.[A-Za-z0-9_\-]{10,}
Pem Block|-----BEGIN CERTIFICATE-----
EOF

# Sensitive filenames that should not be committed
SENSITIVE_FILES=(
  ".env"
  ".env.local"
  ".env.*"
  "*.pem"
  "*.key"
  "*.p12"
  "*.pfx"
  "*.keystore"
  "keystore.properties"
  "id_rsa"
  "id_dsa"
  "google-services.json"
  "GoogleService-Info.plist"
)

FOUND=0

echo "== File name scan (respecting .gitignore) ==" | tee -a "$REPORT_FILE"
# Files that are tracked or would be added by `git add .`
mapfile -t CANDIDATE_FILES < <(git ls-files -c -o --exclude-standard)
for pattern in "${SENSITIVE_FILES[@]}"; do
  for f in "${CANDIDATE_FILES[@]}"; do
    if [[ "$f" == $pattern ]]; then
      echo "[HIGH] Sensitive file present: $f" | tee -a "$REPORT_FILE"
      FOUND=1
    fi
  done
done
echo "" | tee -a "$REPORT_FILE"

echo "== Content scan ==" | tee -a "$REPORT_FILE"
if has_cmd rg; then
  IFS=$'\n'
  for line in $REGEX_PATTERNS; do
    name=${line%%|*}
    regex=${line#*|}
    # Use multiline disabled for performance; show up to 200 matches per pattern
    if rg -n --no-heading --hidden "${RG_EXCLUDES[@]}" -U -e "$regex" . | head -n 1 >/dev/null; then
      echo "[MATCH] $name" | tee -a "$REPORT_FILE"
      rg -n --no-heading --hidden "${RG_EXCLUDES[@]}" -U -e "$regex" . | sed 's/^/  /' | tee -a "$REPORT_FILE"
      FOUND=1
      echo "" >> "$REPORT_FILE"
    fi
  done
else
  echo "ripgrep (rg) not found; falling back to grep (slower)." | tee -a "$REPORT_FILE"
  while IFS= read -r line; do
    name=${line%%|*}
    regex=${line#*|}
    if grep -RInI ${GREP_EXCLUDES[*]} -E "$regex" . >/dev/null 2>&1; then
      echo "[MATCH] $name" | tee -a "$REPORT_FILE"
      grep -RInI ${GREP_EXCLUDES[*]} -E "$regex" . | sed 's/^/  /' | tee -a "$REPORT_FILE"
      FOUND=1
      echo "" >> "$REPORT_FILE"
    fi
  done <<< "$REGEX_PATTERNS"
fi

echo "== Optional deep scanners ==" | tee -a "$REPORT_FILE"
if has_cmd gitleaks; then
  echo "Running gitleaks..." | tee -a "$REPORT_FILE"
  if ! gitleaks detect --no-banner --redact --source . >> "$REPORT_FILE" 2>&1; then
    FOUND=1
  fi
else
  echo "gitleaks not installed. Install with: brew install gitleaks" | tee -a "$REPORT_FILE"
fi

echo "" | tee -a "$REPORT_FILE"
if [[ $FOUND -eq 0 ]]; then
  echo "No secrets detected." | tee -a "$REPORT_FILE"
else
  echo "Potential secrets detected. See $REPORT_FILE" | tee -a "$REPORT_FILE"
fi

exit $FOUND


