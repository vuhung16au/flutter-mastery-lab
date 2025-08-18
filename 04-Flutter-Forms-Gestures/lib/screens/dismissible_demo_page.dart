import 'package:flutter/material.dart';

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
          Card(
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
                        '${_items.length} items remaining',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      if (_deletedItems.isNotEmpty)
                        Text(
                          '${_deletedItems.length} items deleted',
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
          ),

          // Dismissible List
          Expanded(
            child: _items.isEmpty
                ? Center(
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
                          onPressed: _restoreItems,
                          icon: const Icon(Icons.restore),
                          label: const Text('Restore Items'),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return Dismissible(
                        // Each Dismissible must contain a Key. Keys allow Flutter to
                        // uniquely identify widgets.
                        key: Key(item),
                        // Provide a function that tells the app
                        // what to do after an item has been swiped away.
                        onDismissed: (direction) {
                          // Remove the item from the data source.
                          setState(() {
                            _items.removeAt(index);
                            _deletedItems.add(item);
                          });

                          // Then show a snackbar.
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
                        // Show a red background as the item is swiped away.
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        // Show a green background when swiping from right to left
                        secondaryBackground: Container(
                          color: Colors.green,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                        // Confirm dismissal for important items
                        confirmDismiss: (direction) async {
                          if (item.contains('5') || item.contains('10') || item.contains('15')) {
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
                            subtitle: Text('Swipe to dismiss this item'),
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
                    },
                  ),
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
