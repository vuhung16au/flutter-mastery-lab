# Flutter Security Scanner

## Overview

The `security-scan.sh` script is a comprehensive security scanning tool designed specifically for Flutter projects. It helps developers identify and prevent sensitive information, credentials, and API keys from being accidentally committed to version control.

## Features

### 🔍 **Comprehensive Scanning**
- **Sensitive File Detection**: Scans for certificate files, keystores, and configuration files
- **Hardcoded Credentials**: Detects passwords, API keys, and secrets in code
- **Specific String Patterns**: Identifies known sensitive string formats (Stripe, AWS, GitHub, etc.)
- **Comment Analysis**: Checks comments for sensitive information references
- **Gitignore Validation**: Ensures proper exclusion patterns are in place

### 🛡️ **Security Patterns Detected**

#### File Types
- `*.key`, `*.pem`, `*.p12`, `*.keystore`, `*.jks`, `*.pfx`
- `*.crt`, `*.cer`, `*.der`, `*.p8`
- `*.mobileprovision`, `*.entitlements`
- `.env*`, `secrets.*`, `config.*`

#### Credential Patterns
- `password = "..."`, `api_key = "..."`, `secret = "..."`
- `token = "..."`, `credential = "..."`, `auth = "..."`
- `database_url = "..."`, `connection_string = "..."`

#### Known Sensitive Strings
- **Stripe**: `sk_live_`, `pk_live_`, `sk_test_`, `pk_test_`
- **Google**: `AIza` (API keys)
- **AWS**: `AKIA`, `AKIB`, `AKIC`, etc. (Access keys)
- **GitHub**: `ghp_`, `gho_`, `ghu_`, `ghs_`, `ghr_` (Tokens)
- **Slack**: `xoxb-`, `xoxp-`, `xoxa-`, `xoxr-`, `xoxs-`, `xoxo-` (Tokens)
- **Facebook**: `EAAA`, `EAAB`, `EAAC`, etc. (Tokens)

#### Comment Patterns
- `TODO.*password`, `FIXME.*api.*key`, `NOTE.*secret`
- `HACK.*token`, `BUG.*credential`, `XXX.*auth`

## Usage

### Basic Usage
```bash
./script/security-scan.sh
```

### Integration with CI/CD
```yaml
# Example GitHub Actions workflow
- name: Security Scan
  run: |
    chmod +x ./script/security-scan.sh
    ./script/security-scan.sh
```

### Pre-commit Hook
```bash
#!/bin/bash
# .git/hooks/pre-commit
if ! ./script/security-scan.sh; then
    echo "Security scan failed. Please fix issues before committing."
    exit 1
fi
```

## Output

### Color-Coded Results
- 🔵 **INFO**: General information and progress
- 🟢 **SUCCESS**: No issues found
- 🟡 **WARNING**: Issues that should be reviewed
- 🔴 **ERROR**: Script errors
- 🟣 **CRITICAL**: Security issues that must be addressed

### Exit Codes
- `0`: No critical issues found
- `1`: Critical security issues detected

### Example Output
```
[INFO] Starting Flutter Security Scan...
======================================

[INFO] Scanning for sensitive file types...
[SUCCESS] No sensitive file types found

[INFO] Scanning for hardcoded credentials in code...
[CRITICAL] Found hardcoded credential pattern in: ./lib/config.dart
[INFO]   Pattern: api_key.*=.*['"][^'"]*['"]

[INFO] Scanning for specific sensitive strings...
[CRITICAL] Found sensitive string 'sk_live_' in: ./lib/payment.dart

[INFO] Checking .gitignore for sensitive file patterns...
[SUCCESS] .gitignore contains all recommended sensitive file patterns

[INFO] Scanning comments for sensitive information...
[WARNING] Found comment with sensitive reference in: ./lib/auth.dart
[INFO]   Pattern: TODO.*password

======================================
[CRITICAL] Security scan completed with issues found!

[INFO] Summary:
  🔴 Critical issues: 2
  🟡 Warning issues: 1
  📊 Total issues: 3

[CRITICAL] CRITICAL: Found 2 critical security issues that must be addressed!
[CRITICAL] Please review and fix these issues before committing to version control.
```

## Configuration

### Excluded Directories
The scanner automatically excludes:
- `.git/` - Version control
- `build/` - Build artifacts
- `.dart_tool/` - Dart tool cache
- `ios/Pods/` - iOS dependencies
- `android/.gradle/` - Android build cache
- `android/build/` - Android build artifacts
- `script/` - Script files (to avoid false positives)
- `node_modules/` - Node.js dependencies

### Customization
You can modify the script to:
- Add new sensitive string patterns
- Exclude additional directories
- Change severity levels
- Add custom file type checks

## Best Practices

### 1. **Regular Scanning**
- Run the scanner before each commit
- Include in CI/CD pipelines
- Schedule periodic scans

### 2. **Environment Variables**
Instead of hardcoding credentials:
```dart
// ❌ Bad
static const String apiKey = 'sk_live_1234567890';

// ✅ Good
static const String apiKey = String.fromEnvironment('STRIPE_API_KEY');
```

### 3. **Secure Storage**
Use secure storage solutions:
- Flutter Secure Storage
- Platform-specific keychains
- Environment variables
- CI/CD secrets

### 4. **Configuration Files**
- Keep sensitive configs out of version control
- Use template files with placeholder values
- Document required environment variables

## Troubleshooting

### Common Issues

#### False Positives
If the scanner flags legitimate code:
1. Review the flagged content
2. Consider if it's actually sensitive
3. Add exclusion patterns if needed
4. Document why the pattern is safe

#### Permission Denied
```bash
chmod +x script/security-scan.sh
```

#### Missing Tools
Ensure `grep` and `find` are installed:
```bash
# macOS
brew install grep findutils

# Ubuntu/Debian
sudo apt-get install grep findutils
```

### Performance
For large projects, the scanner may take time. Consider:
- Running during off-peak hours
- Excluding more directories
- Using parallel processing (future enhancement)

## Security Notes

⚠️ **Important**: This scanner helps identify potential security issues but should not be your only security measure. Always:

1. Follow security best practices
2. Use proper secret management
3. Regularly audit your code
4. Keep dependencies updated
5. Use secure communication channels
6. Implement proper authentication and authorization

## Contributing

To improve the security scanner:

1. Add new sensitive string patterns
2. Improve detection accuracy
3. Add support for new file types
4. Enhance performance
5. Add more configuration options

## License

This security scanner is part of the Flutter Design Animations project and follows the same license terms.
