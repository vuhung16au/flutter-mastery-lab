import 'package:flutter/material.dart';
import 'package:flutter_forms_gestures/models/drag_models.dart';

class DraggableItems extends StatelessWidget {
  final List<DraggableItem> draggableItems;
  final Function(String) onDragStarted;
  final Function(String) onDragEnd;

  const DraggableItems({
    super.key,
    required this.draggableItems,
    required this.onDragStarted,
    required this.onDragEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Draggable Items',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: draggableItems.map((item) => _buildDraggableItem(item)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableItem(DraggableItem item) {
    return Draggable<String>(
      data: item.id,
      feedback: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: item.color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            item.icon,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
      childWhenDragging: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: item.color.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: item.color.withValues(alpha: 0.5), style: BorderStyle.solid),
        ),
        child: Icon(
          item.icon,
          color: item.color.withValues(alpha: 0.5),
          size: 32,
        ),
      ),
      onDragStarted: () => onDragStarted(item.id),
      onDragEnd: (details) => onDragEnd(item.id),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: item.color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              item.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
