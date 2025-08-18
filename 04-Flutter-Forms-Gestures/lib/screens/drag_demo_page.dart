import 'package:flutter/material.dart';

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
                          'Drag Count: $_dragCount',
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
                color: _isDragging ? Colors.blue.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _isDragging ? Colors.blue.withValues(alpha: 0.3) : Colors.grey.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _isDragging ? Icons.drag_handle : Icons.info_outline,
                    color: _isDragging ? Colors.blue : Colors.grey,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _lastDragStatus,
                      style: TextStyle(
                        color: _isDragging ? Colors.blue : Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Draggable Items Section
            Container(
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
                      children: _draggableItems.map((item) => _buildDraggableItem(item)).toList(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Drop Zones Section
            Container(
              height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Drop Zones',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Row(
                      children: _dropZones.map((zone) => Expanded(
                        child: _buildDropZone(zone),
                      )).toList(),
                    ),
                  ),
                ],
              ),
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
      onDragStarted: () {
        setState(() {
          _isDragging = true;
          _lastDragStatus = 'Dragging ${item.title}...';
        });
      },
      onDragEnd: (details) {
        setState(() {
          _isDragging = false;
          _dragCount++;
          _lastDragStatus = 'Drag completed for ${item.title}';
        });
      },
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

  Widget _buildDropZone(DropZone zone) {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        bool isHighlighted = candidateData.isNotEmpty;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isHighlighted 
                ? zone.color.withValues(alpha: 0.6)
                : zone.color,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isHighlighted ? Colors.blue : Colors.grey.shade400,
              width: isHighlighted ? 2 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isHighlighted ? Icons.add_circle : Icons.place,
                color: isHighlighted ? Colors.blue : Colors.grey.shade600,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                zone.title,
                style: TextStyle(
                  color: isHighlighted ? Colors.blue : Colors.grey.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Accepts: ${zone.acceptedItems.join(", ")}',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
      onWillAcceptWithDetails: (details) {
        return zone.acceptedItems.contains(details.data);
      },
      onAcceptWithDetails: (details) {
        setState(() {
          _dragCount++;
          _lastDragStatus = 'Item ${details.data} dropped in ${zone.title}!';
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Item ${details.data} successfully dropped in ${zone.title}!'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      },
      onLeave: (data) {
        setState(() {
          _lastDragStatus = 'Item $data left ${zone.title}';
        });
      },
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

class DraggableItem {
  final String id;
  final String title;
  final Color color;
  final IconData icon;

  DraggableItem({
    required this.id,
    required this.title,
    required this.color,
    required this.icon,
  });
}

class DropZone {
  final String id;
  final String title;
  final Color color;
  final List<String> acceptedItems;

  DropZone({
    required this.id,
    required this.title,
    required this.color,
    required this.acceptedItems,
  });
}
