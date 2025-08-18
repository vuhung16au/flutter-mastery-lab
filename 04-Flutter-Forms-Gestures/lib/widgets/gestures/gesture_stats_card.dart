import 'package:flutter/material.dart';

class GestureStatsCard extends StatelessWidget {
  final String lastGesture;
  final int tapCount;
  final int doubleTapCount;
  final int longPressCount;
  final int dragCount;
  final int flickCount;
  final int pinchCount;
  final int spreadCount;
  final int panCount;
  final VoidCallback onReset;

  const GestureStatsCard({
    super.key,
    required this.lastGesture,
    required this.tapCount,
    required this.doubleTapCount,
    required this.longPressCount,
    required this.dragCount,
    required this.flickCount,
    required this.pinchCount,
    required this.spreadCount,
    required this.panCount,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gesture Status',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
              ),
              child: Text(
                lastGesture,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _CounterChip(label: 'Tap', count: tapCount, color: Colors.green),
                _CounterChip(label: 'Double Tap', count: doubleTapCount, color: Colors.purple),
                _CounterChip(label: 'Long Press', count: longPressCount, color: Colors.orange),
                _CounterChip(label: 'Drag', count: dragCount, color: Colors.blue),
                _CounterChip(label: 'Flick', count: flickCount, color: Colors.red),
                _CounterChip(label: 'Pinch', count: pinchCount, color: Colors.teal),
                _CounterChip(label: 'Spread', count: spreadCount, color: Colors.indigo),
                _CounterChip(label: 'Pan', count: panCount, color: Colors.amber),
              ],
            ),
            const SizedBox(height: 8),
            Center(
              child: OutlinedButton.icon(
                onPressed: onReset,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset Counters'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CounterChip extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _CounterChip({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}


