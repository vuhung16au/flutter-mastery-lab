# Flutter Advanced Concepts

A comprehensive Flutter application demonstrating advanced concepts including Firebase integration, HTTP APIs, device features, and more.

## Features

### 🔥 Firebase Integration
- **Read and Write Data on Firebase**: Complete CRUD operations with Cloud Firestore
- Real-time data synchronization
- User and post management
- Data validation and error handling

### 📧 Mail and SMS
- **Email functionality**: Send emails using device's email app
- **SMS functionality**: Send text messages using device's SMS app
- Form validation and error handling
- Multiple recipient support

### 📞 Making Calls
- **Phone call functionality**: Make calls directly from the app
- Contact selection and management
- Phone number validation and formatting
- Call confirmation dialogs

### ⚡ FAB Speed Dial
- **Floating Action Button Speed Dial**: Quick access to multiple actions
- Customizable animations and styling
- Conditional visibility
- Multiple positioning options

### 🔋 Wakelock
- **Screen wake management**: Prevent device from sleeping
- Duration-based wakelock
- Battery optimization considerations
- Use case implementations (video player, games)

### 🌐 REST API Integration
- **HTTP GET Response handling**: Complete API integration
- JSON parsing and data models
- Error handling and retry logic
- Response caching
- Dio and http package implementations

## Project Structure

```
lib/
├── main.dart                 # Main application entry point
├── models/                   # Data models (User, Post, etc.)
├── services/                 # Business logic services
├── providers/                # State management
└── widgets/                  # UI components

docs/
├── firebase-integration.md   # Firebase documentation
├── mail-sms.md              # Email and SMS documentation
├── making-calls.md          # Phone call documentation
├── fab-speed-dial.md        # Speed dial documentation
├── wakelock.md              # Wakelock documentation
├── rest-api.md              # REST API documentation
└── http-get-response.md     # HTTP GET response documentation

assets/
├── images/                  # Image assets
└── icons/                   # Icon assets
```

## Dependencies

### Core Dependencies
- `flutter`: Flutter SDK
- `provider`: State management
- `firebase_core`: Firebase initialization
- `cloud_firestore`: Cloud Firestore database
- `firebase_auth`: Firebase authentication

### HTTP and API
- `http`: HTTP client for API requests
- `dio`: Advanced HTTP client with interceptors
- `json_annotation`: JSON serialization

### Device Features
- `url_launcher`: Launch external apps (email, SMS, phone)
- `wakelock_plus`: Screen wake management

### UI Components
- `flutter_speed_dial`: Speed dial floating action button
- `cupertino_icons`: iOS-style icons

## Setup Instructions

### 1. Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Firebase project setup

### 2. Installation
```bash
# Clone the repository
git clone <repository-url>

# Navigate to the project directory
cd 07-Flutter-Advanced-Concepts

# Install dependencies
flutter pub get

# Run the application
flutter run
```

### 3. Firebase Setup
1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Add your Android and iOS apps to the project
3. Download configuration files:
   - `google-services.json` for Android
   - `GoogleService-Info.plist` for iOS
4. Place the files in the appropriate directories:
   - Android: `android/app/google-services.json`
   - iOS: `ios/Runner/GoogleService-Info.plist`

### 4. Platform Configuration

#### Android
Add permissions to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.SEND_SMS" />
<uses-permission android:name="android.permission.CALL_PHONE" />
<uses-permission android:name="android.permission.WAKE_LOCK" />
```

**Note**: The project is configured with:
- `minSdk = 23` (required for Firebase)
- `ndkVersion = "27.0.12077973"` (required for Firebase plugins)

#### iOS
Add to `ios/Runner/Info.plist`:
```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>mailto</string>
    <string>sms</string>
    <string>tel</string>
    <string>telprompt</string>
</array>
```

**Note**: The project is configured with:
- `platform :ios, '13.0'` (required for Firebase)
- `MinimumOSVersion = 13.0` (required for Firebase)

## Usage

### Firebase Operations
- **Add User**: Fill the form and tap "Add User"
- **View Users**: Users are displayed in a list with contact options
- **Add Post**: Create posts with title and content
- **View Posts**: Posts are displayed with creation dates

### Communication Features
- **Email**: Tap email icon to open email app
- **SMS**: Tap SMS icon to open SMS app
- **Phone**: Tap phone icon to make calls
- **Speed Dial**: Use the floating action button for quick access

### API Integration
- **View API Posts**: Fetches posts from JSONPlaceholder API
- **Error Handling**: Displays error messages and retry options
- **Loading States**: Shows loading indicators during API calls

### Wakelock
- **Toggle Wakelock**: Use the switch to enable/disable screen wake
- **Status Display**: Shows current wakelock status
- **Battery Considerations**: Automatic timeout for battery optimization

## Key Concepts Demonstrated

### State Management
- Provider pattern for app-wide state
- Reactive UI updates
- Loading and error state handling

### Error Handling
- Comprehensive error handling for all operations
- User-friendly error messages
- Retry mechanisms

### Data Models
- JSON serialization with json_annotation
- Type-safe data handling
- Model validation

### UI/UX
- Material Design 3
- Responsive layouts
- Loading states and feedback
- Accessibility considerations

## Best Practices Implemented

1. **Code Organization**: Clear separation of concerns
2. **Error Handling**: Comprehensive error management
3. **State Management**: Efficient state updates
4. **Performance**: Optimized data fetching and caching
5. **User Experience**: Intuitive UI with proper feedback
6. **Platform Compatibility**: Cross-platform considerations
7. **Security**: Proper permission handling
8. **Testing**: Error scenarios and edge cases

## Troubleshooting

### Common Issues

1. **Firebase Connection Error**
   - Verify Firebase configuration files
   - Check internet connection
   - Ensure Firebase project is properly set up

2. **Permission Denied**
   - Check platform-specific permissions
   - Verify manifest/plist configurations
   - Test on physical device

3. **API Request Failures**
   - Check internet connection
   - Verify API endpoints
   - Review error handling

4. **Build Errors**
   - Run `flutter clean` and `flutter pub get`
   - Check dependency versions
   - Verify Flutter SDK version

5. **Android Build Issues**
   - Ensure `minSdk = 23` in `android/app/build.gradle.kts`
   - Verify `ndkVersion = "27.0.12077973"`
   - Check that all Firebase configuration files are in place

6. **iOS Build Issues**
   - Ensure `platform :ios, '13.0'` in `ios/Podfile`
   - Verify `MinimumOSVersion = 13.0` in `ios/Flutter/AppFrameworkInfo.plist`
   - Run `flutter clean` and `flutter pub get`

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions:
- Check the documentation in the `docs/` folder
- Review the code comments
- Open an issue on GitHub

## Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- All package authors for their contributions
