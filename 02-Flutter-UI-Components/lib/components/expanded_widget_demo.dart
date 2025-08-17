import 'package:flutter/material.dart';

class ExpandedWidgetDemo extends StatelessWidget {
  const ExpandedWidgetDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expanded Widget Demo'),
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.red,
              child: const Center(child: Text('Expanded')),
            ),
          ),
          Container(
            width: 100,
            color: Colors.blue,
            child: const Center(child: Text('Fixed')),
          ),
        ],
      ),
    );
  }
}
