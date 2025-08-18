import 'package:flutter/material.dart';
import '../services/communication_service.dart';

class CommunicationPage extends StatelessWidget {
  const CommunicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.email, color: Colors.green),
                title: const Text('Send Email'),
                subtitle: const Text('Open email app to send a message'),
                onTap: () => _sendEmail(context),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.phone, color: Colors.blue),
                title: const Text('Make Call'),
                subtitle: const Text('Open phone app to make a call'),
                onTap: () => _makeCall(context),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.message, color: Colors.orange),
                title: const Text('Send SMS'),
                subtitle: const Text('Open SMS app to send a message'),
                onTap: () => _sendSMS(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendEmail(BuildContext context) async {
    try {
      await CommunicationService.sendEmail(
        to: 'test@example.com',
        subject: 'Hello from Flutter',
        body: 'This is a test email from the Flutter app.',
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email app opened')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _makeCall(BuildContext context) async {
    try {
      await CommunicationService.makeCall('1234567890');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Phone app opened')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _sendSMS(BuildContext context) async {
    try {
      await CommunicationService.sendSMS(
        phoneNumber: '1234567890',
        message: 'Hello from Flutter!',
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('SMS app opened')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
}
