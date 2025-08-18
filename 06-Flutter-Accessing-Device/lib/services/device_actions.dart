import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DeviceActions {
  static void _showSnackBar(
    ScaffoldMessengerState? messenger,
    String message,
  ) {
    messenger?.showSnackBar(SnackBar(content: Text(message)));
  }

  static Future<void> sendEmail(BuildContext context) async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    try {
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: 'test@example.com',
        queryParameters: const {
          'subject': 'Test Email from Flutter App',
          'body':
              'This is a test email sent from the Flutter Device Access app.',
        },
      );
      if (await canLaunchUrl(emailUri)) {
        final ok = await launchUrl(
          emailUri,
          // Let the platform decide; improves reliability on iOS simulators
          mode: LaunchMode.platformDefault,
        );
        if (!ok) {
          throw Exception('No external email app');
        }
        _showSnackBar(messenger, 'Email app opened');
      } else {
        // Fallback: open Gmail web compose if no mail app is available
        final webCompose = Uri.parse(
          'https://mail.google.com/mail/?view=cm&fs=1&to=test@example.com&su=Test%20Email%20from%20Flutter%20App&body=This%20is%20a%20test%20email%20sent%20from%20the%20Flutter%20Device%20Access%20app.',
        );
        final launchedWeb = await launchUrl(webCompose, mode: LaunchMode.inAppBrowserView);
        if (!launchedWeb) {
          _showSnackBar(messenger, 'Could not launch email app');
        }
      }
    } catch (e) {
      _showSnackBar(messenger, 'Error sending email: $e');
    }
  }

  static Future<void> makePhoneCall(BuildContext context) async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    try {
      await FlutterPhoneDirectCaller.callNumber('1234567890');
      _showSnackBar(messenger, 'Phone call initiated');
    } catch (e) {
      _showSnackBar(messenger, 'Error making phone call: $e');
    }
  }

  static Future<void> openWebsite(BuildContext context, {Uri? uri}) async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    try {
      final Uri url = uri ?? Uri.parse('https://flutter.dev');
      final bool launchedExternally = await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
      if (!launchedExternally) {
        final bool launchedInApp = await launchUrl(
          url,
          mode: LaunchMode.inAppBrowserView,
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
          ),
        );
        if (!launchedInApp) {
          _showSnackBar(messenger, 'Could not open website');
        }
      }
    } catch (e) {
      _showSnackBar(messenger, 'Error opening website: $e');
    }
  }

  static Future<void> makeHttpRequest(BuildContext context) async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _showSnackBar(messenger, 'HTTP Request successful: ${data['title']}');
      } else {
        _showSnackBar(messenger, 'HTTP Request failed: ${response.statusCode}');
      }
    } catch (e) {
      _showSnackBar(messenger, 'Error making HTTP request: $e');
    }
  }

  static Future<bool> isWakelockEnabled() async {
    try {
      return await WakelockPlus.enabled;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> setWakelockEnabled(bool enable) async {
    try {
      if (enable) {
        await WakelockPlus.enable();
      } else {
        await WakelockPlus.disable();
      }
      return await isWakelockEnabled();
    } catch (_) {
      return false;
    }
  }
}
