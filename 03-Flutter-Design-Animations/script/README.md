# Flutter Smoke Test Script

This directory contains automation scripts for the Flutter project.

## `flutter-smoke.sh`

A comprehensive smoke test script that validates the Flutter project's health and build capabilities.

### What it does

The script runs the following Flutter commands in sequence:

1. **`flutter doctor`** - Checks Flutter installation and environment
2. **`flutter analyze`** - Analyzes code for issues and warnings
3. **`flutter test`** - Runs all unit and widget tests
4. **`flutter build ios --no-codesign`** - Builds iOS app without codesigning
5. **`flutter build apk`** - Builds Android APK

### Usage

```bash
# Make sure you're in the project root directory
cd /path/to/flutter_design_animations

# Run the smoke test
./script/flutter-smoke.sh
```

### Features

- ✅ **Colored output** for better readability
- ✅ **Error handling** with proper exit codes
- ✅ **Progress tracking** with step-by-step status
- ✅ **Build artifact locations** displayed at the end
- ✅ **Comprehensive validation** of project health

### Exit Codes

- `0` - All tests passed successfully
- `1` - One or more steps failed

### Output

The script provides clear, colored output indicating:
- `[INFO]` - General information and progress
- `[SUCCESS]` - Successful completion of steps
- `[WARNING]` - Important notes (like iOS codesigning)
- `[ERROR]` - Failures that caused the script to exit

### Build Artifacts

After successful completion, the script creates:

- **iOS**: `build/ios/iphoneos/Runner.app` (53.8MB)
- **Android**: `build/app/outputs/flutter-apk/app-release.apk` (21.5MB)

### Notes

- The iOS build is created without codesigning for faster builds
- Manual codesigning is required for iOS device deployment
- The script exits on first failure to prevent cascading issues
- All Flutter commands are run with their default settings

### Use Cases

- **CI/CD Pipelines** - Automated testing and building
- **Pre-commit Validation** - Ensure code quality before commits
- **Release Preparation** - Validate builds before distribution
- **Development Workflow** - Quick project health check

### Requirements

- Flutter SDK installed and in PATH
- macOS with Xcode (for iOS builds)
- Android SDK (for Android builds)
- Sufficient disk space for build artifacts (~75MB)
