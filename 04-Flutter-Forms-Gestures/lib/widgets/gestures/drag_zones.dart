import 'package:flutter/material.dart';
import 'package:flutter_forms_gestures/models/drag_models.dart';

class DragZones extends StatelessWidget {
  final List<DropZone> dropZones;
  final Function(String?) onItemDropped;
  final Function(String?) onItemLeft;

  const DragZones({
    super.key,
    required this.dropZones,
    required this.onItemDropped,
    required this.onItemLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              children: dropZones.map((zone) => Expanded(
                child: _buildDropZone(zone),
              )).toList(),
            ),
          ),
        ],
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
        onItemDropped(details.data);
      },
      onLeave: (data) {
        onItemLeft(data);
      },
    );
  }
}
