import 'package:flutter/material.dart';

class FeaturesSummary extends StatelessWidget {
  const FeaturesSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Implemented Features',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _FeatureItem('✅ All TutorialsPoint gestures', 'Tap, Double Tap, Drag, Flick, Pinch, Spread, Panning'),
            _FeatureItem('✅ Material Design ripples', 'InkWell for proper touch feedback'),
            _FeatureItem('✅ Swipe to dismiss', 'Dismissible widget with confirmation'),
            _FeatureItem('✅ Drag and drop', 'Draggable widgets with drop zones'),
            _FeatureItem('✅ Form validation', 'Real-time validation with error handling'),
            _FeatureItem('✅ Visual feedback', 'Snackbars, animations, and status updates'),
          ],
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String title;
  final String description;

  const _FeatureItem(this.title, this.description);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
