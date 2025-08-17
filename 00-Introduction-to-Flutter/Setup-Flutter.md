# Setup Flutter

Flutter is Google's UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase. This guide will walk you through the process of setting up Flutter on your development machine.

## Prerequisites

Before installing Flutter, ensure you have the following prerequisites installed:

### For Windows:
- **Git for Windows**: Download and install from [git-scm.com](https://git-scm.com/downloads/win)
- **Visual Studio Code** (recommended): Download from [code.visualstudio.com](https://code.visualstudio.com/)

### For macOS:
- **Xcode Command Line Tools**: Run `xcode-select --install` in Terminal
- **Visual Studio Code** (recommended): Download from [code.visualstudio.com](https://code.visualstudio.com/)

### For Linux:
- **Required packages**: Install using your package manager
  ```bash
  sudo apt-get update -y && sudo apt-get upgrade -y
  sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa
  ```
- **Visual Studio Code** (recommended): Download from [code.visualstudio.com](https://code.visualstudio.com/)

## Install Flutter

### Using Visual Studio Code (Recommended)

This is the easiest and most streamlined way to install Flutter:

1. **Launch VS Code**
   - Open Visual Studio Code on your system

2. **Install Flutter Extension**
   - Go to the Extensions view (Ctrl+Shift+X or Cmd+Shift+X)
   - Search for "Flutter" and install the official Flutter extension by Dart Code
   - This will also install the Dart extension automatically

3. **Install Flutter SDK through VS Code**
   - Open the Command Palette (Ctrl+Shift+P or Cmd+Shift+P)
   - Type "Flutter: New Project"
   - Select "Flutter: New Project"
   - When prompted to locate Flutter SDK, choose "Download SDK"
   - Select a folder where you want to install Flutter
   - Click "Clone Flutter" and wait for the download to complete
   - Click "Add SDK to PATH" when prompted

4. **Verify Installation**
   - Open a new terminal and run:
   ```bash
   flutter --version
   dart --version
   ```

### Using Manual Installation

If you prefer to install Flutter manually or need more control over the installation:

#### Step 1: Download Flutter SDK

**For Windows:**
- Download the latest Flutter SDK from [flutter.dev](https://docs.flutter.dev/get-started/install/windows)
- Extract the ZIP file to a location like `C:\Users\{username}\develop\flutter`

**For macOS:**
- Download the latest Flutter SDK from [flutter.dev](https://docs.flutter.dev/get-started/install/macos)
- Extract the file to a location like `~/develop/flutter`

**For Linux:**
- Download the latest Flutter SDK from [flutter.dev](https://docs.flutter.dev/get-started/install/linux)
- Extract the file to a location like `~/develop/flutter`

#### Step 2: Add Flutter to PATH

**For Windows:**
1. Open System Properties → Advanced → Environment Variables
2. Under "User variables", find or create "Path"
3. Add the path to Flutter's bin directory: `C:\Users\{username}\develop\flutter\bin`
4. Click OK to save

**For macOS/Linux:**
1. Open your shell profile file (`.bash_profile`, `.zshrc`, etc.)
2. Add the following line:
   ```bash
   export PATH="$HOME/develop/flutter/bin:$PATH"
   ```
3. Save the file and restart your terminal

#### Step 3: Verify Installation

Run the following commands to verify your installation:

```bash
flutter --version
dart --version
```

## Verify Your Setup

After installation, run Flutter doctor to check if your setup is complete:

```bash
flutter doctor
```

This command will check your Flutter installation and report any issues that need to be resolved. Common issues include:

- Missing Android Studio or Xcode
- Missing Android SDK
- Missing iOS development tools (macOS only)
- Missing VS Code extensions

## Install Required Tools

### For Android Development:
1. Install [Android Studio](https://developer.android.com/studio)
2. Install Android SDK
3. Set up Android emulator or connect a physical device

### For iOS Development (macOS only):
1. Install [Xcode](https://developer.apple.com/xcode/)
2. Install iOS Simulator
3. Accept Xcode license agreements

### For Web Development:
1. Enable web support: `flutter config --enable-web`
2. Install Chrome browser for testing

## Next Steps

Once Flutter is installed and configured:

1. **Create Your First App**:
   ```bash
   flutter create my_first_app
   cd my_first_app
   flutter run
   ```

2. **Set up an IDE**:
   - Install Flutter and Dart extensions in VS Code
   - Or use Android Studio with Flutter plugin

3. **Choose a Target Platform**:
   - **Web**: Easiest to start with, no additional setup required
   - **Android**: Requires Android Studio and SDK
   - **iOS**: Requires Xcode (macOS only)
   - **Desktop**: Requires additional setup for Windows/macOS/Linux

## Troubleshooting

If you encounter issues during installation:

1. **Check Flutter Doctor**: Run `flutter doctor -v` for detailed information
2. **Verify PATH**: Ensure Flutter is in your system PATH
3. **Check Permissions**: Ensure you have write permissions to the installation directory
4. **Network Issues**: Some downloads may be blocked by corporate firewalls

For more detailed troubleshooting, visit the [Flutter installation troubleshooting guide](https://docs.flutter.dev/get-started/install/troubleshoot).

## Additional Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Flutter GitHub Repository](https://github.com/flutter/flutter)
- [Flutter Community](https://flutter.dev/community)
- [Flutter YouTube Channel](https://www.youtube.com/@flutterdev)

---

**Note**: This guide covers the basic setup for Flutter development. For platform-specific setup (Android, iOS, Web, Desktop), refer to the official Flutter documentation for detailed instructions.