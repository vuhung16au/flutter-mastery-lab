# Animation Assets

This directory is for storing animation files used in the Flutter Design & Animations project.

## Supported Animation Formats

### Lottie Animations
- **Format**: JSON files
- **Usage**: Use with the `lottie` package
- **Example**: `animation.json`

### Rive Animations
- **Format**: RIV files
- **Usage**: Use with the `rive` package
- **Example**: `animation.riv`

## Adding Animation Files

1. Place your animation files in this directory
2. Update the `pubspec.yaml` to include the assets:
   ```yaml
   flutter:
     assets:
       - assets/animations/
   ```

## Usage in Code

### Lottie Animation
```dart
Lottie.asset(
  'assets/animations/animation.json',
  width: 200,
  height: 200,
)
```

### Rive Animation
```dart
RiveAnimation.asset(
  'assets/animations/animation.riv',
  width: 200,
  height: 200,
)
```

## Free Animation Resources

- **LottieFiles**: https://lottiefiles.com/
- **Rive**: https://rive.app/
- **IconScout**: https://iconscout.com/

## Notes

- Keep animation files optimized for mobile performance
- Consider file size and loading times
- Test animations on different devices
