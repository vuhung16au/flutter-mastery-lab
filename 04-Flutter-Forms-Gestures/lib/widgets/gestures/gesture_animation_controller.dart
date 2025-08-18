import 'package:flutter/material.dart';

class GestureAnimationController {
  late AnimationController scaleController;
  late AnimationController rotationController;
  late AnimationController colorController;
  late AnimationController flickController;

  GestureAnimationController(TickerProvider vsync) {
    scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: vsync,
    );
    rotationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: vsync,
    );
    colorController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: vsync,
    );
    flickController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: vsync,
    );
  }

  void dispose() {
    scaleController.dispose();
    rotationController.dispose();
    colorController.dispose();
    flickController.dispose();
  }

  void triggerScaleAnimation() {
    scaleController.forward().then((_) => scaleController.reverse());
  }

  void triggerRotationAnimation() {
    rotationController.forward().then((_) => rotationController.reverse());
  }

  void triggerColorAnimation() {
    colorController.forward().then((_) => colorController.reverse());
  }

  void triggerFlickAnimation() {
    flickController.forward().then((_) => flickController.reverse());
  }

  Listenable get combinedAnimation {
    return Listenable.merge([
      scaleController,
      rotationController,
      colorController,
      flickController,
    ]);
  }
}
