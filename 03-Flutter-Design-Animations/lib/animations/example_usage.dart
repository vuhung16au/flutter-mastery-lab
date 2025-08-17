import 'package:flutter/material.dart';
import 'animation_gallery.dart';

/// Example of how to integrate the Animation Gallery into your main app
class AnimationGalleryExample extends StatelessWidget {
  const AnimationGalleryExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Gallery Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.auto_awesome,
              size: 80,
              color: Colors.blue,
            ),
            const SizedBox(height: 24),
            const Text(
              'Flutter Animation Gallery',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Explore various animation techniques and effects',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AnimationGallery(),
                  ),
                );
              },
              icon: const Icon(Icons.animation),
              label: const Text('Open Animation Gallery'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () {
                // You can also navigate directly to specific animations
                // For example:
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const BasicAnimations(),
                //   ),
                // );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Check the code for direct navigation examples'),
                  ),
                );
              },
              icon: const Icon(Icons.code),
              label: const Text('View Code Examples'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Example of how to add animation gallery to your app's navigation
class AppWithAnimationGallery extends StatelessWidget {
  const AppWithAnimationGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animation Gallery',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const AnimationGalleryExample(),
    );
  }
}
