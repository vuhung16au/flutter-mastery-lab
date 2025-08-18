import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class ApiPostListWidget extends StatelessWidget {
  const ApiPostListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Error: ${provider.error}',
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => provider.loadApiPosts(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: provider.apiPosts.length,
          itemBuilder: (context, index) {
            final post = provider.apiPosts[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text(post['title'] ?? ''),
                subtitle: Text(post['body'] ?? ''),
                trailing: Text('ID: ${post['id']}'),
              ),
            );
          },
        );
      },
    );
  }
}
