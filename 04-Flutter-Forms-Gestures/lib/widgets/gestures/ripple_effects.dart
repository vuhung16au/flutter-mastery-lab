import 'package:flutter/material.dart';

class RippleEffects extends StatelessWidget {
  final bool isRippling;
  final Offset rippleCenter;
  final double rippleRadius;
  final VoidCallback onTap;
  final VoidCallback onDoubleTap;
  final VoidCallback onLongPress;
  final GestureTapDownCallback? onTapDown;
  final double scale;
  final Color currentColor;
  final double colorControllerValue;

  const RippleEffects({
    super.key,
    required this.isRippling,
    required this.rippleCenter,
    required this.rippleRadius,
    required this.onTap,
    required this.onDoubleTap,
    required this.onLongPress,
    required this.onTapDown,
    required this.scale,
    required this.currentColor,
    required this.colorControllerValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade50,
      ),
      child: Stack(
        children: [
          // Ripple effect
          if (isRippling)
            Positioned(
              left: rippleCenter.dx - rippleRadius,
              top: rippleCenter.dy - rippleRadius,
              child: Container(
                width: rippleRadius * 2,
                height: rippleRadius * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.withValues(alpha: 0.3),
                ),
              ),
            ),
          
          // Interactive area
          Center(
                      child: GestureDetector(
            onTapDown: onTapDown ?? (_) {},
              onTap: onTap,
              onDoubleTap: onDoubleTap,
              onLongPress: onLongPress,
              child: Transform.scale(
                scale: scale,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTap,
                    onDoubleTap: onDoubleTap,
                    onLongPress: onLongPress,
                    borderRadius: BorderRadius.circular(12),
                    splashColor: Colors.blue.withValues(alpha: 0.3),
                    highlightColor: Colors.blue.withValues(alpha: 0.1),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Color.lerp(
                          currentColor,
                          currentColor.withValues(alpha: 0.8),
                          colorControllerValue,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.touch_app,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
