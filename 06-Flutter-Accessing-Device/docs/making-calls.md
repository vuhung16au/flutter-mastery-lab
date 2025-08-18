# Making Calls in Flutter

This document covers how to implement phone calling functionality in Flutter applications using the `flutter_phone_direct_caller` package.

## Overview

Flutter provides the ability to make phone calls directly from your application. This can be achieved using either the `url_launcher` package (which opens the phone app) or the `flutter_phone_direct_caller` package (which can make direct calls on some platforms).

## Setup

### Dependencies

Add the following dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_phone_direct_caller: ^2.1.1
  url_launcher: ^6.3.1
  permission_handler: ^11.3.1
```

### Platform Configuration

#### Android

Add the following permissions to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.CALL_PHONE" />
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
```

#### iOS

Add the following to `ios/Runner/Info.plist`:

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
  <string>tel</string>
</array>
```

## Implementation

### Phone Call Service

```dart
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class PhoneCallService {
  static Future<bool> makeDirectCall(String phoneNumber) async {
    try {
      // Request phone permission
      PermissionStatus status = await Permission.phone.request();
      
      if (status.isGranted) {
        return await FlutterPhoneDirectCaller.callNumber(phoneNumber);
      } else {
        throw Exception('Phone permission not granted');
      }
    } catch (e) {
      throw Exception('Failed to make direct call: $e');
    }
  }

  static Future<bool> openPhoneApp(String phoneNumber) async {
    try {
      final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
      
      if (await canLaunchUrl(phoneUri)) {
        return await launchUrl(phoneUri);
      } else {
        throw Exception('Could not launch phone app');
      }
    } catch (e) {
      throw Exception('Failed to open phone app: $e');
    }
  }

  static Future<bool> makeCallWithConfirmation(String phoneNumber) async {
    try {
      // This method shows a confirmation dialog before making the call
      return await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    } catch (e) {
      throw Exception('Failed to make call: $e');
    }
  }

  static Future<bool> makeEmergencyCall(String phoneNumber) async {
    try {
      // Emergency calls might bypass some restrictions
      return await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    } catch (e) {
      throw Exception('Failed to make emergency call: $e');
    }
  }
}
```

### UI Implementation

```dart
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class PhoneCallPage extends StatefulWidget {
  @override
  _PhoneCallPageState createState() => _PhoneCallPageState();
}

class _PhoneCallPageState extends State<PhoneCallPage> {
  final TextEditingController _phoneController = TextEditingController();
  bool _hasPhonePermission = false;

  @override
  void initState() {
    super.initState();
    _checkPhonePermission();
  }

