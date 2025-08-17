# Flutter Animation Demos

This directory contains a comprehensive collection of Flutter animation demonstrations showcasing various animation techniques and effects.

## 📁 File Structure

```
lib/animations/
├── index.dart                 # Main exports and demo list
├── animation_gallery.dart     # Main gallery screen
├── basic_animations.dart      # Basic fade, slide, scale, rotate
├── staggered_animations.dart  # Sequential list/grid animations
├── text_animations.dart       # Text-specific animations
├── physics_animations.dart    # Physics-based animations
├── hero_animations.dart       # Hero transitions
├── lottie_animations.dart     # Lottie file animations
├── flutter_animate_demos.dart # Modern animation syntax
├── loading_animations.dart    # Loading states and spinners
└── README.md                  # This file
```

## 🎨 Animation Categories

### 1. Basic Animations (`basic_animations.dart`)
- **Fade Animation**: Smooth opacity transitions
- **Slide Animation**: Horizontal and vertical movement
- **Scale Animation**: Size changes with bounce effects
- **Rotate Animation**: Rotation transformations

### 2. Staggered Animations (`staggered_animations.dart`)
- **List Animations**: Sequential item animations
- **Grid Animations**: Staggered grid layouts
- **Custom Timing**: Configurable delays and durations

### 3. Text Animations (`text_animations.dart`)
- **Typewriter Effect**: Character-by-character typing
- **Fade Text**: Smooth text transitions
- **Scale Text**: Text size animations
- **Wavy Text**: Wave-like text effects
- **Rotate Text**: Text rotation animations

### 4. Physics Animations (`physics_animations.dart`)
- **Spring Animation**: Elastic spring effects
- **Bounce Animation**: Realistic bouncing
- **Gravity Animation**: Falling object simulation
- **Pendulum Animation**: Swinging pendulum effect

### 5. Hero Animations (`hero_animations.dart`)
- **Hero Transitions**: Smooth screen transitions
- **Shared Element**: Element continuity between screens
- **Custom Hero Tags**: Multiple hero elements

### 6. Lottie Animations (`lottie_animations.dart`)
- **Loading Animations**: Custom loading states
- **Success Animations**: Success feedback
- **Error Animations**: Error state animations
- **Celebration Animations**: Achievement celebrations

### 7. Flutter Animate (`flutter_animate_demos.dart`)
- **Modern Syntax**: Chain-based animations
- **Conditional Animations**: State-based animations
- **Complex Chains**: Multiple animation sequences
- **Staggered Effects**: Delayed animations

### 8. Loading Animations (`loading_animations.dart`)
- **Spinner Animation**: Rotating loaders
- **Pulse Animation**: Pulsing effects
- **Wave Animation**: Wave-like loading
- **Progress Bars**: Animated progress indicators
- **Skeleton Loading**: Content placeholders
- **Dots Loading**: Animated dots

## 🚀 Usage

### Quick Start

```dart
import 'package:your_app/animations/index.dart';

// Navigate to the animation gallery
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const AnimationGallery(),
  ),
);
```

### Individual Animations

```dart
// Use specific animation screens
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const BasicAnimations(),
  ),
);
```

### Programmatic Access

```dart
// Access demo list programmatically
for (final demo in AnimationDemos.demos) {
  print('${demo.title}: ${demo.description}');
}
```

## 📦 Dependencies

The animations use the following packages (already included in `pubspec.yaml`):

- `flutter_staggered_animations`: For staggered animations
- `animated_text_kit`: For text animations
- `lottie`: For Lottie file animations
- `flutter_animate`: For modern animation syntax
- `shimmer`: For skeleton loading effects

## 🎯 Features

### Interactive Controls
- Play/Pause buttons for animations
- Reset functionality
- Progress controls
- Custom timing options

### Responsive Design
- Adapts to different screen sizes
- Material Design 3 theming
- Dark/Light mode support
- Accessibility considerations

### Performance Optimized
- Efficient animation controllers
- Proper disposal of resources
- Optimized rebuild cycles
- Memory management

## 🔧 Customization

### Adding New Animations

1. Create a new animation file in the `lib/animations/` directory
2. Add the export to `index.dart`
3. Add the demo to `AnimationDemos.demos` list
4. Update this README

### Example New Animation

```dart
// my_custom_animation.dart
import 'package:flutter/material.dart';

class MyCustomAnimation extends StatefulWidget {
  const MyCustomAnimation({super.key});

  @override
  State<MyCustomAnimation> createState() => _MyCustomAnimationState();
}

class _MyCustomAnimationState extends State<MyCustomAnimation>
    with TickerProviderStateMixin {
  // Your animation implementation
}
```

### Modifying Existing Animations

Each animation file is self-contained and can be easily modified:
- Change colors and themes
- Adjust timing and curves
- Add new animation effects
- Customize UI elements

## 🎨 Design Principles

### Material Design 3
- Consistent with Material Design guidelines
- Dynamic color theming
- Elevation and shadows
- Typography hierarchy

### Accessibility
- Screen reader support
- High contrast support
- Reduced motion options
- Focus indicators

### Performance
- 60fps animations
- Efficient rendering
- Memory optimization
- Battery consideration

## 📱 Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Desktop (Windows, macOS, Linux)

## 🤝 Contributing

To add new animations or improve existing ones:

1. Follow the existing code structure
2. Add proper documentation
3. Include interactive controls
4. Test on multiple platforms
5. Update this README

## 📄 License

This animation collection is part of the Flutter Design & Animations project and follows the same license terms.

## 🔗 Resources

- [Flutter Animation Documentation](https://docs.flutter.dev/development/ui/animations)
- [Material Design Animation Guidelines](https://m2.material.io/design/motion/)
- [LottieFiles](https://lottiefiles.com/) - For Lottie animations
- [Flutter Animate Package](https://pub.dev/packages/flutter_animate)

---

**Happy Animating! 🎉**
