import 'package:flutter/material.dart';

class DismissibleHeader extends StatelessWidget {
  final int itemsCount;
  final int deletedItemsCount;

  const DismissibleHeader({
    super.key,
    required this.itemsCount,
    required this.deletedItemsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Swipe to Dismiss Demo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Swipe items left or right to dismiss them. This demonstrates the Dismissible widget from Flutter documentation.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue, size: 16),
                const SizedBox(width: 8),
                Text(
                  '$itemsCount items remaining',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                if (deletedItemsCount > 0)
                  Text(
                    '$deletedItemsCount items deleted',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
