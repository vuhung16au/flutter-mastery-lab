# hello_flutter

Simple Flutter app. This doc shows how to run and build it on each platform.

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
vuhung@vhM1  ~/Desktop/flutter-playground/HelloFlutter/hello_flutter   main  flutter run -d ios

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

### Web (build)

```bash
flutter build web --release
```

## Useful scripts

```bash
# Clean build artifacts
flutter clean && flutter pub get

# Show Flutter/Dart versions
flutter --version
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

