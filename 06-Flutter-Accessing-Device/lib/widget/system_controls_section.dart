import 'package:flutter/material.dart';

class SystemControlsSection extends StatelessWidget {
  final bool isPortraitOnly;
  final bool isWakelockEnabled;
  final VoidCallback onToggleOrientation;
  final VoidCallback onToggleWakelock;

  const SystemControlsSection({
    super.key,
    required this.isPortraitOnly,
    required this.isWakelockEnabled,
    required this.onToggleOrientation,
    required this.onToggleWakelock,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onToggleOrientation,
            icon: Icon(
              isPortraitOnly
                  ? Icons.screen_lock_portrait
                  : Icons.screen_lock_rotation,
            ),
            label: Text(isPortraitOnly ? 'Portrait Only' : 'All Orientations'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onToggleWakelock,
            icon: Icon(
              isWakelockEnabled ? Icons.wb_sunny : Icons.nightlight_round,
            ),
            label: Text(isWakelockEnabled ? 'Wakelock On' : 'Wakelock Off'),
          ),
        ),
      ],
    );
  }
}
