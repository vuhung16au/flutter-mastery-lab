# Flutter - Named Routes

## Overview
Named routes provide a clean and organized way to manage navigation in Flutter applications. Instead of directly instantiating widgets for navigation, you define routes with names and navigate using those names.

## Key Concepts

### 1. Route Definition
Routes are defined in the `MaterialApp` widget's `routes` property:
```dart
MaterialApp(
  routes: {
    '/': (context) => const HomePage(),
    '/profile': (context) => const ProfilePage(),
    '/settings': (context) => const SettingsPage(),
  },
)
```

### 2. Route Navigation
Navigate using route names instead of widget constructors:
```dart
Navigator.pushNamed(context, '/profile');
```

### 3. Initial Route
Set the starting route of your application:
```dart
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => const HomePage(),
    // ... other routes
  },
)
```

## Implementation

### Basic Named Routes Setup
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Named Routes Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/basic-navigation': (context) => const BasicNavigationPage(),
        '/named-routes': (context) => const NamedRoutesPage(),
        '/arguments': (context) => const ArgumentsPage(),
        '/return-data': (context) => const ReturnDataPage(),
        '/urls': (context) => const URLsPage(),
        '/text-fields': (context) => const TextFieldsPage(),
        '/websockets': (context) => const WebSocketsPage(),
        '/avoiding-jank': (context) => const AvoidingJankPage(),
        '/http-operations': (context) => const HttpOperationsPage(),
        '/send-data': (context) => const SendDataPage(),
        '/route-settings': (context) => const RouteSettingsPage(),
      },
    );
  }
}
```

### Navigation Methods
```dart
// Basic navigation
Navigator.pushNamed(context, '/profile');

// Replace current route
Navigator.pushReplacementNamed(context, '/home');

// Clear stack and navigate
Navigator.pushNamedAndRemoveUntil(
  context, 
  '/home', 
  (route) => false
);

// Navigate and remove until specific route
Navigator.pushNamedAndRemoveUntil(
  context, 
  '/home', 
  ModalRoute.withName('/')
);
```

## Benefits of Named Routes

### 1. Cleaner Code
- No need to import widget classes everywhere
- Centralized route management
- Easier to maintain and refactor

### 2. Better Organization
- All routes defined in one place
- Clear navigation structure
- Easy to understand app flow

### 3. Type Safety
- Route names are strings, but can be constants
- IDE autocomplete support
- Easier to catch typos

### 4. Testing
- Easier to test navigation flows
- Can test routes independently
- Better unit test coverage

## Best Practices

### 1. Use Constants for Route Names
```dart
class AppRoutes {
  static const String home = '/';
  static const String profile = '/profile';
  static const String settings = '/settings';
}

// Usage
Navigator.pushNamed(context, AppRoutes.profile);
```

### 2. Organize Routes by Feature
```dart
routes: {
  // Auth routes
  '/login': (context) => const LoginPage(),
  '/register': (context) => const RegisterPage(),
  
  // Main app routes
  '/': (context) => const HomePage(),
  '/profile': (context) => const ProfilePage(),
  
  // Settings routes
  '/settings': (context) => const SettingsPage(),
  '/settings/account': (context) => const AccountSettingsPage(),
}
```

### 3. Handle Unknown Routes
```dart
MaterialApp(
  onUnknownRoute: (settings) {
    return MaterialPageRoute(
      builder: (context) => const NotFoundPage(),
    );
  },
)
```

## Advanced Features

### 1. Route Guards
```dart
routes: {
  '/profile': (context) {
    // Check if user is logged in
    if (isLoggedIn) {
      return const ProfilePage();
    } else {
      return const LoginPage();
    }
  },
}
```

### 2. Dynamic Routes
```dart
// For routes with parameters, use onGenerateRoute
onGenerateRoute: (settings) {
  if (settings.name!.startsWith('/user/')) {
    final userId = settings.name!.split('/').last;
    return MaterialPageRoute(
      builder: (context) => UserProfilePage(userId: userId),
    );
  }
  return null;
}
```

## Common Patterns

### 1. Nested Routes
```dart
routes: {
  '/settings': (context) => const SettingsPage(),
  '/settings/profile': (context) => const ProfileSettingsPage(),
  '/settings/notifications': (context) => const NotificationSettingsPage(),
}
```

### 2. Modal Routes
```dart
// For modal dialogs, still use MaterialPageRoute
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const ModalDialog(),
    fullscreenDialog: true,
  ),
);
```

## Error Handling

### 1. Route Not Found
```dart
onUnknownRoute: (settings) {
  return MaterialPageRoute(
    builder: (context) => const NotFoundPage(),
  );
}
```

### 2. Invalid Route Parameters
```dart
onGenerateRoute: (settings) {
  try {
    // Parse route parameters
    final args = settings.arguments as Map<String, dynamic>;
    return MaterialPageRoute(
      builder: (context) => DetailPage(data: args),
    );
  } catch (e) {
    return MaterialPageRoute(
      builder: (context) => const ErrorPage(),
    );
  }
}
```

## Testing Named Routes

### 1. Unit Tests
```dart
testWidgets('navigate to profile page', (tester) async {
  await tester.pumpWidget(const MyApp());
  
  await tester.tap(find.text('Profile'));
  await tester.pumpAndSettle();
  
  expect(find.byType(ProfilePage), findsOneWidget);
});
```

### 2. Integration Tests
```dart
testWidgets('complete navigation flow', (tester) async {
  await tester.pumpWidget(const MyApp());
  
  // Navigate through multiple screens
  await tester.tap(find.text('Settings'));
  await tester.pumpAndSettle();
  
  await tester.tap(find.text('Profile Settings'));
  await tester.pumpAndSettle();
  
  expect(find.byType(ProfileSettingsPage), findsOneWidget);
});
```

## Conclusion

Named routes provide a powerful and organized way to manage navigation in Flutter applications. They improve code maintainability, make testing easier, and provide a clear structure for app navigation. By following best practices and using advanced features appropriately, you can create robust and scalable navigation systems.
