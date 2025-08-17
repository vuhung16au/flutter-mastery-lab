#!/bin/bash

# Flutter Security Scanner Script
# This script scans the entire Flutter project for sensitive information,
# passwords, API keys, and credentials that might be hardcoded or
# accidentally committed to version control.

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_critical() {
    echo -e "${PURPLE}[CRITICAL]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if required tools are installed
if ! command_exists grep; then
    print_error "grep is not installed or not in PATH"
    exit 1
fi

if ! command_exists find; then
    print_error "find is not installed or not in PATH"
    exit 1
fi

# Initialize counters
total_issues=0
critical_issues=0
warning_issues=0

print_status "Starting Flutter Security Scan..."
echo "======================================"

# Function to scan for patterns
scan_pattern() {
    local pattern="$1"
    local description="$2"
    local severity="$3"
    local exclude_patterns="$4"
    
    print_status "Scanning for $description..."
    
    local find_cmd="find . -type f"
    local exclude_cmd=""
    
    # Add exclude patterns
    if [ -n "$exclude_patterns" ]; then
        exclude_cmd=" -not -path '$exclude_patterns'"
    fi
    
    # Standard excludes for Flutter projects
    exclude_cmd="$exclude_cmd -not -path './.git/*' -not -path './build/*' -not -path './.dart_tool/*' -not -path './.flutter-plugins*' -not -path './.packages' -not -path './pubspec.lock' -not -path './ios/Pods/*' -not -path './android/.gradle/*' -not -path './android/build/*' -not -path './node_modules/*' -not -path './*.log' -not -path './*.tmp' -not -path './script/*'"
    
    # Find files and search for pattern
    local results=$(eval "$find_cmd$exclude_cmd -exec grep -l -i \"$pattern\" {} \; 2>/dev/null || true")
    
    if [ -n "$results" ]; then
        echo "$results" | while read -r file; do
            if [ -n "$file" ]; then
                case $severity in
                    "critical")
                        print_critical "Found $description in: $file"
                        ((critical_issues++))
                        ;;
                    "warning")
                        print_warning "Found $description in: $file"
                        ((warning_issues++))
                        ;;
                    *)
                        print_warning "Found $description in: $file"
                        ((warning_issues++))
                        ;;
                esac
                ((total_issues++))
            fi
        done
    else
        print_success "No $description found"
    fi
}

# Function to scan for specific file types
scan_file_types() {
    print_status "Scanning for sensitive file types..."
    
    # Look for common sensitive file types
    local sensitive_files=$(find . -type f \( -name "*.key" -o -name "*.pem" -o -name "*.p12" -o -name "*.keystore" -o -name "*.jks" -o -name "*.pfx" -o -name "*.crt" -o -name "*.cer" -o -name "*.der" -o -name "*.p8" -o -name "*.mobileprovision" -o -name ".env*" -o -name "secrets.*" -o -name "config.*" \) 2>/dev/null | grep -v "./.git/" | grep -v "./build/" | grep -v "./.dart_tool/" | grep -v "./ios/Pods/" | grep -v "./android/.gradle/" | grep -v "./script/" || true)
    
    if [ -n "$sensitive_files" ]; then
        echo "$sensitive_files" | while read -r file; do
            if [ -n "$file" ]; then
                print_critical "Found sensitive file: $file"
                ((critical_issues++))
                ((total_issues++))
            fi
        done
    else
        print_success "No sensitive file types found"
    fi
}

