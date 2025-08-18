# Security Scanning Scripts

This directory contains security-related scripts for the Flutter project.

## security_scan.sh

A comprehensive security scanner that checks for sensitive information, passwords, API keys, and credentials that might be hardcoded or committed to version control.

### Features

- **Pattern-based scanning**: Detects common sensitive patterns like API keys, passwords, tokens
- **Hardcoded value detection**: Finds hardcoded sensitive values in code
- **Git history analysis**: Checks for sensitive data in git history
- **Environment file validation**: Ensures .env files are properly ignored
- **Gitignore verification**: Checks if sensitive files are properly excluded
- **Comprehensive coverage**: Scans Dart, YAML, JSON, XML, and other relevant file types

### Usage

```bash
# Run the security scan
./scripts/security_scan.sh

# Or from project root
bash scripts/security_scan.sh
```

### What it scans for

#### API Keys and Tokens
- `api_key`, `api_token`, `access_token`
- `secret_key`, `private_key`, `client_secret`
- `app_secret`, `service_account`

#### Passwords and Credentials
- `password`, `passwd`, `pwd`
- `credential`, `auth_token`
- `bearer_token`, `jwt_token`

#### Database and Connection Strings
- `database_url`, `db_url`
- `connection_string`
- `mongodb_uri`, `postgres_url`, `mysql_url`

#### Cloud Services
- AWS access keys and secrets
- Firebase configuration
- Google API keys
- Stripe keys, Twilio tokens

#### Common Patterns
- Stripe keys (`sk_`, `pk_`)
- Google API keys (`AIza...`)
- AWS ARNs and access keys
- OAuth tokens

### Scanned Directories
- `lib/` - Main Dart code
- `android/` - Android-specific files
- `ios/` - iOS-specific files
- `web/` - Web-specific files
- `test/` - Test files
- `docs/` - Documentation

### Excluded Directories
- `build/` - Build artifacts
- `.dart_tool/` - Dart tool cache
- `node_modules/` - Node.js dependencies
- `.git/` - Git repository
- Generated files (`*.g.dart`, `*.freezed.dart`)

### Output

The script provides:
- ✅ Green: No issues found
- ⚠️ Yellow: Warnings and recommendations
- ❌ Red: Potential security issues found

### Exit Codes
- `0`: No security issues found
- `1`: Security issues detected

### Best Practices

1. **Run before commits**: Use this script as a pre-commit hook
2. **Regular scanning**: Run periodically during development
3. **CI/CD integration**: Include in your CI/CD pipeline
4. **Review findings**: Always review and validate detected issues
5. **Update patterns**: Add new patterns as your project evolves

### Integration with Git Hooks

Add to `.git/hooks/pre-commit`:

```bash
#!/bin/bash
if ! ./scripts/security_scan.sh; then
    echo "Security scan failed. Please fix issues before committing."
    exit 1
fi
```

### Customization

You can customize the script by modifying:
- `SCAN_DIRS`: Directories to scan
- `EXCLUDE_DIRS`: Directories to exclude
- `PATTERNS`: Patterns to search for
- `SCAN_EXTENSIONS`: File extensions to scan

### Dependencies

- Bash shell
- grep (with regex support)
- find
- git (for history scanning)

### Security Notes

- This script only detects patterns and doesn't validate if found values are actually sensitive
- Always review findings manually
- Consider using additional tools like `truffleHog` or `git-secrets` for more comprehensive scanning
- Keep the script updated with new patterns and best practices
