import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFontsSection extends StatelessWidget {
  const CustomFontsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Google Fonts Examples',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This is using Poppins font',
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            Text(
              'This is using Roboto font',
              style: GoogleFonts.roboto(fontSize: 14),
            ),
            Text(
              'This is using Open Sans font',
              style: GoogleFonts.openSans(fontSize: 14),
            ),
            Text(
              'This is using Lato font',
              style: GoogleFonts.lato(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
