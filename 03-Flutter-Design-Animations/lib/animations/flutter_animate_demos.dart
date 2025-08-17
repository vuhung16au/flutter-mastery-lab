import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FlutterAnimateDemos extends StatefulWidget {
  const FlutterAnimateDemos({super.key});

  @override
  State<FlutterAnimateDemos> createState() => _FlutterAnimateDemosState();
}

class _FlutterAnimateDemosState extends State<FlutterAnimateDemos> {
  bool _showAnimations = false;

  @override
  void initState() {
    super.initState();
    // Start animations after a short delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _showAnimations = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Animate Demos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Fade In Animation
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
                    'Fade In Animation',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 50,
                    ),
                  )
                      .animate(
                        onPlay: (controller) => controller.repeat(),
                      )
                      .fadeIn(
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeInOut,
                      )
                      .then()
                      .fadeOut(
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeInOut,
                      ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Slide Animation
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
                    'Slide Animation',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 50,
                    ),
                  )
                      .animate(
                        onPlay: (controller) => controller.repeat(),
                      )
                      .slideX(
                        begin: -1,
                        end: 1,
                        duration: const Duration(milliseconds: 2000),
                        curve: Curves.easeInOut,
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
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.flash_on,
                      color: Colors.white,
                      size: 50,
                    ),
                  )
                      .animate(
                        onPlay: (controller) => controller.repeat(),
                      )
                      .scale(
                        begin: const Offset(0.5, 0.5),
                        end: const Offset(1.2, 1.2),
                        duration: const Duration(milliseconds: 1500),
                        curve: Curves.elasticOut,
                      )
                      .then()
                      .scale(
                        begin: const Offset(1.2, 1.2),
                        end: const Offset(0.5, 0.5),
                        duration: const Duration(milliseconds: 1500),
                        curve: Curves.elasticIn,
                      ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Rotate Animation
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
                    'Rotate Animation',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 50,
                    ),
                  )
                      .animate(
                        onPlay: (controller) => controller.repeat(),
                      )
                      .rotate(
                        begin: 0,
                        end: 1,
                        duration: const Duration(milliseconds: 3000),
                        curve: Curves.linear,
                      ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Staggered List Animation
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.teal.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Staggered List Animation',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i < 3; i++)
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            [Icons.favorite, Icons.star, Icons.flash_on][i],
                            color: Colors.white,
                            size: 30,
                          ),
                        )
                            .animate(
                              delay: Duration(milliseconds: i * 200),
                            )
                            .fadeIn(
                              duration: const Duration(milliseconds: 500),
                            )
                            .slideY(
                              begin: 0.3,
                              end: 0,
                              duration: const Duration(milliseconds: 500),
                            ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Conditional Animation
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
                    'Conditional Animation',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.warning,
                      color: Colors.white,
                      size: 50,
                    ),
                  )
                      .animate(
                        target: _showAnimations ? 1 : 0,
                      )
                      .fadeIn(
                        duration: const Duration(milliseconds: 1000),
                      )
                      .scale(
                        begin: const Offset(0, 0),
                        end: const Offset(1, 1),
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.elasticOut,
                      ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Complex Animation Chain
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.indigo.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.indigo.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Complex Animation Chain',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      color: Colors.white,
                      size: 50,
                    ),
                  )
                      .animate(
                        onPlay: (controller) => controller.repeat(),
                      )
                      .fadeIn(
                        duration: const Duration(milliseconds: 500),
                      )
                      .scale(
                        begin: const Offset(0.5, 0.5),
                        end: const Offset(1, 1),
                        duration: const Duration(milliseconds: 500),
                      )
                      .then(delay: const Duration(milliseconds: 500))
                      .rotate(
                        begin: 0,
                        end: 0.5,
                        duration: const Duration(milliseconds: 1000),
                      )
                      .then(delay: const Duration(milliseconds: 500))
                      .shimmer(
                        duration: const Duration(milliseconds: 1000),
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
