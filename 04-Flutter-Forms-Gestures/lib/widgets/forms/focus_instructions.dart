import 'package:flutter/material.dart';

class FocusInstructions extends StatelessWidget {
  const FocusInstructions({super.key});

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
              'Focus Management',
              'Use Tab key or the arrow button to navigate between fields',
              Icons.keyboard,
              Colors.blue,
            ),
            _buildInstruction(
              'Real-time Validation',
              'Watch validation status update as you type',
              Icons.check_circle,
              Colors.green,
            ),
            _buildInstruction(
              'Character Counting',
              'Notes field shows character count in real-time',
              Icons.text_fields,
              Colors.orange,
            ),
            _buildInstruction(
              'Field Changes',
              'Track which field was last modified',
              Icons.edit,
              Colors.purple,
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
