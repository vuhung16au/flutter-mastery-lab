# Flutter - Wakelock

## Overview
This document covers how to implement wakelock functionality in Flutter applications using the `wakelock_plus` package. Wakelock prevents the device from going to sleep, which is useful for applications that need to stay active (like video players, games, or monitoring apps).

## Dependencies
```yaml
dependencies:
  wakelock_plus: ^1.1.4
```

## Setup

### Android Permissions
Add the following permissions to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.WAKE_LOCK" />
<uses-permission android:name="android.permission.DISABLE_KEYGUARD" />
```

### iOS Permissions
No special permissions required for iOS.

## Basic Wakelock Implementation

### Enable Wakelock
```dart
import 'package:wakelock_plus/wakelock_plus.dart';

class WakelockService {
  static Future<void> enableWakelock() async {
    await WakelockPlus.enable();
  }
}
```

### Disable Wakelock
```dart
class WakelockService {
  static Future<void> disableWakelock() async {
    await WakelockPlus.disable();
  }
}
```

### Check Wakelock Status
```dart
class WakelockService {
  static Future<bool> isWakelockEnabled() async {
    return await WakelockPlus.enabled;
  }
}
```

## Advanced Wakelock Features

### Toggle Wakelock
```dart
class WakelockService {
  static Future<void> toggleWakelock() async {
    final bool isEnabled = await WakelockPlus.enabled;
    if (isEnabled) {
      await WakelockPlus.disable();
    } else {
      await WakelockPlus.enable();
    }
  }
}
```

### Wakelock with Duration
```dart
class WakelockService {
  static Future<void> enableWakelockForDuration(Duration duration) async {
    await WakelockPlus.enable();
    
    // Disable after specified duration
    Future.delayed(duration, () async {
      await WakelockPlus.disable();
    });
  }
}
```

### Wakelock with Screen Brightness
```dart
import 'package:flutter/services.dart';

class WakelockService {
  static Future<void> enableWakelockWithBrightness() async {
    // Enable wakelock
    await WakelockPlus.enable();
    
    // Set screen brightness to maximum
    await SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light,
    );
  }
}
```

## UI Components

### Wakelock Toggle Widget
```dart
class WakelockToggle extends StatefulWidget {
  @override
  _WakelockToggleState createState() => _WakelockToggleState();
}

class _WakelockToggleState extends State<WakelockToggle> {
  bool _isWakelockEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkWakelockStatus();
  }

  Future<void> _checkWakelockStatus() async {
    final bool isEnabled = await WakelockPlus.enabled;
    setState(() {
      _isWakelockEnabled = isEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          _isWakelockEnabled ? Icons.wb_sunny : Icons.nightlight_round,
          color: _isWakelockEnabled ? Colors.orange : Colors.blue,
        ),
        title: Text('Keep Screen Awake'),
        subtitle: Text(
          _isWakelockEnabled 
            ? 'Screen will stay awake' 
            : 'Screen can go to sleep',
        ),
        trailing: Switch(
          value: _isWakelockEnabled,
          onChanged: (bool value) async {
            if (value) {
              await WakelockPlus.enable();
            } else {
              await WakelockPlus.disable();
            }
            setState(() {
              _isWakelockEnabled = value;
            });
          },
        ),
      ),
    );
  }
}
```

### Wakelock Settings Widget
```dart
class WakelockSettings extends StatefulWidget {
  @override
  _WakelockSettingsState createState() => _WakelockSettingsState();
}

class _WakelockSettingsState extends State<WakelockSettings> {
  bool _isWakelockEnabled = false;
  Duration _selectedDuration = Duration(minutes: 30);

  @override
  void initState() {
    super.initState();
    _checkWakelockStatus();
  }

