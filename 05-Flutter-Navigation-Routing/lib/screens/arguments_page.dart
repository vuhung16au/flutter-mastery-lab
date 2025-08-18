import 'package:flutter/material.dart';

class ArgumentsPage extends StatelessWidget {
  const ArgumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arguments in Named Routes'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Arguments Demo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ArgumentsDetailPage(
                      name: 'John Doe',
                      age: 25,
                      email: 'john@example.com',
                    ),
                  ),
                );
              },
              child: const Text('Pass Arguments to Detail Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class ArgumentsDetailPage extends StatelessWidget {
  final String name;
  final int age;
  final String email;

  const ArgumentsDetailPage({
    super.key,
    required this.name,
    required this.age,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arguments Detail'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Received Arguments:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text('Name: $name', style: const TextStyle(fontSize: 18)),
            Text('Age: $age', style: const TextStyle(fontSize: 18)),
            Text('Email: $email', style: const TextStyle(fontSize: 18)),
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
