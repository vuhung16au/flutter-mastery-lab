#!/bin/bash

# Security Scan Script for Flutter Navigation & Routing Project
# This script scans the project for sensitive information that should not be committed to version control

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Project root directory
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCAN_RESULTS="$PROJECT_ROOT/security_scan_results.txt"

echo -e "${BLUE}🔒 Starting Security Scan for Flutter Navigation & Routing Project${NC}"
echo "=================================================="
echo ""

# Initialize results file
> "$SCAN_RESULTS"

# Function to log findings
log_finding() {
    local severity="$1"
    local message="$2"
    local file="$3"
    local line="$4"
    
    case $severity in
        "ERROR")
            echo -e "${RED}❌ ERROR: $message${NC}" | tee -a "$SCAN_RESULTS"
            ;;
        "WARNING")
            echo -e "${YELLOW}⚠️  WARNING: $message${NC}" | tee -a "$SCAN_RESULTS"
            ;;
        "INFO")
            echo -e "${BLUE}ℹ️  INFO: $message${NC}" | tee -a "$SCAN_RESULTS"
            ;;
    esac
    
    if [[ -n "$file" ]]; then
        echo "   File: $file" | tee -a "$SCAN_RESULTS"
        if [[ -n "$line" ]]; then
            echo "   Line: $line" | tee -a "$SCAN_RESULTS"
        fi
    fi
    echo "" | tee -a "$SCAN_RESULTS"
}

# Function to scan for patterns
scan_pattern() {
    local pattern="$1"
    local description="$2"
    local severity="$3"
    local exclude_patterns="$4"
    
    echo -e "${BLUE}Scanning for: $description${NC}"
    
    local grep_cmd="grep -r -n -i --exclude-dir={.git,build,.dart_tool,ios/Pods,android/.gradle,scripts,docs} --exclude={*.lock,*.g.dart,*.freezed.dart,*.plist,*.pbxproj,*.xcworkspace,*.xcodeproj,*.jar,*.bin,*.ico,*.png,*.h,*.cpp,*.c,*.rc,*.txt,*.json}"
    
    # Add exclude patterns
    if [[ -n "$exclude_patterns" ]]; then
        for exclude in $exclude_patterns; do
            grep_cmd="$grep_cmd --exclude=$exclude"
        done
    fi
    
    grep_cmd="$grep_cmd '$pattern' $PROJECT_ROOT || true"
    
    local results=$(eval $grep_cmd)
    
    if [[ -n "$results" ]]; then
        while IFS= read -r line; do
            if [[ -n "$line" ]]; then
                local file=$(echo "$line" | cut -d: -f1)
                local line_num=$(echo "$line" | cut -d: -f2)
                local content=$(echo "$line" | cut -d: -f3-)
                
                log_finding "$severity" "$description found: $content" "$file" "$line_num"
            fi
        done <<< "$results"
    else
        echo -e "${GREEN}✅ No $description found${NC}"
    fi
    echo ""
}

# 1. Scan for API keys and tokens
echo "1. Scanning for API Keys and Tokens..."
scan_pattern "api[_-]?key" "API Key" "ERROR"
scan_pattern "api[_-]?token" "API Token" "ERROR"
scan_pattern "access[_-]?token" "Access Token" "ERROR"
scan_pattern "secret[_-]?key" "Secret Key" "ERROR"
scan_pattern "private[_-]?key" "Private Key" "ERROR"
scan_pattern "auth[_-]?token" "Auth Token" "ERROR"
scan_pattern "bearer[_-]?token" "Bearer Token" "ERROR"

# 2. Scan for passwords
echo "2. Scanning for Passwords..."
scan_pattern "password[[:space:]]*=" "Password assignment" "ERROR"
scan_pattern "passwd[[:space:]]*=" "Password assignment" "ERROR"
scan_pattern "pwd[[:space:]]*=" "Password assignment" "ERROR"
scan_pattern "password[[:space:]]*:" "Password field" "WARNING"

# 3. Scan for credentials
echo "3. Scanning for Credentials..."
scan_pattern "username[[:space:]]*=" "Username assignment" "WARNING"
scan_pattern "email[[:space:]]*=" "Email assignment" "WARNING"

# 4. Scan for database connections
echo "4. Scanning for Database Connections..."
scan_pattern "mongodb://" "MongoDB connection string" "ERROR"
scan_pattern "postgresql://" "PostgreSQL connection string" "ERROR"
scan_pattern "mysql://" "MySQL connection string" "ERROR"
scan_pattern "sqlite://" "SQLite connection string" "WARNING"

# 5. Scan for URLs with credentials
echo "5. Scanning for URLs with Credentials..."
scan_pattern "https?://[^@]*@[^[:space:]]*" "URL with embedded credentials" "ERROR"