  Future<void> _checkWakelockStatus() async {
    final bool isEnabled = await WakelockPlus.enabled;
    setState(() {
      _isWakelockEnabled = isEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            leading: Icon(Icons.settings),
            title: Text('Wakelock Settings'),
            subtitle: Text('Configure screen wake behavior'),
          ),
        ),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.timer),
                title: Text('Duration'),
                subtitle: Text('${_selectedDuration.inMinutes} minutes'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: _showDurationPicker,
              ),
              ListTile(
                leading: Icon(Icons.wb_sunny),
                title: Text('Keep Screen Awake'),
                subtitle: Text(
                  _isWakelockEnabled 
                    ? 'Enabled' 
                    : 'Disabled',
                ),
                trailing: Switch(
                  value: _isWakelockEnabled,
                  onChanged: _toggleWakelock,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: _isWakelockEnabled ? null : _enableWakelockWithDuration,
          icon: Icon(Icons.play_arrow),
          label: Text('Start with Duration'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  void _showDurationPicker() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: _selectedDuration.inHours,
        minute: _selectedDuration.inMinutes % 60,
      ),
    );

    if (time != null) {
      setState(() {
        _selectedDuration = Duration(
          hours: time.hour,
          minutes: time.minute,
        );
      });
    }
  }

  void _toggleWakelock(bool value) async {
    if (value) {
      await WakelockPlus.enable();
    } else {
      await WakelockPlus.disable();
    }
    setState(() {
      _isWakelockEnabled = value;
    });
  }

  void _enableWakelockWithDuration() async {
    await WakelockPlus.enable();
    setState(() {
      _isWakelockEnabled = true;
    });

    // Show countdown
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Wakelock enabled for ${_selectedDuration.inMinutes} minutes'),
        duration: Duration(seconds: 2),
      ),
    );

    // Disable after duration
    Future.delayed(_selectedDuration, () async {
      await WakelockPlus.disable();
      setState(() {
        _isWakelockEnabled = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Wakelock disabled'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    });
  }
}
```

## Use Cases

### Video Player with Wakelock
```dart
class VideoPlayerWithWakelock extends StatefulWidget {
  @override
  _VideoPlayerWithWakelockState createState() => _VideoPlayerWithWakelockState();
}

class _VideoPlayerWithWakelockState extends State<VideoPlayerWithWakelock> {
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    // Enable wakelock when video player is created
    WakelockPlus.enable();
  }

  @override
  void dispose() {
    // Disable wakelock when video player is disposed
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
        actions: [
          IconButton(
            icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              setState(() {
                _isPlaying = !_isPlaying;
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isPlaying ? Icons.play_circle_filled : Icons.pause_circle_filled,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              _isPlaying ? 'Playing' : 'Paused',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Screen will stay awake while video is playing',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
```

### Game with Wakelock
```dart
class GameWithWakelock extends StatefulWidget {
  @override
  _GameWithWakelockState createState() => _GameWithWakelockState();
}

class _GameWithWakelockState extends State<GameWithWakelock> {
  bool _isGameActive = false;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    // Enable wakelock when game starts
    WakelockPlus.enable();
  }

  @override
  void dispose() {
    // Disable wakelock when game ends
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game'),
        actions: [
          Text('Score: $_score', style: TextStyle(fontSize: 18)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Game Active',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _score += 10;
                });
              },
              child: Text('Score Point'),
            ),
            SizedBox(height: 20),
            Text(
              'Screen will stay awake during gameplay',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
```

## Error Handling

### Wakelock Error Handler
```dart
class WakelockErrorHandler {
  static Future<void> safeWakelockOperation(Future<void> Function() operation) async {
    try {
      await operation();
    } catch (e) {
      print('Wakelock error: $e');
      // Handle wakelock errors gracefully
    }
  }

  static Future<bool> checkWakelockSupport() async {
    try {
      final bool isEnabled = await WakelockPlus.enabled;
      return true;
    } catch (e) {
      return false;
    }
  }
}
```

## Best Practices
1. **Enable wakelock only when needed** to conserve battery
2. **Always disable wakelock** when the feature is no longer needed
3. **Use duration-based wakelock** for temporary needs
4. **Handle errors gracefully** when wakelock operations fail
5. **Inform users** when wakelock is active
6. **Consider battery impact** and provide user control
7. **Test on different devices** to ensure compatibility
8. **Follow platform guidelines** for wakelock usage

## Platform-Specific Considerations

### Android
- Requires `WAKE_LOCK` permission
- May need `DISABLE_KEYGUARD` for full screen apps
- Consider battery optimization settings

### iOS
- No special permissions required
- Wakelock behavior may vary with iOS version
- Consider background app refresh settings

### Web
- Limited wakelock support
- May require user interaction to enable
- Consider using Page Visibility API

## Example Implementation
See the main application for a complete implementation of wakelock functionality with proper lifecycle management and user controls.
