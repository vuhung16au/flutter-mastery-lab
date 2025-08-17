import 'package:flutter/material.dart';

// Animation Demo Exports
export 'basic_animations.dart';
export 'staggered_animations.dart';
export 'text_animations.dart';
export 'physics_animations.dart';
export 'hero_animations.dart';
export 'lottie_animations.dart';
export 'flutter_animate_demos.dart';
export 'loading_animations.dart';
export 'animation_gallery.dart';
export 'example_usage.dart';

// Animation Demo List for Navigation
class AnimationDemo {
  final String title;
  final String description;
  final IconData icon;
  final String routeName;

  const AnimationDemo({
    required this.title,
    required this.description,
    required this.icon,
    required this.routeName,
  });
}

class AnimationDemos {
  static const List<AnimationDemo> demos = [
    AnimationDemo(
      title: 'Basic Animations',
      description: 'Fade, slide, scale, and rotate animations',
      icon: Icons.animation,
      routeName: 'basic-animations',
    ),
    AnimationDemo(
      title: 'Staggered Animations',
      description: 'Sequential animations for lists and grids',
      icon: Icons.list,
      routeName: 'staggered-animations',
    ),
    AnimationDemo(
      title: 'Text Animations',
      description: 'Typewriter, fade, scale, and wavy text effects',
      icon: Icons.text_fields,
      routeName: 'text-animations',
    ),
    AnimationDemo(
      title: 'Physics Animations',
      description: 'Spring, bounce, gravity, and pendulum effects',
      icon: Icons.science,
      routeName: 'physics-animations',
    ),
    AnimationDemo(
      title: 'Hero Animations',
      description: 'Smooth transitions between screens',
      icon: Icons.flight,
      routeName: 'hero-animations',
    ),
    AnimationDemo(
      title: 'Lottie Animations',
      description: 'Complex animations using Lottie files',
      icon: Icons.movie,
      routeName: 'lottie-animations',
    ),
    AnimationDemo(
      title: 'Flutter Animate',
      description: 'Modern animation syntax with flutter_animate',
      icon: Icons.auto_awesome,
      routeName: 'flutter-animate-demos',
    ),
    AnimationDemo(
      title: 'Loading Animations',
      description: 'Spinners, progress bars, and skeleton screens',
      icon: Icons.hourglass_empty,
      routeName: 'loading-animations',
    ),
  ];
}
