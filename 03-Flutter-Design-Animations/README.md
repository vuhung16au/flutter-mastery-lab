# Flutter Design & Animations

A comprehensive showcase of Flutter's design and animation capabilities, demonstrating various techniques for creating beautiful and engaging user interfaces.

## 🎨 Features

This project demonstrates **17 different design and animation components**:

### Design Components
1. **Customizing Fonts in Flutter** - Google Fonts integration with multiple font families
2. **Flutter Themes** - Material 3 design system with light/dark theme support
3. **Auto Size Text** - Responsive text that adapts to container size
4. **Skeleton Text & Shimmer** - Loading state animations with shimmer effects
5. **Using Google Fonts** - Typography customization and font management

### Animation Components
6. **Animation in Route Transition** - Custom page transitions with slide animations
7. **Ripple Effect** - Interactive touch feedback animations
8. **Lazy Loader** - Loading indicators and progress animations
9. **Radial Hero Animation** - Scale and transform animations with radial effects
10. **Hinge Animation** - Rotation-based animations simulating hinge movement
11. **Lottie Animation** - Integration with Lottie files for complex animations
12. **Progress Indicator** - Linear and circular progress bars with animations
13. **Physics Simulation** - Gravity and physics-based animations
14. **Rotate Transition** - Smooth rotation animations and transitions
15. **Animated Splash Screen** - App launch animations with fade and scale effects
16. **Shimmer** - Loading state effects and content placeholder animations
17. **Rive Animations** - Advanced vector animations and interactive sequences (placeholder - requires rive package)

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd 03-Flutter-Design-Animations
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

## 📱 App Structure

### Main Components

- **AnimatedSplashScreen**: App launch with fade and scale animations
- **DesignAnimationsHome**: Main screen with all animation demonstrations
- **DetailPage**: Example page for route transition animations

### Animation Controllers

The app uses multiple `AnimationController`s for different effects:
- `_rippleController` - Ripple effect animations
- `_hingeController` - Hinge-style rotations
- `_rotateController` - Rotation transitions
- `_radialController` - Radial hero animations
- `_physicsController` - Physics-based movements
- `_skeletonController` - Skeleton loading effects

## 🛠 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  
  # Animation and Design packages
  google_fonts: ^6.1.0
  auto_size_text: ^3.0.0
  shimmer: ^3.0.0
  lottie: ^3.1.2
  flutter_staggered_animations: ^1.1.1
  animated_text_kit: ^4.2.2
  flutter_animate: ^4.5.0
```

## 📁 Project Structure

```
03-Flutter-Design-Animations/
├── lib/
│   └── main.dart                 # Main application entry point
├── assets/
│   ├── animations/              # Animation files (Lottie, Rive)
│   ├── images/                  # Image assets
│   └── fonts/                   # Custom font files
├── docs/
│   ├── README.md               # Main documentation
│   ├── animations.md           # Animation guide
│   └── customizing-fonts.md    # Font customization guide
├── test/
│   └── widget_test.dart        # Unit tests
└── pubspec.yaml                # Dependencies and configuration
```

## 🎯 Key Features Demonstrated

### Typography System
- Multiple Google Fonts (Poppins, Roboto, Open Sans, Lato)
- Responsive text sizing with AutoSizeText
- Theme-aware typography
- Custom font integration

### Animation System
- **Staggered Animations**: Coordinated entrance animations
- **Custom Transitions**: Page route animations
- **Interactive Animations**: Touch-based effects
- **Loading States**: Skeleton and shimmer effects
- **Progress Indicators**: Animated progress bars

### Theme System
- Material 3 design system
- Light and dark theme support
- Custom color schemes
- Theme-aware components

## 🔧 Usage Examples

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

## 🎨 Animation Best Practices

1. **Performance**: Use `AnimatedBuilder` for complex animations
2. **Duration**: Keep animations short (300-1000ms) for better UX
3. **Curves**: Use meaningful curves that match the animation purpose
4. **Accessibility**: Provide fallbacks for users who prefer reduced motion
5. **Testing**: Test animations on different devices and screen sizes

## 📚 Documentation

- **[Animations Guide](docs/animations.md)** - Detailed animation techniques and examples
- **[Font Customization](docs/customizing-fonts.md)** - Typography and font management
- **[Main Documentation](docs/README.md)** - Comprehensive project overview

## 🤝 Contributing

Feel free to contribute to this project by:
- Adding new animation examples
- Improving existing animations
- Enhancing documentation
- Reporting bugs or issues

## 📄 License

This project is open source and available under the MIT License.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Package authors for the excellent animation libraries
- Google Fonts for the beautiful typography
- LottieFiles and Rive for animation resources

---

**Happy Animating! 🎉**
