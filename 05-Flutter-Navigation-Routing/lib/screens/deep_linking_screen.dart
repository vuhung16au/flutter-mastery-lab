import 'package:flutter/material.dart';

class DeepLinkingScreen extends StatelessWidget {
  const DeepLinkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deep Linking'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Deep Linking Examples',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Deep linking allows your app to handle URLs and navigate to specific content. '
              'This is useful for sharing links, app-to-app navigation, and web integration.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            _buildDeepLinkCard(
              context,
              'Product Details',
              'Navigate to a specific product',
              'myapp://product/123',
              Icons.shopping_cart,
            ),
            _buildDeepLinkCard(
              context,
              'User Profile',
              'Navigate to a user profile',
              'myapp://user/john_doe',
              Icons.person,
            ),
            _buildDeepLinkCard(
              context,
              'Settings',
              'Navigate to app settings',
              'myapp://settings',
              Icons.settings,
            ),
            const SizedBox(height: 20),
            const Text(
              'URL Structure Examples:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• myapp://product/{id}'),
                  Text('• myapp://user/{username}'),
                  Text('• myapp://category/{category}'),
                  Text('• myapp://search?query={term}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeepLinkCard(
    BuildContext context,
    String title,
    String description,
    String url,
    IconData icon,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            const SizedBox(height: 4),
            Text(
              url,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.link),
        onTap: () {
          // In a real app, this would trigger the deep link
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Deep link triggered: $url'),
              duration: const Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }
}
