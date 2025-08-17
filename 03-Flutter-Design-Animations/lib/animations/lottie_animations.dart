import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimations extends StatefulWidget {
  const LottieAnimations({super.key});

  @override
  State<LottieAnimations> createState() => _LottieAnimationsState();
}

class _LottieAnimationsState extends State<LottieAnimations>
    with TickerProviderStateMixin {
  AnimationController? _controller1;
  AnimationController? _controller2;
  AnimationController? _controller3;
  AnimationController? _controller4;
  AnimationController? _controller5;
  AnimationController? _controller6;

  bool _isPlaying1 = false;
  bool _isPlaying2 = false;
  bool _isPlaying3 = false;
  bool _isPlaying4 = false;
  bool _isPlaying5 = false;
  bool _isPlaying6 = false;

  @override
  void initState() {
    super.initState();
    
    _controller1 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _controller2 = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    
    _controller3 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _controller4 = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    
    _controller5 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _controller6 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller1?.dispose();
    _controller2?.dispose();
    _controller3?.dispose();
    _controller4?.dispose();
    _controller5?.dispose();
    _controller6?.dispose();
    super.dispose();
  }

  void _toggleAnimation1() {
    setState(() {
      _isPlaying1 = !_isPlaying1;
    });
    
    if (_isPlaying1) {
      _controller1?.repeat();
    } else {
      _controller1?.stop();
    }
  }

  void _toggleAnimation2() {
    setState(() {
      _isPlaying2 = !_isPlaying2;
    });
    
    if (_isPlaying2) {
      _controller2?.repeat();
    } else {
      _controller2?.stop();
    }
  }

  void _toggleAnimation3() {
    setState(() {
      _isPlaying3 = !_isPlaying3;
    });
    
    if (_isPlaying3) {
      _controller3?.repeat();
    } else {
      _controller3?.stop();
    }
  }

  void _toggleAnimation4() {
    setState(() {
      _isPlaying4 = !_isPlaying4;
    });
    
    if (_isPlaying4) {
      _controller4?.repeat();
    } else {
      _controller4?.stop();
    }
  }

  void _toggleAnimation5() {
    setState(() {
      _isPlaying5 = !_isPlaying5;
    });
    
    if (_isPlaying5) {
      _controller5?.repeat();
    } else {
      _controller5?.stop();
    }
  }

  void _toggleAnimation6() {
    setState(() {
      _isPlaying6 = !_isPlaying6;
    });
    
    if (_isPlaying6) {
      _controller6?.repeat();
    } else {
      _controller6?.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lottie Animations'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Sample Lottie animations created for this project',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Loading Animation
            Container(
              height: 150,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Loading Spinner',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Center(
                      child: Lottie.asset(
                        'assets/animations/loading_spinner.json',
                        controller: _controller1,
                        onLoaded: (composition) {
                          _controller1?.duration = composition.duration;
                        },
                        width: 80,
                        height: 80,
                        fit: BoxFit.fill,
                        repeat: true,
                        animate: true,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _toggleAnimation1,
                    child: Text(_isPlaying1 ? 'Stop' : 'Play'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Success Animation
            Container(
              height: 150,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Success Check',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Center(
                      child: Lottie.asset(
                        'assets/animations/success_check.json',
                        controller: _controller2,
                        onLoaded: (composition) {
                          _controller2?.duration = composition.duration;
                        },
                        width: 80,
                        height: 80,
                        fit: BoxFit.fill,
                        repeat: true,
                        animate: true,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _toggleAnimation2,
                    child: Text(_isPlaying2 ? 'Stop' : 'Play'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Error Animation
            Container(
              height: 150,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Error X',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Center(
                      child: Lottie.asset(
                        'assets/animations/error_x.json',
                        controller: _controller3,
                        onLoaded: (composition) {
                          _controller3?.duration = composition.duration;
                        },
                        width: 80,
                        height: 80,
                        fit: BoxFit.fill,
                        repeat: true,
                        animate: true,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _toggleAnimation3,
                    child: Text(_isPlaying3 ? 'Stop' : 'Play'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Heart Beat Animation
            Container(
              height: 150,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.purple.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Heart Beat',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Center(
                      child: Lottie.asset(
                        'assets/animations/heart_beat.json',
                        controller: _controller4,
                        onLoaded: (composition) {
                          _controller4?.duration = composition.duration;
                        },
                        width: 80,
                        height: 80,
                        fit: BoxFit.fill,
                        repeat: true,
                        animate: true,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _toggleAnimation4,
                    child: Text(_isPlaying4 ? 'Stop' : 'Play'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Wave Loading Animation
            Container(
              height: 150,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Wave Loading',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Center(
                      child: Lottie.asset(
                        'assets/animations/wave_loading.json',
                        controller: _controller5,
                        onLoaded: (composition) {
                          _controller5?.duration = composition.duration;
                        },
                        width: 80,
                        height: 80,
                        fit: BoxFit.fill,
                        repeat: true,
                        animate: true,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _toggleAnimation5,
                    child: Text(_isPlaying5 ? 'Stop' : 'Play'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Pulse Dots Animation
            Container(
              height: 150,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.teal.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Pulse Dots',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Center(
                      child: Lottie.asset(
                        'assets/animations/pulse_dots.json',
                        controller: _controller6,
                        onLoaded: (composition) {
                          _controller6?.duration = composition.duration;
                        },
                        width: 80,
                        height: 80,
                        fit: BoxFit.fill,
                        repeat: true,
                        animate: true,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _toggleAnimation6,
                    child: Text(_isPlaying6 ? 'Stop' : 'Play'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Instructions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How to add Lottie animations:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '1. Download Lottie JSON files from lottiefiles.com\n'
                    '2. Place them in assets/animations/\n'
                    '3. Update the asset paths in this file\n'
                    '4. The animations will automatically load',
                    style: TextStyle(fontSize: 14),
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
