import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableDemo extends StatefulWidget {
  const SlidableDemo({super.key});

  @override
  State<SlidableDemo> createState() => _SlidableDemoState();
}

class _SlidableDemoState extends State<SlidableDemo> {
  final List<Map<String, dynamic>> _items = [
    {'title': 'Email from John', 'subtitle': 'Meeting tomorrow at 10 AM', 'color': Colors.blue},
    {'title': 'Shopping List', 'subtitle': 'Milk, Bread, Eggs', 'color': Colors.green},
    {'title': 'Workout Plan', 'subtitle': 'Cardio and Strength training', 'color': Colors.orange},
    {'title': 'Book Reading', 'subtitle': 'Flutter Development Guide', 'color': Colors.purple},
    {'title': 'Travel Plans', 'subtitle': 'Weekend trip to mountains', 'color': Colors.teal},
  ];

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Item removed'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            // In a real app, you would restore the item here
          },
        ),
      ),
    );
  }

  void _archiveItem(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${_items[index]['title']} archived')),
    );
  }

  void _shareItem(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${_items[index]['title']} shared')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slidable Demo'),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          return Slidable(
            key: ValueKey(index),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (_) => _archiveItem(index),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  icon: Icons.archive,
                  label: 'Archive',
                ),
                SlidableAction(
                  onPressed: (_) => _shareItem(index),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  icon: Icons.share,
                  label: 'Share',
                ),
                SlidableAction(
                  onPressed: (_) => _removeItem(index),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: item['color'],
                child: Text(
                  item['title'][0],
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(item['title']),
              subtitle: Text(item['subtitle']),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        },
      ),
    );
  }
}
