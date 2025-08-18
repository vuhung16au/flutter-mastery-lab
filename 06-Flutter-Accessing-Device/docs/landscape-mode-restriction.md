# Restrict Landscape Mode in Flutter

## Overview

Landscape mode restriction in Flutter allows you to control the orientation of your app, limiting it to portrait mode or specific orientations. This is useful for apps that are designed for a specific orientation or when you want to ensure consistent user experience across different devices.

## Implementation

### 1. Basic Orientation Control

The primary way to control screen orientation in Flutter is using the `SystemChrome` class from the `flutter/services.dart` package.

```dart
import 'package:flutter/services.dart';

// Restrict to portrait mode only
await SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown,
]);

// Allow all orientations
await SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown,
  DeviceOrientation.landscapeLeft,
  DeviceOrientation.landscapeRight,
]);

// Restrict to landscape mode only
await SystemChrome.setPreferredOrientations([
  DeviceOrientation.landscapeLeft,
  DeviceOrientation.landscapeRight,
]);
```

### 2. Complete Implementation Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set initial orientation to portrait only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orientation Control Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OrientationControlPage(),
    );
  }
}

class OrientationControlPage extends StatefulWidget {
  @override
  _OrientationControlPageState createState() => _OrientationControlPageState();
}

class _OrientationControlPageState extends State<OrientationControlPage> {
  bool _isPortraitOnly = true;

  Future<void> _toggleOrientation() async {
    if (_isPortraitOnly) {
      // Enable all orientations
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      setState(() {
        _isPortraitOnly = false;
      });
    } else {
      // Restrict to portrait only
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      setState(() {
        _isPortraitOnly = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orientation Control'),
        actions: [
          IconButton(
            icon: Icon(_isPortraitOnly ? Icons.screen_rotation : Icons.screen_lock_portrait),
            onPressed: _toggleOrientation,
            tooltip: 'Toggle Orientation',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current Mode:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              _isPortraitOnly ? 'Portrait Only' : 'All Orientations',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _toggleOrientation,
              icon: Icon(_isPortraitOnly ? Icons.screen_rotation : Icons.screen_lock_portrait),
              label: Text(_isPortraitOnly ? 'Enable All Orientations' : 'Restrict to Portrait'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 3. Advanced Orientation Management

```dart
class OrientationManager {
  static const List<DeviceOrientation> _portraitOrientations = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ];

  static const List<DeviceOrientation> _landscapeOrientations = [
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ];

  static const List<DeviceOrientation> _allOrientations = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ];

  // Set to portrait mode only
  static Future<void> setPortraitOnly() async {
    await SystemChrome.setPreferredOrientations(_portraitOrientations);
  }

  // Set to landscape mode only
  static Future<void> setLandscapeOnly() async {
    await SystemChrome.setPreferredOrientations(_landscapeOrientations);
  }

  // Allow all orientations
  static Future<void> setAllOrientations() async {
    await SystemChrome.setPreferredOrientations(_allOrientations);
  }

  // Set custom orientations
  static Future<void> setCustomOrientations(List<DeviceOrientation> orientations) async {
    await SystemChrome.setPreferredOrientations(orientations);
  }

  // Get current orientation
  static Orientation getCurrentOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  // Check if device is in portrait mode
  static bool isPortrait(BuildContext context) {
    return getCurrentOrientation(context) == Orientation.portrait;
  }

  // Check if device is in landscape mode
  static bool isLandscape(BuildContext context) {
    return getCurrentOrientation(context) == Orientation.landscape;
  }
}
```

### 4. Responsive UI with Orientation Awareness

```dart
class ResponsiveWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return _buildPortraitLayout();
        } else {
          return _buildLandscapeLayout();
        }
      },
    );
  }

  Widget _buildPortraitLayout() {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.blue,
            child: Center(
              child: Text(
                'Portrait Layout',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.green,
            child: Center(
              child: Text(
                'Content Area',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.blue,
            child: Center(
              child: Text(
                'Landscape\nSidebar',
                style: TextStyle(color: Colors.white, fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.green,
            child: Center(
              child: Text(
                'Content Area',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
```

## Use Cases

### 1. Portrait-Only Apps

Many apps are designed specifically for portrait mode:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Force portrait mode for the entire app
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(MyApp());
}
```

### 2. Game Apps with Specific Orientation

Games often require specific orientations:

```dart
class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    // Force landscape for game
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // Reset to portrait when leaving game
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Text(
            'Game Screen - Landscape Only',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
```

### 3. Video Player with Orientation Control

```dart
class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  bool _isFullscreen = false;

  void _toggleFullscreen() async {
    if (_isFullscreen) {
      // Exit fullscreen - portrait only
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      setState(() {
        _isFullscreen = false;
      });
    } else {
      // Enter fullscreen - all orientations
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      setState(() {
        _isFullscreen = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isFullscreen ? null : AppBar(title: Text('Video Player')),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Video Player',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _toggleFullscreen,
                child: Text(_isFullscreen ? 'Exit Fullscreen' : 'Enter Fullscreen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Platform-Specific Considerations

### Android Configuration

For Android, you can also set the orientation in the `AndroidManifest.xml`:

```xml
<activity
    android:name=".MainActivity"
    android:screenOrientation="portrait"
    android:exported="true">
    <!-- ... -->
</activity>
```

### iOS Configuration

For iOS, you can set the orientation in `Info.plist`:

```xml
<key>UISupportedInterfaceOrientations</key>
<array>
    <string>UIInterfaceOrientationPortrait</string>
    <string>UIInterfaceOrientationPortraitUpsideDown</string>
</array>
```

## Best Practices

### 1. Initialize Early

Set orientation preferences early in your app lifecycle:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set orientation before running the app
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(MyApp());
}
```

### 2. Handle Orientation Changes

Use `OrientationBuilder` to respond to orientation changes:

```dart
OrientationBuilder(
  builder: (context, orientation) {
    return orientation == Orientation.portrait
        ? PortraitLayout()
        : LandscapeLayout();
  },
)
```

### 3. Provide User Control

Allow users to control orientation when appropriate:

```dart
class OrientationSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.screen_rotation),
      title: Text('Auto-rotate'),
      trailing: Switch(
        value: true, // Get from settings
        onChanged: (value) {
          if (value) {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ]);
          } else {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);
          }
        },
      ),
    );
  }
}
```

### 4. Test on Different Devices

Always test your orientation settings on:
- Different screen sizes
- Different aspect ratios
- Both Android and iOS devices
- Physical devices (not just simulators)

## Troubleshooting

### Common Issues

1. **Orientation not changing**: Ensure `WidgetsFlutterBinding.ensureInitialized()` is called
2. **App crashes on rotation**: Check for null safety issues in orientation-dependent code
3. **UI layout issues**: Use responsive design patterns
4. **Performance problems**: Avoid heavy computations during orientation changes

### Debug Tips

- Use `print` statements to track orientation changes
- Test with different device orientations
- Check platform-specific configurations
- Monitor memory usage during orientation changes

## Conclusion

Orientation control is an important aspect of Flutter app development. By understanding how to properly implement and manage screen orientations, you can create apps that provide the best user experience across different devices and use cases. Remember to always consider your app's specific requirements and user needs when implementing orientation restrictions.
