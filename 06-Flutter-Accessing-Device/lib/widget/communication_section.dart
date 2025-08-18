import 'package:flutter/material.dart';

class CommunicationSection extends StatelessWidget {
  final VoidCallback onEmail;
  final VoidCallback onCall;
  final VoidCallback onOpenWebsite;

  const CommunicationSection({
    super.key,
    required this.onEmail,
    required this.onCall,
    required this.onOpenWebsite,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onEmail,
                icon: const Icon(Icons.email),
                label: const Text('Email'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onCall,
                icon: const Icon(Icons.phone),
                label: const Text('Call'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: onOpenWebsite,
          icon: const Icon(Icons.language),
          label: const Text('Open Website'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
          ),
        ),
      ],
    );
  }
}
