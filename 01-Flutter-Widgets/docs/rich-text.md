# Flutter - RichText Widget

## 📖 Overview

The **RichText** widget is a text widget that displays text with different styles. It allows you to create text with multiple styles, colors, and fonts within a single text widget. RichText is useful when you need to display text with varying formatting without using multiple Text widgets.

## 🎯 What is RichText?

RichText is a widget that displays text with rich formatting capabilities. It uses TextSpan objects to define different text styles within a single text block. This makes it perfect for displaying text with mixed formatting, such as bold, italic, different colors, or different font sizes.

### Key Features

- **Multiple Styles**: Different styles within a single text block
- **TextSpan Support**: Use TextSpan objects for rich formatting
- **Flexible Styling**: Support for colors, fonts, sizes, and decorations
- **Performance**: Efficient rendering of complex text
- **Accessibility**: Proper semantic support for screen readers
- **Interactive**: Support for tap gestures on text spans

## 🏗️ Basic Structure

```dart
RichText(
  text: TextSpan(
    style: TextStyle(fontSize: 16, color: Colors.black),
    children: [
      TextSpan(text: 'Normal text '),
      TextSpan(
        text: 'bold text',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ],
  ),
)
```

## 📋 Key Properties

### Essential Properties

| Property | Type | Description |
|----------|------|-------------|
| `text` | TextSpan | The text span to display |
| `textAlign` | TextAlign | How to align the text |
| `textDirection` | TextDirection | The direction of the text |
| `softWrap` | bool | Whether to wrap text at soft line breaks |
| `overflow` | TextOverflow | How to handle text overflow |

### Advanced Properties

| Property | Type | Description |
|----------|------|-------------|
| `maxLines` | int | Maximum number of lines |
| `strutStyle` | StrutStyle | The strut style for the text |
| `textWidthBasis` | TextWidthBasis | How to measure the width of the text |
| `textHeightBehavior` | TextHeightBehavior | How to handle text height |

## 🎨 Basic Usage Examples

### Simple RichText

```dart
RichText(
  text: TextSpan(
    text: 'Hello ',
    style: TextStyle(color: Colors.black),
    children: [
      TextSpan(
        text: 'World',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  ),
)
```

### RichText with Multiple Styles

```dart
RichText(
  text: TextSpan(
    style: TextStyle(fontSize: 16, color: Colors.black),
    children: [
      TextSpan(text: 'Normal text '),
      TextSpan(
        text: 'bold text',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextSpan(text: ' and '),
      TextSpan(
        text: 'italic text',
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
    ],
  ),
)
```

### RichText with Colors

```dart
RichText(
  text: TextSpan(
    children: [
      TextSpan(
        text: 'Red text ',
        style: TextStyle(color: Colors.red),
      ),
      TextSpan(
        text: 'Green text ',
        style: TextStyle(color: Colors.green),
      ),
      TextSpan(
        text: 'Blue text',
        style: TextStyle(color: Colors.blue),
      ),
    ],
  ),
)
```

## 📚 Example in Our App

In the Flutter Widgets Demo app, we use RichText as follows:

```dart
// RichText Widget demonstration
RichText(
  text: const TextSpan(
    style: TextStyle(fontSize: 16, color: Colors.black),
    children: [
      TextSpan(
        text: 'This is ',
        style: TextStyle(fontWeight: FontWeight.normal),
      ),
      TextSpan(
        text: 'bold text',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
      TextSpan(
        text: ' and this is ',
        style: TextStyle(fontWeight: FontWeight.normal),
      ),
      TextSpan(
        text: 'italic text',
        style: TextStyle(
          fontStyle: FontStyle.italic,
          color: Colors.red,
        ),
      ),
      TextSpan(
        text: ' with different styles!',
        style: TextStyle(fontWeight: FontWeight.normal),
      ),
    ],
  ),
),
```

### Breakdown of Our RichText

- **Base style**: 16px black text
- **Bold blue text**: "bold text" with bold weight and blue color
- **Italic red text**: "italic text" with italic style and red color
- **Normal text**: Regular weight for other text portions

## 🎯 Common Use Cases

### 1. Highlighted Text

```dart
RichText(
  text: TextSpan(
    style: TextStyle(fontSize: 16, color: Colors.black),
    children: [
      TextSpan(text: 'Search results for: '),
      TextSpan(
        text: '"Flutter"',
        style: TextStyle(
          backgroundColor: Colors.yellow,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  ),
)
```

### 2. Price Display

```dart
RichText(
  text: TextSpan(
    children: [
      TextSpan(
        text: 'Price: ',
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),
      TextSpan(
        text: '\$99.99',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
      TextSpan(
        text: ' (20% off)',
        style: TextStyle(
          fontSize: 12,
          color: Colors.red,
          fontStyle: FontStyle.italic,
        ),
      ),
    ],
  ),
)
```

### 3. Formatted Numbers

```dart
RichText(
  text: TextSpan(
    children: [
      TextSpan(
        text: 'Rating: ',
        style: TextStyle(fontSize: 14),
      ),
      TextSpan(
        text: '4.5',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.orange,
        ),
      ),
      TextSpan(
        text: '/5',
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),
    ],
  ),
)
```

### 4. Interactive Text

```dart
RichText(
  text: TextSpan(
    style: TextStyle(fontSize: 16, color: Colors.black),
    children: [
      TextSpan(text: 'By continuing, you agree to our '),
      TextSpan(
        text: 'Terms of Service',
        style: TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            // Handle tap on terms
          },
      ),
      TextSpan(text: ' and '),
      TextSpan(
        text: 'Privacy Policy',
        style: TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            // Handle tap on privacy policy
          },
      ),
    ],
  ),
)
```

