#!/bin/bash

# Security Scan Script for Flutter Projects
# Scans for sensitive information, passwords, API keys, and credentials
# that might be hardcoded or committed to version control

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SCAN_DIRS=("lib" "android" "ios" "web" "test" "docs")
EXCLUDE_DIRS=("build" ".dart_tool" "node_modules" ".git" "*.g.dart" "*.freezed.dart")
EXCLUDE_FILES=("pubspec.lock" "*.lock" "*.log" "*.tmp" "*.cache")

# Patterns to scan for
declare -a PATTERNS=(
    # API Keys and Tokens
    "api[_-]?key"
    "api[_-]?token"
    "access[_-]?token"
    "secret[_-]?key"
    "private[_-]?key"
    "client[_-]?secret"
    "app[_-]?secret"
    "service[_-]?account"
    
    # Passwords and Credentials
    "password"
    "passwd"
    "pwd"
    "credential"
    "auth[_-]?token"
    "bearer[_-]?token"
    "jwt[_-]?token"
    
    # Database and Connection Strings
    "database[_-]?url"
    "db[_-]?url"
    "connection[_-]?string"
    "mongodb[_-]?uri"
    "postgres[_-]?url"
    "mysql[_-]?url"
    
    # AWS and Cloud Services
    "aws[_-]?access[_-]?key"
    "aws[_-]?secret[_-]?key"
    "aws[_-]?session[_-]?token"
    "firebase[_-]?config"
    "google[_-]?api[_-]?key"
    "stripe[_-]?key"
    "twilio[_-]?token"
    
    # Common sensitive patterns
    "sk_[a-zA-Z0-9]{24}"
    "pk_[a-zA-Z0-9]{24}"
    "AIza[0-9A-Za-z-_]{35}"
    "ya29\\.[0-9A-Za-z-_]+"
    "1//[0-9A-Za-z-_]+"
    "AKIA[0-9A-Z]{16}"
    "AKIA[0-9A-Z]{20}"
    "arn:aws:[a-z0-9-]+:[0-9]{12}:[a-z0-9-]+"
)

# File extensions to scan
SCAN_EXTENSIONS=("dart" "yaml" "yml" "json" "xml" "plist" "gradle" "kt" "java" "swift" "objc" "h" "m" "md" "txt" "env" "properties" "config")

# Variables to track results
FOUND_ISSUES=0
SCANNED_FILES=0

echo -e "${BLUE}🔒 Flutter Security Scanner${NC}"
echo -e "${BLUE}========================${NC}"
echo ""

# Function to check if file should be excluded
should_exclude() {
    local file="$1"
    
    # Check exclude directories
    for exclude_dir in "${EXCLUDE_DIRS[@]}"; do
        if [[ "$file" == *"$exclude_dir"* ]]; then
            return 0
        fi
    done
    
    # Check exclude files
    for exclude_file in "${EXCLUDE_FILES[@]}"; do
        if [[ "$file" == *"$exclude_file" ]]; then
            return 0
        fi
    done
    
    return 1
}

# Function to check if file has scanable extension
has_scanable_extension() {
    local file="$1"
    local extension="${file##*.}"
    
    for scan_ext in "${SCAN_EXTENSIONS[@]}"; do
        if [[ "$extension" == "$scan_ext" ]]; then
            return 0
        fi
    done
    
    return 1
}

