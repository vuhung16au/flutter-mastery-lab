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
  late AnimationController _flickController;
  
  double _scale = 1.0;
  double _rotation = 0.0;
  Color _boxColor = Colors.blue;
  Offset _position = const Offset(0, 0);
  String _lastGesture = 'No gesture detected';
  
  // Gesture counters
  int _tapCount = 0;
  int _longPressCount = 0;
  int _doubleTapCount = 0;
  int _dragCount = 0;
  int _flickCount = 0;
  int _pinchCount = 0;
  int _spreadCount = 0;
  int _panCount = 0;
  
  // Gesture tracking variables
  bool _isDragging = false;
  bool _isPanning = false;
  Offset? _dragStartPosition;
  DateTime? _lastFlickTime;
  double _lastFlickVelocity = 0.0;
  Offset? _lastFocalPoint;
  DateTime? _dragStartTime;

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
    _flickController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    _colorController.dispose();
    _flickController.dispose();
    super.dispose();
  }

  // Tap gesture
  void _onTap() {
    setState(() {
      _tapCount++;
      _lastGesture = 'Tap detected! Count: $_tapCount';
    });
    _scaleController.forward().then((_) => _scaleController.reverse());
  }

  // Double tap gesture
  void _onDoubleTap() {
    setState(() {
      _doubleTapCount++;
      _lastGesture = 'Double tap detected! Count: $_doubleTapCount';
      _rotation += 90;
    });
    _rotationController.forward().then((_) => _rotationController.reverse());
  }

  // Long press gesture
  void _onLongPress() {
    setState(() {
      _longPressCount++;
      _lastGesture = 'Long press detected! Count: $_longPressCount';
      _boxColor = _getRandomColor();
    });
    _colorController.forward().then((_) => _colorController.reverse());
  }

  // Scale gesture (handles both scaling and panning)
  void _onScaleStart(ScaleStartDetails details) {
    setState(() {
      _lastFocalPoint = details.focalPoint;
      _dragStartTime = DateTime.now();
      _lastGesture = 'Gesture started';
    });
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      // Handle scaling (pinch/spread)
      if (details.scale != 1.0) {
        double previousScale = _scale;
        _scale = details.scale.clamp(0.5, 3.0);
        
        // Determine if it's pinch or spread
        if (_scale < previousScale) {
          _pinchCount++;
          _lastGesture = 'Pinch detected! Count: $_pinchCount, Scale: ${_scale.toStringAsFixed(2)}';
        } else if (_scale > previousScale) {
          _spreadCount++;
          _lastGesture = 'Spread/Zoom detected! Count: $_spreadCount, Scale: ${_scale.toStringAsFixed(2)}';
        }
      }
      
      // Handle panning through focal point delta
      if (details.focalPointDelta != Offset.zero) {
        _position += details.focalPointDelta;
        _panCount++;
        _lastGesture = 'Panning... Count: $_panCount';
        
        // Check if this is a drag gesture (single finger movement)
        if (details.pointerCount == 1) {
          _dragCount++;
          _lastGesture = 'Dragging... Count: $_dragCount';
        }
      }
    });
  }

  void _onScaleEnd(ScaleEndDetails details) {
    setState(() {
      // Check if it was a flick (high velocity)
      if (details.velocity.pixelsPerSecond.distance > 800) {
        _flickCount++;
        _lastGesture = 'Flick detected! Count: $_flickCount';
        _lastFlickTime = DateTime.now();
        _lastFlickVelocity = details.velocity.pixelsPerSecond.distance;
        _flickController.forward().then((_) => _flickController.reverse());
      } else {
        _lastGesture = 'Gesture completed. Final scale: ${_scale.toStringAsFixed(2)}';
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
      _dragCount = 0;
      _flickCount = 0;
      _pinchCount = 0;
      _spreadCount = 0;
      _panCount = 0;
      _lastGesture = 'Counters reset!';
    });
  }

  void _resetBox() {
    setState(() {
      _scale = 1.0;
      _rotation = 0.0;
      _position = const Offset(0, 0);
      _boxColor = Colors.blue;
      _lastGesture = 'Box reset to original state!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Gestures Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetBox,
            tooltip: 'Reset Box',
          ),
        ],
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
                      'Flutter Gestures Demo',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Demonstrating all Flutter gesture types from TutorialsPoint',
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
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        _lastGesture,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildCounterChip('Tap', _tapCount, Colors.green),
                        _buildCounterChip('Double Tap', _doubleTapCount, Colors.purple),
                        _buildCounterChip('Long Press', _longPressCount, Colors.orange),
                        _buildCounterChip('Drag', _dragCount, Colors.blue),
                        _buildCounterChip('Flick', _flickCount, Colors.red),
                        _buildCounterChip('Pinch', _pinchCount, Colors.teal),
                        _buildCounterChip('Spread', _spreadCount, Colors.indigo),
                        _buildCounterChip('Pan', _panCount, Colors.amber),
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
                color: Colors.grey.shade50,
              ),
              child: Center(
                child: GestureDetector(
                  onTap: _onTap,
                  onDoubleTap: _onDoubleTap,
                  onLongPress: _onLongPress,
                  onScaleStart: _onScaleStart,
                  onScaleUpdate: _onScaleUpdate,
                  onScaleEnd: _onScaleEnd,
                  child: AnimatedBuilder(
                    animation: Listenable.merge([
                      _scaleController,
                      _rotationController,
                      _colorController,
                      _flickController,
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
                                  _boxColor.withValues(alpha: 0.7),
                                  _colorController.value,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.2),
                                    blurRadius: 8 + (_flickController.value * 4),
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
                      'Available Gestures (from TutorialsPoint)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildGestureInstruction('Tap', 'Touching the surface with fingertip for a short period', Icons.touch_app),
                    _buildGestureInstruction('Double Tap', 'Tapping twice in a short time', Icons.touch_app),
                    _buildGestureInstruction('Drag', 'Touching and moving fingertip in a steady manner', Icons.drag_handle),
                    _buildGestureInstruction('Flick', 'Similar to dragging, but in a speeder way', Icons.flash_on),
                    _buildGestureInstruction('Pinch', 'Pinching the surface using two fingers', Icons.zoom_out),
                    _buildGestureInstruction('Spread/Zoom', 'Opposite of pinching', Icons.zoom_in),
                    _buildGestureInstruction('Panning', 'Touching and moving in any direction without releasing', Icons.pan_tool),
                    _buildGestureInstruction('Long Press', 'Press and hold for extended period', Icons.timer),
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
                    _buildPropertyRow('Color', '#${_boxColor.toARGB32().toRadixString(16).toUpperCase().substring(2)}'),
                    if (_lastFlickTime != null)
                      _buildPropertyRow('Last Flick Velocity', '${_lastFlickVelocity.toStringAsFixed(0)} px/s'),
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
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
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
