import 'package:flutter/material.dart';
import 'package:flutter_forms_gestures/widgets/gestures/ripple_effects.dart';
import 'package:flutter_forms_gestures/widgets/gestures/ripple_buttons.dart';
import 'package:flutter_forms_gestures/widgets/gestures/ripple_instructions.dart';
import 'package:flutter_forms_gestures/widgets/gestures/ripple_stats_card.dart';

class RippleGestureDemoPage extends StatefulWidget {
  const RippleGestureDemoPage({super.key});

  @override
  State<RippleGestureDemoPage> createState() => _RippleGestureDemoPageState();
}

class _RippleGestureDemoPageState extends State<RippleGestureDemoPage>
    with TickerProviderStateMixin {
  late AnimationController _rippleController;
  late AnimationController _scaleController;
  late AnimationController _colorController;
  
  double _rippleRadius = 0.0;
  double _scale = 1.0;
  Color _currentColor = Colors.blue;
  Offset _rippleCenter = Offset.zero;
  bool _isRippling = false;
  
  int _tapCount = 0;
  int _longPressCount = 0;
  int _doubleTapCount = 0;
  String _lastAction = 'No action yet';

  @override
  void initState() {
    super.initState();
    _rippleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _colorController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _rippleController.addListener(() {
      setState(() {
        _rippleRadius = _rippleController.value * 100;
      });
    });
    
    _scaleController.addListener(() {
      setState(() {
        _scale = 1.0 + (_scaleController.value * 0.1);
      });
    });
  }

  @override
  void dispose() {
    _rippleController.dispose();
    _scaleController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _rippleCenter = details.localPosition;
      _isRippling = true;
    });
    _rippleController.forward().then((_) {
      setState(() {
        _isRippling = false;
      });
      _rippleController.reset();
    });
  }

  void _onTap() {
    setState(() {
      _tapCount++;
      _lastAction = 'Tap detected!';
    });
    _scaleController.forward().then((_) => _scaleController.reverse());
  }

  void _onDoubleTap() {
    setState(() {
      _doubleTapCount++;
      _lastAction = 'Double tap detected!';
      _currentColor = _getRandomColor();
    });
    _colorController.forward().then((_) => _colorController.reverse());
  }

  void _onLongPress() {
    setState(() {
      _longPressCount++;
      _lastAction = 'Long press detected!';
      _currentColor = _getRandomColor();
    });
    _colorController.forward().then((_) => _colorController.reverse());
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
      Colors.indigo,
      Colors.amber,
    ];
    return colors[DateTime.now().millisecond % colors.length];
  }

  void _resetCounters() {
    setState(() {
      _tapCount = 0;
      _longPressCount = 0;
      _doubleTapCount = 0;
      _lastAction = 'Counters reset!';
      _currentColor = Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ripple & Gesture Effects Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetCounters,
            tooltip: 'Reset Counters',
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
                      'Ripple & Gesture Effects Demo',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Demonstrating ripple effects, tap handling, and gesture animations from Flutter documentation.',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Stats Card
            RippleStatsCard(
              tapCount: _tapCount,
              doubleTapCount: _doubleTapCount,
              longPressCount: _longPressCount,
              lastAction: _lastAction,
            ),
            const SizedBox(height: 16),
            
            // Interactive Ripple Area
            AnimatedBuilder(
              animation: Listenable.merge([
                _scaleController,
                _colorController,
              ]),
              builder: (context, child) {
                return RippleEffects(
                  isRippling: _isRippling,
                  rippleCenter: _rippleCenter,
                  rippleRadius: _rippleRadius,
                  onTap: _onTap,
                  onDoubleTap: _onDoubleTap,
                  onLongPress: _onLongPress,
                  onTapDown: (details) => _onTapDown(details),
                  scale: _scale,
                  currentColor: _currentColor,
                  colorControllerValue: _colorController.value,
                );
              },
            ),
            const SizedBox(height: 16),
            
            // Ripple Effects Demo
            RippleButtons(
              onTap: _onTap,
              onDoubleTap: _onDoubleTap,
              onLongPress: _onLongPress,
              onCustomRipple: () {
                setState(() {
                  _rippleCenter = const Offset(50, 50);
                  _isRippling = true;
                });
                _rippleController.forward().then((_) {
                  setState(() {
                    _isRippling = false;
                  });
                  _rippleController.reset();
                });
              },
            ),
            const SizedBox(height: 16),
            
            // Instructions Card
            const RippleInstructions(),
          ],
        ),
      ),
    );
  }






}
