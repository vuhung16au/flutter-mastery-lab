import 'package:flutter/material.dart';

class ProgressIndicatorsDemo extends StatefulWidget {
  const ProgressIndicatorsDemo({super.key});

  @override
  State<ProgressIndicatorsDemo> createState() => _ProgressIndicatorsDemoState();
}

class _ProgressIndicatorsDemoState extends State<ProgressIndicatorsDemo>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  double _linearProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    
    // Simulate progress
    _startProgress();
  }

  void _startProgress() async {
    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        _linearProgress = i / 100;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Indicators Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Linear Progress Indicators',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('Determinate Progress:'),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: _linearProgress),
            const SizedBox(height: 16),
            const Text('Indeterminate Progress:'),
            const SizedBox(height: 8),
            const LinearProgressIndicator(),
            const SizedBox(height: 20),
            const Text(
              'Circular Progress Indicators',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text('Determinate:'),
                    const SizedBox(height: 8),
                    CircularProgressIndicator(value: _linearProgress),
                  ],
                ),
                Column(
                  children: [
                    const Text('Indeterminate:'),
                    const SizedBox(height: 8),
                    const CircularProgressIndicator(),
                  ],
                ),
                Column(
                  children: [
                    const Text('Animated:'),
                    const SizedBox(height: 8),
                    RotationTransition(
                      turns: _animationController,
                      child: const CircularProgressIndicator(),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Custom Styled Progress',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: _linearProgress,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.purple),
              minHeight: 10,
            ),
            const SizedBox(height: 16),
            CircularProgressIndicator(
              value: _linearProgress,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
              strokeWidth: 8,
            ),
            const SizedBox(height: 20),
            const Text(
              'Progress with Labels',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Download Progress:'),
                    Text('${(_linearProgress * 100).toInt()}%'),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(value: _linearProgress),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Upload Progress:'),
                    Text('${(_linearProgress * 100).toInt()}%'),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: _linearProgress,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Custom Progress Container',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                children: [
                  const Text(
                    'Processing Files...',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: _linearProgress,
                    backgroundColor: Colors.blue.shade200,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  const SizedBox(height: 8),
                  Text('${(_linearProgress * 100).toInt()}% Complete'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
