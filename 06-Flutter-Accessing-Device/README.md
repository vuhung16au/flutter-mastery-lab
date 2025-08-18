# Flutter - Advanced Concepts

A comprehensive Flutter project demonstrating advanced concepts including device access capabilities, Firebase integration, mail/SMS functionality, phone calls, speed dial, wakelock, and REST API integration.

## Features

### 🎯 Implemented Components

#### Device Access
1. **Gallery Access** - Select images and videos from device gallery
2. **Camera Access** - Take photos and record videos using device camera
3. **Background Local Notifications** - Schedule and manage local notifications
4. **Landscape Mode Restriction** - Control device orientation

#### Advanced Concepts
5. **Firebase Read/Write** - Integrate with Firebase Firestore for data persistence
6. **Mail and SMS** - Send emails and SMS messages using device apps
7. **Making Calls** - Make phone calls directly from the app
8. **FAB Speed Dial** - Implement floating action button with speed dial
9. **Wakelock** - Keep screen awake during specific operations
10. **REST API Integration** - Make HTTP requests and handle responses
11. **HTTP GET Response** - Parse and display API data

### 📱 Device Access Capabilities

- **Camera Integration**: Take photos and record videos
- **Gallery Access**: Select multiple images and videos
- **Permission Management**: Handle camera, storage, and notification permissions
- **Device Information**: Display device details and capabilities
- **Orientation Control**: Restrict or allow different screen orientations
- **Local Notifications**: Schedule and manage background notifications

### 🚀 Advanced Features

- **Firebase Integration**: Real-time database operations with Firestore
- **Communication**: Email, SMS, and phone call capabilities
- **UI Enhancement**: Speed dial floating action button
- **Power Management**: Screen wake lock control
- **API Integration**: HTTP requests and JSON parsing
- **Data Management**: CRUD operations with external APIs

## Getting Started

### Prerequisites

- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- Physical device or emulator for testing

### Installation

1. **Clone the project**:
   ```bash
   cd 06-Flutter-Accessing-Device
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

## Dependencies

This project uses the following key packages:

### Device Access
- `image_picker: ^1.0.7` - Camera and gallery access
- `permission_handler: ^11.3.1` - Permission management
- `flutter_local_notifications: ^17.2.2` - Local notifications
- `device_info_plus: ^10.1.0` - Device information
- `flutter/services.dart` - Orientation control (built-in)
- `path_provider: ^2.1.4` - File system access
- `path: ^1.9.0` - Path manipulation

### Advanced Concepts
- `firebase_core: ^3.6.0` - Firebase core functionality
- `firebase_auth: ^5.3.1` - Firebase authentication
- `cloud_firestore: ^5.4.1` - Firestore database
- `firebase_storage: ^12.3.1` - Firebase storage
- `url_launcher: ^6.3.1` - Launch URLs, emails, SMS, calls
- `flutter_phone_direct_caller: ^2.1.1` - Direct phone calls
- `flutter_speed_dial: ^7.0.0` - Speed dial floating action button
- `wakelock_plus: ^1.1.4` - Keep screen awake
- `http: ^1.2.2` - HTTP requests
- `json_annotation: ^4.9.0` - JSON serialization
- `json_serializable: ^6.8.0` - JSON code generation
- `build_runner: ^2.4.13` - Code generation

## Usage

### Device Access
- **Camera & Gallery**: Tap "Take Photo" to capture images, "Gallery" to select images, "Record Video" to record videos
- **Notifications**: Tap "Show Now" for immediate notification, "Schedule" for delayed notification, "Cancel All" to remove notifications
- **Orientation Control**: Use the orientation toggle button to switch between portrait-only and all orientations

### Advanced Concepts
- **Email & SMS**: Use the buttons in the Advanced Concepts section to send emails and SMS
- **Phone Calls**: Tap the "Call" button to make direct phone calls
- **Wakelock**: Toggle screen wake lock to keep the screen on during operations
- **API Testing**: Tap "Test API Call" to fetch data from a REST API
- **Speed Dial**: Use the floating action button to access quick actions

## Permissions Required

### Android
- `android.permission.CAMERA`
- `android.permission.READ_EXTERNAL_STORAGE`
- `android.permission.WRITE_EXTERNAL_STORAGE`
- `android.permission.RECEIVE_BOOT_COMPLETED`
- `android.permission.CALL_PHONE`
- `android.permission.READ_PHONE_STATE`
- `android.permission.WAKE_LOCK`
- `android.permission.QUERY_ALL_PACKAGES`

### iOS
- `NSCameraUsageDescription`
- `NSPhotoLibraryUsageDescription`
- `NSPhotoLibraryAddUsageDescription`
- `LSApplicationQueriesSchemes` (for mailto, sms, tel)



## Documentation

Comprehensive documentation for each component is available in the `docs/` folder:

### Device Access
- [Gallery Access](docs/gallery-access.md)
- [Camera Access](docs/camera-access.md)
- [Local Notifications](docs/notifications.md)
- [Landscape Mode Restriction](docs/landscape-mode-restriction.md)

### Advanced Concepts
- [Firebase Read/Write](docs/firebase-read-write.md)
- [Mail and SMS](docs/mail-sms.md)
- [Making Calls](docs/making-calls.md)
- [FAB Speed Dial](docs/fab-speed-dial.md)
- [Wakelock](docs/wakelock.md)
- [REST API](docs/rest-api.md)
- [HTTP GET Response](docs/http-get-response.md)

## Project Structure

```
06-Flutter-Accessing-Device/
├── lib/
│   └── main.dart              # Main application with all components
├── docs/
│   ├── gallery-access.md      # Gallery access documentation
│   ├── camera-access.md       # Camera access documentation
│   ├── notifications.md       # Notifications documentation
│   ├── landscape-mode-restriction.md # Orientation control documentation
│   ├── firebase-read-write.md # Firebase integration documentation
│   ├── mail-sms.md           # Mail and SMS documentation
│   ├── making-calls.md       # Phone calls documentation
│   ├── fab-speed-dial.md     # Speed dial documentation
│   ├── wakelock.md           # Wakelock documentation
│   ├── rest-api.md           # REST API documentation
│   ├── http-get-response.md  # HTTP GET response documentation
│   └── README.md             # Project overview
├── pubspec.yaml              # Dependencies and configuration
└── README.md                 # This file
```

## Testing

### Manual Testing
1. Test camera functionality on a physical device
2. Verify gallery access with different image types
3. Test notification scheduling and display
4. Verify orientation changes work correctly

### Automated Testing
```bash
flutter test
```

## Troubleshooting

### Common Issues

1. **Camera not working**: Ensure camera permissions are granted
2. **Gallery access denied**: Check storage permissions
3. **Notifications not showing**: Verify notification permissions
4. **Orientation not changing**: Check device auto-rotate settings

### Debug Tips

- Use `flutter doctor` to check Flutter installation
- Check device logs for permission-related errors
- Test on different Android/iOS versions
- Verify manifest file configurations

## Contributing

1. Fork the project
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is part of the Flutter Playground learning series.

## Support

For issues and questions, please refer to the documentation in the `docs/` folder or create an issue in the repository.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
