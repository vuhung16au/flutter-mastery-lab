# Flutter - Wakelock

This document covers how to implement Wakelock functionality in Flutter applications using the `wakelock_plus` package.

## Overview

Wakelock is a feature that prevents the device from going to sleep or turning off the screen. This is useful for applications that need to keep the screen on for extended periods, such as video players, navigation apps, or presentation tools.

## Setup

### Dependencies

Add the following dependency to your `pubspec.yaml`:

```yaml
dependencies:
  wakelock_plus: ^1.1.4
```

### Platform Configuration

#### Android

Add the following permission to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.WAKE_LOCK" />
```

#### iOS

No additional configuration is required for iOS.

## Implementation

### Basic Wakelock Service

```dart
import 'package:wakelock_plus/wakelock_plus.dart';

class WakelockService {
  static bool _isEnabled = false;

  static bool get isEnabled => _isEnabled;

  static Future<void> enable() async {
    try {
      await WakelockPlus.enable();
      _isEnabled = true;
    } catch (e) {
      throw Exception('Failed to enable wakelock: $e');
    }
  }

  static Future<void> disable() async {
    try {
      await WakelockPlus.disable();
      _isEnabled = false;
    } catch (e) {
      throw Exception('Failed to disable wakelock: $e');
    }
  }

  static Future<void> toggle() async {
    if (_isEnabled) {
      await disable();
    } else {
      await enable();
    }
  }

  static Future<bool> isEnabled() async {
    try {
      return await WakelockPlus.enabled;
    } catch (e) {
      throw Exception('Failed to check wakelock status: $e');
    }
  }
}
```

### UI Implementation

```dart
import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class WakelockDemoPage extends StatefulWidget {
  @override
  _WakelockDemoPageState createState() => _WakelockDemoPageState();
}

