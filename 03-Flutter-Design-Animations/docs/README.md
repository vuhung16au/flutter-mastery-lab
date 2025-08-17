# Flutter Design & Animations

A comprehensive showcase of Flutter's design and animation capabilities, demonstrating various techniques for creating beautiful and engaging user interfaces.

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
assets/
├── animations/              # Animation files (Lottie, Rive)
├── images/                  # Image assets
└── fonts/                   # Custom font files
docs/
├── README.md               # This file
├── animations.md           # Animation documentation
└── customizing-fonts.md    # Font customization guide
```

## Usage Examples

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

## Contributing

Feel free to contribute to this project by adding new animation examples or improving existing ones.

## License

This project is open source and available under the MIT License.
