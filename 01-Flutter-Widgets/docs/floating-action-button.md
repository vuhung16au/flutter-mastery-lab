# Flutter – FloatingActionButton

## 📖 Overview

The **FloatingActionButton** (FAB) is a Material Design widget that displays a circular floating button that hovers over the content. It's typically used for the primary action in an application, such as adding a new item or creating content.

## 🎯 What is FloatingActionButton?

FloatingActionButton is a circular button that floats above the content, typically positioned in the bottom-right corner of the screen. It's designed to promote the most common or important action in an application.

### Key Features

- **Floating Design**: Hovers above the content
- **Circular Shape**: Material Design circular button
- **Primary Action**: Promotes the most important action
- **Contextual**: Can change based on the current screen
- **Accessible**: Supports accessibility features
- **Responsive**: Adapts to different screen sizes

## 🏗️ Basic Structure

```dart
FloatingActionButton(
  onPressed: () {
    // Handle button press
  },
  child: Icon(Icons.add),
)
```

## 📋 Key Properties

### Essential Properties

| Property | Type | Description |
|----------|------|-------------|
| `onPressed` | VoidCallback | Callback when button is pressed |
| `child` | Widget | The widget to display inside the button |
| `backgroundColor` | Color | Background color of the button |
| `foregroundColor` | Color | Color of the child widget |
| `elevation` | double | Elevation/shadow of the button |

### Advanced Properties

| Property | Type | Description |
|----------|------|-------------|
| `tooltip` | String | Tooltip text for accessibility |
| `heroTag` | Object | Tag for hero animation |
| `mini` | bool | Whether to use mini size |
| `shape` | ShapeBorder | Custom shape for the button |
| `clipBehavior` | Clip | How to clip the button |

## 🎨 Basic Usage Examples

### Simple FloatingActionButton

```dart
FloatingActionButton(
  onPressed: () {
    print('FAB pressed!');
  },
  child: Icon(Icons.add),
)
```

### FloatingActionButton with Custom Colors

```dart
FloatingActionButton(
  onPressed: () {},
  backgroundColor: Colors.blue,
  foregroundColor: Colors.white,
  child: Icon(Icons.add),
)
```

### FloatingActionButton with Text

```dart
FloatingActionButton(
  onPressed: () {},
  child: Text('+'),
)
```

## 📚 Example in Our App

In the Flutter Widgets Demo app, we use FloatingActionButton as follows:

```dart
floatingActionButton: FloatingActionButton(
  onPressed: () {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Floating Action Button pressed!')),
    );
  },
  backgroundColor: Colors.blue,
  foregroundColor: Colors.white,
  child: const Icon(Icons.add),
),
```

### Breakdown of Our FAB

- **onPressed**: Shows a SnackBar when pressed
- **backgroundColor**: Blue background color
- **foregroundColor**: White icon color
- **child**: Plus icon (Icons.add)

## 🎯 Common Use Cases

### 1. Add New Item

```dart
FloatingActionButton(
  onPressed: () {
    // Navigate to add item screen
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => AddItemScreen(),
    ));
  },
  child: Icon(Icons.add),
  tooltip: 'Add new item',
)
```

### 2. Create New Document

```dart
FloatingActionButton(
  onPressed: () {
    // Create new document
    _createNewDocument();
  },
  child: Icon(Icons.create),
  tooltip: 'Create new document',
)
```

### 3. Send Message

```dart
FloatingActionButton(
  onPressed: () {
    // Open message composer
    _openMessageComposer();
  },
  child: Icon(Icons.send),
  tooltip: 'Send message',
)
```

### 4. Take Photo

```dart
FloatingActionButton(
  onPressed: () {
    // Open camera
    _openCamera();
  },
  child: Icon(Icons.camera_alt),
  tooltip: 'Take photo',
)
```

## 💡 Best Practices

### 1. Single Primary Action

```dart
// ✅ Good: Single, clear primary action
FloatingActionButton(
  onPressed: () => _addNewItem(),
  child: Icon(Icons.add),
  tooltip: 'Add new item',
)

// ❌ Avoid: Multiple actions or unclear purpose
FloatingActionButton(
  onPressed: () => _showOptionsDialog(), // Too generic
  child: Icon(Icons.more_vert),
)
```

### 2. Contextual Actions

```dart
// ✅ Good: Contextual to current screen
class EmailListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(...),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _composeEmail(),
        child: Icon(Icons.edit),
        tooltip: 'Compose email',
      ),
    );
  }
}
```

### 3. Proper Icon Usage

```dart
// ✅ Good: Clear, recognizable icon
FloatingActionButton(
  onPressed: () {},
  child: Icon(Icons.add), // Universal add icon
)

// ❌ Avoid: Unclear or custom icons
FloatingActionButton(
  onPressed: () {},
  child: Icon(Icons.star), // Not clear what this does
)
```

### 4. Accessibility Support

```dart
// ✅ Good: Include tooltip for accessibility
FloatingActionButton(
  onPressed: () {},
  child: Icon(Icons.add),
  tooltip: 'Add new item', // Helps screen readers
)
```

## 🔧 Advanced Features

### 1. Mini FloatingActionButton

```dart
FloatingActionButton(
  onPressed: () {},
  mini: true, // Smaller size
  child: Icon(Icons.add),
)
```

### 2. Custom Shape

```dart
FloatingActionButton(
  onPressed: () {},
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  child: Icon(Icons.add),
)
```

### 3. Extended FloatingActionButton

```dart
FloatingActionButton.extended(
  onPressed: () {},
  icon: Icon(Icons.add),
  label: Text('Add Item'),
)
```

### 4. Animated FloatingActionButton

```dart
class AnimatedFAB extends StatefulWidget {
  @override
  _AnimatedFABState createState() => _AnimatedFABState();
}

class _AnimatedFABState extends State<AnimatedFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FloatingActionButton(
        onPressed: () {
          _controller.forward().then((_) => _controller.reverse());
          // Handle action
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### 5. Multiple FloatingActionButtons

```dart
Scaffold(
  body: Content(),
  floatingActionButton: Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      FloatingActionButton(
        onPressed: () {},
        mini: true,
        child: Icon(Icons.edit),
      ),
      SizedBox(height: 16),
      FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    ],
  ),
)
```

## 🎯 Key Takeaways

1. **Primary Action**: Use for the most important action on the screen
2. **Contextual**: Should be relevant to the current screen content
3. **Accessible**: Include tooltips and proper labeling
4. **Consistent**: Use consistent icons and behavior across the app
5. **Responsive**: Consider different screen sizes and orientations

## 📖 Further Reading

- [FloatingActionButton API Documentation](https://api.flutter.dev/flutter/material/FloatingActionButton-class.html)
- [Material Design FAB Guidelines](https://material.io/design/components/floating-action-button.html)
- [Flutter Accessibility](https://docs.flutter.dev/ui/accessibility)
- [Flutter Animation Tutorial](https://docs.flutter.dev/ui/animations)

---

**Previous**: [AppBar Widget](app-bar.md) | **Next**: [BottomNavigationBar](bottom-navigation-bar.md)
