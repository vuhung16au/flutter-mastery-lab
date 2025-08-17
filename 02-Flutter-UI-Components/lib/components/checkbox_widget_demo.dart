import 'package:flutter/material.dart';

class CheckboxWidgetDemo extends StatelessWidget {
  const CheckboxWidgetDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkbox Widget Demo'),
      ),
      body: const Center(
        child: Checkbox(
          value: true,
          onChanged: null,
        ),
      ),
    );
  }
}
