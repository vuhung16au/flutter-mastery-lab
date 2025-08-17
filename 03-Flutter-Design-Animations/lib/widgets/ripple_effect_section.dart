import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RippleEffectSection extends StatelessWidget {
  final AnimationController controller;

  const RippleEffectSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ripple Effect Animation',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: GestureDetector(
                onTapDown: (details) {
                  controller.forward(from: 0.0);
                },
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return Container(
                      width: 100 + (controller.value * 50),
                      height: 100 + (controller.value * 50),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primary.withValues(
                          alpha: 1.0 - controller.value,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.touch_app,
                          size: 40,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