# 6. Scan for hardcoded IP addresses
echo "6. Scanning for Hardcoded IP Addresses..."
scan_pattern "[[:space:]]1[0-9]{2}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}[[:space:]]" "Hardcoded IP address" "WARNING"
scan_pattern "[[:space:]]172\.[1-3][0-9]\.[0-9]{1,3}\.[0-9]{1,3}[[:space:]]" "Hardcoded IP address" "WARNING"
scan_pattern "[[:space:]]192\.168\.[0-9]{1,3}\.[0-9]{1,3}[[:space:]]" "Hardcoded IP address" "WARNING"

# 7. Scan for sensitive file paths
echo "7. Scanning for Sensitive File Paths..."
scan_pattern "/etc/passwd" "Sensitive file path" "ERROR"
scan_pattern "/etc/shadow" "Sensitive file path" "ERROR"
scan_pattern "~/.ssh/" "SSH directory reference" "WARNING"

# 8. Scan for debug flags and development settings
echo "8. Scanning for Debug Flags..."
scan_pattern "debug[[:space:]]*=[[:space:]]*true" "Debug flag enabled" "WARNING"
scan_pattern "verbose[[:space:]]*=[[:space:]]*true" "Verbose logging enabled" "WARNING"

# 9. Scan for potential secrets in comments
echo "9. Scanning for Secrets in Comments..."
scan_pattern "//.*password.*:" "Password in comment" "WARNING"
scan_pattern "//.*key.*:" "Key in comment" "WARNING"
scan_pattern "//.*secret.*:" "Secret in comment" "WARNING"

# 10. Scan for environment variables that might contain secrets
echo "10. Scanning for Environment Variables..."
scan_pattern "process\.env\." "Environment variable usage" "INFO"
scan_pattern "Platform\.environment" "Environment variable usage" "INFO"

# 11. Check for .env files
echo "11. Checking for Environment Files..."
if find "$PROJECT_ROOT" -name ".env*" -type f | grep -q .; then
    log_finding "WARNING" "Environment files found (.env*)" "Check if these contain secrets"
    find "$PROJECT_ROOT" -name ".env*" -type f | while read -r file; do
        echo "   Found: $file" | tee -a "$SCAN_RESULTS"
    done
else
    echo -e "${GREEN}✅ No .env files found${NC}"
fi
echo ""

# 12. Check for key files
echo "12. Checking for Key Files..."
if find "$PROJECT_ROOT" -name "*.key" -o -name "*.pem" -o -name "*.p12" -o -name "*.keystore" | grep -q .; then
    log_finding "WARNING" "Key files found" "Check if these should be in version control"
    find "$PROJECT_ROOT" -name "*.key" -o -name "*.pem" -o -name "*.p12" -o -name "*.keystore" | while read -r file; do
        echo "   Found: $file" | tee -a "$SCAN_RESULTS"
    done
else
    echo -e "${GREEN}✅ No key files found${NC}"
fi
echo ""

# 13. Check .gitignore for security
echo "13. Checking .gitignore for Security..."
if [[ -f "$PROJECT_ROOT/.gitignore" ]]; then
    missing_patterns=()
    
    # Check for common patterns that should be ignored
    if ! grep -q "\.env" "$PROJECT_ROOT/.gitignore"; then
        missing_patterns+=(".env files")
    fi
    
    if ! grep -q "\.key" "$PROJECT_ROOT/.gitignore"; then
        missing_patterns+=("*.key files")
    fi
    
    if ! grep -q "\.pem" "$PROJECT_ROOT/.gitignore"; then
        missing_patterns+=("*.pem files")
    fi
    
    if ! grep -q "keystore" "$PROJECT_ROOT/.gitignore"; then
        missing_patterns+=("keystore files")
    fi
    
    if [[ ${#missing_patterns[@]} -gt 0 ]]; then
        log_finding "WARNING" "Missing patterns in .gitignore: ${missing_patterns[*]}"
    else
        echo -e "${GREEN}✅ .gitignore looks good${NC}"
    fi
else
    log_finding "ERROR" "No .gitignore file found"
fi
echo ""

# Summary
echo "=================================================="
echo -e "${BLUE}🔍 Security Scan Complete${NC}"
echo ""

# Count findings by severity
error_count=$(grep -c "❌ ERROR:" "$SCAN_RESULTS" || echo "0")
warning_count=$(grep -c "⚠️  WARNING:" "$SCAN_RESULTS" || echo "0")
info_count=$(grep -c "ℹ️  INFO:" "$SCAN_RESULTS" || echo "0")

echo "📊 Scan Summary:"
echo "   Errors: $error_count"
echo "   Warnings: $warning_count"
echo "   Info: $info_count"
echo ""

if [[ $error_count -gt 0 ]]; then
    echo -e "${RED}🚨 CRITICAL: Found $error_count security issues that must be addressed!${NC}"
    exit 1
elif [[ $warning_count -gt 0 ]]; then
    echo -e "${YELLOW}⚠️  WARNING: Found $warning_count potential issues to review${NC}"
    exit 0
else
    echo -e "${GREEN}✅ No security issues found!${NC}"
    exit 0
fi
