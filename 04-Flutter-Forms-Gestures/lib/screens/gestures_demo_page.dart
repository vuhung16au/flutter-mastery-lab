import 'package:flutter/material.dart';

class GesturesDemoPage extends StatelessWidget {
  const GesturesDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestures Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Text('Gestures Demo'),
      ),
    );
  }
}