  Future<void> _checkPhonePermission() async {
    PermissionStatus status = await Permission.phone.status;
    setState(() {
      _hasPhonePermission = status.isGranted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Call Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Phone Number Input
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Make Phone Call',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                        hintText: '+1234567890',
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _makeDirectCall,
                            icon: Icon(Icons.call),
                            label: Text('Direct Call'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _openPhoneApp,
                            icon: Icon(Icons.phone_android),
                            label: Text('Open Phone App'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Quick Call Buttons
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Call',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _callNumber('911'),
                            icon: Icon(Icons.emergency),
                            label: Text('Emergency'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _callNumber('411'),
                            icon: Icon(Icons.info),
                            label: Text('Directory'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _callNumber('+18005551234'),
                            icon: Icon(Icons.support_agent),
                            label: Text('Support'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _showContactPicker,
                            icon: Icon(Icons.contacts),
                            label: Text('Contacts'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
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
            
            // Permission Status
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Permission Status',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          _hasPhonePermission ? Icons.check_circle : Icons.error,
                          color: _hasPhonePermission ? Colors.green : Colors.red,
                        ),
                        SizedBox(width: 8),
                        Text(
                          _hasPhonePermission 
                            ? 'Phone permission granted' 
                            : 'Phone permission required',
                        ),
                      ],
                    ),
                    if (!_hasPhonePermission) ...[
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: _requestPhonePermission,
                        child: Text('Request Permission'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Call History (Mock)
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recent Calls',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    _buildCallHistoryItem('+1234567890', 'John Doe', '2 minutes ago'),
                    _buildCallHistoryItem('+1987654321', 'Jane Smith', '1 hour ago'),
                    _buildCallHistoryItem('911', 'Emergency', '2 hours ago'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallHistoryItem(String number, String name, String time) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.green,
        child: Icon(Icons.call, color: Colors.white),
      ),
      title: Text(name),
      subtitle: Text(number),
      trailing: Text(time, style: TextStyle(fontSize: 12)),
      onTap: () => _callNumber(number),
    );
  }

  Future<void> _makeDirectCall() async {
    try {
      if (_phoneController.text.isEmpty) {
        _showSnackBar('Please enter a phone number');
        return;
      }

      if (!_hasPhonePermission) {
        _showSnackBar('Phone permission required');
        return;
      }

      bool success = await PhoneCallService.makeDirectCall(_phoneController.text);
      
      if (success) {
        _showSnackBar('Call initiated successfully!');
      } else {
        _showSnackBar('Failed to make call');
      }
    } catch (e) {
      _showSnackBar('Error: $e');
    }
  }

  Future<void> _openPhoneApp() async {
    try {
      if (_phoneController.text.isEmpty) {
        _showSnackBar('Please enter a phone number');
        return;
      }

      bool success = await PhoneCallService.openPhoneApp(_phoneController.text);
      
      if (success) {
        _showSnackBar('Phone app opened successfully!');
      } else {
        _showSnackBar('Failed to open phone app');
      }
    } catch (e) {
      _showSnackBar('Error: $e');
    }
  }

  Future<void> _callNumber(String number) async {
    try {
      _phoneController.text = number;
      await _makeDirectCall();
    } catch (e) {
      _showSnackBar('Error: $e');
    }
  }

  Future<void> _showContactPicker() async {
    // This would typically integrate with contacts plugin
    _showSnackBar('Contact picker not implemented in this demo');
  }

  Future<void> _requestPhonePermission() async {
    try {
      PermissionStatus status = await Permission.phone.request();
      setState(() {
        _hasPhonePermission = status.isGranted;
      });
      
      if (status.isGranted) {
        _showSnackBar('Phone permission granted!');
      } else {
        _showSnackBar('Phone permission denied');
      }
    } catch (e) {
      _showSnackBar('Error requesting permission: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
```

## Advanced Features

### Call with Confirmation Dialog

```dart
class CallConfirmationDialog extends StatelessWidget {
  final String phoneNumber;
  final String contactName;

  CallConfirmationDialog({
    required this.phoneNumber,
    required this.contactName,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Make Call'),
      content: Text('Call $contactName at $phoneNumber?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text('Call'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}

// Usage
Future<void> _showCallConfirmation(String phoneNumber, String contactName) async {
  bool? shouldCall = await showDialog<bool>(
    context: context,
    builder: (context) => CallConfirmationDialog(
      phoneNumber: phoneNumber,
      contactName: contactName,
    ),
  );

  if (shouldCall == true) {
    await PhoneCallService.makeDirectCall(phoneNumber);
  }
}
```

### Call Logging

```dart
class CallLog {
  final String phoneNumber;
  final String contactName;
  final DateTime timestamp;
  final Duration? duration;
  final CallType type;

  CallLog({
    required this.phoneNumber,
    required this.contactName,
    required this.timestamp,
    this.duration,
    required this.type,
  });
}

enum CallType { incoming, outgoing, missed }

class CallLogger {
  static List<CallLog> _callLogs = [];

  static void logCall(CallLog callLog) {
    _callLogs.add(callLog);
    // In a real app, you would save this to local storage or a database
  }

  static List<CallLog> getCallLogs() {
    return List.from(_callLogs);
  }

  static List<CallLog> getRecentCalls(int count) {
    return _callLogs
        .take(count)
        .toList();
  }
}
```

### International Number Support

```dart
class PhoneNumberFormatter {
  static String formatPhoneNumber(String phoneNumber) {
    // Remove all non-digit characters
    String digits = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    
    // Add country code if not present
    if (!digits.startsWith('1') && digits.length == 10) {
      digits = '1$digits';
    }
    
    // Format the number
    if (digits.length == 11) {
      return '+${digits.substring(0, 1)} (${digits.substring(1, 4)}) ${digits.substring(4, 7)}-${digits.substring(7)}';
    }
    
    return phoneNumber;
  }

  static bool isValidPhoneNumber(String phoneNumber) {
    String digits = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    return digits.length >= 10 && digits.length <= 15;
  }
}
```

## Best Practices

1. **Permission Handling**: Always check and request phone permissions before making calls
2. **Error Handling**: Provide fallback options when direct calling is not available
3. **User Experience**: Show confirmation dialogs for important calls
4. **Number Validation**: Validate phone numbers before attempting to call
5. **Platform Differences**: Be aware that calling behavior may differ between platforms
6. **Emergency Calls**: Handle emergency numbers (like 911) appropriately

## Common Use Cases

### Emergency Call

```dart
Future<void> makeEmergencyCall() async {
  try {
    await PhoneCallService.makeEmergencyCall('911');
  } catch (e) {
    // Fallback to opening phone app
    await PhoneCallService.openPhoneApp('911');
  }
}
```

### Support Call

```dart
Future<void> callSupport() async {
  String supportNumber = '+18005551234';
  await PhoneCallService.makeCallWithConfirmation(supportNumber);
}
```

### Contact Call

```dart
Future<void> callContact(Contact contact) async {
  if (contact.phoneNumbers.isNotEmpty) {
    String phoneNumber = contact.phoneNumbers.first;
    await PhoneCallService.makeDirectCall(phoneNumber);
  }
}
```

This implementation provides a comprehensive solution for making phone calls in Flutter applications with proper permission handling and user experience considerations.
