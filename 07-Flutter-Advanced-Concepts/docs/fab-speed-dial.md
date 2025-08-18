# FAB - Speed Dial in Flutter

## Overview
This document covers how to implement Floating Action Button (FAB) Speed Dial functionality in Flutter using the `flutter_speed_dial` package. Speed dial provides a quick way to access multiple actions from a single floating action button.

## Dependencies
```yaml
dependencies:
  flutter_speed_dial: ^7.0.0
```

## Basic Speed Dial Implementation

### Simple Speed Dial
```dart
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class BasicSpeedDial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Basic Speed Dial')),
      body: Center(child: Text('Content goes here')),
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
            label: 'Email',
            onTap: () => print('Email tapped'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.phone),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            label: 'Call',
            onTap: () => print('Call tapped'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.message),
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            label: 'Message',
            onTap: () => print('Message tapped'),
          ),
        ],
      ),
    );
  }
}
```

## Advanced Speed Dial Features

### Speed Dial with Custom Styling
```dart
class CustomSpeedDial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Custom Speed Dial')),
      body: Center(child: Text('Content goes here')),
      floatingActionButton: SpeedDial(
        // Main FAB
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        activeBackgroundColor: Colors.red,
        activeForegroundColor: Colors.white,
        
        // Size and positioning
        buttonSize: const Size(60.0, 60.0),
        visible: true,
        closeManually: false,
        
        // Animation
        curve: Curves.elasticInOut,
        overlayColor: Colors.black,
        overlayOpacity: 0.6,
        elevation: 12.0,
        
        // Shape and styling
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        
        // Children
        children: [
          SpeedDialChild(
            child: const Icon(Icons.email, size: 28),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            label: 'Send Email',
            labelStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            labelBackgroundColor: Colors.green,
            onTap: () => _showSnackBar(context, 'Email tapped'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.phone, size: 28),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            label: 'Make Call',
            labelStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            labelBackgroundColor: Colors.blue,
            onTap: () => _showSnackBar(context, 'Call tapped'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.message, size: 28),
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            label: 'Send Message',
            labelStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            labelBackgroundColor: Colors.orange,
            onTap: () => _showSnackBar(context, 'Message tapped'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
```

### Speed Dial with Conditional Visibility
```dart
class ConditionalSpeedDial extends StatefulWidget {
  @override
  _ConditionalSpeedDialState createState() => _ConditionalSpeedDialState();
}

class _ConditionalSpeedDialState extends State<ConditionalSpeedDial> {
  bool _isVisible = true;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conditional Speed Dial'),
        actions: [
          IconButton(
            icon: Icon(_isVisible ? Icons.visibility_off : Icons.visibility),
            onPressed: () => setState(() => _isVisible = !_isVisible),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Speed Dial is ${_isVisible ? "Visible" : "Hidden"}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => setState(() => _isExpanded = !_isExpanded),
              child: Text(_isExpanded ? "Collapse" : "Expand"),
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        visible: _isVisible,
        closeManually: false,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.create),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            label: 'Create',
            onTap: () => _showSnackBar('Create tapped'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.edit),
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            label: 'Edit',
            onTap: () => _showSnackBar('Edit tapped'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.delete),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            label: 'Delete',
            onTap: () => _showSnackBar('Delete tapped'),
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

## Speed Dial with Different Positions

### Bottom Right Speed Dial
```dart
class BottomRightSpeedDial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bottom Right Speed Dial')),
      body: Center(child: Text('Content goes here')),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.email),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            label: 'Email',
            onTap: () => print('Email tapped'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.phone),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            label: 'Call',
            onTap: () => print('Call tapped'),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
```

### Center Float Speed Dial
```dart
class CenterFloatSpeedDial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Center Float Speed Dial')),
      body: Center(child: Text('Content goes here')),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.email),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            label: 'Email',
            onTap: () => print('Email tapped'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.phone),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            label: 'Call',
            onTap: () => print('Call tapped'),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
```

## Speed Dial with Custom Animations

### Bounce Animation Speed Dial
```dart
class BounceSpeedDial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bounce Animation Speed Dial')),
      body: Center(child: Text('Content goes here')),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        curve: Curves.bounceInOut,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.email),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            label: 'Email',
            onTap: () => print('Email tapped'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.phone),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            label: 'Call',
            onTap: () => print('Call tapped'),
          ),
        ],
      ),
    );
  }
}
```

## Speed Dial with Different Shapes

### Rounded Rectangle Speed Dial
```dart
class RoundedRectangleSpeedDial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rounded Rectangle Speed Dial')),
      body: Center(child: Text('Content goes here')),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.email),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            label: 'Email',
            onTap: () => print('Email tapped'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.phone),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            label: 'Call',
            onTap: () => print('Call tapped'),
          ),
        ],
      ),
    );
  }
}
```

## Speed Dial with Custom Labels

### Speed Dial with Rich Labels
```dart
class RichLabelSpeedDial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rich Label Speed Dial')),
      body: Center(child: Text('Content goes here')),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.email),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            label: 'Send Email',
            labelStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            labelBackgroundColor: Colors.green,
            onTap: () => print('Email tapped'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.phone),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            label: 'Make Call',
            labelStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            labelBackgroundColor: Colors.blue,
            onTap: () => print('Call tapped'),
          ),
        ],
      ),
    );
  }
}
```

## Best Practices
1. **Use meaningful icons** that clearly represent the action
2. **Limit the number of children** to 3-5 for better UX
3. **Group related actions** together in the speed dial
4. **Use consistent colors** for related actions
5. **Provide clear labels** for accessibility
6. **Handle errors gracefully** in onTap callbacks
7. **Consider the user's context** when showing/hiding the speed dial
8. **Test on different screen sizes** to ensure proper positioning

## Example Implementation
See the main application for a complete implementation of speed dial functionality with various configurations and use cases.
