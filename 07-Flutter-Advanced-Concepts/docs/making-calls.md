# Making Calls in Flutter

## Overview
This document covers how to implement phone call functionality in Flutter applications using the `url_launcher` package. This allows users to make phone calls directly from your app.

## Dependencies
```yaml
dependencies:
  url_launcher: ^6.2.5
```

## Setup

### Android Permissions
Add the following permissions to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.CALL_PHONE" />
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
```

### iOS Permissions
Add the following to `ios/Runner/Info.plist`:
```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>tel</string>
    <string>telprompt</string>
</array>
```

## Basic Call Functionality

### Make a Phone Call
```dart
import 'package:url_launcher/url_launcher.dart';

class CallService {
  static Future<void> makeCall(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      throw 'Could not launch phone app';
    }
  }
}
```

### Make a Call with Prompt (iOS)
```dart
class CallService {
  static Future<void> makeCallWithPrompt(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'telprompt', path: phoneNumber);

    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      // Fallback to regular tel scheme
      await makeCall(phoneNumber);
    }
  }
}
```

## Advanced Call Features

### Call with Confirmation Dialog
```dart
class AdvancedCallService {
  static Future<void> makeCallWithConfirmation(
    BuildContext context,
    String phoneNumber,
    String contactName,
  ) async {
    final bool? shouldCall = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Make Call'),
          content: Text('Do you want to call $contactName at $phoneNumber?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Call'),
            ),
          ],
        );
      },
    );

    if (shouldCall == true) {
      await makeCall(phoneNumber);
    }
  }
}
```

### Call with Contact Selection
```dart
class ContactCallService {
  static Future<void> selectContactAndCall(BuildContext context) async {
    // This would typically integrate with a contacts plugin
    // For now, we'll show a simple dialog
    final String? selectedNumber = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Contact'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('John Doe'),
                subtitle: Text('+1 234 567 8900'),
                onTap: () => Navigator.of(context).pop('+12345678900'),
              ),
              ListTile(
                title: Text('Jane Smith'),
                subtitle: Text('+1 234 567 8901'),
                onTap: () => Navigator.of(context).pop('+12345678901'),
              ),
            ],
          ),
        );
      },
    );

    if (selectedNumber != null) {
      await makeCall(selectedNumber);
    }
  }
}
```

## Phone Number Validation and Formatting

### Phone Number Validator
```dart
class PhoneNumberValidator {
  static bool isValidPhoneNumber(String phone) {
    // Remove all non-digit characters for validation
    String digits = phone.replaceAll(RegExp(r'[^\d]'), '');
    return digits.length >= 10 && digits.length <= 15;
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
    
    // Add country code if not present (assuming US)
    if (!digits.startsWith('1') && digits.length == 10) {
      digits = '1$digits';
    }
    
    return '+$digits';
  }

  static String formatForDisplay(String phone) {
    String digits = phone.replaceAll(RegExp(r'[^\d]'), '');
    
    if (digits.length == 10) {
      return '(${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6)}';
    } else if (digits.length == 11 && digits.startsWith('1')) {
      return '+1 (${digits.substring(1, 4)}) ${digits.substring(4, 7)}-${digits.substring(7)}';
    }
    
    return phone;
  }
}
```

## UI Components

### Call Button Widget
```dart
class CallButton extends StatelessWidget {
  final String phoneNumber;
  final String? contactName;
  final IconData icon;
  final Color? color;

  const CallButton({
    Key? key,
    required this.phoneNumber,
    this.contactName,
    this.icon = Icons.call,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      color: color ?? Colors.green,
      onPressed: () => _makeCall(context),
      tooltip: 'Call ${contactName ?? phoneNumber}',
    );
  }

  void _makeCall(BuildContext context) async {
    try {
      await CallService.makeCall(phoneNumber);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
```

### Call Form Widget
```dart
class CallForm extends StatefulWidget {
  @override
  _CallFormState createState() => _CallFormState();
}

class _CallFormState extends State<CallForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              prefixIcon: Icon(Icons.phone),
            ),
            keyboardType: TextInputType.phone,
            validator: PhoneNumberValidator.validatePhoneNumber,
          ),
          SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _makeCall,
            icon: Icon(Icons.call),
            label: Text('Make Call'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _makeCall() async {
    if (_formKey.currentState!.validate()) {
      try {
        final formattedNumber = PhoneNumberValidator.formatPhoneNumber(_phoneController.text);
        await CallService.makeCall(formattedNumber);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
}
```

### Contact List Widget
```dart
class ContactList extends StatelessWidget {
  final List<Contact> contacts;

  const ContactList({Key? key, required this.contacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(contact.name[0].toUpperCase()),
          ),
          title: Text(contact.name),
          subtitle: Text(contact.phoneNumber),
          trailing: CallButton(
            phoneNumber: contact.phoneNumber,
            contactName: contact.name,
          ),
        );
      },
    );
  }
}

class Contact {
  final String name;
  final String phoneNumber;

  Contact({required this.name, required this.phoneNumber});
}
```

## Error Handling

### Call Error Handler
```dart
class CallErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error.toString().contains('Could not launch')) {
      return 'No phone app found on device';
    }
    if (error.toString().contains('permission')) {
      return 'Phone permission denied';
    }
    return 'An error occurred: $error';
  }

  static Future<bool> checkPhoneAppAvailable() async {
    final Uri testUri = Uri(scheme: 'tel', path: '1234567890');
    return await canLaunchUrl(testUri);
  }

  static Future<void> handleCallError(BuildContext context, dynamic error) async {
    final String message = getErrorMessage(error);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
```

## Platform-Specific Considerations

### Android
- Requires `CALL_PHONE` permission
- May need to handle runtime permissions
- Consider using `tel:` scheme

### iOS
- Uses `tel:` or `telprompt:` schemes
- `telprompt:` shows confirmation dialog
- No special permissions required for basic calling

### Web
- Limited functionality
- May redirect to external calling services
- Consider using WebRTC for web-based calling

## Best Practices
1. **Always validate** phone numbers before making calls
2. **Handle permissions** properly on Android
3. **Provide user feedback** for call actions
4. **Use proper formatting** for phone numbers
5. **Implement error handling** for failed calls
6. **Consider accessibility** features
7. **Test on multiple devices** and platforms
8. **Respect user privacy** and preferences

## Example Implementation
See the main application for a complete implementation of phone call functionality with proper UI components, error handling, and platform-specific considerations.