# Function to scan a single file
scan_file() {
    local file="$1"
    local file_issues=0
    
    echo -e "${YELLOW}Scanning: $file${NC}"
    ((SCANNED_FILES++))
    
    for pattern in "${PATTERNS[@]}"; do
        # Use grep to search for patterns, case insensitive
        if grep -q -i "$pattern" "$file" 2>/dev/null; then
            # Check for false positives based on context
            local is_false_positive=false
            
            # Skip common false positives
            if [[ "$pattern" == "password" ]]; then
                # Skip if it's just a form field or UI element
                if grep -q -i "TextEditingController\|TextField\|form\|input\|ui\|widget" "$file" 2>/dev/null; then
                    is_false_positive=true
                fi
            fi
            
            # Skip if it's in test files and looks like test data
            if [[ "$file" == *"test"* ]] && grep -q -i "test\|expect\|find\|widget" "$file" 2>/dev/null; then
                is_false_positive=true
            fi
            
            # Skip if it's in documentation and looks like documentation
            if [[ "$file" == *"docs"* ]] && grep -q -i "documentation\|example\|guide\|tutorial" "$file" 2>/dev/null; then
                is_false_positive=true
            fi
            
            if [ "$is_false_positive" = false ]; then
                echo -e "${RED}  ⚠️  Potential issue found in $file${NC}"
                echo -e "${RED}     Pattern: $pattern${NC}"
                
                # Show the matching lines (first 3 matches)
                echo -e "${YELLOW}     Matches:${NC}"
                grep -i -n "$pattern" "$file" 2>/dev/null | head -3 | while read -r line; do
                    echo -e "${YELLOW}       Line $line${NC}"
                done
                echo ""
                
                ((file_issues++))
                ((FOUND_ISSUES++))
            fi
        fi
    done
    
    if [ $file_issues -eq 0 ]; then
        echo -e "${GREEN}  ✅ No issues found${NC}"
    fi
}

# Function to scan for hardcoded values
scan_hardcoded_values() {
    echo -e "${BLUE}🔍 Scanning for hardcoded sensitive values...${NC}"
    echo ""
    
    # Scan for common hardcoded patterns
    local hardcoded_patterns=(
        "password.*=.*['\"][^'\"]{8,}['\"]"
        "api_key.*=.*['\"][^'\"]{10,}['\"]"
        "secret.*=.*['\"][^'\"]{10,}['\"]"
        "token.*=.*['\"][^'\"]{10,}['\"]"
        "key.*=.*['\"][^'\"]{10,}['\"]"
    )
    
    for pattern in "${hardcoded_patterns[@]}"; do
        echo -e "${YELLOW}Checking pattern: $pattern${NC}"
        find . -type f \( -name "*.dart" -o -name "*.yaml" -o -name "*.yml" -o -name "*.json" \) \
            -not -path "./build/*" \
            -not -path "./.dart_tool/*" \
            -not -path "./.git/*" \
            -exec grep -l -i "$pattern" {} \; 2>/dev/null | while read -r file; do
            if [ -f "$file" ]; then
                echo -e "${RED}  ⚠️  Potential hardcoded value in: $file${NC}"
                grep -i -n "$pattern" "$file" 2>/dev/null | head -2 | while read -r line; do
                    echo -e "${YELLOW}    Line $line${NC}"
                done
                echo ""
                ((FOUND_ISSUES++))
            fi
        done
    done
}

# Function to check git history for sensitive data
check_git_history() {
    echo -e "${BLUE}🔍 Checking git history for sensitive data...${NC}"
    echo ""
    
    if [ -d ".git" ]; then
        # Check for sensitive patterns in git history
        for pattern in "${PATTERNS[@]}"; do
            if git log --all --full-history -- "$(pwd)" | grep -q -i "$pattern" 2>/dev/null; then
                echo -e "${RED}  ⚠️  Potential sensitive data found in git history${NC}"
                echo -e "${RED}     Pattern: $pattern${NC}"
                echo -e "${YELLOW}     Consider using BFG Repo-Cleaner or git filter-branch to remove${NC}"
                echo ""
                ((FOUND_ISSUES++))
            fi
        done
        
        # Check for large files that might contain sensitive data
        echo -e "${YELLOW}Checking for large files in git history...${NC}"
        git rev-list --objects --all | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | \
            awk '/^blob/ {print substr($0,6)}' | sort -k2nr | head -10 | while read -r size hash path; do
            if [ "$size" -gt 1048576 ]; then  # Files larger than 1MB
                echo -e "${YELLOW}  Large file: $path ($size bytes)${NC}"
            fi
        done
    else
        echo -e "${YELLOW}  No git repository found${NC}"
    fi
}

