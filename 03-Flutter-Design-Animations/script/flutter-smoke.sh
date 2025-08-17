#!/bin/bash

# Flutter Smoke Test Script
# This script runs a comprehensive set of Flutter commands to verify project health
# and build capabilities for both iOS and Android platforms.

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
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

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if Flutter is installed
if ! command_exists flutter; then
    print_error "Flutter is not installed or not in PATH"
    exit 1
fi

print_status "Starting Flutter Smoke Test..."
echo "=================================="

# Step 1: Flutter Doctor
print_status "Step 1/5: Running 'flutter doctor'..."
if flutter doctor; then
    print_success "Flutter doctor completed successfully"
else
    print_error "Flutter doctor failed"
    exit 1
fi
echo

# Step 2: Flutter Analyze
print_status "Step 2/5: Running 'flutter analyze'..."
if flutter analyze; then
    print_success "Flutter analyze completed successfully - No issues found"
else
    print_warning "Flutter analyze found issues - Check the output above"
    # Don't exit here as we want to continue with tests and builds
fi
echo

# Step 3: Flutter Test
print_status "Step 3/5: Running 'flutter test'..."
if flutter test; then
    print_success "Flutter test completed successfully - All tests passed"
else
    print_error "Flutter test failed"
    exit 1
fi
echo

# Step 4: Flutter Build iOS (without codesign)
print_status "Step 4/5: Running 'flutter build ios --no-codesign'..."
print_warning "Building for iOS without codesigning - manual codesigning required for device deployment"
if flutter build ios --no-codesign; then
    print_success "iOS build completed successfully"
    print_status "iOS build location: build/ios/iphoneos/Runner.app"
else
    print_error "iOS build failed"
    exit 1
fi
echo

# Step 5: Flutter Build APK
print_status "Step 5/5: Running 'flutter build apk'..."
if flutter build apk; then
    print_success "Android APK build completed successfully"
    print_status "APK build location: build/app/outputs/flutter-apk/app-release.apk"
else
    print_error "Android APK build failed"
    exit 1
fi
echo

# Summary
echo "=================================="
print_success "🎉 Flutter Smoke Test Completed Successfully!"
echo
print_status "Build artifacts created:"
echo "  📱 iOS: build/ios/iphoneos/Runner.app"
echo "  🤖 Android: build/app/outputs/flutter-apk/app-release.apk"
echo
print_warning "Note: iOS build was created without codesigning. Manual codesigning required for device deployment."
echo
print_status "All smoke tests passed! ✅"
