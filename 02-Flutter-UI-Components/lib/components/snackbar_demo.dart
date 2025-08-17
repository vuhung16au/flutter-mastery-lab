import 'package:flutter/material.dart';

class SnackbarDemo extends StatelessWidget {
  const SnackbarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbar Demo'),
      ),
      body: const Center(
        child: Text('Snackbar Demo'),
      ),
    );
  }
}