# Function to check for environment files
check_env_files() {
    echo -e "${BLUE}🔍 Checking for environment files...${NC}"
    echo ""
    
    local env_files=(".env" ".env.local" ".env.production" ".env.development" ".env.test")
    
    for env_file in "${env_files[@]}"; do
        if [ -f "$env_file" ]; then
            echo -e "${YELLOW}  Found environment file: $env_file${NC}"
            
            # Check if it's in .gitignore
            if grep -q "$env_file" .gitignore 2>/dev/null; then
                echo -e "${GREEN}    ✅ Properly ignored in .gitignore${NC}"
            else
                echo -e "${RED}    ⚠️  NOT in .gitignore - should be added!${NC}"
                ((FOUND_ISSUES++))
            fi
            
            # Check for sensitive patterns in env file
            for pattern in "${PATTERNS[@]}"; do
                if grep -q -i "$pattern" "$env_file" 2>/dev/null; then
                    echo -e "${RED}    ⚠️  Contains sensitive pattern: $pattern${NC}"
                    ((FOUND_ISSUES++))
                fi
            done
        fi
    done
}

# Function to check .gitignore
check_gitignore() {
    echo -e "${BLUE}🔍 Checking .gitignore configuration...${NC}"
    echo ""
    
    if [ -f ".gitignore" ]; then
        local important_patterns=(
            ".env"
            "*.key"
            "*.pem"
            "*.p12"
            "*.keystore"
            "google-services.json"
            "GoogleService-Info.plist"
            "firebase_options.dart"
        )
        
        for pattern in "${important_patterns[@]}"; do
            if grep -q "$pattern" .gitignore 2>/dev/null; then
                echo -e "${GREEN}  ✅ $pattern is properly ignored${NC}"
            else
                echo -e "${YELLOW}  ⚠️  Consider adding $pattern to .gitignore${NC}"
            fi
        done
    else
        echo -e "${RED}  ⚠️  No .gitignore file found${NC}"
        ((FOUND_ISSUES++))
    fi
}

# Main scanning function
main_scan() {
    echo -e "${BLUE}🔍 Starting security scan...${NC}"
    echo ""
    
    # Scan all files in specified directories
    for dir in "${SCAN_DIRS[@]}"; do
        if [ -d "$dir" ]; then
            echo -e "${BLUE}📁 Scanning directory: $dir${NC}"
            echo ""
            
            find "$dir" -type f | while read -r file; do
                if ! should_exclude "$file" && has_scanable_extension "$file"; then
                    scan_file "$file"
                fi
            done
        fi
    done
}

# Main execution
main() {
    echo "Starting comprehensive security scan..."
    echo "Scan directories: ${SCAN_DIRS[*]}"
    echo "Exclude patterns: ${EXCLUDE_DIRS[*]}"
    echo ""
    
    # Run all scans
    main_scan
    scan_hardcoded_values
    check_env_files
    check_gitignore
    check_git_history
    
    # Summary
    echo -e "${BLUE}📊 Scan Summary${NC}"
    echo -e "${BLUE}==============${NC}"
    echo -e "Files scanned: $SCANNED_FILES"
    echo -e "Issues found: $FOUND_ISSUES"
    echo ""
    
    if [ $FOUND_ISSUES -eq 0 ]; then
        echo -e "${GREEN}🎉 No security issues found!${NC}"
        exit 0
    else
        echo -e "${RED}⚠️  $FOUND_ISSUES potential security issues found${NC}"
        echo -e "${YELLOW}Please review and fix the issues above before committing to version control.${NC}"
        exit 1
    fi
}

# Run main function
main "$@"
