#!/bin/bash

# Setup Git Hooks for Security Scanning
# This script sets up pre-commit hooks to automatically run security scans

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔧 Setting up Git Hooks for Security Scanning${NC}"
echo -e "${BLUE}=============================================${NC}"
echo ""

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo -e "${RED}❌ Not in a git repository. Please run this from the project root.${NC}"
    exit 1
fi

# Create hooks directory if it doesn't exist
mkdir -p .git/hooks

# Create pre-commit hook
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash

# Pre-commit hook for security scanning
echo "🔒 Running security scan before commit..."

# Run the security scan
if ! ./scripts/security_scan.sh; then
    echo ""
    echo "❌ Security scan failed. Please fix the issues before committing."
    echo "You can run './scripts/security_scan.sh' manually to see details."
    exit 1
fi

echo "✅ Security scan passed. Proceeding with commit..."
EOF

# Make the hook executable
chmod +x .git/hooks/pre-commit

echo -e "${GREEN}✅ Pre-commit hook installed successfully!${NC}"
echo ""
echo -e "${BLUE}📝 What this does:${NC}"
echo "- Runs security scan before every commit"
echo "- Prevents commits if security issues are found"
echo "- Helps maintain security best practices"
echo ""
echo -e "${YELLOW}💡 Tips:${NC}"
echo "- The hook will run automatically on every commit"
echo "- If you need to bypass the scan (not recommended), use:"
echo "  git commit --no-verify -m 'your message'"
echo "- You can manually run the scan anytime with:"
echo "  ./scripts/security_scan.sh"
echo ""
echo -e "${GREEN}🎉 Git hooks setup complete!${NC}"
