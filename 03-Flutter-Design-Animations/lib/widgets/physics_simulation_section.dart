import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PhysicsSimulationSection extends StatelessWidget {
  final AnimationController controller;

  const PhysicsSimulationSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Physics Simulation',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Icon(Icons.science, size: 50),
            ),
          ],
        ),
      ),
    );
  }
}
