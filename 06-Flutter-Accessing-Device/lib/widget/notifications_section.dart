import 'package:flutter/material.dart';

class NotificationsSection extends StatelessWidget {
  final VoidCallback onShowNow;
  final VoidCallback onSchedule;

  const NotificationsSection({
    super.key,
    required this.onShowNow,
    required this.onSchedule,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onShowNow,
            icon: const Icon(Icons.notifications),
            label: const Text('Show Now'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onSchedule,
            icon: const Icon(Icons.schedule),
            label: const Text('Schedule'),
          ),
        ),
      ],
    );
  }
}
