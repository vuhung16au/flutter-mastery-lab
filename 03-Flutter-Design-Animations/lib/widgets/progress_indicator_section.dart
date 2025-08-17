import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressIndicatorSection extends StatelessWidget {
  const ProgressIndicatorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Progress Indicator',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const LinearProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
