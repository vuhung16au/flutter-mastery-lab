# URLs in Flutter

## Overview
URL handling in Flutter is essential for web applications, deep linking, and cross-platform URL management. This component demonstrates how to work with URLs, handle deep linking, and integrate URL-based navigation in Flutter applications.

## Key Concepts

### 1. URL Structure
Understanding URL components and how to parse and construct them.

### 2. Deep Linking
Navigating to specific screens via URLs, especially important for web and mobile apps.

### 3. Web Integration
Preparing Flutter applications for web deployment with proper URL handling.

## Implementation

### Basic URL Handling

#### URL Parsing
```dart
import 'dart:convert';

class URLHandler {
  static Uri parseUrl(String urlString) {
    return Uri.parse(urlString);
  }

  static Map<String, String> getQueryParameters(String urlString) {
    final uri = Uri.parse(urlString);
    return uri.queryParameters;
  }

  static String getPath(String urlString) {
    final uri = Uri.parse(urlString);
    return uri.path;
  }
}
```

#### URL Construction
```dart
class URLBuilder {
  static String buildUrl({
    required String baseUrl,
    String? path,
    Map<String, String>? queryParameters,
  }) {
    final uri = Uri.parse(baseUrl);
    
    return uri.replace(
      path: path ?? uri.path,
      queryParameters: queryParameters,
    ).toString();
  }

  static String buildDeepLink({
    required String scheme,
    required String host,
    String? path,
    Map<String, String>? queryParameters,
  }) {
    return Uri(
      scheme: scheme,
      host: host,
      path: path,
      queryParameters: queryParameters,
    ).toString();
  }
}
```

### URL-Based Navigation

#### Basic URL Navigation
```dart
class URLsPage extends StatelessWidget {
  const URLsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('URLs in Flutter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('URL Handling Demo'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const URLDetailPage(
                      url: 'https://flutter.dev',
                      title: 'Flutter Official Site',
                    ),
                  ),
                );
              },
              child: const Text('Open Flutter Website'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const URLDetailPage(
                      url: 'https://pub.dev',
                      title: 'Pub.dev',
                    ),
                  ),
                );
              },
              child: const Text('Open Pub.dev'),
            ),
          ],
        ),
      ),
    );
  }
}
```

#### URL Detail Page
```dart
class URLDetailPage extends StatelessWidget {
  final String url;
  final String title;

  const URLDetailPage({super.key, required this.url, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'URL: $url',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'In a real app, you would open this URL in a WebView or launch it in the browser.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Advanced URL Patterns

### 1. Deep Linking Implementation

#### URL Scheme Registration
```dart
// In your app's configuration
class DeepLinkHandler {
  static const String scheme = 'myapp';
  static const String host = 'example.com';

  static String createDeepLink({
    required String path,
    Map<String, String>? parameters,
  }) {
    return URLBuilder.buildDeepLink(
      scheme: scheme,
      host: host,
      path: path,
      queryParameters: parameters,
    );
  }

  static Map<String, dynamic> parseDeepLink(String url) {
    final uri = Uri.parse(url);
    
    if (uri.scheme != scheme || uri.host != host) {
      throw ArgumentError('Invalid deep link URL');
    }

    return {
      'path': uri.path,
      'parameters': uri.queryParameters,
    };
  }
}
```

#### Deep Link Navigation
```dart
class DeepLinkNavigator {
  static void handleDeepLink(BuildContext context, String url) {
    try {
      final linkData = DeepLinkHandler.parseDeepLink(url);
      final path = linkData['path'] as String;
      final parameters = linkData['parameters'] as Map<String, String>;

      switch (path) {
        case '/profile':
          Navigator.pushNamed(
            context,
            '/profile',
            arguments: parameters,
          );
          break;
        case '/product':
          final productId = parameters['id'];
          if (productId != null) {
            Navigator.pushNamed(
              context,
              '/product-detail',
              arguments: {'id': productId},
            );
          }
          break;
        default:
          // Handle unknown paths
          Navigator.pushNamed(context, '/not-found');
      }
    } catch (e) {
      // Handle invalid deep links
      Navigator.pushNamed(context, '/error');
    }
  }
}
```

### 2. Web URL Handling

#### Web-Specific URL Management
```dart
import 'package:flutter/foundation.dart';

class WebURLHandler {
  static void updateBrowserURL(String path) {
    if (kIsWeb) {
      // Update browser URL without page reload
      // This would typically use JavaScript interop
      // For demo purposes, we'll just print the URL
      print('Browser URL updated to: $path');
    }
  }

  static String getCurrentURL() {
    if (kIsWeb) {
      // Get current browser URL
      // This would typically use JavaScript interop
      return 'https://example.com/current-path';
    }
    return '';
  }

  static void handleBrowserBackButton() {
    if (kIsWeb) {
      // Handle browser back button
      // This would typically use JavaScript interop
      print('Browser back button pressed');
    }
  }
}
```

### 3. URL Parameter Handling

#### Query Parameter Management
```dart
class URLParameterHandler {
  static Map<String, String> parseQueryString(String queryString) {
    if (queryString.isEmpty) return {};
    
    final params = <String, String>{};
    final pairs = queryString.split('&');
    
    for (final pair in pairs) {
      final keyValue = pair.split('=');
      if (keyValue.length == 2) {
        params[Uri.decodeComponent(keyValue[0])] = 
            Uri.decodeComponent(keyValue[1]);
      }
    }
    
    return params;
  }

