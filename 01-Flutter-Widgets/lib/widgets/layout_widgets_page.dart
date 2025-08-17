import 'package:flutter/material.dart';

// Page 2: Layout Widgets - Demonstrates various layout widgets
class LayoutWidgetsPage extends StatelessWidget {
  const LayoutWidgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sydney Layout Widgets',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          
          // Row and Column demonstration
          const Text(
            'Row and Column:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 60,
                height: 60,
                color: Colors.red.shade100,
                child: const Center(child: Text('CBD')),
              ),
              Container(
                width: 60,
                height: 60,
                color: Colors.green.shade100,
                child: const Center(child: Text('North')),
              ),
              Container(
                width: 60,
                height: 60,
                color: Colors.blue.shade100,
                child: const Center(child: Text('East')),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Stack demonstration
          const Text(
            'Stack Widget:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Center(child: Text('Harbour')),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Bridge'),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Wrap demonstration
          const Text(
            'Wrap Widget:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              Chip(
                label: Text('Bondi'),
                backgroundColor: Colors.blue,
              ),
              Chip(
                label: Text('Manly'),
                backgroundColor: Colors.green,
              ),
              Chip(
                label: Text('Coogee'),
                backgroundColor: Colors.orange,
              ),
              Chip(
                label: Text('Bronte'),
                backgroundColor: Colors.purple,
              ),
              Chip(
                label: Text('Tamarama'),
                backgroundColor: Colors.red,
              ),
              Chip(
                label: Text('Clovelly'),
                backgroundColor: Colors.teal,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
