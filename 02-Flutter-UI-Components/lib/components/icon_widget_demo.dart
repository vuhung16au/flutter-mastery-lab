import 'package:flutter/material.dart';

class IconWidgetDemo extends StatelessWidget {
  const IconWidgetDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Icon Widget Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Basic Icons',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(Icons.home),
                Icon(Icons.favorite),
                Icon(Icons.star),
                Icon(Icons.settings),
                Icon(Icons.person),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Different Sizes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(Icons.favorite, size: 16),
                Icon(Icons.favorite, size: 24),
                Icon(Icons.favorite, size: 32),
                Icon(Icons.favorite, size: 48),
                Icon(Icons.favorite, size: 64),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Colored Icons',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(Icons.favorite, color: Colors.red),
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.thumb_up, color: Colors.green),
                Icon(Icons.info, color: Colors.blue),
                Icon(Icons.warning, color: Colors.orange),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Icon with Text',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Icon(Icons.email, color: Colors.blue),
                SizedBox(width: 8),
                Text('Send Email'),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.phone, color: Colors.green),
                SizedBox(width: 8),
                Text('Call Now'),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.location_on, color: Colors.red),
                SizedBox(width: 8),
                Text('Get Directions'),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Icon Buttons',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Like pressed!')),
                    );
                  },
                  icon: const Icon(Icons.favorite_border),
                  tooltip: 'Like',
                ),
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Share pressed!')),
                    );
                  },
                  icon: const Icon(Icons.share),
                  tooltip: 'Share',
                ),
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('More options pressed!')),
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                  tooltip: 'More options',
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Custom Icon Container',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 32),
                  SizedBox(width: 8),
                  Text(
                    'Success!',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
