# hello_flutter

A simple Flutter app demonstrating cross-platform development. This document shows how to run and build it on each platform.

## The App

The main part of this hello world app is as simple as:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('G\'day from Sydney!'),
        ),
      ),
    );
  }
}
```

## Prerequisites

- Flutter SDK (stable) installed and on PATH
- VS Code or Android Studio (optional but handy)
- Platform toolchains as needed:
	- Android: Android Studio + SDK, an emulator or device
	- iOS/macOS: Xcode + Command Line Tools, a Simulator or device
	- Web: a recent Chrome/Safari/Edge; enable web in Flutter

Verify setup:

```bash
flutter doctor -v
```

## Get dependencies

From the project root (this folder):

```bash
flutter pub get
```

## Run (debug)

List available devices/simulators:

```bash
flutter devices
```

Then pick one of the targets below.

### Android (run)

```bash
# Start an emulator from Android Studio or `emulator -avd <name>` first
# Run on the currently active Android device/emulator
flutter run -d android

# Or target a specific device ID shown by `flutter devices` (example)
flutter run -d emulator-5554

# List available Android emulators and launch one (optional)
flutter emulators
flutter emulators --launch <emulator_id>
```

### iOS (run on Simulator or device)

```bash
# Open the iOS Simulator (optional)
open -a Simulator

# List all devices and copy the Simulator name or UDID
flutter devices
```

You will see the list of available iOS devices and simulators.

```bash
vuhung@vhM1  ~/Desktop/flutter-playground/HelloFlutter/hello_flutter  main  flutter run -d ios

No devices found yet. Checking for wireless devices...

No supported devices found with name or id matching 'ios'.

The following devices were found:
sdk gphone16k arm64 (mobile) • emulator-5554                        • android-arm64  • Android 16 (API 36)
(emulator)
iPhone 16 Plus (mobile)      • ACBDC51A-4700-42DA-89EA-89DB2B402467 • ios            •
com.apple.CoreSimulator.SimRuntime.iOS-18-4 (simulator)
macOS (desktop)              • macos                                • darwin-arm64   • macOS 15.6 24G84
darwin-arm64
Chrome (web)                 • chrome                               • web-javascript • Google Chrome
139.x.y.z
```

```bash
# Run by exact Simulator name (quote if it has spaces)
flutter run -d "iPhone 16 Plus"

# Or run by Simulator UDID (example)
flutter run -d ACBDC51A-4700-42DA-89EA-89DB2B402467
```

Notes:

- Use an exact device name or UDID from `flutter devices`. The alias `ios` is not a device ID and may fail with "No supported devices found with name or id matching 'ios'".
- For a physical iPhone, trust the device, enable Developer Mode, then open `ios/Runner.xcworkspace` in Xcode and set a Development Team under Signing & Capabilities.

### macOS Desktop (run)

```bash
flutter config --enable-macos-desktop
flutter run -d macos
```

### Web (run)

```bash
flutter config --enable-web
flutter run -d chrome
```

## Build (release)

Run these from the project root. Artifacts will be created under `build/`.

### Android (build)

```bash
# APK (good for sideloading/testing)
flutter build apk --release

# App Bundle (for Play Store)
flutter build appbundle --release
```

### iOS (build)

```bash
# Produces an Xcode archive; finalize signing in Xcode Organizer
flutter build ios --release

# Alternatively (modern flow) to create an .ipa
flutter build ipa --export-method ad-hoc
```

### macOS (build)

```bash
flutter build macos --release
```

**Expected output:**
```
Building macOS application...
✓ Built build/macos/Build/Products/Release/hello_flutter.app (46.5MB)
```

**Generated files:**
- `build/macos/Build/Products/Release/hello_flutter.app` - The main macOS application bundle (46.5MB)
- `build/macos/Build/Products/Release/hello_flutter.app.dSYM` - Debug symbols for crash reporting
- `build/macos/Build/Products/Release/App.framework` - Your Flutter app's framework
- `build/macos/Build/Products/Release/FlutterMacOS.framework` - Flutter's macOS framework

**To run the built macOS app:**
```bash
open build/macos/Build/Products/Release/hello_flutter.app
```

**Distribution options:**
- Zip the `.app` bundle and share with other macOS users
- Submit to Mac App Store (requires proper code signing)
- Create a DMG installer for easier distribution

### Web (build)

```bash
flutter build web --release
```

**Expected output:**
```
Compiling lib/main.dart for the Web...                             13.3s
✓ Built build/web
```

**Generated files:**
- `build/web/index.html` - The main HTML file that loads your Flutter web app
- `build/web/main.dart.js` - The compiled Dart code (1.6MB)
- `build/web/flutter.js` - Flutter web runtime
- `build/web/flutter_service_worker.js` - Service worker for offline functionality
- `build/web/manifest.json` - Web app manifest for PWA features
- `build/web/favicon.png` - App icon
- `build/web/assets/` - Contains app assets
- `build/web/canvaskit/` - CanvasKit renderer files

**To serve the web app locally:**
```bash
cd build/web && python3 -m http.server 8000
```

Then access at: **http://localhost:8000**

**Deployment options:**
- Firebase Hosting: `firebase deploy`
- Netlify: Drag and drop the `build/web` folder
- Vercel: Connect your repository and set build output to `build/web`
- Any traditional web server

## Build Notes

### Web Build Optimizations
- Material Icons font is tree-shaken by 99.5% (from 1.6MB to 7.7KB)
- Tree-shaking can be disabled with `--no-tree-shake-icons` flag
- The app includes PWA (Progressive Web App) capabilities

### macOS Build Features
- Built for both ARM64 (Apple Silicon) and x86_64 (Intel) architectures
- Release build optimized for performance
- Includes all necessary frameworks and dependencies
- Ready for distribution and App Store submission

## Useful scripts

```bash
# Clean build artifacts
flutter clean && flutter pub get

# Show Flutter/Dart versions
flutter --version

# Check available devices
flutter devices

# Enable platform support
flutter config --enable-web
flutter config --enable-macos-desktop
```

## Troubleshooting

- Run `flutter doctor -v` and follow its suggestions.
- Android licenses: `flutter doctor --android-licenses`.
- iOS CocoaPods: ensure CocoaPods is installed (`sudo gem install cocoapods`), then:
  
```bash
cd ios && pod install && cd -
```

- iOS code signing: open `ios/Runner.xcworkspace` in Xcode, set a Team under Signing & Capabilities.
- If device discovery fails, restart the IDE and run `flutter devices` again.
- For web builds, ensure you have a modern browser and web support is enabled.
- For macOS builds, ensure Xcode and Command Line Tools are properly installed.

