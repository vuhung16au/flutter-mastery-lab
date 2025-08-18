import 'package:flutter/material.dart';

class SendDataPage extends StatelessWidget {
  const SendDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Data to Screen'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Send Data Demo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DataReceiverPage(
                      userData: UserData(
                        name: 'Alice Johnson',
                        email: 'alice@example.com',
                        age: 30,
                        isActive: true,
                      ),
                    ),
                  ),
                );
              },
              child: const Text('Send User Data'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DataReceiverPage(
                      userData: UserData(
                        name: 'Bob Smith',
                        email: 'bob@example.com',
                        age: 25,
                        isActive: false,
                      ),
                    ),
                  ),
                );
              },
              child: const Text('Send Another User Data'),
            ),
          ],
        ),
      ),
    );
  }
}

class UserData {
  final String name;
  final String email;
  final int age;
  final bool isActive;

  const UserData({
    required this.name,
    required this.email,
    required this.age,
    required this.isActive,
  });
}

class DataReceiverPage extends StatelessWidget {
  final UserData userData;

  const DataReceiverPage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Receiver'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Received User Data:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('Name: ${userData.name}', style: const TextStyle(fontSize: 18)),
                    Text('Email: ${userData.email}', style: const TextStyle(fontSize: 18)),
                    Text('Age: ${userData.age}', style: const TextStyle(fontSize: 18)),
                    Text(
                      'Status: ${userData.isActive ? "Active" : "Inactive"}',
                      style: TextStyle(
                        fontSize: 18,
                        color: userData.isActive ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
