# Flutter Project Scripts

This directory contains utility scripts for the Flutter project.

## Scripts

### 1. `flutter-smoke.sh`
A comprehensive Flutter smoke test script that runs:
- `flutter doctor`
- `flutter analyze`
- `flutter test`
- `flutter build ios --no-codesign`
- `flutter build apk`

**Usage:**
```bash
./script/flutter-smoke.sh
```

### 2. `security-scan.sh` 🔒
A security scanning script that checks your Flutter project for sensitive information, passwords, API keys, and credentials that might be hardcoded or accidentally committed to version control.

**Usage:**
```bash
./script/security-scan.sh
```

## Security Scanner Features

The security scanner performs the following checks:

### 🔍 **Sensitive File Detection**
Scans for common sensitive file types:
- `*.key`, `*.pem`, `*.p12`, `*.keystore`, `*.jks`, `*.pfx`
- `*.crt`, `*.cer`, `*.der`, `*.p8`
- `*.mobileprovision`, `*.entitlements`
- `.env*`, `secrets.*`, `config.*`

### 🔑 **Hardcoded Credentials**
Detects hardcoded credentials in code files:
- Passwords, API keys, secrets, tokens
- Database URLs, connection strings
- Client IDs, client secrets
- Private/public keys

### 🚨 **Specific Sensitive Strings**
Scans for known sensitive string patterns:
- Stripe keys (`sk_live_`, `pk_live_`, etc.)
- Google API keys (`AIza`)
- AWS access keys (`AKIA`, `AKIB`, etc.)
- GitHub tokens (`ghp_`, `gho_`, etc.)
- Slack tokens (`xoxb-`, `xoxp-`, etc.)
- Facebook tokens (`EAAA`, `EAAB`, etc.)

### 📝 **Comment Analysis**
Checks comments for sensitive information references:
- TODO/FIXME comments mentioning passwords, API keys
- HACK/BUG comments with credential references

### 🛡️ **Gitignore Validation**
Verifies that `.gitignore` contains recommended patterns for sensitive files:
- Certificate files
- Environment files
- Configuration files
- Firebase configuration files

## Output

The script provides color-coded output:
- 🔵 **INFO**: General information
- 🟢 **SUCCESS**: No issues found
- 🟡 **WARNING**: Issues that should be reviewed
- 🔴 **ERROR**: Script errors
- 🟣 **CRITICAL**: Security issues that must be addressed

## Exit Codes

- `0`: No critical issues found
- `1`: Critical security issues detected (script will exit)

## Best Practices

1. **Run before commits**: Use this script as a pre-commit hook or before pushing to GitHub
2. **Regular scanning**: Run the script periodically during development
3. **CI/CD integration**: Include this script in your CI/CD pipeline
4. **Team awareness**: Share this script with your team members

## Example Output

```
[INFO] Starting Flutter Security Scan...
======================================

[INFO] Scanning for sensitive file types...
[SUCCESS] No sensitive file types found

[INFO] Scanning for hardcoded credentials in code...
[SUCCESS] No hardcoded credential patterns found

[INFO] Scanning for specific sensitive strings...
[SUCCESS] No sensitive strings found

[INFO] Checking .gitignore for sensitive file patterns...
[SUCCESS] .gitignore contains all recommended sensitive file patterns

[INFO] Scanning comments for sensitive information...
[SUCCESS] No sensitive comments found

======================================
🎉 Security scan completed successfully!
No security issues found. ✅

[INFO] Security scan completed!
```

## Troubleshooting

If you encounter issues:

1. **Permission denied**: Make sure the script is executable:
   ```bash
   chmod +x script/security-scan.sh
   ```

2. **Missing tools**: Ensure `grep` and `find` are installed on your system

3. **False positives**: The script may flag legitimate code. Review each finding and adjust patterns if needed

## Customization

You can modify the script to:
- Add new sensitive string patterns
- Exclude additional directories
- Change severity levels
- Add custom file type checks

## Security Note

This script helps identify potential security issues but should not be your only security measure. Always follow security best practices and use proper secret management solutions.
