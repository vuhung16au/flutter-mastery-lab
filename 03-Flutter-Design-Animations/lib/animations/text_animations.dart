import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class TextAnimations extends StatefulWidget {
  const TextAnimations({super.key});

  @override
  State<TextAnimations> createState() => _TextAnimationsState();
}

class _TextAnimationsState extends State<TextAnimations> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Animations'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Typewriter Animation
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Typewriter Effect',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                                                 TypewriterAnimatedText(
                           'Hello World!',
                         ),
                         TypewriterAnimatedText(
                           'Flutter is amazing!',
                         ),
                         TypewriterAnimatedText(
                           'Animation is fun!',
                         ),
                      ],
                      totalRepeatCount: 4,
                      pause: const Duration(milliseconds: 1000),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Fade Animation
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Fade Animation',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        FadeAnimatedText(
                          'FADE IN',
                          duration: const Duration(milliseconds: 2000),
                          fadeOutBegin: 0.8,
                          fadeInEnd: 0.7,
                        ),
                        FadeAnimatedText(
                          'FADE OUT',
                          duration: const Duration(milliseconds: 2000),
                          fadeOutBegin: 0.8,
                          fadeInEnd: 0.7,
                        ),
                        FadeAnimatedText(
                          'SMOOTH',
                          duration: const Duration(milliseconds: 2000),
                          fadeOutBegin: 0.8,
                          fadeInEnd: 0.7,
                        ),
                      ],
                      totalRepeatCount: 4,
                      pause: const Duration(milliseconds: 1000),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Scale Animation
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Scale Animation',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        ScaleAnimatedText(
                          'SCALE UP',
                          scalingFactor: 0.3,
                          duration: const Duration(milliseconds: 1500),
                        ),
                        ScaleAnimatedText(
                          'SCALE DOWN',
                          scalingFactor: 0.3,
                          duration: const Duration(milliseconds: 1500),
                        ),
                        ScaleAnimatedText(
                          'BOUNCE',
                          scalingFactor: 0.3,
                          duration: const Duration(milliseconds: 1500),
                        ),
                      ],
                      totalRepeatCount: 4,
                      pause: const Duration(milliseconds: 1000),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Wavy Animation
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.purple.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Wavy Animation',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                                         child: AnimatedTextKit(
                       animatedTexts: [
                         WavyAnimatedText(
                           'WAVY TEXT',
                           textStyle: const TextStyle(
                             fontSize: 24,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                       ],
                       isRepeatingAnimation: true,
                     ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Rotate Animation
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Rotate Animation',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        RotateAnimatedText(
                          'ROTATE',
                          textStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          duration: const Duration(milliseconds: 2000),
                        ),
                        RotateAnimatedText(
                          'FLIP',
                          textStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          duration: const Duration(milliseconds: 2000),
                        ),
                        RotateAnimatedText(
                          'SPIN',
                          textStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          duration: const Duration(milliseconds: 2000),
                        ),
                      ],
                      totalRepeatCount: 4,
                      pause: const Duration(milliseconds: 1000),
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