class _WakelockDemoPageState extends State<WakelockDemoPage> {
  bool _isWakelockEnabled = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkWakelockStatus();
  }

  Future<void> _checkWakelockStatus() async {
    try {
      bool status = await WakelockPlus.enabled;
      setState(() {
        _isWakelockEnabled = status;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showSnackBar('Error checking wakelock status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wakelock Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status Card
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wakelock Status',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    if (_isLoading)
                      Center(child: CircularProgressIndicator())
                    else
                      Row(
                        children: [
                          Icon(
                            _isWakelockEnabled ? Icons.lightbulb : Icons.lightbulb_outline,
                            color: _isWakelockEnabled ? Colors.yellow : Colors.grey,
                            size: 32,
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _isWakelockEnabled ? 'Screen Stay Awake' : 'Screen Can Sleep',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  _isWakelockEnabled 
                                    ? 'The screen will stay on' 
                                    : 'The screen will turn off normally',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Control Buttons
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Controls',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _isLoading ? null : _enableWakelock,
                            icon: Icon(Icons.lightbulb),
                            label: Text('Enable'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _isLoading ? null : _disableWakelock,
                            icon: Icon(Icons.lightbulb_outline),
                            label: Text('Disable'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: _isLoading ? null : _toggleWakelock,
                      icon: Icon(Icons.swap_horiz),
                      label: Text('Toggle'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 48),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Use Cases
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Common Use Cases',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    _buildUseCaseItem(
                      'Video Player',
                      'Keep screen on during video playback',
                      Icons.video_library,
                    ),
                    _buildUseCaseItem(
                      'Navigation',
                      'Keep screen on during navigation',
                      Icons.navigation,
                    ),
                    _buildUseCaseItem(
                      'Presentation',
                      'Keep screen on during presentations',
                      Icons.present_to_all,
                    ),
                    _buildUseCaseItem(
                      'Reading',
                      'Keep screen on while reading',
                      Icons.book,
                    ),
                    _buildUseCaseItem(
                      'Gaming',
                      'Keep screen on during gameplay',
                      Icons.games,
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Timer Demo
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Timer Demo',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'This timer will keep running even when the screen is off (if wakelock is enabled)',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: Text(
                        '00:00:00',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _startTimer,
                            icon: Icon(Icons.play_arrow),
                            label: Text('Start'),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _stopTimer,
                            icon: Icon(Icons.stop),
                            label: Text('Stop'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUseCaseItem(String title, String description, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 24),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _enableWakelock() async {
    try {
      await WakelockService.enable();
      setState(() {
        _isWakelockEnabled = true;
      });
      _showSnackBar('Wakelock enabled - screen will stay on');
    } catch (e) {
      _showSnackBar('Error enabling wakelock: $e');
    }
  }

  Future<void> _disableWakelock() async {
    try {
      await WakelockService.disable();
      setState(() {
        _isWakelockEnabled = false;
      });
      _showSnackBar('Wakelock disabled - screen can sleep normally');
    } catch (e) {
      _showSnackBar('Error disabling wakelock: $e');
    }
  }

  Future<void> _toggleWakelock() async {
    try {
      await WakelockService.toggle();
      setState(() {
        _isWakelockEnabled = !_isWakelockEnabled;
      });
      _showSnackBar(
        _isWakelockEnabled 
          ? 'Wakelock enabled' 
          : 'Wakelock disabled'
      );
    } catch (e) {
      _showSnackBar('Error toggling wakelock: $e');
    }
  }

  void _startTimer() {
    _showSnackBar('Timer started (demo only)');
  }

  void _stopTimer() {
    _showSnackBar('Timer stopped (demo only)');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
```

### Advanced Wakelock Implementation

```dart
class AdvancedWakelockPage extends StatefulWidget {
  @override
  _AdvancedWakelockPageState createState() => _AdvancedWakelockPageState();
}

class _AdvancedWakelockPageState extends State<AdvancedWakelockPage> {
  bool _isWakelockEnabled = false;
  Timer? _timer;
  int _elapsedSeconds = 0;
  bool _isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    _checkWakelockStatus();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _checkWakelockStatus() async {
    try {
      bool status = await WakelockPlus.enabled;
      setState(() {
        _isWakelockEnabled = status;
      });
    } catch (e) {
      _showSnackBar('Error checking wakelock status: $e');
    }
  }

  void _startTimer() {
    if (!_isTimerRunning) {
      setState(() {
        _isTimerRunning = true;
        _elapsedSeconds = 0;
      });
      
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _elapsedSeconds++;
        });
      });
      
      _showSnackBar('Timer started');
    }
  }

  void _stopTimer() {
    if (_isTimerRunning) {
      _timer?.cancel();
      setState(() {
        _isTimerRunning = false;
      });
      _showSnackBar('Timer stopped');
    }
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isTimerRunning = false;
      _elapsedSeconds = 0;
    });
    _showSnackBar('Timer reset');
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Advanced Wakelock Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Timer Display
            Card(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text(
                      'Elapsed Time',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(
                      _formatTime(_elapsedSeconds),
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                        color: _isTimerRunning ? Colors.green : Colors.grey,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _isTimerRunning ? null : _startTimer,
                            icon: Icon(Icons.play_arrow),
                            label: Text('Start'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _isTimerRunning ? _stopTimer : null,
                            icon: Icon(Icons.pause),
                            label: Text('Pause'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _resetTimer,
                            icon: Icon(Icons.refresh),
                            label: Text('Reset'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Wakelock Status
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wakelock Status',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(
                          _isWakelockEnabled ? Icons.lightbulb : Icons.lightbulb_outline,
                          color: _isWakelockEnabled ? Colors.yellow : Colors.grey,
                          size: 32,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _isWakelockEnabled ? 'Screen Stay Awake' : 'Screen Can Sleep',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                _isWakelockEnabled 
                                  ? 'Timer will continue running when screen is off' 
                                  : 'Timer will pause when screen turns off',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _toggleWakelock,
                      icon: Icon(_isWakelockEnabled ? Icons.lightbulb_outline : Icons.lightbulb),
                      label: Text(_isWakelockEnabled ? 'Disable Wakelock' : 'Enable Wakelock'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 48),
                        backgroundColor: _isWakelockEnabled ? Colors.red : Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Instructions
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Instructions',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    _buildInstructionItem(
                      '1. Start the timer',
                      'Press the Start button to begin counting',
                    ),
                    _buildInstructionItem(
                      '2. Enable wakelock',
                      'Press "Enable Wakelock" to keep screen on',
                    ),
                    _buildInstructionItem(
                      '3. Test screen timeout',
                      'Turn off the screen manually to test',
                    ),
                    _buildInstructionItem(
                      '4. Observe behavior',
                      'Timer continues with wakelock, pauses without',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionItem(String title, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleWakelock() async {
    try {
      await WakelockService.toggle();
      setState(() {
        _isWakelockEnabled = !_isWakelockEnabled;
      });
      _showSnackBar(
        _isWakelockEnabled 
          ? 'Wakelock enabled - screen will stay on' 
          : 'Wakelock disabled - screen can sleep'
      );
    } catch (e) {
      _showSnackBar('Error toggling wakelock: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
```

## Best Practices

1. **Battery Conservation**: Only enable wakelock when necessary
2. **User Control**: Always provide a way for users to disable wakelock
3. **Context Awareness**: Enable wakelock based on app context (video playing, navigation, etc.)
4. **Automatic Disable**: Disable wakelock when the feature is no longer needed
5. **User Feedback**: Inform users when wakelock is enabled/disabled
6. **Testing**: Test on different devices and screen timeout settings

## Common Use Cases

### Video Player

```dart
class VideoPlayerWidget extends StatefulWidget {
  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  bool _isPlaying = false;

  @override
  void dispose() {
    WakelockService.disable();
    super.dispose();
  }

  void _togglePlayback() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
    
    if (_isPlaying) {
      WakelockService.enable();
    } else {
      WakelockService.disable();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Video player widget
        Container(
          height: 200,
          color: Colors.black,
          child: Center(
            child: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: 64,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _togglePlayback,
          child: Text(_isPlaying ? 'Pause' : 'Play'),
        ),
      ],
    );
  }
}
```

### Navigation App

```dart
class NavigationWidget extends StatefulWidget {
  @override
  _NavigationWidgetState createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    // Enable wakelock when navigation starts
    WakelockService.enable();
  }

  @override
  void dispose() {
    // Disable wakelock when navigation ends
    WakelockService.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Navigation UI
    );
  }
}
```

This implementation provides a comprehensive solution for implementing Wakelock functionality in Flutter applications with proper battery management and user experience considerations.
