import 'package:flutter/material.dart';

class GestureStats {
  final String lastGesture;
  final int tapCount;
  final int longPressCount;
  final int doubleTapCount;
  final int dragCount;
  final int flickCount;
  final int pinchCount;
  final int spreadCount;
  final int panCount;
  final double scale;
  final double rotationDeg;
  final Offset position;
  final Color boxColor;
  final double? lastFlickVelocity;

  const GestureStats({
    this.lastGesture = 'No gesture detected',
    this.tapCount = 0,
    this.longPressCount = 0,
    this.doubleTapCount = 0,
    this.dragCount = 0,
    this.flickCount = 0,
    this.pinchCount = 0,
    this.spreadCount = 0,
    this.panCount = 0,
    this.scale = 1.0,
    this.rotationDeg = 0.0,
    this.position = const Offset(0, 0),
    this.boxColor = Colors.blue,
    this.lastFlickVelocity,
  });

  GestureStats copyWith({
    String? lastGesture,
    int? tapCount,
    int? longPressCount,
    int? doubleTapCount,
    int? dragCount,
    int? flickCount,
    int? pinchCount,
    int? spreadCount,
    int? panCount,
    double? scale,
    double? rotationDeg,
    Offset? position,
    Color? boxColor,
    double? lastFlickVelocity,
  }) {
    return GestureStats(
      lastGesture: lastGesture ?? this.lastGesture,
      tapCount: tapCount ?? this.tapCount,
      longPressCount: longPressCount ?? this.longPressCount,
      doubleTapCount: doubleTapCount ?? this.doubleTapCount,
      dragCount: dragCount ?? this.dragCount,
      flickCount: flickCount ?? this.flickCount,
      pinchCount: pinchCount ?? this.pinchCount,
      spreadCount: spreadCount ?? this.spreadCount,
      panCount: panCount ?? this.panCount,
      scale: scale ?? this.scale,
      rotationDeg: rotationDeg ?? this.rotationDeg,
      position: position ?? this.position,
      boxColor: boxColor ?? this.boxColor,
      lastFlickVelocity: lastFlickVelocity ?? this.lastFlickVelocity,
    );
  }
}


