# Flutter - Send Data to the Screen using RouteSettings

## Overview
RouteSettings provides a powerful way to pass data and metadata during navigation in Flutter. This component demonstrates how to use RouteSettings to pass arguments, handle route metadata, and implement advanced navigation patterns with proper data management.

## Key Concepts

### 1. RouteSettings
A class that contains information about a route, including name, arguments, and other metadata.

### 2. Route Arguments
Data passed through the route settings that can be accessed by the destination screen.

### 3. Route Metadata
Additional information about routes that can be used for navigation logic and analytics.

## Implementation

### Basic RouteSettings Usage

#### Passing Data with RouteSettings
```dart
class RouteSettingsPage extends StatelessWidget {
  const RouteSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Route Settings Demo'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RouteSettingsDetailPage(),
                    settings: RouteSettings(
                      name: '/route-settings-detail',
                      arguments: {
                        'title': 'Detail Page',
                        'message': 'This page was navigated using RouteSettings',
                        'timestamp': DateTime.now().toIso8601String(),
                        'userId': 123,
                        'isActive': true,
                      },
                    ),
                  ),
                );
              },
              child: const Text('Navigate with RouteSettings'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RouteSettingsDetailPage(),
                    settings: RouteSettings(
                      name: '/route-settings-detail',
                      arguments: {
                        'title': 'Another Detail Page',
                        'message': 'Different data passed via RouteSettings',
                        'timestamp': DateTime.now().toIso8601String(),
                        'userId': 456,
                        'isActive': false,
                        'extraData': {
                          'category': 'premium',
                          'tags': ['flutter', 'dart', 'mobile'],
                        },
                      },
                    ),
                  ),
                );
              },
              child: const Text('Navigate with Complex Data'),
            ),
          ],
        ),
      ),
    );
  }
}

class RouteSettingsDetailPage extends StatelessWidget {
  const RouteSettingsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access route settings and arguments
    final routeSettings = ModalRoute.of(context)?.settings;
    final arguments = routeSettings?.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
        title: Text(arguments?['title'] ?? 'Detail Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard('Route Name', routeSettings?.name ?? 'Unknown'),
            _buildInfoCard('Message', arguments?['message'] ?? 'No message'),
            _buildInfoCard('Timestamp', arguments?['timestamp'] ?? 'No timestamp'),
            _buildInfoCard('User ID', arguments?['userId']?.toString() ?? 'No user ID'),
            _buildInfoCard('Active Status', arguments?['isActive']?.toString() ?? 'Unknown'),
            if (arguments?['extraData'] != null) ...[
              const SizedBox(height: 20),
              _buildExtraDataSection(arguments!['extraData']),
            ],
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Go Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(label),
        subtitle: Text(value),
      ),
    );
  }

  Widget _buildExtraDataSection(Map<String, dynamic> extraData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Extra Data:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: extraData.entries.map((entry) {
              return ListTile(
                title: Text(entry.key),
                subtitle: Text(entry.value.toString()),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
```

## Advanced RouteSettings Patterns

### 1. Typed Route Arguments

