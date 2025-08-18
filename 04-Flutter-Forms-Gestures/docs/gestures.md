# Flutter - Gestures

## Overview
This component demonstrates how to implement various touch gestures in Flutter applications, including tap, swipe, pinch, and drag gestures for enhanced user interaction.

## Key Components Used

### 1. GestureDetector
- **Purpose**: Detects various touch gestures
- **Usage**: Wraps widgets to add gesture functionality

### 2. InkWell
- **Purpose**: Material Design touch feedback
- **Usage**: Provides ripple effect on touch

### 3. Draggable
- **Purpose**: Makes widgets draggable
- **Usage**: Enables drag and drop functionality

### 4. DragTarget
- **Purpose**: Accepts dragged widgets
- **Usage**: Defines drop zones for drag operations

## Implementation Steps

1. **Basic Tap Gesture**:
   ```dart
   GestureDetector(
     onTap: () {
       print('Widget tapped!');
     },
     child: Container(
       width: 100,
       height: 100,
       color: Colors.blue,
       child: Center(child: Text('Tap Me')),
     ),
   )
   ```

2. **Long Press Gesture**:
   ```dart
   GestureDetector(
     onLongPress: () {
       print('Long press detected!');
     },
     child: Container(
       width: 100,
       height: 100,
       color: Colors.red,
       child: Center(child: Text('Long Press')),
     ),
   )
   ```

3. **Swipe Gesture**:
   ```dart
   GestureDetector(
     onPanUpdate: (details) {
       // Handle swipe gesture
       print('Swipe detected: ${details.delta}');
     },
     child: Container(
       width: 200,
       height: 100,
       color: Colors.green,
       child: Center(child: Text('Swipe Me')),
     ),
   )
   ```

4. **Drag and Drop**:
   ```dart
   Draggable<String>(
     data: 'Dragged Item',
     child: Container(
       width: 100,
       height: 100,
       color: Colors.orange,
       child: Center(child: Text('Drag Me')),
     ),
     feedback: Container(
       width: 100,
       height: 100,
       color: Colors.orange.withOpacity(0.5),
       child: Center(child: Text('Dragging...')),
     ),
   )
   ```

## Gesture Types
- **onTap**: Single tap
- **onDoubleTap**: Double tap
- **onLongPress**: Long press
- **onPanUpdate**: Swipe/drag movement
- **onScaleUpdate**: Pinch/zoom gestures
- **onVerticalDragUpdate**: Vertical drag
- **onHorizontalDragUpdate**: Horizontal drag

## Best Practices
- Provide visual feedback for gestures
- Use appropriate gesture types for functionality
- Consider accessibility requirements
- Test gestures on different devices
- Handle gesture conflicts appropriately
