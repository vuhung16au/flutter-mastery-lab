import 'package:flutter/material.dart';

class StrategyCard extends StatelessWidget {
  final String title;
  final String description;
  final String example;
  final IconData icon;
  final Color color;
  final List<String> features;

  const StrategyCard({
    super.key,
    required this.title,
    required this.description,
    required this.example,
    required this.icon,
    required this.color,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(description),
                      Text(
                        example,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...features.map((feature) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: color, size: 16),
                  const SizedBox(width: 8),
                  Expanded(child: Text(feature)),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