#### Strongly Typed Arguments
```dart
class RouteArguments {
  final String title;
  final String message;
  final DateTime timestamp;
  final int userId;
  final bool isActive;
  final Map<String, dynamic>? extraData;

  const RouteArguments({
    required this.title,
    required this.message,
    required this.timestamp,
    required this.userId,
    required this.isActive,
    this.extraData,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'userId': userId,
      'isActive': isActive,
      if (extraData != null) 'extraData': extraData,
    };
  }

  factory RouteArguments.fromMap(Map<String, dynamic> map) {
    return RouteArguments(
      title: map['title'] as String,
      message: map['message'] as String,
      timestamp: DateTime.parse(map['timestamp'] as String),
      userId: map['userId'] as int,
      isActive: map['isActive'] as bool,
      extraData: map['extraData'] as Map<String, dynamic>?,
    );
  }
}

class TypedRouteSettingsPage extends StatelessWidget {
  const TypedRouteSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Typed Route Settings')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final arguments = RouteArguments(
                  title: 'Typed Route Page',
                  message: 'Using strongly typed arguments',
                  timestamp: DateTime.now(),
                  userId: 789,
                  isActive: true,
                  extraData: {
                    'category': 'typed',
                    'version': '1.0.0',
                  },
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TypedRouteDetailPage(),
                    settings: RouteSettings(
                      name: '/typed-route-detail',
                      arguments: arguments.toMap(),
                    ),
                  ),
                );
              },
              child: const Text('Navigate with Typed Arguments'),
            ),
          ],
        ),
      ),
    );
  }
}

class TypedRouteDetailPage extends StatelessWidget {
  const TypedRouteDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final routeSettings = ModalRoute.of(context)?.settings;
    final argumentsMap = routeSettings?.arguments as Map<String, dynamic>?;
    
    RouteArguments? arguments;
    if (argumentsMap != null) {
      try {
        arguments = RouteArguments.fromMap(argumentsMap);
      } catch (e) {
        print('Error parsing arguments: $e');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(arguments?.title ?? 'Typed Detail Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: arguments != null
            ? _buildContent(arguments!)
            : const Center(
                child: Text('No valid arguments provided'),
              ),
      ),
    );
  }

  Widget _buildContent(RouteArguments arguments) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoCard('Title', arguments.title),
        _buildInfoCard('Message', arguments.message),
        _buildInfoCard('Timestamp', arguments.timestamp.toString()),
        _buildInfoCard('User ID', arguments.userId.toString()),
        _buildInfoCard('Active Status', arguments.isActive.toString()),
        if (arguments.extraData != null) ...[
          const SizedBox(height: 20),
          _buildExtraDataSection(arguments.extraData!),
        ],
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Go Back'),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(label),
        subtitle: Text(value),
      ),
    );
  }

  Widget _buildExtraDataSection(Map<String, dynamic> extraData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Extra Data:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: extraData.entries.map((entry) {
              return ListTile(
                title: Text(entry.key),
                subtitle: Text(entry.value.toString()),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
```

### 2. Route Analytics and Tracking

#### Navigation Analytics
```dart
class AnalyticsRouteSettings {
  final String routeName;
  final Map<String, dynamic> arguments;
  final String source;
  final DateTime timestamp;
  final String? userId;

  const AnalyticsRouteSettings({
    required this.routeName,
    required this.arguments,
    required this.source,
    required this.timestamp,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'routeName': routeName,
      'arguments': arguments,
      'source': source,
      'timestamp': timestamp.toIso8601String(),
      if (userId != null) 'userId': userId,
    };
  }

  void trackNavigation() {
    // In a real app, you would send this to your analytics service
    print('Navigation tracked: $routeName from $source at $timestamp');
    print('Arguments: $arguments');
  }
}

class AnalyticsRoutePage extends StatelessWidget {
  const AnalyticsRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics Route')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final analyticsSettings = AnalyticsRouteSettings(
                  routeName: '/analytics-detail',
                  arguments: {
                    'page': 'analytics',
                    'action': 'view',
                    'category': 'navigation',
                  },
                  source: 'main_menu',
                  timestamp: DateTime.now(),
                  userId: 'user123',
                );

                // Track the navigation
                analyticsSettings.trackNavigation();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AnalyticsDetailPage(),
                    settings: RouteSettings(
                      name: analyticsSettings.routeName,
                      arguments: analyticsSettings.toMap(),
                    ),
                  ),
                );
              },
              child: const Text('Navigate with Analytics'),
            ),
          ],
        ),
      ),
    );
  }
}

class AnalyticsDetailPage extends StatelessWidget {
  const AnalyticsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final routeSettings = ModalRoute.of(context)?.settings;
    final arguments = routeSettings?.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(title: const Text('Analytics Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard('Route Name', routeSettings?.name ?? 'Unknown'),
            _buildInfoCard('Source', arguments?['source'] ?? 'Unknown'),
            _buildInfoCard('Timestamp', arguments?['timestamp'] ?? 'Unknown'),
            _buildInfoCard('User ID', arguments?['userId'] ?? 'Unknown'),
            const SizedBox(height: 20),
            const Text(
              'Navigation Arguments:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: (arguments?['arguments'] as Map<String, dynamic>?)
                    ?.entries
                    .map((entry) => ListTile(
                          title: Text(entry.key),
                          subtitle: Text(entry.value.toString()),
                        ))
                    .toList() ??
                    [],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Go Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(label),
        subtitle: Text(value),
      ),
    );
  }
}
```

