import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildExpansionTile(),
        const SizedBox(height: 16),
        _buildCheckboxSection(),
        const SizedBox(height: 16),
        _buildSlidableList(),
      ],
    );
  }

  Widget _buildExpansionTile() {
    return Card(
      child: ExpansionTile(
        leading: const Icon(Icons.expand_more),
        title: const Text('Expansion Tile Example'),
        subtitle: const Text('Tap to expand and see more content'),
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'This is the expanded content of the ExpansionTile. '
              'You can put any widgets here including lists, forms, or other complex layouts.',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Checkbox Examples',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text('Enable Notifications'),
              subtitle: const Text('Receive push notifications'),
              value: true,
              onChanged: (bool? value) {
                // Handle checkbox change
              },
            ),
            CheckboxListTile(
              title: const Text('Dark Mode'),
              subtitle: const Text('Use dark theme'),
              value: false,
              onChanged: (bool? value) {
                // Handle checkbox change
              },
            ),
            CheckboxListTile(
              title: const Text('Auto Save'),
              subtitle: const Text('Automatically save changes'),
              value: true,
              onChanged: (bool? value) {
                // Handle checkbox change
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlidableList() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Slidable List Items',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    // Handle edit action
                  },
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'Edit',
                ),
                SlidableAction(
                  onPressed: (context) {
                    // Handle delete action
                  },
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: const ListTile(
              title: Text('Swipe to see actions'),
              subtitle: Text('Swipe left to reveal edit and delete options'),
              leading: Icon(Icons.swipe),
            ),
          ),
          Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    // Handle edit action
                  },
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'Edit',
                ),
                SlidableAction(
                  onPressed: (context) {
                    // Handle delete action
                  },
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: const ListTile(
              title: Text('Another slidable item'),
              subtitle: Text('Try swiping this one too'),
              leading: Icon(Icons.list),
            ),
          ),
        ],
      ),
    );
  }
}
