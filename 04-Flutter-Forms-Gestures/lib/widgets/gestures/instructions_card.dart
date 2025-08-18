import 'package:flutter/material.dart';

class InstructionsCard extends StatelessWidget {
  final List<Instruction> items;
  final String title;

  const InstructionsCard({
    super.key,
    required this.items,
    this.title = 'Available Gestures (from TutorialsPoint & Flutter Docs)',
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
            const SizedBox(height: 12),
            for (final it in items)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Icon(it.icon, color: Colors.blue, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            it.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            it.description,
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
              ),
          ],
        ),
      ),
    );
  }
}

class Instruction {
  final String title;
  final String description;
  final IconData icon;

  const Instruction(this.title, this.description, this.icon);
}

List<Instruction> buildGestureInstructions() => const [
  Instruction('Tap', 'Touching the surface with fingertip for a short period', Icons.touch_app),
  Instruction('Double Tap', 'Tapping twice in a short time', Icons.touch_app),
  Instruction('Drag', 'Touching and moving fingertip in a steady manner', Icons.drag_handle),
  Instruction('Flick', 'Similar to dragging, but in a speeder way', Icons.flash_on),
  Instruction('Pinch', 'Pinching the surface using two fingers', Icons.zoom_out),
  Instruction('Spread/Zoom', 'Opposite of pinching', Icons.zoom_in),
  Instruction('Panning', 'Touching and moving in any direction without releasing', Icons.pan_tool),
  Instruction('Long Press', 'Press and hold for extended period', Icons.timer),
  Instruction('Material Ripples', 'Visual feedback using InkWell', Icons.waves),
];