### 3. Route Guards and Validation

#### Route Access Control
```dart
class RouteGuard {
  final bool requiresAuth;
  final List<String> requiredPermissions;
  final String? redirectRoute;

  const RouteGuard({
    this.requiresAuth = false,
    this.requiredPermissions = const [],
    this.redirectRoute,
  });

  bool canAccess(Map<String, dynamic> userData) {
    if (requiresAuth && userData['isAuthenticated'] != true) {
      return false;
    }

    if (requiredPermissions.isNotEmpty) {
      final userPermissions = List<String>.from(userData['permissions'] ?? []);
      for (final permission in requiredPermissions) {
        if (!userPermissions.contains(permission)) {
          return false;
        }
      }
    }

    return true;
  }
}

class GuardedRoutePage extends StatelessWidget {
  const GuardedRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Guarded Routes')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final routeGuard = RouteGuard(
                  requiresAuth: true,
                  requiredPermissions: ['read'],
                );

                final userData = {
                  'isAuthenticated': true,
                  'permissions': ['read', 'write'],
                  'userId': 'user456',
                };

                if (routeGuard.canAccess(userData)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GuardedDetailPage(),
                      settings: RouteSettings(
                        name: '/guarded-detail',
                        arguments: {
                          'userData': userData,
                          'guard': routeGuard,
                          'accessTime': DateTime.now().toIso8601String(),
                        },
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Access denied'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Access Protected Route'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final routeGuard = RouteGuard(
                  requiresAuth: true,
                  requiredPermissions: ['admin'],
                );

                final userData = {
                  'isAuthenticated': true,
                  'permissions': ['read', 'write'], // No admin permission
                  'userId': 'user789',
                };

                if (routeGuard.canAccess(userData)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GuardedDetailPage(),
                      settings: RouteSettings(
                        name: '/guarded-detail',
                        arguments: {
                          'userData': userData,
                          'guard': routeGuard,
                          'accessTime': DateTime.now().toIso8601String(),
                        },
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Insufficient permissions'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              },
              child: const Text('Try Admin Route'),
            ),
          ],
        ),
      ),
    );
  }
}

class GuardedDetailPage extends StatelessWidget {
  const GuardedDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final routeSettings = ModalRoute.of(context)?.settings;
    final arguments = routeSettings?.arguments as Map<String, dynamic>?;
    final userData = arguments?['userData'] as Map<String, dynamic>?;
    final accessTime = arguments?['accessTime'] as String?;

    return Scaffold(
      appBar: AppBar(title: const Text('Protected Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to the protected page!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildInfoCard('User ID', userData?['userId']?.toString() ?? 'Unknown'),
            _buildInfoCard('Access Time', accessTime ?? 'Unknown'),
            _buildInfoCard('Permissions', (userData?['permissions'] as List?)?.join(', ') ?? 'None'),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Go Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(label),
        subtitle: Text(value),
      ),
    );
  }
}
```

## Route Management Utilities

### 1. Route Helper Functions
```dart
class RouteHelper {
  static void navigateWithData(
    BuildContext context,
    Widget page, {
    String? routeName,
    Map<String, dynamic>? arguments,
    String? source,
  }) {
    final settings = RouteSettings(
      name: routeName ?? '/default',
      arguments: {
        if (arguments != null) ...arguments,
        if (source != null) 'source': source,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
        settings: settings,
      ),
    );
  }

  static Map<String, dynamic>? getArguments(BuildContext context) {
    final routeSettings = ModalRoute.of(context)?.settings;
    return routeSettings?.arguments as Map<String, dynamic>?;
  }

  static String? getRouteName(BuildContext context) {
    final routeSettings = ModalRoute.of(context)?.settings;
    return routeSettings?.name;
  }

  static T? getArgument<T>(BuildContext context, String key) {
    final arguments = getArguments(context);
    return arguments?[key] as T?;
  }
}
```

