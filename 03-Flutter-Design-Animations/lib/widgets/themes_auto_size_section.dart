import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ThemesAutoSizeSection extends StatelessWidget {
  const ThemesAutoSizeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Auto Size Text Example',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 200,
              height: 60,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: AutoSizeText(
                  'This text will automatically resize to fit the container!',
                  style: GoogleFonts.poppins(fontSize: 16),
                  maxLines: 2,
                  minFontSize: 8,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Theme Colors',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                _buildColorChip('Primary', Theme.of(context).colorScheme.primary),
                _buildColorChip('Secondary', Theme.of(context).colorScheme.secondary),
                _buildColorChip('Tertiary', Theme.of(context).colorScheme.tertiary),
                _buildColorChip('Surface', Theme.of(context).colorScheme.surface),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorChip(String label, Color color) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
        ),
      ),
      backgroundColor: color,
    );
  }
}
