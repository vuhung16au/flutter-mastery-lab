import 'package:flutter/material.dart';

class IconWidgetDemo extends StatelessWidget {
  const IconWidgetDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Icon Widget Demo'),
      ),
      body: const Center(
        child: Icon(
          Icons.star,
          size: 100,
          color: Colors.amber,
        ),
      ),
    );
  }
}
