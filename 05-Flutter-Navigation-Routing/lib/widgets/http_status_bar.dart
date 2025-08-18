import 'package:flutter/material.dart';

class HttpStatusBar extends StatelessWidget {
  final String status;
  final bool isLoading;
  final VoidCallback onFetch;
  final VoidCallback onCreate;

  const HttpStatusBar({
    super.key,
    required this.status,
    required this.isLoading,
    required this.onFetch,
    required this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.blue.shade50,
      child: Column(
        children: [
          Text(
            'Status: $status',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: isLoading ? null : onFetch,
                child: const Text('Fetch'),
              ),
              ElevatedButton(
                onPressed: onCreate,
                child: const Text('Create'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
