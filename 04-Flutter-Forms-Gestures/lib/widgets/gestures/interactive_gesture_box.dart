import 'package:flutter/material.dart';
import 'package:flutter_forms_gestures/widgets/gestures/gesture_animation_controller.dart';

typedef GestureStatsCallback = void Function({
  required String lastGesture,
  int? tapDelta,
  int? doubleTapDelta,
  int? longPressDelta,
  int? dragDelta,
  int? flickDelta,
  int? pinchDelta,
  int? spreadDelta,
  int? panDelta,
  double? scale,
  double? rotationDeg,
  Offset? position,
  Color? boxColor,
  double? lastFlickVelocity,
});

class InteractiveGestureBox extends StatefulWidget {
  final GestureStatsCallback onStats;

  const InteractiveGestureBox({super.key, required this.onStats});

  @override
  State<InteractiveGestureBox> createState() => _InteractiveGestureBoxState();
}

class _InteractiveGestureBoxState extends State<InteractiveGestureBox>
    with TickerProviderStateMixin {
  late GestureAnimationController _animationController;

  double _scale = 1.0;
  double _rotation = 0.0;
  Color _boxColor = Colors.blue;
  Offset _position = const Offset(0, 0);

  @override
  void initState() {
    super.initState();
    _animationController = GestureAnimationController(this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _emit({
    required String lastGesture,
    int? tapDelta,
    int? doubleTapDelta,
    int? longPressDelta,
    int? dragDelta,
    int? flickDelta,
    int? pinchDelta,
    int? spreadDelta,
    int? panDelta,
    double? scale,
    double? rotationDeg,
    Offset? position,
    Color? boxColor,
    double? lastFlickVelocity,
  }) {
    widget.onStats(
      lastGesture: lastGesture,
      tapDelta: tapDelta,
      doubleTapDelta: doubleTapDelta,
      longPressDelta: longPressDelta,
      dragDelta: dragDelta,
      flickDelta: flickDelta,
      pinchDelta: pinchDelta,
      spreadDelta: spreadDelta,
      panDelta: panDelta,
      scale: scale ?? _scale,
      rotationDeg: rotationDeg ?? _rotation,
      position: position ?? _position,
      boxColor: boxColor ?? _boxColor,
      lastFlickVelocity: lastFlickVelocity,
    );
  }

  void _onTap() {
    _emit(lastGesture: 'Tap detected!', tapDelta: 1);
    _animationController.triggerScaleAnimation();
  }

  void _onDoubleTap() {
    setState(() => _rotation += 90);
    _emit(lastGesture: 'Double tap detected!', doubleTapDelta: 1, rotationDeg: _rotation);
    _animationController.triggerRotationAnimation();
  }

  void _onLongPress() {
    setState(() => _boxColor = _randomColor());
    _emit(lastGesture: 'Long press detected!', longPressDelta: 1, boxColor: _boxColor);
    _animationController.triggerColorAnimation();
  }

  void _onScaleStart(ScaleStartDetails _) {
    _emit(lastGesture: 'Gesture started');
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    if (details.scale != 1.0) {
      final previous = _scale;
      setState(() => _scale = details.scale.clamp(0.5, 3.0));
      if (_scale < previous) {
        _emit(lastGesture: 'Pinch detected!', pinchDelta: 1, scale: _scale);
      } else if (_scale > previous) {
        _emit(lastGesture: 'Spread/Zoom detected!', spreadDelta: 1, scale: _scale);
      }
    }
    if (details.focalPointDelta != Offset.zero) {
      setState(() => _position += details.focalPointDelta);
      _emit(lastGesture: 'Panning...', panDelta: 1, position: _position);
      if (details.pointerCount == 1) {
        _emit(lastGesture: 'Dragging...', dragDelta: 1, position: _position);
      }
    }
  }

  void _onScaleEnd(ScaleEndDetails details) {
    if (details.velocity.pixelsPerSecond.distance > 800) {
      final v = details.velocity.pixelsPerSecond.distance;
      _emit(lastGesture: 'Flick detected!', flickDelta: 1, lastFlickVelocity: v);
      _animationController.triggerFlickAnimation();
    } else {
      _emit(lastGesture: 'Gesture completed. Final scale: ${_scale.toStringAsFixed(2)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            animation: _animationController.combinedAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scale * (1.0 + _animationController.scaleController.value * 0.1),
                child: Transform.rotate(
                  angle: (_rotation * 3.14159 / 180) + (_animationController.rotationController.value * 0.1),
                  child: Transform.translate(
                    offset: _position,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _onTap,
                        onDoubleTap: _onDoubleTap,
                        onLongPress: _onLongPress,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Color.lerp(
                              _boxColor,
                              _boxColor.withValues(alpha: 0.7),
                              _animationController.colorController.value,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 8 + (_animationController.flickController.value * 4),
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
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Color _randomColor() {
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
}


