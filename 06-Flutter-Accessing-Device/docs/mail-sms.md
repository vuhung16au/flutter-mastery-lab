# Mail and SMS in Flutter

This document covers how to implement email and SMS functionality in Flutter applications using the `url_launcher` package.

## Overview

Flutter provides the ability to send emails and SMS messages by launching the device's default email and messaging apps. This is achieved using the `url_launcher` package, which can open URLs, make phone calls, send emails, and send SMS messages.

## Setup

### Dependencies

Add the following dependency to your `pubspec.yaml`:

```yaml
dependencies:
  url_launcher: ^6.3.1
```

### Platform Configuration

#### Android

Add the following permissions to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.QUERY_ALL_PACKAGES" />
```

#### iOS

Add the following to `ios/Runner/Info.plist`:

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
  <string>mailto</string>
  <string>sms</string>
  <string>tel</string>
</array>
```

## Implementation

### Email Service

```dart
import 'package:url_launcher/url_launcher.dart';

class EmailService {
  static Future<bool> sendEmail({
    required String to,
    String? subject,
    String? body,
    List<String>? cc,
    List<String>? bcc,
  }) async {
    try {
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: to,
        queryParameters: {
          if (subject != null) 'subject': subject,
          if (body != null) 'body': body,
          if (cc != null && cc.isNotEmpty) 'cc': cc.join(','),
          if (bcc != null && bcc.isNotEmpty) 'bcc': bcc.join(','),
        },
      );

      if (await canLaunchUrl(emailUri)) {
        return await launchUrl(emailUri);
      } else {
        throw Exception('Could not launch email app');
      }
    } catch (e) {
      throw Exception('Failed to send email: $e');
    }
  }

  static Future<bool> sendEmailWithAttachment({
    required String to,
    String? subject,
    String? body,
    String? attachmentPath,
  }) async {
    try {
      // Note: File attachments require platform-specific implementation
      // This is a simplified version
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: to,
        queryParameters: {
          if (subject != null) 'subject': subject,
          if (body != null) 'body': body,
        },
      );

      if (await canLaunchUrl(emailUri)) {
        return await launchUrl(emailUri);
      } else {
        throw Exception('Could not launch email app');
      }
    } catch (e) {
      throw Exception('Failed to send email: $e');
    }
  }
}
```

### SMS Service

```dart
import 'package:url_launcher/url_launcher.dart';

class SMSService {
  static Future<bool> sendSMS({
    required String phoneNumber,
    String? message,
  }) async {
    try {
      final Uri smsUri = Uri(
        scheme: 'sms',
        path: phoneNumber,
        queryParameters: {
          if (message != null) 'body': message,
        },
      );

      if (await canLaunchUrl(smsUri)) {
        return await launchUrl(smsUri);
      } else {
        throw Exception('Could not launch SMS app');
      }
    } catch (e) {
      throw Exception('Failed to send SMS: $e');
    }
  }

  static Future<bool> sendSMSMultiple({
    required List<String> phoneNumbers,
    String? message,
  }) async {
    try {
      final String numbers = phoneNumbers.join(',');
      final Uri smsUri = Uri(
        scheme: 'sms',
        path: numbers,
        queryParameters: {
          if (message != null) 'body': message,
        },
      );

      if (await canLaunchUrl(smsUri)) {
        return await launchUrl(smsUri);
      } else {
        throw Exception('Could not launch SMS app');
      }
    } catch (e) {
      throw Exception('Failed to send SMS: $e');
    }
  }
}
```

### UI Implementation

```dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MailSMSPage extends StatefulWidget {
  @override
  _MailSMSPageState createState() => _MailSMSPageState();
}

class _MailSMSPageState extends State<MailSMSPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _smsMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mail & SMS Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Email Section
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Send Email',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: _subjectController,
                      decoration: InputDecoration(
                        labelText: 'Subject',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.subject),
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: _bodyController,
                      decoration: InputDecoration(
                        labelText: 'Message',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.message),
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _sendEmail,
                      icon: Icon(Icons.send),
                      label: Text('Send Email'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 48),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // SMS Section
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Send SMS',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: _smsMessageController,
                      decoration: InputDecoration(
                        labelText: 'Message',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.sms),
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _sendSMS,
                      icon: Icon(Icons.sms),
                      label: Text('Send SMS'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 48),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // Quick Actions
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Actions',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _openEmailApp(),
                            icon: Icon(Icons.email),
                            label: Text('Open Email App'),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _openSMSApp(),
                            icon: Icon(Icons.sms),
                            label: Text('Open SMS App'),
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

  Future<void> _sendEmail() async {
    try {
      if (_emailController.text.isEmpty) {
        _showSnackBar('Please enter an email address');
        return;
      }

      bool success = await EmailService.sendEmail(
        to: _emailController.text,
        subject: _subjectController.text,
        body: _bodyController.text,
      );

      if (success) {
        _showSnackBar('Email app opened successfully!');
        _clearEmailFields();
      } else {
        _showSnackBar('Failed to open email app');
      }
    } catch (e) {
      _showSnackBar('Error: $e');
    }
  }

  Future<void> _sendSMS() async {
    try {
      if (_phoneController.text.isEmpty) {
        _showSnackBar('Please enter a phone number');
        return;
      }

      bool success = await SMSService.sendSMS(
        phoneNumber: _phoneController.text,
        message: _smsMessageController.text,
      );

      if (success) {
        _showSnackBar('SMS app opened successfully!');
        _clearSMSFields();
      } else {
        _showSnackBar('Failed to open SMS app');
      }
    } catch (e) {
      _showSnackBar('Error: $e');
    }
  }

  Future<void> _openEmailApp() async {
    try {
      final Uri emailUri = Uri(scheme: 'mailto');
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
        _showSnackBar('Email app opened!');
      } else {
        _showSnackBar('No email app found');
      }
    } catch (e) {
      _showSnackBar('Error: $e');
    }
  }

  Future<void> _openSMSApp() async {
    try {
      final Uri smsUri = Uri(scheme: 'sms');
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
        _showSnackBar('SMS app opened!');
      } else {
        _showSnackBar('No SMS app found');
      }
    } catch (e) {
      _showSnackBar('Error: $e');
    }
  }

  void _clearEmailFields() {
    _emailController.clear();
    _subjectController.clear();
    _bodyController.clear();
  }

  void _clearSMSFields() {
    _phoneController.clear();
    _smsMessageController.clear();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
```

## Advanced Features

### Email with HTML Content

```dart
static Future<bool> sendEmailWithHTML({
  required String to,
  String? subject,
  String? htmlBody,
}) async {
  try {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: to,
      queryParameters: {
        if (subject != null) 'subject': subject,
        if (htmlBody != null) 'body': htmlBody,
      },
    );

    if (await canLaunchUrl(emailUri)) {
      return await launchUrl(emailUri);
    } else {
      throw Exception('Could not launch email app');
    }
  } catch (e) {
    throw Exception('Failed to send email: $e');
  }
}
```

### SMS with Pre-filled Message

```dart
static Future<bool> sendSMSTemplate({
  required String phoneNumber,
  required String template,
  Map<String, String>? variables,
}) async {
  try {
    String message = template;
    if (variables != null) {
      variables.forEach((key, value) {
        message = message.replaceAll('{{$key}}', value);
      });
    }

    return await sendSMS(
      phoneNumber: phoneNumber,
      message: message,
    );
  } catch (e) {
    throw Exception('Failed to send SMS template: $e');
  }
}
```

## Best Practices

1. **Error Handling**: Always wrap URL launching operations in try-catch blocks
2. **Validation**: Validate email addresses and phone numbers before sending
3. **User Experience**: Provide clear feedback when apps are opened or fail to open
4. **Platform Differences**: Be aware that different platforms may handle URLs differently
5. **Fallbacks**: Provide alternative methods when apps are not available
6. **Permissions**: Ensure proper permissions are set up for each platform

## Common Use Cases

### Contact Support

```dart
Future<void> contactSupport() async {
  await EmailService.sendEmail(
    to: 'support@yourapp.com',
    subject: 'Support Request',
    body: 'Hello, I need help with...',
  );
}
```

### Share via SMS

```dart
Future<void> shareViaSMS(String message) async {
  await SMSService.sendSMS(
    phoneNumber: '', // Empty for contact picker
    message: message,
  );
}
```

### Emergency Contact

```dart
Future<void> emergencyCall() async {
  await SMSService.sendSMS(
    phoneNumber: '911',
    message: 'Emergency: Need immediate assistance',
  );
}
```

This implementation provides a comprehensive solution for sending emails and SMS messages in Flutter applications.