### 2. Route History Tracking
```dart
class RouteHistory {
  static final List<RouteEntry> _history = [];

  static void addEntry(String routeName, Map<String, dynamic>? arguments) {
    _history.add(RouteEntry(
      routeName: routeName,
      arguments: arguments,
      timestamp: DateTime.now(),
    ));
  }

  static List<RouteEntry> getHistory() {
    return List.unmodifiable(_history);
  }

  static RouteEntry? getLastEntry() {
    return _history.isNotEmpty ? _history.last : null;
  }

  static void clearHistory() {
    _history.clear();
  }
}

class RouteEntry {
  final String routeName;
  final Map<String, dynamic>? arguments;
  final DateTime timestamp;

  const RouteEntry({
    required this.routeName,
    this.arguments,
    required this.timestamp,
  });

  @override
  String toString() {
    return 'RouteEntry(routeName: $routeName, timestamp: $timestamp)';
  }
}
```

## Best Practices

### 1. Route Argument Validation
```dart
class RouteArgumentValidator {
  static bool validateArguments(Map<String, dynamic> arguments, List<String> requiredKeys) {
    for (final key in requiredKeys) {
      if (!arguments.containsKey(key)) {
        return false;
      }
    }
    return true;
  }

  static String? validateString(Map<String, dynamic> arguments, String key) {
    final value = arguments[key];
    if (value is String && value.isNotEmpty) {
      return value;
    }
    return null;
  }

  static int? validateInt(Map<String, dynamic> arguments, String key) {
    final value = arguments[key];
    if (value is int) {
      return value;
    }
    if (value is String) {
      return int.tryParse(value);
    }
    return null;
  }
}
```

### 2. Route Error Handling
```dart
class RouteErrorHandler {
  static void handleMissingArguments(BuildContext context, String routeName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Missing arguments for route: $routeName'),
        backgroundColor: Colors.red,
      ),
    );
  }

  static void handleInvalidArguments(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Invalid arguments: $message'),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
```

## Testing

### 1. Route Settings Tests
```dart
test('route arguments are passed correctly', () {
  final arguments = {
    'title': 'Test Page',
    'message': 'Test message',
    'userId': 123,
  };

  final routeSettings = RouteSettings(
    name: '/test',
    arguments: arguments,
  );

  expect(routeSettings.name, equals('/test'));
  expect(routeSettings.arguments, equals(arguments));
});

test('typed route arguments work correctly', () {
  final routeArgs = RouteArguments(
    title: 'Test',
    message: 'Test message',
    timestamp: DateTime.now(),
    userId: 123,
    isActive: true,
  );

  final map = routeArgs.toMap();
  final reconstructed = RouteArguments.fromMap(map);

  expect(reconstructed.title, equals(routeArgs.title));
  expect(reconstructed.message, equals(routeArgs.message));
  expect(reconstructed.userId, equals(routeArgs.userId));
  expect(reconstructed.isActive, equals(routeArgs.isActive));
});
```

### 2. Route Guard Tests
```dart
test('route guard validates permissions correctly', () {
  final guard = RouteGuard(
    requiresAuth: true,
    requiredPermissions: ['read', 'write'],
  );

  final userWithPermissions = {
    'isAuthenticated': true,
    'permissions': ['read', 'write', 'admin'],
  };

  final userWithoutPermissions = {
    'isAuthenticated': true,
    'permissions': ['read'],
  };

  expect(guard.canAccess(userWithPermissions), isTrue);
  expect(guard.canAccess(userWithoutPermissions), isFalse);
});
```

## Conclusion

RouteSettings provides a powerful and flexible way to pass data and metadata during navigation in Flutter applications. By implementing proper validation, error handling, and using typed arguments, you can create robust navigation systems that are both maintainable and scalable. Always follow best practices for data validation and error handling to ensure a smooth user experience.
