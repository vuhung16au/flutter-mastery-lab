import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationExamples extends StatelessWidget {
  const AnimationExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lottie Animation Examples'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sample Lottie Animations',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // Loading Spinner
            _buildAnimationCard(
              'Loading Spinner',
              'assets/animations/loading_spinner.json',
              'A simple rotating circle loading animation',
            ),
            
            // Success Check
            _buildAnimationCard(
              'Success Check',
              'assets/animations/success_check.json',
              'A green checkmark for success states',
            ),
            
            // Error X
            _buildAnimationCard(
              'Error X',
              'assets/animations/error_x.json',
              'A red X mark for error states',
            ),
            
            // Heart Beat
            _buildAnimationCard(
              'Heart Beat',
              'assets/animations/heart_beat.json',
              'A pulsing heart animation',
            ),
            
            // Wave Loading
            _buildAnimationCard(
              'Wave Loading',
              'assets/animations/wave_loading.json',
              'A wave-like loading animation',
            ),
            
            // Pulse Dots
            _buildAnimationCard(
              'Pulse Dots',
              'assets/animations/pulse_dots.json',
              'Three dots that pulse in sequence',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimationCard(String title, String assetPath, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Center(
              child: Lottie.asset(
                assetPath,
                width: 100,
                height: 100,
                repeat: true,
                animate: true,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Asset Path: $assetPath',
              style: const TextStyle(fontSize: 12, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

// Usage in your app:
// Navigator.push(
//   context,
//   MaterialPageRoute(builder: (context) => const AnimationExamples()),
// );
