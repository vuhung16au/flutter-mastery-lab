import 'package:flutter/material.dart';

class DragStatusDisplay extends StatelessWidget {
  final bool isDragging;
  final int dragCount;
  final String lastDragStatus;

  const DragStatusDisplay({
    super.key,
    required this.isDragging,
    required this.dragCount,
    required this.lastDragStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header Card
        Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Drag Demo',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Demonstrating drag functionality including Draggable widgets and drop zones.',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.drag_handle, color: Colors.blue, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      'Drag Count: $dragCount',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Drag Status
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDragging ? Colors.blue.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isDragging ? Colors.blue.withValues(alpha: 0.3) : Colors.grey.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              Icon(
                isDragging ? Icons.drag_handle : Icons.info_outline,
                color: isDragging ? Colors.blue : Colors.grey,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  lastDragStatus,
                  style: TextStyle(
                    color: isDragging ? Colors.blue : Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
