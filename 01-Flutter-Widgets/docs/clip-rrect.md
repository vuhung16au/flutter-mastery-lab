# ClipRRect Widget in Flutter

## 📖 Overview

The **ClipRRect** widget is a widget that clips its child using a rounded rectangle. It's commonly used to create rounded corners on widgets that don't naturally support them, such as images, containers, or any other widget that needs rounded corner clipping.

## 🎯 What is ClipRRect?

ClipRRect is a widget that applies a rounded rectangle clip to its child. It's useful when you want to create rounded corners on widgets that don't have built-in border radius support, or when you need more control over the clipping behavior.

### Key Features

- **Rounded Corners**: Creates rounded corners on any widget
- **Customizable Radius**: Control the roundness of corners
- **Clipping Control**: Clips content that extends beyond the rounded bounds
- **Performance**: Efficient clipping implementation
- **Flexible**: Works with any child widget
- **Visual Effects**: Creates modern, polished UI elements

## 🏗️ Basic Structure

```dart
ClipRRect(
  borderRadius: BorderRadius.circular(12),
  child: Container(
    color: Colors.blue,
    child: Text('Rounded Container'),
  ),
)
```

## 📋 Key Properties

### Essential Properties

| Property | Type | Description |
|----------|------|-------------|
| `borderRadius` | BorderRadius | The radius for the rounded corners |
| `child` | Widget | The widget to be clipped |
| `clipBehavior` | Clip | How to handle clipping |

### Advanced Properties

| Property | Type | Description |
|----------|------|-------------|
| `clipper` | CustomClipper<RRect> | Custom clipper for complex shapes |

## 🎨 Basic Usage Examples

### Simple Rounded Container

```dart
ClipRRect(
  borderRadius: BorderRadius.circular(12),
  child: Container(
    color: Colors.blue,
    child: Text('Rounded Container'),
  ),
)
```

### Rounded Image

```dart
ClipRRect(
  borderRadius: BorderRadius.circular(20),
  child: Image.network(
    'https://example.com/image.jpg',
    width: 200,
    height: 200,
    fit: BoxFit.cover,
  ),
)
```

### Rounded Button

```dart
ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: ElevatedButton(
    onPressed: () {},
    child: Text('Rounded Button'),
  ),
)
```

## 📚 Example in Our App

In the Flutter Widgets Demo app, we use ClipRRect as follows:

```dart
// ClipRRect Widget demonstration
ClipRRect(
  borderRadius: BorderRadius.circular(20),
  child: Container(
    width: double.infinity,
    height: 80,
    color: Colors.purple.shade100,
    child: const Center(
      child: Text(
        'Rounded corners with ClipRRect',
        style: TextStyle(fontSize: 16),
      ),
    ),
  ),
),
```

### Breakdown of Our ClipRRect

- **borderRadius**: Creates 20-pixel rounded corners
- **child**: A purple container with text
- **effect**: The container has rounded corners instead of sharp edges

## 🎯 Common Use Cases

### 1. Rounded Profile Images

```dart
ClipRRect(
  borderRadius: BorderRadius.circular(50), // Perfect circle
  child: Image.network(
    'https://example.com/profile.jpg',
    width: 100,
    height: 100,
    fit: BoxFit.cover,
  ),
)
```

### 2. Rounded Cards

```dart
ClipRRect(
  borderRadius: BorderRadius.circular(12),
  child: Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 3,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        Text('Card Title', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Card content goes here...'),
      ],
    ),
  ),
)
```

### 3. Rounded Buttons

```dart
ClipRRect(
  borderRadius: BorderRadius.circular(25),
  child: Container(
    width: 200,
    height: 50,
    color: Colors.blue,
    child: Center(
      child: Text(
        'Rounded Button',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  ),
)
```

### 4. Rounded Video Thumbnails

```dart
ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: Stack(
    children: [
      Image.network(
        'https://example.com/video-thumbnail.jpg',
        width: 300,
        height: 200,
        fit: BoxFit.cover,
      ),
      Positioned(
        bottom: 8,
        right: 8,
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '3:45',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    ],
  ),
)
```

## 💡 Best Practices

### 1. Use Appropriate Border Radius

```dart
// ✅ Good: Appropriate radius for the context
ClipRRect(
  borderRadius: BorderRadius.circular(8), // Subtle rounding
  child: Container(color: Colors.blue),
)

// ❌ Avoid: Too much or too little rounding
ClipRRect(
  borderRadius: BorderRadius.circular(50), // Too much for a card
  child: Container(color: Colors.blue),
)
```

### 2. Consider Performance

