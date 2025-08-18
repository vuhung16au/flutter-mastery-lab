#!/bin/bash

# Test script to demonstrate security scanning capabilities
# This script creates temporary files with sensitive data to test the scanner

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🧪 Security Scanner Test${NC}"
echo -e "${BLUE}======================${NC}"
echo ""

# Create test directory
TEST_DIR="test_security_scan"
mkdir -p "$TEST_DIR"

echo -e "${YELLOW}Creating test files with sensitive data...${NC}"

# Create a test Dart file with hardcoded API key
cat > "$TEST_DIR/test_api.dart" << 'EOF'
class ApiService {
  // This should be detected as a security issue
  static const String apiKey = "AIzaSyC_1234567890abcdefghijklmnopqrstuvwxyz";
  static const String secretKey = "sk_test_1234567890abcdefghijklmnopqrstuvwxyz";
  
  // This should NOT be detected (legitimate password field)
  final passwordController = TextEditingController();
  
  void authenticate() {
    // This should be detected
    final token = "ya29.1234567890abcdefghijklmnopqrstuvwxyz";
    print("Using token: $token");
  }
}
EOF

# Create a test YAML file with credentials
cat > "$TEST_DIR/config.yaml" << 'EOF'
# This should be detected
database:
  url: "mongodb://user:password123@localhost:27017/db"
  password: "super_secret_password_123"

# This should be detected
aws:
  access_key: "AKIA1234567890ABCDEF"
  secret_key: "abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnop"

# This should be detected
firebase:
  api_key: "AIzaSyC_9876543210zyxwvutsrqponmlkjihgfedcba"
EOF

# Create a test environment file
cat > "$TEST_DIR/.env" << 'EOF'
# This should be detected
DATABASE_URL=postgresql://user:password123@localhost:5432/mydb
API_KEY=sk_live_1234567890abcdefghijklmnopqrstuvwxyz
SECRET_TOKEN=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c
EOF

echo -e "${GREEN}✅ Test files created in $TEST_DIR/${NC}"
echo ""

# Run security scan on test directory
echo -e "${BLUE}🔍 Running security scan on test files...${NC}"
echo ""

# Temporarily modify the script to scan test directory
cp scripts/security_scan.sh scripts/security_scan_test.sh
sed -i '' 's/SCAN_DIRS=("lib" "android" "ios" "web" "test" "docs")/SCAN_DIRS=("test_security_scan")/' scripts/security_scan_test.sh

# Run the test scan
if ./scripts/security_scan_test.sh; then
    echo -e "${GREEN}✅ Security scan completed${NC}"
else
    echo -e "${RED}❌ Security scan found issues (as expected)${NC}"
fi

echo ""
echo -e "${YELLOW}🧹 Cleaning up test files...${NC}"
rm -rf "$TEST_DIR"
rm scripts/security_scan_test.sh

echo -e "${GREEN}✅ Test completed!${NC}"
echo ""
echo -e "${BLUE}📝 Summary:${NC}"
echo "The security scanner should have detected:"
echo "- Hardcoded API keys in Dart files"
echo "- Database credentials in YAML files"
echo "- Sensitive tokens in environment files"
echo "- AWS access keys and secrets"
echo ""
echo -e "${YELLOW}Note: The scanner is designed to detect potential security issues.${NC}"
echo -e "${YELLOW}Always review findings manually to confirm they are actual security risks.${NC}"
