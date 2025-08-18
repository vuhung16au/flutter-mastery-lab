import 'package:flutter/material.dart';

class DraggableItem {
  final String id;
  final String title;
  final Color color;
  final IconData icon;

  const DraggableItem({
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

  const DropZone({
    required this.id,
    required this.title,
    required this.color,
    required this.acceptedItems,
  });
}


