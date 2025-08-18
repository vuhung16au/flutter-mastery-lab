import 'package:flutter/material.dart';

class GesturesDemoPage extends StatefulWidget {
  const GesturesDemoPage({super.key});

  @override
  State<GesturesDemoPage> createState() => _GesturesDemoPageState();
}

class _GesturesDemoPageState extends State<GesturesDemoPage>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _rotationController;
  late AnimationController _colorController;
  
  double _scale = 1.0;
  double _rotation = 0.0;
  Color _boxColor = Colors.blue;
  Offset _position = const Offset(0, 0);
  String _lastGesture = 'No gesture detected';
  int _tapCount = 0;
  int _longPressCount = 0;
  int _doubleTapCount = 0;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _colorController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  void _onTap() {
    setState(() {
      _tapCount++;
      _lastGesture = 'Tap detected! Count: $_tapCount';
    });
    _scaleController.forward().then((_) => _scaleController.reverse());
  }

  void _onDoubleTap() {
    setState(() {
      _doubleTapCount++;
      _lastGesture = 'Double tap detected! Count: $_doubleTapCount';
      _rotation += 90;
    });
    _rotationController.forward().then((_) => _rotationController.reverse());
  }

  void _onLongPress() {
    setState(() {
      _longPressCount++;
      _lastGesture = 'Long press detected! Count: $_longPressCount';
      _boxColor = _getRandomColor();
    });
    _colorController.forward().then((_) => _colorController.reverse());
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      // Handle both scale and pan through the scale gesture recognizer
      if (details.scale != 1.0) {
        _scale = details.scale.clamp(0.5, 3.0);
        _lastGesture = 'Scale detected! Scale: ${_scale.toStringAsFixed(2)}';
      } else if (details.focalPointDelta != Offset.zero) {
        _position += details.focalPointDelta;
        _lastGesture = 'Pan detected! Position: (${_position.dx.toStringAsFixed(1)}, ${_position.dy.toStringAsFixed(1)})';
      }
    });
  }

  Color _getRandomColor() {
    final colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
      Colors.pink,
      Colors.teal,
    ];
    return colors[DateTime.now().millisecond % colors.length];
  }

  void _resetCounters() {
    setState(() {
      _tapCount = 0;
      _longPressCount = 0;
      _doubleTapCount = 0;
      _lastGesture = 'Counters reset!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestures Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Interactive Gestures Demo',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Try different gestures on the interactive box below',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Gesture Status Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gesture Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _lastGesture,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildCounterChip('Taps', _tapCount, Colors.green),
                        _buildCounterChip('Long Press', _longPressCount, Colors.orange),
                        _buildCounterChip('Double Tap', _doubleTapCount, Colors.purple),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: OutlinedButton.icon(
                        onPressed: _resetCounters,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reset Counters'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Interactive Box Container
            Container(
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: GestureDetector(
                  onTap: _onTap,
                  onDoubleTap: _onDoubleTap,
                  onLongPress: _onLongPress,
                  onScaleUpdate: _onScaleUpdate,
                  child: AnimatedBuilder(
                    animation: Listenable.merge([
                      _scaleController,
                      _rotationController,
                      _colorController,
                    ]),
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scale * (1.0 + _scaleController.value * 0.1),
                        child: Transform.rotate(
                          angle: (_rotation * 3.14159 / 180) + (_rotationController.value * 0.1),
                          child: Transform.translate(
                            offset: _position,
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Color.lerp(
                                  _boxColor,
                                  _boxColor.withOpacity(0.7),
                                  _colorController.value,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.touch_app,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Instructions Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Available Gestures',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildGestureInstruction('Tap', 'Single tap to trigger animation', Icons.touch_app),
                    _buildGestureInstruction('Double Tap', 'Double tap to rotate 90°', Icons.rotate_right),
                    _buildGestureInstruction('Long Press', 'Long press to change color', Icons.palette),
                    _buildGestureInstruction('Pan', 'Drag to move the box', Icons.drag_handle),
                    _buildGestureInstruction('Scale', 'Pinch to resize the box', Icons.zoom_in),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Properties Display Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Current Properties',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildPropertyRow('Scale', '${_scale.toStringAsFixed(2)}x'),
                    _buildPropertyRow('Rotation', '${_rotation.toStringAsFixed(0)}°'),
                    _buildPropertyRow('Position', '(${_position.dx.toStringAsFixed(1)}, ${_position.dy.toStringAsFixed(1)})'),
                    _buildPropertyRow('Color', '#${_boxColor.value.toRadixString(16).toUpperCase().substring(2)}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterChip(String label, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGestureInstruction(String title, String description, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
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

  Widget _buildPropertyRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
