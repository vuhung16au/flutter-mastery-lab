import 'package:flutter/material.dart';

class RouteSettingsPage extends StatelessWidget {
  const RouteSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Settings'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Route Settings Demo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RouteSettingsDetailPage(),
                    settings: RouteSettings(
                      name: '/route-settings-detail',
                      arguments: {
                        'title': 'Detail Page',
                        'message': 'This page was navigated using RouteSettings',
                        'timestamp': DateTime.now().toIso8601String(),
                      },
                    ),
                  ),
                );
              },
              child: const Text('Navigate with Route Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class RouteSettingsDetailPage extends StatelessWidget {
  const RouteSettingsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
        title: Text(args?['title'] ?? 'Detail Page'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Route Settings Arguments:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (args != null) ...[
              Text('Title: ${args['title']}', style: const TextStyle(fontSize: 18)),
              Text('Message: ${args['message']}', style: const TextStyle(fontSize: 18)),
              Text('Timestamp: ${args['timestamp']}', style: const TextStyle(fontSize: 18)),
            ] else ...[
              const Text('No arguments provided', style: TextStyle(fontSize: 18)),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