```dart
// ✅ Good: Use ClipRRect only when needed
ClipRRect(
  borderRadius: BorderRadius.circular(12),
  child: Image.network('https://example.com/image.jpg'), // Image needs clipping
)

// ❌ Avoid: Unnecessary clipping
ClipRRect(
  borderRadius: BorderRadius.circular(12),
  child: Text('Text doesn\'t need clipping'), // Text doesn't need clipping
)
```

### 3. Consistent Border Radius

```dart
// ✅ Good: Consistent radius throughout app
class AppConstants {
  static const double cardRadius = 12.0;
  static const double buttonRadius = 8.0;
  static const double imageRadius = 20.0;
}

ClipRRect(
  borderRadius: BorderRadius.circular(AppConstants.cardRadius),
  child: Container(color: Colors.blue),
)

// ❌ Avoid: Inconsistent radius values
ClipRRect(
  borderRadius: BorderRadius.circular(15), // Inconsistent
  child: Container(color: Colors.blue),
)
```

### 4. Handle Overflow Properly

```dart
// ✅ Good: Handle content that might overflow
ClipRRect(
  borderRadius: BorderRadius.circular(12),
  child: Container(
    width: 200,
    height: 100,
    child: Text(
      'Long text that might overflow the container bounds',
      overflow: TextOverflow.ellipsis,
    ),
  ),
)

// ❌ Avoid: Content overflowing without clipping
Container(
  width: 200,
  height: 100,
  child: Text('Long text that might overflow'), // No clipping
)
```

## 🔧 Advanced Features

### 1. Custom Border Radius

```dart
ClipRRect(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
    bottomLeft: Radius.circular(8),
    bottomRight: Radius.circular(8),
  ),
  child: Container(
    color: Colors.blue,
    height: 100,
    child: Center(child: Text('Custom Radius')),
  ),
)
```

### 2. Different Radius for Each Corner

```dart
ClipRRect(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(30),
    topRight: Radius.circular(10),
    bottomLeft: Radius.circular(10),
    bottomRight: Radius.circular(30),
  ),
  child: Container(
    color: Colors.green,
    height: 100,
    child: Center(child: Text('Asymmetric Radius')),
  ),
)
```

### 3. ClipRRect with Gradient

```dart
ClipRRect(
  borderRadius: BorderRadius.circular(16),
  child: Container(
    width: 200,
    height: 100,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue, Colors.purple],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Center(
      child: Text(
        'Gradient with Rounded Corners',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  ),
)
```

### 4. Animated ClipRRect

```dart
class AnimatedClipRRectExample extends StatefulWidget {
  @override
  _AnimatedClipRRectExampleState createState() => _AnimatedClipRRectExampleState();
}

class _AnimatedClipRRectExampleState extends State<AnimatedClipRRectExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _radiusAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _radiusAnimation = Tween<double>(
      begin: 0.0,
      end: 30.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _radiusAnimation,
          builder: (context, child) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(_radiusAnimation.value),
              child: Container(
                width: 200,
                height: 100,
                color: Colors.orange,
                child: Center(child: Text('Animated Radius')),
              ),
            );
          },
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            if (_controller.status == AnimationStatus.completed) {
              _controller.reverse();
            } else {
              _controller.forward();
            }
          },
          child: Text('Animate Radius'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### 5. Custom Clipper

```dart
class CustomRRectClipper extends CustomClipper<RRect> {
  final double radius;

  CustomRRectClipper(this.radius);

  @override
  RRect getClip(Size size) {
    return RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );
  }

  @override
  bool shouldReclip(CustomClipper<RRect> oldClipper) {
    return oldClipper is CustomRRectClipper && oldClipper.radius != radius;
  }
}

// Usage
ClipRRect(
  clipper: CustomRRectClipper(20),
  child: Container(
    color: Colors.red,
    height: 100,
    child: Center(child: Text('Custom Clipper')),
  ),
)
```

## 🎯 Key Takeaways

1. **Rounded Corners**: Use ClipRRect to create rounded corners on any widget
2. **Performance**: Only use when necessary, as clipping has performance cost
3. **Consistency**: Maintain consistent border radius throughout your app
4. **Flexibility**: Works with any child widget that needs rounded corners
5. **Customization**: Supports custom clippers for complex shapes

## 📖 Further Reading

- [ClipRRect API Documentation](https://api.flutter.dev/flutter/widgets/ClipRRect-class.html)
- [CustomClipper API Documentation](https://api.flutter.dev/flutter/rendering/CustomClipper-class.html)
- [Flutter Layout Tutorial](https://docs.flutter.dev/ui/layout)
- [Flutter Performance Best Practices](https://docs.flutter.dev/perf/best-practices)

---

**Previous**: [SizedBox Widget](sized-box.md) | **Next**: [RichText Widget](rich-text.md)
