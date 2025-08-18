# Flutter Navigation & Routing Demo

A comprehensive Flutter application demonstrating various navigation and routing capabilities, including basic navigation, named routes, data passing, tabs, drawers, deep linking, and more advanced features.

## 🚀 Features

### Core Navigation Features
- **Basic Navigation**: Using `Navigator.push()` and `Navigator.pop()`
- **Named Routes**: Route-based navigation with predefined routes
- **Arguments in Named Routes**: Passing data through named routes
- **Return Data from Screen**: Getting data back from navigated screens
- **Send Data to Screen**: Passing data between screens
- **Route Settings**: Using RouteSettings for data passing

### Advanced Navigation Features
- **Tabbed Navigation**: Using `TabBar` and `TabBarView`
- **Drawer Navigation**: Custom drawer implementation
- **Deep Linking**: Handling custom URL schemes
- **App Links & Universal Links**: Android App Links and iOS Universal Links
- **URL Strategies**: Path vs Hash URL strategies for web

### Data & API Features
- **Text Fields Data**: Retrieving data from form inputs
- **WebSockets**: Real-time communication
- **HTTP Operations**: Fetching, sending, updating, and deleting data
- **Avoiding Jank**: Performance optimization techniques

## 📁 Project Structure

```
lib/
├── main.dart                 # Main application entry point
├── models/                   # Data models
│   ├── user.dart            # User model for data passing
│   └── navigation_item.dart # Navigation menu item model
├── screens/                  # Application screens
│   ├── home_screen.dart     # Main home screen
│   ├── basic_navigation_page.dart
│   ├── named_routes_page.dart
│   ├── arguments_page.dart
│   ├── return_data_page.dart
│   ├── send_data_page.dart
│   ├── route_settings_page.dart
│   ├── tabs_screen.dart
│   ├── drawer_navigation_screen.dart
│   ├── deep_linking_screen.dart
│   ├── app_links_screen.dart
│   ├── url_strategies_screen.dart
│   ├── urls_page.dart
│   ├── text_fields_page.dart
│   ├── websockets_page.dart
│   ├── avoiding_jank_page.dart
│   └── http_operations_page.dart
└── widgets/                  # Reusable widgets
    ├── navigation_card.dart
    ├── custom_drawer.dart
    ├── strategy_card.dart
    ├── consideration_item.dart
    ├── http_status_bar.dart
    └── post_card.dart
```

## 🛠️ Setup & Installation

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code
- iOS Simulator (for iOS development)
- Android Emulator (for Android development)

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flutter-navigation-routing
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

## 🔧 Development Commands

### Code Quality
```bash
# Clean the project
flutter clean

# Check Flutter installation
flutter doctor

# Analyze code for issues
flutter analyze

# Run tests
flutter test
```

### Building
```bash
# Build for iOS (without code signing)
flutter build ios --no-codesign

# Build for Android
flutter build apk

# Build for web
flutter build web
```

### Security Scan
```bash
# Run security scan
./scripts/security_scan.sh
```

## 📱 Navigation Examples

### Basic Navigation
```dart
// Navigate to a new screen
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const SecondScreen()),
);

// Return to previous screen
Navigator.pop(context);
```

### Named Routes
```dart
// Define routes in MaterialApp
routes: {
  '/': (context) => const HomeScreen(),
  '/second': (context) => const SecondScreen(),
  '/third': (context) => const ThirdScreen(),
}

// Navigate using named route
Navigator.pushNamed(context, '/second');
```

### Passing Data
```dart
// Send data to screen
Navigator.pushNamed(
  context,
  '/detail',
  arguments: {'id': 123, 'title': 'Sample Title'},
);

// Receive data in screen
final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
```

### Return Data
```dart
// Navigate and wait for result
final result = await Navigator.pushNamed(context, '/selection');

// Return data from screen
Navigator.pop(context, 'Selected Item');
```

## 🔒 Security

This project includes a comprehensive security scan script that checks for:
- API keys and tokens
- Passwords and credentials
- Database connection strings
- Hardcoded IP addresses
- Sensitive file paths
- Environment variables
- Key files (.key, .pem, .p12, .keystore)

### Running Security Scan
```bash
./scripts/security_scan.sh
```

## 📚 Documentation

The project includes detailed documentation in the `docs/` directory covering:
- Navigation basics
- Named routes
- Arguments and data passing
- Return data from screens
- URL handling
- Text field data retrieval
- WebSocket communication
- HTTP operations
- Performance optimization

## 🧪 Testing

The project includes unit tests for the main application functionality:
```bash
flutter test
```

## 📦 Dependencies

### Core Dependencies
- `flutter`: Flutter SDK
- `cupertino_icons`: iOS-style icons
- `http`: HTTP requests for API calls
- `web_socket_channel`: WebSocket support
- `go_router`: URL handling and routing
- `json_annotation`: JSON serialization

### Dev Dependencies
- `flutter_test`: Testing framework
- `flutter_lints`: Code linting
- `json_serializable`: JSON serialization code generation
- `build_runner`: Code generation

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the excellent framework
- Flutter community for the rich ecosystem of packages
- Contributors and maintainers of the used packages

## 📞 Support

If you have any questions or need help with this project, please:
1. Check the documentation in the `docs/` directory
2. Review the code examples in the `lib/screens/` directory
3. Open an issue on GitHub

---

**Happy Fluttering! 🚀**
