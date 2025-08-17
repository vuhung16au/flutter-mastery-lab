import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HingeAnimationSection extends StatelessWidget {
  final AnimationController controller;

  const HingeAnimationSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hinge Animation',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Icon(Icons.door_front_door, size: 50),
            ),
          ],
        ),
      ),
    );
  }
}