# Function to scan for hardcoded credentials in code
scan_hardcoded_credentials() {
    print_status "Scanning for hardcoded credentials in code..."
    
    # Common patterns for hardcoded credentials
    local patterns=(
        "password.*=.*['\"][^'\"]*['\"]"
        "api_key.*=.*['\"][^'\"]*['\"]"
        "secret.*=.*['\"][^'\"]*['\"]"
        "token.*=.*['\"][^'\"]*['\"]"
        "credential.*=.*['\"][^'\"]*['\"]"
        "auth.*=.*['\"][^'\"]*['\"]"
        "key.*=.*['\"][^'\"]*['\"]"
        "private_key.*=.*['\"][^'\"]*['\"]"
        "public_key.*=.*['\"][^'\"]*['\"]"
        "access_token.*=.*['\"][^'\"]*['\"]"
        "refresh_token.*=.*['\"][^'\"]*['\"]"
        "client_id.*=.*['\"][^'\"]*['\"]"
        "client_secret.*=.*['\"][^'\"]*['\"]"
        "database_url.*=.*['\"][^'\"]*['\"]"
        "connection_string.*=.*['\"][^'\"]*['\"]"
    )
    
    for pattern in "${patterns[@]}"; do
        local results=$(find . -type f \( -name "*.dart" -o -name "*.yaml" -o -name "*.yml" -o -name "*.json" -o -name "*.xml" -o -name "*.plist" -o -name "*.gradle" -o -name "*.kt" -o -name "*.swift" -o -name "*.java" \) -not -path "./.git/*" -not -path "./build/*" -not -path "./.dart_tool/*" -not -path "./ios/Pods/*" -not -path "./android/.gradle/*" -not -path "./android/build/*" -not -path "./script/*" -exec grep -l -i "$pattern" {} \; 2>/dev/null || true)
        
        if [ -n "$results" ]; then
            echo "$results" | while read -r file; do
                if [ -n "$file" ]; then
                    print_critical "Found hardcoded credential pattern in: $file"
                    print_status "  Pattern: $pattern"
                    ((critical_issues++))
                    ((total_issues++))
                fi
            done
        fi
    done
}

# Function to scan for specific sensitive strings
scan_sensitive_strings() {
    print_status "Scanning for specific sensitive strings..."
    
    # Common sensitive strings that should not be in code
    local sensitive_strings=(
        "sk_live_"
        "pk_live_"
        "sk_test_"
        "pk_test_"
        "AIza"
        "AKIA"
        "AKIB"
        "AKIC"
        "AKID"
        "AKIE"
        "AKIF"
        "AKIG"
        "AKIH"
        "AKII"
        "AKIJ"
        "AKIK"
        "AKIL"
        "AKIM"
        "AKIN"
        "AKIO"
        "AKIP"
        "AKIQ"
        "AKIR"
        "AKIS"
        "AKIT"
        "AKIU"
        "AKIV"
        "AKIW"
        "AKIX"
        "AKIY"
        "AKIZ"
        "ghp_"
        "gho_"
        "ghu_"
        "ghs_"
        "ghr_"
        "xoxb-"
        "xoxp-"
        "xoxa-"
        "xoxr-"
        "xoxs-"
        "xoxo-"
        "sk-"
        "pk-"
        "rk_live_"
        "rk_test_"
        "sq0atp-"
        "sq0csp-"
        "EAAA"
        "EAAB"
        "EAAC"
        "EAAD"
        "EAAE"
        "EAAF"
        "EAAG"
        "EAAH"
        "EAAI"
        "EAAJ"
        "EAAK"
        "EAAL"
        "EAAM"
        "EAAN"
        "EAAO"
        "EAAP"
        "EAAQ"
        "EAAR"
        "EAAS"
        "EAAT"
        "EAAU"
        "EAAV"
        "EAAW"
        "EAAX"
        "EAAY"
        "EAAZ"
    )
    
    for string in "${sensitive_strings[@]}"; do
        local results=$(find . -type f -not -path "./.git/*" -not -path "./build/*" -not -path "./.dart_tool/*" -not -path "./ios/Pods/*" -not -path "./android/.gradle/*" -not -path "./android/build/*" -not -path "./node_modules/*" -not -path "./script/*" -exec grep -l "$string" {} \; 2>/dev/null || true)
        
        if [ -n "$results" ]; then
            echo "$results" | while read -r file; do
                if [ -n "$file" ]; then
                    print_critical "Found sensitive string '$string' in: $file"
                    ((critical_issues++))
                    ((total_issues++))
                fi
            done
        fi
    done
}

