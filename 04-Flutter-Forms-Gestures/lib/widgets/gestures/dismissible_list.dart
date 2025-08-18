import 'package:flutter/material.dart';

class DismissibleList extends StatelessWidget {
  final List<String> items;
  final List<String> deletedItems;
  final Function(int) onDismissed;
  final Function(int, String) onUndo;
  final Function(String) onConfirmDismiss;

  const DismissibleList({
    super.key,
    required this.items,
    required this.deletedItems,
    required this.onDismissed,
    required this.onUndo,
    required this.onConfirmDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: items.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => _buildDismissibleItem(context, index),
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 64,
            color: Colors.green.withValues(alpha: 0.6),
          ),
          const SizedBox(height: 16),
          Text(
            'All items dismissed!',
            style: TextStyle(
              fontSize: 18,
              color: Colors.green.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {
              // This will be handled by the parent widget
            },
            icon: const Icon(Icons.restore),
            label: const Text('Restore Items'),
          ),
        ],
      ),
    );
  }

  Widget _buildDismissibleItem(BuildContext context, int index) {
    final item = items[index];
    return Dismissible(
      key: Key(item),
      onDismissed: (direction) => onDismissed(index),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      secondaryBackground: Container(
        color: Colors.green,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (direction) async {
        if (item.contains('5') || item.contains('10') || item.contains('15')) {
          return await onConfirmDismiss(item);
        }
        return true;
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _getItemColor(item),
            child: Text(
              item.split(' ').last,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            item,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: const Text('Swipe to dismiss this item'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.swipe_left,
                color: Colors.grey.withValues(alpha: 0.6),
                size: 20,
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.swipe_right,
                color: Colors.grey.withValues(alpha: 0.6),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getItemColor(String item) {
    final number = int.tryParse(item.split(' ').last) ?? 0;
    final colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
      Colors.amber,
      Colors.cyan,
    ];
    return colors[number % colors.length];
  }
}
