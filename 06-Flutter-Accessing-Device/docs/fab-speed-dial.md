# FAB - Speed Dial in Flutter

This document covers how to implement Floating Action Button (FAB) Speed Dial functionality in Flutter applications using the `flutter_speed_dial` package.

## Overview

Speed Dial is a Material Design pattern that expands a Floating Action Button to reveal a set of related actions. It's useful for providing quick access to multiple actions while keeping the UI clean and uncluttered.

## Setup

### Dependencies

Add the following dependency to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_speed_dial: ^7.0.0
```

## Implementation

### Basic Speed Dial

```dart
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class SpeedDialDemoPage extends StatefulWidget {
  @override
  _SpeedDialDemoPageState createState() => _SpeedDialDemoPageState();
}

class _SpeedDialDemoPageState extends State<SpeedDialDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speed Dial Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Text(
          'Tap the floating action button to see the speed dial in action!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        activeBackgroundColor: Colors.red,
        activeForegroundColor: Colors.white,
        buttonSize: const Size(56.0, 56.0),
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        elevation: 8.0,
        shape: const CircleBorder(),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.email),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            label: 'Send Email',
            onTap: () => _showSnackBar('Email action tapped!'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.phone),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            label: 'Make Call',
            onTap: () => _showSnackBar('Call action tapped!'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.message),
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            label: 'Send SMS',
            onTap: () => _showSnackBar('SMS action tapped!'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
```

### Advanced Speed Dial with Customization

```dart
class AdvancedSpeedDialPage extends StatefulWidget {
  @override
  _AdvancedSpeedDialPageState createState() => _AdvancedSpeedDialPageState();
}

class _AdvancedSpeedDialPageState extends State<AdvancedSpeedDialPage> {
  bool _isDialOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Advanced Speed Dial'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Speed Dial Status',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          _isDialOpen ? Icons.expand_less : Icons.expand_more,
                          color: _isDialOpen ? Colors.green : Colors.orange,
                        ),
                        SizedBox(width: 8),
                        Text(
                          _isDialOpen ? 'Speed Dial is Open' : 'Speed Dial is Closed',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Features',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    _buildFeatureItem('Multiple Actions', 'Access to various quick actions'),
                    _buildFeatureItem('Custom Icons', 'Different icons for each action'),
                    _buildFeatureItem('Color Coding', 'Different colors for different actions'),
                    _buildFeatureItem('Labels', 'Descriptive labels for each action'),
                    _buildFeatureItem('Animations', 'Smooth opening and closing animations'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        activeBackgroundColor: Colors.red,
        activeForegroundColor: Colors.white,
        buttonSize: const Size(56.0, 56.0),
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        elevation: 8.0,
        shape: const CircleBorder(),
        onOpen: () => setState(() => _isDialOpen = true),
        onClose: () => setState(() => _isDialOpen = false),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.camera_alt),
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
            label: 'Take Photo',
            labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            onTap: () => _takePhoto(),
          ),
          SpeedDialChild(
            child: const Icon(Icons.photo_library),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            label: 'Gallery',
            labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            onTap: () => _openGallery(),
          ),
          SpeedDialChild(
            child: const Icon(Icons.share),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            label: 'Share',
            labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            onTap: () => _shareContent(),
          ),
          SpeedDialChild(
            child: const Icon(Icons.favorite),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            label: 'Favorite',
            labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            onTap: () => _addToFavorites(),
          ),
          SpeedDialChild(
            child: const Icon(Icons.settings),
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            label: 'Settings',
            labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            onTap: () => _openSettings(),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 20),
          SizedBox(width: 8),
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

  void _takePhoto() {
    _showSnackBar('Camera action tapped!');
    // Implement camera functionality
  }

  void _openGallery() {
    _showSnackBar('Gallery action tapped!');
    // Implement gallery functionality
  }

  void _shareContent() {
    _showSnackBar('Share action tapped!');
    // Implement share functionality
  }

  void _addToFavorites() {
    _showSnackBar('Added to favorites!');
    // Implement favorites functionality
  }

  void _openSettings() {
    _showSnackBar('Settings action tapped!');
    // Implement settings navigation
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
```

### Contextual Speed Dial

```dart
class ContextualSpeedDialPage extends StatefulWidget {
  @override
  _ContextualSpeedDialPageState createState() => _ContextualSpeedDialPageState();
}

class _ContextualSpeedDialPageState extends State<ContextualSpeedDialPage> {
  bool _showSpeedDial = true;
  String _selectedItem = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contextual Speed Dial'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Control Panel
          Card(
            margin: EdgeInsets.all(16.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Speed Dial Controls',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => setState(() => _showSpeedDial = true),
                          child: Text('Show Speed Dial'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _showSpeedDial ? Colors.green : null,
                            foregroundColor: _showSpeedDial ? Colors.white : null,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => setState(() => _showSpeedDial = false),
                          child: Text('Hide Speed Dial'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: !_showSpeedDial ? Colors.red : null,
                            foregroundColor: !_showSpeedDial ? Colors.white : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Selected Item Display
          if (_selectedItem.isNotEmpty)
            Card(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.blue),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Last action: $_selectedItem',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          
          // Content Area
          Expanded(
            child: Center(
              child: Text(
                'Scroll or interact with the content to see the speed dial in action!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _showSpeedDial ? SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        activeBackgroundColor: Colors.red,
        activeForegroundColor: Colors.white,
        buttonSize: const Size(56.0, 56.0),
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        elevation: 8.0,
        shape: const CircleBorder(),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.edit),
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            label: 'Edit',
            onTap: () => _performAction('Edit'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.delete),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            label: 'Delete',
            onTap: () => _performAction('Delete'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.copy),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            label: 'Copy',
            onTap: () => _performAction('Copy'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.paste),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            label: 'Paste',
            onTap: () => _performAction('Paste'),
          ),
        ],
      ) : null,
    );
  }

  void _performAction(String action) {
    setState(() {
      _selectedItem = action;
    });
    _showSnackBar('$action action performed!');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
```

### Speed Dial with Custom Animations

```dart
class AnimatedSpeedDialPage extends StatefulWidget {
  @override
  _AnimatedSpeedDialPageState createState() => _AnimatedSpeedDialPageState();
}

class _AnimatedSpeedDialPageState extends State<AnimatedSpeedDialPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Speed Dial'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.touch_app,
                    size: 64,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Tap the speed dial to see animations!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        activeBackgroundColor: Colors.red,
        activeForegroundColor: Colors.white,
        buttonSize: const Size(56.0, 56.0),
        visible: true,
        closeManually: false,
        curve: Curves.elasticInOut,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        elevation: 8.0,
        shape: const CircleBorder(),
        onOpen: () {
          _animationController.forward();
        },
        onClose: () {
          _animationController.reverse();
        },
        children: [
          SpeedDialChild(
            child: const Icon(Icons.star),
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.black,
            label: 'Star',
            onTap: () => _showSnackBar('Star action!'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.favorite),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            label: 'Like',
            onTap: () => _showSnackBar('Like action!'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.share),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            label: 'Share',
            onTap: () => _showSnackBar('Share action!'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
```

## Customization Options

### Speed Dial Properties

```dart
SpeedDial(
  // Basic properties
  icon: Icons.add,                    // Main button icon
  activeIcon: Icons.close,            // Icon when speed dial is open
  backgroundColor: Colors.blue,       // Main button background color
  foregroundColor: Colors.white,      // Main button icon color
  activeBackgroundColor: Colors.red,  // Background color when open
  activeForegroundColor: Colors.white, // Icon color when open
  
  // Size and appearance
  buttonSize: Size(56.0, 56.0),      // Size of the main button
  elevation: 8.0,                    // Shadow elevation
  shape: CircleBorder(),              // Shape of the button
  
  // Behavior
  visible: true,                      // Whether to show the speed dial
  closeManually: false,               // Close on overlay tap
  curve: Curves.bounceIn,             // Animation curve
  
  // Overlay
  overlayColor: Colors.black,         // Overlay background color
  overlayOpacity: 0.5,                // Overlay opacity
  
  // Callbacks
  onOpen: () {},                      // Called when speed dial opens
  onClose: () {},                     // Called when speed dial closes
  
  // Children
  children: [],                       // List of SpeedDialChild widgets
)
```

### Speed Dial Child Properties

```dart
SpeedDialChild(
  child: Icon(Icons.email),           // Child widget (usually an icon)
  backgroundColor: Colors.green,      // Background color
  foregroundColor: Colors.white,      // Icon color
  label: 'Send Email',                // Label text
  labelStyle: TextStyle(),            // Label text style
  onTap: () {},                       // Tap callback
  onLongPress: () {},                 // Long press callback
)
```

## Best Practices

1. **Limit Actions**: Don't include too many actions (3-5 is ideal)
2. **Logical Grouping**: Group related actions together
3. **Clear Labels**: Use descriptive labels for each action
4. **Color Coding**: Use different colors to distinguish actions
5. **Consistent Icons**: Use appropriate and consistent icons
6. **Accessibility**: Ensure actions are accessible to all users
7. **Performance**: Avoid heavy operations in onTap callbacks

## Common Use Cases

### Social Media Actions

```dart
SpeedDial(
  icon: Icons.share,
  children: [
    SpeedDialChild(
      child: Icon(Icons.facebook),
      backgroundColor: Colors.blue[600]!,
      label: 'Facebook',
      onTap: () => shareToFacebook(),
    ),
    SpeedDialChild(
      child: Icon(Icons.twitter),
      backgroundColor: Colors.blue[400]!,
      label: 'Twitter',
      onTap: () => shareToTwitter(),
    ),
    SpeedDialChild(
      child: Icon(Icons.whatsapp),
      backgroundColor: Colors.green,
      label: 'WhatsApp',
      onTap: () => shareToWhatsApp(),
    ),
  ],
)
```

### File Operations

```dart
SpeedDial(
  icon: Icons.file_copy,
  children: [
    SpeedDialChild(
      child: Icon(Icons.create),
      backgroundColor: Colors.green,
      label: 'New File',
      onTap: () => createNewFile(),
    ),
    SpeedDialChild(
      child: Icon(Icons.folder_open),
      backgroundColor: Colors.blue,
      label: 'Open File',
      onTap: () => openFile(),
    ),
    SpeedDialChild(
      child: Icon(Icons.save),
      backgroundColor: Colors.orange,
      label: 'Save',
      onTap: () => saveFile(),
    ),
  ],
)
```

This implementation provides a comprehensive solution for implementing Speed Dial functionality in Flutter applications with various customization options and use cases.
