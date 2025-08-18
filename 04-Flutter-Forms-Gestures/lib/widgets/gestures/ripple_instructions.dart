import 'package:flutter/material.dart';

class RippleInstructions extends StatelessWidget {
  const RippleInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How to Use',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildInstruction(
              'Tap',
              'Single tap to trigger ripple effect and increment counter',
              Icons.touch_app,
              Colors.blue,
            ),
            _buildInstruction(
              'Double Tap',
              'Double tap to change color and trigger animation',
              Icons.touch_app,
              Colors.green,
            ),
            _buildInstruction(
              'Long Press',
              'Long press to change color and trigger animation',
              Icons.touch_app,
              Colors.orange,
            ),
            _buildInstruction(
              'Ripple Effects',
              'Watch ripple animations spread from touch points',
              Icons.radio_button_checked,
              Colors.purple,
            ),
            _buildInstruction(
              'Visual Feedback',
              'All gestures provide immediate visual feedback',
              Icons.visibility,
              Colors.teal,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstruction(String title, String description, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: color,
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
