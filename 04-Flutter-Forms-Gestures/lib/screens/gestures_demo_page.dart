import 'package:flutter/material.dart';
import 'package:flutter_forms_gestures/widgets/gestures/interactive_gesture_box.dart';
import 'package:flutter_forms_gestures/widgets/gestures/gesture_stats_card.dart';
import 'package:flutter_forms_gestures/widgets/gestures/instructions_card.dart';
import 'package:flutter_forms_gestures/widgets/gestures/properties_card.dart';

class GesturesDemoPage extends StatefulWidget {
  const GesturesDemoPage({super.key});

  @override
  State<GesturesDemoPage> createState() => _GesturesDemoPageState();
}

class _GesturesDemoPageState extends State<GesturesDemoPage> {
  String _lastGesture = 'No gesture detected';
  int _tapCount = 0;
  int _longPressCount = 0;
  int _doubleTapCount = 0;
  int _dragCount = 0;
  int _flickCount = 0;
  int _pinchCount = 0;
  int _spreadCount = 0;
  int _panCount = 0;
  double _scale = 1.0;
  double _rotation = 0.0;
  Offset _position = const Offset(0, 0);
  Color _boxColor = Colors.blue;
  double? _lastFlickVelocity;

  void _resetBox() {
    setState(() {
      _scale = 1.0;
      _rotation = 0.0;
      _position = const Offset(0, 0);
      _boxColor = Colors.blue;
      _lastGesture = 'Box reset to original state!';
    });
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

  void _onStatsUpdate({
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
    setState(() {
      _lastGesture = lastGesture;
      _tapCount += tapDelta ?? 0;
      _doubleTapCount += doubleTapDelta ?? 0;
      _longPressCount += longPressDelta ?? 0;
      _dragCount += dragDelta ?? 0;
      _flickCount += flickDelta ?? 0;
      _pinchCount += pinchDelta ?? 0;
      _spreadCount += spreadDelta ?? 0;
      _panCount += panDelta ?? 0;
      _scale = scale ?? _scale;
      _rotation = rotationDeg ?? _rotation;
      _position = position ?? _position;
      _boxColor = boxColor ?? _boxColor;
      _lastFlickVelocity = lastFlickVelocity ?? _lastFlickVelocity;
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
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Flutter Gestures Demo', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Demonstrating all Flutter gesture types from TutorialsPoint & Flutter Docs', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureStatsCard(
              lastGesture: _lastGesture,
              tapCount: _tapCount,
              doubleTapCount: _doubleTapCount,
              longPressCount: _longPressCount,
              dragCount: _dragCount,
              flickCount: _flickCount,
              pinchCount: _pinchCount,
              spreadCount: _spreadCount,
              panCount: _panCount,
              onReset: _resetCounters,
            ),
            const SizedBox(height: 16),
            InteractiveGestureBox(onStats: _onStatsUpdate),
            const SizedBox(height: 16),
            InstructionsCard(items: buildGestureInstructions()),
            const SizedBox(height: 16),
            PropertiesCard(
              scale: _scale,
              rotationDeg: _rotation,
              position: _position,
              color: _boxColor,
              lastFlickVelocity: _lastFlickVelocity,
            ),
          ],
        ),
      ),
    );
  }
}