# Function to check .gitignore for sensitive files
check_gitignore() {
    print_status "Checking .gitignore for sensitive file patterns..."
    
    if [ -f ".gitignore" ]; then
        local missing_patterns=()
        
        # Check for common sensitive patterns that should be in .gitignore
        local required_patterns=(
            "*.key"
            "*.pem"
            "*.p12"
            "*.keystore"
            "*.jks"
            "*.pfx"
            "*.crt"
            "*.cer"
            "*.der"
            "*.p8"
            "*.mobileprovision"
            "*.entitlements"
            ".env*"
            "secrets.*"
            "config.*"
            "google-services.json"
            "GoogleService-Info.plist"
            "firebase_options.dart"
        )
        
        for pattern in "${required_patterns[@]}"; do
            if ! grep -q "$pattern" .gitignore 2>/dev/null; then
                missing_patterns+=("$pattern")
            fi
        done
        
        if [ ${#missing_patterns[@]} -gt 0 ]; then
            print_warning "Missing patterns in .gitignore:"
            for pattern in "${missing_patterns[@]}"; do
                echo "  - $pattern"
                ((warning_issues++))
                ((total_issues++))
            done
        else
            print_success ".gitignore contains all recommended sensitive file patterns"
        fi
    else
        print_warning ".gitignore file not found"
        ((warning_issues++))
        ((total_issues++))
    fi
}

# Function to scan for comments containing sensitive info
scan_comments() {
    print_status "Scanning comments for sensitive information..."
    
    local comment_patterns=(
        "TODO.*password"
        "FIXME.*api.*key"
        "NOTE.*secret"
        "HACK.*token"
        "BUG.*credential"
        "XXX.*auth"
        "TEMP.*key"
    )
    
    for pattern in "${comment_patterns[@]}"; do
        local results=$(find . -type f \( -name "*.dart" -o -name "*.yaml" -o -name "*.yml" -o -name "*.json" -o -name "*.xml" -o -name "*.plist" -o -name "*.gradle" -o -name "*.kt" -o -name "*.swift" -o -name "*.java" \) -not -path "./.git/*" -not -path "./build/*" -not -path "./.dart_tool/*" -not -path "./ios/Pods/*" -not -path "./android/.gradle/*" -not -path "./android/build/*" -not -path "./script/*" -exec grep -l -i "$pattern" {} \; 2>/dev/null || true)
        
        if [ -n "$results" ]; then
            echo "$results" | while read -r file; do
                if [ -n "$file" ]; then
                    print_warning "Found comment with sensitive reference in: $file"
                    print_status "  Pattern: $pattern"
                    ((warning_issues++))
                    ((total_issues++))
                fi
            done
        fi
    done
}

# Main scanning process
echo

# Step 1: Scan for sensitive file types
scan_file_types
echo

# Step 2: Scan for hardcoded credentials
scan_hardcoded_credentials
echo

# Step 3: Scan for specific sensitive strings
scan_sensitive_strings
echo

# Step 4: Check .gitignore
check_gitignore
echo

# Step 5: Scan comments
scan_comments
echo

# Summary
echo "======================================"
if [ $total_issues -eq 0 ]; then
    print_success "🎉 Security scan completed successfully!"
    print_success "No security issues found. ✅"
else
    print_critical "Security scan completed with issues found!"
    echo
    print_status "Summary:"
    echo "  🔴 Critical issues: $critical_issues"
    echo "  🟡 Warning issues: $warning_issues"
    echo "  📊 Total issues: $total_issues"
    echo
    
    if [ $critical_issues -gt 0 ]; then
        print_critical "CRITICAL: Found $critical_issues critical security issues that must be addressed!"
        print_critical "Please review and fix these issues before committing to version control."
        exit 1
    else
        print_warning "WARNING: Found $warning_issues warning issues that should be reviewed."
        print_success "No critical issues found. ✅"
    fi
fi

echo
print_status "Security scan completed!"
