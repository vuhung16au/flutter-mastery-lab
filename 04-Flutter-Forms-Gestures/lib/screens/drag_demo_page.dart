import 'package:flutter/material.dart';
import 'package:flutter_forms_gestures/models/drag_models.dart';
import 'package:flutter_forms_gestures/widgets/gestures/drag_status_display.dart';
import 'package:flutter_forms_gestures/widgets/gestures/drag_zones.dart';
import 'package:flutter_forms_gestures/widgets/gestures/draggable_items.dart';

class DragDemoPage extends StatefulWidget {
  const DragDemoPage({super.key});

  @override
  State<DragDemoPage> createState() => _DragDemoPageState();
}

class _DragDemoPageState extends State<DragDemoPage> {
  bool _isDragging = false;
  int _dragCount = 0;
  String _lastDragStatus = 'No drag detected';

  // Draggable items
  final List<DraggableItem> _draggableItems = [
    DraggableItem(
      id: '1',
      title: 'Red Box',
      color: Colors.red,
      icon: Icons.favorite,
    ),
    DraggableItem(
      id: '2',
      title: 'Blue Box',
      color: Colors.blue,
      icon: Icons.star,
    ),
    DraggableItem(
      id: '3',
      title: 'Green Box',
      color: Colors.green,
      icon: Icons.check_circle,
    ),
    DraggableItem(
      id: '4',
      title: 'Purple Box',
      color: Colors.purple,
      icon: Icons.diamond,
    ),
  ];

  // Drop zones
  final List<DropZone> _dropZones = [
    DropZone(
      id: 'zone1',
      title: 'Drop Zone 1',
      color: Colors.orange.withValues(alpha: 0.3),
      acceptedItems: ['1', '2'],
    ),
    DropZone(
      id: 'zone2',
      title: 'Drop Zone 2',
      color: Colors.teal.withValues(alpha: 0.3),
      acceptedItems: ['3', '4'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drag Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetDemo,
            tooltip: 'Reset Demo',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DragStatusDisplay(
              isDragging: _isDragging,
              dragCount: _dragCount,
              lastDragStatus: _lastDragStatus,
            ),

            const SizedBox(height: 16),

            // Draggable Items Section
            DraggableItems(
              draggableItems: _draggableItems,
              onDragStarted: (String itemId) {
                setState(() {
                  _isDragging = true;
                  _lastDragStatus = 'Dragging item $itemId...';
                });
              },
              onDragEnd: (String itemId) {
                setState(() {
                  _isDragging = false;
                  _dragCount++;
                  _lastDragStatus = 'Drag completed for item $itemId';
                });
              },
            ),

            const SizedBox(height: 16),

            // Drop Zones Section
            DragZones(
              dropZones: _dropZones,
              onItemDropped: (String? itemId) {
                if (itemId != null) {
                  setState(() {
                    _dragCount++;
                    _lastDragStatus = 'Item $itemId dropped successfully!';
                  });
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Item $itemId successfully dropped!'),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              onItemLeft: (String? itemId) {
                if (itemId != null) {
                  setState(() {
                    _lastDragStatus = 'Item $itemId left drop zone';
                  });
                }
              },
            ),

            const SizedBox(height: 16),

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
                      'Drag Items',
                      'Long press and drag items from the top section',
                      Icons.drag_handle,
                      Colors.blue,
                    ),
                    _buildInstruction(
                      'Drop Zones',
                      'Drop items in the appropriate zones below',
                      Icons.place,
                      Colors.green,
                    ),
                    _buildInstruction(
                      'Accepted Items',
                      'Zone 1: Red & Blue items, Zone 2: Green & Purple items',
                      Icons.check_circle,
                      Colors.orange,
                    ),
                    _buildInstruction(
                      'Visual Feedback',
                      'Watch for color changes and status updates',
                      Icons.visibility,
                      Colors.purple,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }





  void _resetDemo() {
    setState(() {
      _dragCount = 0;
      _isDragging = false;
      _lastDragStatus = 'Demo reset!';
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Demo reset!'),
        duration: Duration(seconds: 1),
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

 