## 💡 Best Practices

### 1. Use Appropriate Base Style

```dart
// ✅ Good: Set appropriate base style
RichText(
  text: TextSpan(
    style: TextStyle(fontSize: 16, color: Colors.black), // Base style
    children: [
      TextSpan(text: 'Normal text '),
      TextSpan(
        text: 'highlighted text',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ],
  ),
)

// ❌ Avoid: No base style
RichText(
  text: TextSpan(
    children: [
      TextSpan(
        text: 'Normal text ',
        style: TextStyle(fontSize: 16, color: Colors.black), // Repetitive
      ),
      TextSpan(
        text: 'highlighted text',
        style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold), // Repetitive
      ),
    ],
  ),
)
```

### 2. Consistent Styling

```dart
// ✅ Good: Consistent styling approach
RichText(
  text: TextSpan(
    style: TextStyle(fontSize: 16, color: Colors.black),
    children: [
      TextSpan(text: 'Regular text '),
      TextSpan(
        text: 'emphasized text',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
      ),
      TextSpan(text: ' more regular text'),
    ],
  ),
)

// ❌ Avoid: Inconsistent styling
RichText(
  text: TextSpan(
    children: [
      TextSpan(
        text: 'Regular text ',
        style: TextStyle(fontSize: 14, color: Colors.grey), // Inconsistent
      ),
      TextSpan(
        text: 'emphasized text',
        style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold), // Inconsistent
      ),
    ],
  ),
)
```

### 3. Proper Text Overflow Handling

```dart
// ✅ Good: Handle text overflow
RichText(
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
  text: TextSpan(
    style: TextStyle(fontSize: 16),
    children: [
      TextSpan(text: 'Long text that might overflow '),
      TextSpan(
        text: 'with different styles',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ],
  ),
)

// ❌ Avoid: No overflow handling
RichText(
  text: TextSpan(
    children: [
      TextSpan(text: 'Very long text that might overflow the container bounds and cause layout issues '),
      TextSpan(
        text: 'with different styles',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ],
  ),
)
```

### 4. Accessibility Support

```dart
// ✅ Good: Include semantic labels
RichText(
  text: TextSpan(
    children: [
      TextSpan(text: 'Price: '),
      TextSpan(
        text: '\$99.99',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ],
  ),
  semanticsLabel: 'Price: 99 dollars and 99 cents', // Accessibility
)
```

## 🔧 Advanced Features

### 1. RichText with Images

```dart
RichText(
  text: TextSpan(
    children: [
      WidgetSpan(
        child: Icon(Icons.star, color: Colors.yellow, size: 16),
      ),
      TextSpan(text: ' 4.5 stars'),
    ],
  ),
)
```

### 2. RichText with Custom Fonts

```dart
RichText(
  text: TextSpan(
    style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
    children: [
      TextSpan(text: 'Regular text '),
      TextSpan(
        text: 'custom font text',
        style: TextStyle(
          fontFamily: 'Pacifico',
          fontSize: 20,
          color: Colors.purple,
        ),
      ),
    ],
  ),
)
```

### 3. Animated RichText

```dart
class AnimatedRichTextExample extends StatefulWidget {
  @override
  _AnimatedRichTextExampleState createState() => _AnimatedRichTextExampleState();
}

class _AnimatedRichTextExampleState extends State<AnimatedRichTextExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _colorAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Animated ',
                style: TextStyle(fontSize: 16),
              ),
              TextSpan(
                text: 'text',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.lerp(Colors.blue, Colors.red, _colorAnimation.value),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### 4. RichText with Gesture Recognition

```dart
RichText(
  text: TextSpan(
    style: TextStyle(fontSize: 16, color: Colors.black),
    children: [
      TextSpan(text: 'Click '),
      TextSpan(
        text: 'here',
        style: TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Link tapped!')),
            );
          },
      ),
      TextSpan(text: ' to continue'),
    ],
  ),
)
```

### 5. Complex RichText Layout

```dart
RichText(
  textAlign: TextAlign.center,
  text: TextSpan(
    style: TextStyle(fontSize: 16, color: Colors.black),
    children: [
      TextSpan(
        text: 'Welcome to\n',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      TextSpan(
        text: 'Our App',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
          letterSpacing: 2.0,
        ),
      ),
      TextSpan(
        text: '\n\nExperience the best features',
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey,
          fontStyle: FontStyle.italic,
        ),
      ),
    ],
  ),
)
```

## 🎯 Key Takeaways

1. **Multiple Styles**: Use RichText for text with varying styles
2. **TextSpan Structure**: Organize text using TextSpan objects
3. **Base Style**: Set a base style to avoid repetition
4. **Performance**: Efficient for complex text formatting
5. **Accessibility**: Include proper semantic labels

## 📖 Further Reading

- [RichText API Documentation](https://api.flutter.dev/flutter/widgets/RichText-class.html)
- [TextSpan API Documentation](https://api.flutter.dev/flutter/painting/TextSpan-class.html)
- [Flutter Text Tutorial](https://docs.flutter.dev/ui/text)
- [Flutter Accessibility](https://docs.flutter.dev/ui/accessibility)

---

**Previous**: [ClipRRect Widget](clip-rrect.md) | **Next**: [ListView Class](list-view.md)
