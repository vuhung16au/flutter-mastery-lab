import 'package:flutter/material.dart';
import 'package:flutter_forms_gestures/widgets/gestures/dismissible_header.dart';
import 'package:flutter_forms_gestures/widgets/gestures/dismissible_list.dart';

class DismissibleDemoPage extends StatefulWidget {
  const DismissibleDemoPage({super.key});

  @override
  State<DismissibleDemoPage> createState() => _DismissibleDemoPageState();
}

class _DismissibleDemoPageState extends State<DismissibleDemoPage> {
  final List<String> _items = List<String>.generate(20, (i) => 'Item ${i + 1}');
  final List<String> _deletedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swipe to Dismiss Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.restore),
            onPressed: _restoreItems,
            tooltip: 'Restore Items',
          ),
        ],
      ),
      body: Column(
        children: [
          // Header Card
          DismissibleHeader(
            itemsCount: _items.length,
            deletedItemsCount: _deletedItems.length,
          ),

          // Dismissible List
          DismissibleList(
            items: _items,
            deletedItems: _deletedItems,
            onDismissed: (index) {
              final item = _items[index];
              setState(() {
                _items.removeAt(index);
                _deletedItems.add(item);
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$item dismissed'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      setState(() {
                        _items.insert(index, item);
                        _deletedItems.remove(item);
                      });
                    },
                  ),
                ),
              );
            },
            onUndo: (index, item) {
              setState(() {
                _items.insert(index, item);
                _deletedItems.remove(item);
              });
            },
            onConfirmDismiss: (item) async {
              return await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm Dismiss'),
                    content: Text('Are you sure you want to dismiss "$item"?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Dismiss'),
                      ),
                    ],
                  );
                },
              );
            },
          ),

          // Instructions Card
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How to Use',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildInstruction(
                    'Swipe Left',
                    'Dismiss item (red background)',
                    Icons.swipe_left,
                    Colors.red,
                  ),
                  _buildInstruction(
                    'Swipe Right',
                    'Dismiss item (green background)',
                    Icons.swipe_right,
                    Colors.green,
                  ),
                  _buildInstruction(
                    'Special Items',
                    'Items 5, 10, 15 require confirmation',
                    Icons.warning,
                    Colors.orange,
                  ),
                  _buildInstruction(
                    'Undo',
                    'Use the snackbar action to undo',
                    Icons.undo,
                    Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _restoreItems() {
    setState(() {
      _items.addAll(_deletedItems);
      _deletedItems.clear();
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All items restored!'),
        duration: Duration(seconds: 2),
      ),
    );
  }



  Widget _buildInstruction(String title, String description, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
