import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StaggeredGridViewDemo extends StatelessWidget {
  const StaggeredGridViewDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {'title': 'Item 1', 'height': 100, 'color': Colors.red},
      {'title': 'Item 2', 'height': 150, 'color': Colors.green},
      {'title': 'Item 3', 'height': 120, 'color': Colors.blue},
      {'title': 'Item 4', 'height': 200, 'color': Colors.orange},
      {'title': 'Item 5', 'height': 80, 'color': Colors.purple},
      {'title': 'Item 6', 'height': 180, 'color': Colors.teal},
      {'title': 'Item 7', 'height': 110, 'color': Colors.pink},
      {'title': 'Item 8', 'height': 160, 'color': Colors.indigo},
      {'title': 'Item 9', 'height': 90, 'color': Colors.amber},
      {'title': 'Item 10', 'height': 140, 'color': Colors.cyan},
      {'title': 'Item 11', 'height': 170, 'color': Colors.lime},
      {'title': 'Item 12', 'height': 130, 'color': Colors.brown},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Staggered Grid View Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Container(
              height: item['height'].toDouble(),
              decoration: BoxDecoration(
                color: item['color'],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Height: ${item['height']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
