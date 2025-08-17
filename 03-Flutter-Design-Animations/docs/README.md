# Flutter Design & Animations

A comprehensive showcase of Flutter's design and animation capabilities, demonstrating various techniques for creating beautiful and engaging user interfaces. The project now includes a complete animation gallery with 8 different animation categories and 40+ animation types.

## 🎨 New: Animation Gallery

The project now features a comprehensive **Animation Gallery** located in `lib/animations/` that showcases various animation techniques and effects. The gallery is organized into 8 main categories:

### Animation Categories

1. **Basic Animations** - Fade, slide, scale, and rotate animations
2. **Staggered Animations** - Sequential list and grid animations  
3. **Text Animations** - Typewriter, fade, scale, wavy, and rotate text effects
4. **Physics Animations** - Spring, bounce, gravity, and pendulum effects
5. **Hero Animations** - Smooth screen transitions with shared elements
6. **Lottie Animations** - Integration with Lottie animation files
7. **Flutter Animate** - Modern animation syntax examples
8. **Loading Animations** - Spinners, progress bars, and skeleton screens

### Quick Start with Animation Gallery

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

For detailed information about the animation gallery, see [animations.md](animations.md).

## Features

This project demonstrates the following design and animation components:

### 1. Customizing Fonts in Flutter
- Google Fonts integration
- Multiple font families (Poppins, Roboto, Open Sans, Lato)
- Custom font styling and weights

### 2. Flutter Themes
- Material 3 design system
- Light and dark theme support
- Custom color schemes
- Theme-aware components

### 3. Auto Size Text
- Responsive text that adapts to container size
- Automatic font scaling
- Multi-line text support

### 4. Skeleton Text & Shimmer
- Loading state animations
- Shimmer effect for content placeholders
- Smooth transitions from skeleton to actual content

### 5. Animation in Route Transition
- Custom page transitions
- Slide animations
- Fade transitions
- Smooth navigation experiences

### 6. Ripple Effect
- Touch feedback animations
- Custom ripple implementations
- Interactive button effects

### 7. Lazy Loader
- Loading indicators
- Progress animations
- Circular and linear progress bars

### 8. Radial Hero Animation
- Scale and transform animations
- Hero widget transitions
- Radial gradient effects

### 9. Hinge Animation
- Rotation-based animations
- Physics-inspired movements
- Interactive door-like animations

### 10. Lottie Animation
- Integration with Lottie files
- JSON-based animations
- External animation support

### 11. Progress Indicator
- Linear progress bars
- Circular progress indicators
- Custom progress styling

### 12. Physics Simulation
- Gravity-based animations
- Bouncing effects
- Realistic movement patterns

### 13. Using Google Fonts
- Typography customization
- Font family selection
- Responsive text sizing

### 14. Rotate Transition
- Rotation animations
- Smooth transitions
- Interactive rotation effects

### 15. Animated Splash Screen
- App launch animations
- Fade and scale effects
- Smooth app initialization

### 16. Shimmer
- Loading state effects
- Content placeholder animations
- Smooth loading transitions

### 17. Rive Animations
- Advanced vector animations
- Interactive animations
- Complex animation sequences

## Getting Started

1. Install dependencies:
```bash
flutter pub get
```

2. Run the application:
```bash
flutter run
```

3. Explore the Animation Gallery:
   - Navigate to the Animation Gallery from the main app
   - Or use individual animation screens directly
   - Check the documentation in `lib/animations/README.md`

## Dependencies

- `google_fonts`: For custom typography
- `auto_size_text`: For responsive text sizing
- `shimmer`: For loading animations
- `lottie`: For Lottie animation support
- `rive`: For Rive animation support (optional - can cause NDK issues)
- `flutter_staggered_animations`: For staggered animations
- `animated_text_kit`: For text animations
- `flutter_animate`: For simplified animations

## Project Structure

```
lib/
├── main.dart                 # Main application entry point
├── animations/              # 🆕 Comprehensive animation gallery
│   ├── index.dart           # Main exports and demo list
│   ├── animation_gallery.dart # Main gallery screen
│   ├── basic_animations.dart # Basic fade, slide, scale, rotate
│   ├── staggered_animations.dart # Sequential animations
│   ├── text_animations.dart  # Text-specific animations
│   ├── physics_animations.dart # Physics-based animations
│   ├── hero_animations.dart  # Hero transitions
│   ├── lottie_animations.dart # Lottie file animations
│   ├── flutter_animate_demos.dart # Modern animation syntax
│   ├── loading_animations.dart # Loading states and spinners
│   ├── example_usage.dart    # Integration examples
│   ├── README.md             # Detailed documentation
│   └── SUMMARY.md            # Quick overview
├── screens/                  # App screens
├── widgets/                  # Reusable widgets
assets/
├── animations/              # Animation files (Lottie, Rive)
├── images/                  # Image assets
└── fonts/                   # Custom font files
docs/
├── README.md               # This file
├── animations.md           # Animation documentation
├── customizing-fonts.md    # Font customization guide
└── themes.md               # Theme documentation
```

## Usage Examples

### Animation Gallery
```dart
// Navigate to the animation gallery
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const AnimationGallery(),
  ),
);

// Use specific animation screens
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const BasicAnimations(),
  ),
);
```

### Custom Fonts
```dart
Text(
  'Custom Font Example',
  style: GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
)
```

### Auto Size Text
```dart
AutoSizeText(
  'This text will automatically resize',
  style: TextStyle(fontSize: 16),
  maxLines: 2,
  minFontSize: 8,
)
```

### Shimmer Effect
```dart
Shimmer.fromColors(
  baseColor: Colors.grey[300]!,
  highlightColor: Colors.grey[100]!,
  child: Container(
    height: 20,
    color: Colors.white,
  ),
)
```

### Route Transition
```dart
Navigator.of(context).push(
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => DetailPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: animation.drive(Tween(begin: Offset(1.0, 0.0), end: Offset.zero)),
        child: child,
      );
    },
  ),
)
```

## 📊 Animation Gallery Statistics

- **Total Animation Demos**: 8
- **Total Animation Types**: 40+
- **Lines of Code**: ~2000+
- **Dependencies**: 5
- **Platform Support**: Android, iOS, Web, Desktop

## Contributing

Feel free to contribute to this project by:
- Adding new animation examples to the gallery
- Improving existing animations
- Adding new animation categories
- Enhancing documentation
- Reporting issues or suggesting improvements

## License

This project is open source and available under the MIT License.
