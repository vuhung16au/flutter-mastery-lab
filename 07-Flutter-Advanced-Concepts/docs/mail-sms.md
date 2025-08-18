# Mail and SMS in Flutter

## Overview
This document covers how to implement email and SMS functionality in Flutter applications using the `url_launcher` package. This allows users to send emails and SMS messages directly from your app.

## Dependencies
```yaml
dependencies:
  url_launcher: ^6.2.5
```

## Setup

### Android Permissions
Add the following permissions to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.SEND_SMS" />
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
```

### iOS Permissions
Add the following to `ios/Runner/Info.plist`:
```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>mailto</string>
    <string>sms</string>
    <string>tel</string>
</array>
```

## Email Functionality

### Basic Email Sending
```dart
import 'package:url_launcher/url_launcher.dart';

class EmailService {
  static Future<void> sendEmail({
    required String to,
    String? subject,
    String? body,
  }) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: to,
      queryParameters: {
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch email app';
    }
  }
}
```

### Email with Attachments (Advanced)
```dart
class AdvancedEmailService {
  static Future<void> sendEmailWithAttachment({
    required String to,
    String? subject,
    String? body,
    List<String>? attachments,
  }) async {
    // Note: Attachments require platform-specific implementation
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
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch email app';
    }
  }
}
```

### Email Validation
```dart
class EmailValidator {
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    if (!isValidEmail(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }
}
```

## SMS Functionality

### Basic SMS Sending
```dart
class SMSService {
  static Future<void> sendSMS({
    required String phoneNumber,
    required String message,
  }) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: {
        'body': message,
      },
    );

    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      throw 'Could not launch SMS app';
    }
  }
}
```

### SMS with Multiple Recipients
```dart
class AdvancedSMSService {
  static Future<void> sendSMSToMultiple({
    required List<String> phoneNumbers,
    required String message,
  }) async {
    final String numbers = phoneNumbers.join(',');
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: numbers,
      queryParameters: {
        'body': message,
      },
    );

    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      throw 'Could not launch SMS app';
    }
  }
}
```

### Phone Number Validation
```dart
class PhoneValidator {
  static bool isValidPhoneNumber(String phone) {
    // Basic phone number validation
    return RegExp(r'^\+?[\d\s-\(\)]+$').hasMatch(phone);
  }

  static String? validatePhoneNumber(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Phone number is required';
    }
    if (!isValidPhoneNumber(phone)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String formatPhoneNumber(String phone) {
    // Remove all non-digit characters
    String digits = phone.replaceAll(RegExp(r'[^\d]'), '');
    
    // Add country code if not present
    if (!digits.startsWith('1') && digits.length == 10) {
      digits = '1$digits';
    }
    
    return '+$digits';
  }
}
```

## UI Components

### Email Form Widget
```dart
class EmailForm extends StatefulWidget {
  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final _formKey = GlobalKey<FormState>();
  final _toController = TextEditingController();
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _toController,
            decoration: InputDecoration(labelText: 'To'),
            validator: EmailValidator.validateEmail,
          ),
          TextFormField(
            controller: _subjectController,
            decoration: InputDecoration(labelText: 'Subject'),
          ),
          TextFormField(
            controller: _bodyController,
            decoration: InputDecoration(labelText: 'Message'),
            maxLines: 3,
          ),
          ElevatedButton(
            onPressed: _sendEmail,
            child: Text('Send Email'),
          ),
        ],
      ),
    );
  }

  void _sendEmail() async {
    if (_formKey.currentState!.validate()) {
      try {
        await EmailService.sendEmail(
          to: _toController.text,
          subject: _subjectController.text,
          body: _bodyController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email app opened successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
}
```

### SMS Form Widget
```dart
class SMSForm extends StatefulWidget {
  @override
  _SMSFormState createState() => _SMSFormState();
}

class _SMSFormState extends State<SMSForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(labelText: 'Phone Number'),
            keyboardType: TextInputType.phone,
            validator: PhoneValidator.validatePhoneNumber,
          ),
          TextFormField(
            controller: _messageController,
            decoration: InputDecoration(labelText: 'Message'),
            maxLines: 3,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Message is required';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: _sendSMS,
            child: Text('Send SMS'),
          ),
        ],
      ),
    );
  }

  void _sendSMS() async {
    if (_formKey.currentState!.validate()) {
      try {
        await SMSService.sendSMS(
          phoneNumber: PhoneValidator.formatPhoneNumber(_phoneController.text),
          message: _messageController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('SMS app opened successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
}
```

## Error Handling
```dart
class CommunicationErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error.toString().contains('Could not launch')) {
      return 'No email or SMS app found on device';
    }
    return 'An error occurred: $error';
  }

  static Future<bool> checkEmailAppAvailable() async {
    final Uri testUri = Uri(scheme: 'mailto', path: 'test@example.com');
    return await canLaunchUrl(testUri);
  }

  static Future<bool> checkSMSAppAvailable() async {
    final Uri testUri = Uri(scheme: 'sms', path: '1234567890');
    return await canLaunchUrl(testUri);
  }
}
```

## Best Practices
1. **Always validate** email addresses and phone numbers before sending
2. **Handle errors gracefully** and provide user-friendly error messages
3. **Check app availability** before attempting to launch external apps
4. **Use proper formatting** for phone numbers and email addresses
5. **Implement proper UI feedback** to inform users of the action status
6. **Consider accessibility** by providing alternative methods for communication
7. **Test on multiple devices** to ensure compatibility

## Platform-Specific Notes

### Android
- Uses `url_launcher` to open device's default SMS app
- Requires SMS permissions for direct SMS sending
- Falls back gracefully if no SMS app is available

### iOS
- Uses `url_launcher` to open Messages app
- No special permissions required for basic SMS functionality
- Provides better integration with iOS messaging

### Web
- Limited SMS functionality
- Email works through browser's mailto: links
- Consider using Web APIs for enhanced functionality

## Example Implementation
See the main application for a complete implementation of email and SMS functionality with proper UI components and error handling.