  static String buildQueryString(Map<String, String> parameters) {
    if (parameters.isEmpty) return '';
    
    final pairs = parameters.entries.map((entry) {
      return '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}';
    });
    
    return pairs.join('&');
  }
}
```

## URL-Based State Management

### 1. URL State Synchronization
```dart
class URLStateManager {
  static void syncStateToURL(Map<String, dynamic> state) {
    final queryParams = <String, String>{};
    
    state.forEach((key, value) {
      if (value != null) {
        queryParams[key] = value.toString();
      }
    });
    
    final url = URLBuilder.buildUrl(
      baseUrl: 'https://example.com',
      queryParameters: queryParams,
    );
    
    WebURLHandler.updateBrowserURL(url);
  }

  static Map<String, dynamic> getStateFromURL() {
    final currentURL = WebURLHandler.getCurrentURL();
    final uri = Uri.parse(currentURL);
    
    final state = <String, dynamic>{};
    uri.queryParameters.forEach((key, value) {
      state[key] = value;
    });
    
    return state;
  }
}
```

### 2. URL-Based Routing
```dart
class URLRouter {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const HomePage(),
    '/profile': (context) => const ProfilePage(),
    '/settings': (context) => const SettingsPage(),
    '/product': (context) => const ProductPage(),
  };

  static Widget? getRoute(String path) {
    final builder = routes[path];
    return builder != null ? builder(null) : null;
  }

  static void navigateToURL(BuildContext context, String url) {
    final uri = Uri.parse(url);
    final path = uri.path;
    
    final route = getRoute(path);
    if (route != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => route),
      );
    } else {
      Navigator.pushNamed(context, '/not-found');
    }
  }
}
```

## Error Handling

### 1. Invalid URL Handling
```dart
class URLValidator {
  static bool isValidURL(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && uri.hasAuthority;
    } catch (e) {
      return false;
    }
  }

  static String sanitizeURL(String url) {
    // Remove potentially dangerous characters
    return url.replaceAll(RegExp(r'[<>"{}|\\^`\[\]]'), '');
  }

  static String? extractDomain(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.host;
    } catch (e) {
      return null;
    }
  }
}
```

### 2. URL Error Recovery
```dart
class URLErrorHandler {
  static void handleURLError(BuildContext context, String url, dynamic error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error handling URL: $url'),
        backgroundColor: Colors.red,
      ),
    );

    // Log the error for debugging
    print('URL Error: $error for URL: $url');

    // Navigate to error page
    Navigator.pushNamed(context, '/error');
  }

  static String getFallbackURL(String originalURL) {
    // Return a fallback URL if the original fails
    return 'https://example.com/fallback';
  }
}
```

## Best Practices

### 1. URL Security
```dart
class URLSecurity {
  static bool isSecureURL(String url) {
    final uri = Uri.parse(url);
    return uri.scheme == 'https';
  }

  static bool isAllowedDomain(String url, List<String> allowedDomains) {
    final uri = Uri.parse(url);
    return allowedDomains.contains(uri.host);
  }

  static String sanitizeURLForDisplay(String url) {
    // Remove sensitive information from URL for display
    final uri = Uri.parse(url);
    return '${uri.scheme}://${uri.host}${uri.path}';
  }
}
```

### 2. URL Caching
```dart
class URLCache {
  static final Map<String, String> _cache = {};

  static String? getCachedURL(String key) {
    return _cache[key];
  }

  static void cacheURL(String key, String url) {
    _cache[key] = url;
  }

  static void clearCache() {
    _cache.clear();
  }
}
```

### 3. URL Analytics
```dart
class URLAnalytics {
  static void trackURLVisit(String url) {
    // Track URL visits for analytics
    print('URL visited: $url');
  }

  static void trackURLError(String url, String error) {
    // Track URL errors for monitoring
    print('URL error: $error for URL: $url');
  }
}
```

## Testing

### 1. URL Parsing Tests
```dart
test('parse URL correctly', () {
  final url = 'https://example.com/path?param=value';
  final uri = Uri.parse(url);
  
  expect(uri.scheme, equals('https'));
  expect(uri.host, equals('example.com'));
  expect(uri.path, equals('/path'));
  expect(uri.queryParameters['param'], equals('value'));
});
```

### 2. Deep Link Tests
```dart
test('parse deep link correctly', () {
  final deepLink = 'myapp://example.com/profile?id=123';
  final linkData = DeepLinkHandler.parseDeepLink(deepLink);
  
  expect(linkData['path'], equals('/profile'));
  expect(linkData['parameters']['id'], equals('123'));
});
```

## Common Use Cases

### 1. Social Media Sharing
```dart
class SocialMediaURLs {
  static String createTwitterShareURL(String text, String url) {
    return URLBuilder.buildUrl(
      baseUrl: 'https://twitter.com/intent/tweet',
      queryParameters: {
        'text': text,
        'url': url,
      },
    );
  }

  static String createFacebookShareURL(String url) {
    return URLBuilder.buildUrl(
      baseUrl: 'https://www.facebook.com/sharer/sharer.php',
      queryParameters: {'u': url},
    );
  }
}
```

### 2. Email Links
```dart
class EmailURLs {
  static String createEmailURL({
    required String to,
    String? subject,
    String? body,
  }) {
    return URLBuilder.buildUrl(
      baseUrl: 'mailto:$to',
      queryParameters: {
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
      },
    );
  }
}
```

### 3. Phone Links
```dart
class PhoneURLs {
  static String createPhoneURL(String phoneNumber) {
    return 'tel:$phoneNumber';
  }

  static String createSMSURL(String phoneNumber, String message) {
    return URLBuilder.buildUrl(
      baseUrl: 'sms:$phoneNumber',
      queryParameters: {'body': message},
    );
  }
}
```

## Conclusion

URL handling in Flutter is crucial for creating web-compatible applications and implementing deep linking functionality. By following best practices for URL parsing, validation, and error handling, you can create robust applications that work seamlessly across different platforms and handle various URL scenarios effectively.
