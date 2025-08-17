import 'package:flutter/material.dart';
import 'dart:math' as math;

class PhysicsAnimations extends StatefulWidget {
  const PhysicsAnimations({super.key});

  @override
  State<PhysicsAnimations> createState() => _PhysicsAnimationsState();
}

class _PhysicsAnimationsState extends State<PhysicsAnimations>
    with TickerProviderStateMixin {
  late AnimationController _springController;
  late AnimationController _bounceController;
  late AnimationController _gravityController;
  late AnimationController _pendulumController;

  late Animation<double> _springAnimation;
  late Animation<double> _bounceAnimation;
  late Animation<double> _gravityAnimation;
  late Animation<double> _pendulumAnimation;

  bool _isSpringAnimating = false;
  bool _isBounceAnimating = false;
  bool _isGravityAnimating = false;
  bool _isPendulumAnimating = false;

  @override
  void initState() {
    super.initState();

    // Spring Animation
    _springController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _springAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _springController,
      curve: Curves.elasticOut,
    ));

    // Bounce Animation
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _bounceAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.bounceOut,
    ));

    // Gravity Animation
    _gravityController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _gravityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _gravityController,
      curve: Curves.easeIn,
    ));

    // Pendulum Animation
    _pendulumController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );
    _pendulumAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _pendulumController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _springController.dispose();
    _bounceController.dispose();
    _gravityController.dispose();
    _pendulumController.dispose();
    super.dispose();
  }

  void _startSpringAnimation() {
    setState(() {
      _isSpringAnimating = true;
    });
    _springController.forward().then((_) {
      setState(() {
        _isSpringAnimating = false;
      });
    });
  }

  void _startBounceAnimation() {
    setState(() {
      _isBounceAnimating = true;
    });
    _bounceController.forward().then((_) {
      setState(() {
        _isBounceAnimating = false;
      });
    });
  }

  void _startGravityAnimation() {
    setState(() {
      _isGravityAnimating = true;
    });
    _gravityController.forward().then((_) {
      setState(() {
        _isGravityAnimating = false;
      });
    });
  }

  void _startPendulumAnimation() {
    setState(() {
      _isPendulumAnimating = true;
    });
    _pendulumController.repeat();
  }

  void _stopPendulumAnimation() {
    setState(() {
      _isPendulumAnimating = false;
    });
    _pendulumController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Physics Animations'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Spring Animation
            Container(
              height: 120,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Spring Animation',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: AnimatedBuilder(
                      animation: _springAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: 0.5 + (_springAnimation.value * 0.5),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30),
                            ),
                                                         child: const Icon(
                               Icons.auto_awesome,
                               color: Colors.white,
                               size: 30,
                             ),
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _isSpringAnimating ? null : _startSpringAnimation,
                    child: const Text('Start Spring'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Bounce Animation
            Container(
              height: 120,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Bounce Animation',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: AnimatedBuilder(
                      animation: _bounceAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, -50 * _bounceAnimation.value),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Icon(
                              Icons.sports_basketball,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _isBounceAnimating ? null : _startBounceAnimation,
                    child: const Text('Start Bounce'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Gravity Animation
            Container(
              height: 120,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Gravity Animation',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: AnimatedBuilder(
                      animation: _gravityAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, 50 * _gravityAnimation.value),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _isGravityAnimating ? null : _startGravityAnimation,
                    child: const Text('Start Gravity'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Pendulum Animation
            Container(
              height: 120,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.purple.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Pendulum Animation',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: AnimatedBuilder(
                      animation: _pendulumAnimation,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: math.sin(_pendulumAnimation.value * 2 * math.pi) * 0.5,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Icon(
                              Icons.schedule,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _isPendulumAnimating ? null : _startPendulumAnimation,
                        child: const Text('Start'),
                      ),
                      ElevatedButton(
                        onPressed: _isPendulumAnimating ? _stopPendulumAnimation : null,
                        child: const Text('Stop'),
                      ),
                    ],
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
