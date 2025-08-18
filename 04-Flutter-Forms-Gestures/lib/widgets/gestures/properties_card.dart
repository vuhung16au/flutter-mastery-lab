import 'package:flutter/material.dart';

class PropertiesCard extends StatelessWidget {
  final double scale;
  final double rotationDeg;
  final Offset position;
  final Color color;
  final double? lastFlickVelocity;

  const PropertiesCard({
    super.key,
    required this.scale,
    required this.rotationDeg,
    required this.position,
    required this.color,
    this.lastFlickVelocity,
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
              'Current Properties',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _row('Scale', '${scale.toStringAsFixed(2)}x'),
            _row('Rotation', '${rotationDeg.toStringAsFixed(0)}°'),
            _row('Position', '(${position.dx.toStringAsFixed(1)}, ${position.dy.toStringAsFixed(1)})'),
            _row('Color', '#${color.toARGB32().toRadixString(16).toUpperCase().substring(2)}'),
            if (lastFlickVelocity != null)
              _row('Last Flick Velocity', '${lastFlickVelocity!.toStringAsFixed(0)} px/s'),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}


