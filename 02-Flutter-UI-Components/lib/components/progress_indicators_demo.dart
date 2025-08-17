import 'package:flutter/material.dart';

class ProgressIndicatorsDemo extends StatelessWidget {
  const ProgressIndicatorsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Indicators Demo'),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
