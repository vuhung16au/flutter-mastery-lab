# Flutter – Stateful vs Stateless Widgets

## 📖 Overview

Flutter widgets can be categorized into two main types: **StatelessWidget** and **StatefulWidget**. Understanding the difference between these two types is crucial for building efficient and maintainable Flutter applications.

## 🎯 Key Differences

| Aspect | StatelessWidget | StatefulWidget |
|--------|----------------|----------------|
| **State** | Immutable, no internal state | Mutable, can change state |
| **Rebuild** | Never rebuilds itself | Rebuilds when state changes |
| **Performance** | More efficient | Slightly less efficient |
| **Use Case** | Static content | Dynamic content |
| **Lifecycle** | Simple (create → build → dispose) | Complex (multiple lifecycle methods) |

## 📋 StatelessWidget

### What is a StatelessWidget?

A **StatelessWidget** is a widget that describes part of the user interface which can depend on configuration information in the object itself and on the widget's location in the widget tree. StatelessWidgets are **immutable** and **never change**.

### Characteristics

- ✅ **Immutable**: Once created, cannot be modified
- ✅ **Lightweight**: Minimal memory footprint
- ✅ **Efficient**: No state management overhead
- ✅ **Simple**: Easy to understand and test
- ❌ **Static**: Cannot respond to user interactions that change state

### When to Use StatelessWidget

- Displaying static text or images
- Showing data that doesn't change
- UI components that don't need to remember state
- Reusable UI components
- Performance-critical widgets

### Example

```dart
class WelcomeMessage extends StatelessWidget {
  final String userName;
  
  const WelcomeMessage({
    super.key,
    required this.userName,
  });
  
  @override
  Widget build(BuildContext context) {
    return Text(
      'Welcome, $userName!',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }
}
```

### Usage in Our App

```dart
// BasicWidgetsPage is a StatelessWidget
class BasicWidgetsPage extends StatelessWidget {
  const BasicWidgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text('Basic Widgets'),
          // ... other widgets
        ],
      ),
    );
  }
}
```

## 🔄 StatefulWidget

### What is a StatefulWidget?

A **StatefulWidget** is a widget that can change its state over time. It maintains state that can change during the widget's lifetime, and it can rebuild itself when the state changes.

### Characteristics

- ✅ **Mutable**: Can change its state
- ✅ **Interactive**: Can respond to user input
- ✅ **Dynamic**: Can update UI based on state changes
- ✅ **Complex**: Can handle complex state logic
- ❌ **Heavier**: More memory and performance overhead
- ❌ **Complex**: More complex lifecycle management

### When to Use StatefulWidget

- Forms with user input
- Animations
- Real-time data updates
- Interactive UI components
- Widgets that need to remember state

### Example

```dart
class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  void _decrement() {
    setState(() {
      _count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Count: $_count',
          style: TextStyle(fontSize: 24),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _decrement,
              child: Text('-'),
            ),
            SizedBox(width: 20),
            ElevatedButton(
              onPressed: _increment,
              child: Text('+'),
            ),
          ],
        ),
      ],
    );
  }
}
```

### Usage in Our App

```dart
// HomePage is a StatefulWidget because it manages navigation state
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // State that changes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // State change triggers rebuild
          });
        },
        // ... navigation items
      ),
    );
  }
}
```

## 🔧 StatefulWidget Lifecycle

### Lifecycle Methods

```dart
class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  // 1. Constructor (implicit)
  
  // 2. initState - Called once when widget is created
  @override
  void initState() {
    super.initState();
    // Initialize variables, start animations, etc.
  }
  
  // 3. didChangeDependencies - Called when dependencies change
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Access inherited widgets, update based on theme, etc.
  }
  
  // 4. build - Called to build the widget (can be called multiple times)
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  
  // 5. didUpdateWidget - Called when parent widget changes
  @override
  void didUpdateWidget(MyStatefulWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Handle updates from parent widget
  }
  
  // 6. setState - Called to trigger rebuild (can be called multiple times)
  void _updateState() {
    setState(() {
      // Update state variables
    });
  }
  
  // 7. deactivate - Called when widget is removed from tree
  @override
  void deactivate() {
    super.deactivate();
    // Clean up resources, cancel subscriptions, etc.
  }
  
  // 8. dispose - Called when widget is permanently removed
  @override
  void dispose() {
    super.dispose();
    // Final cleanup
  }
}
```

### Lifecycle Flow

```
Widget Creation
     ↓
Constructor
     ↓
createState()
     ↓
initState() ← Called once
     ↓
didChangeDependencies() ← Called when dependencies change
     ↓
build() ← Called to build UI
     ↓
[User Interaction / setState()]
     ↓
build() ← Called again (rebuild)
     ↓
didUpdateWidget() ← Called when parent changes
     ↓
build() ← Called again
     ↓
deactivate() ← Called when removed from tree
     ↓
dispose() ← Called for final cleanup
```

## 💡 Best Practices

### 1. Choose the Right Widget Type

```dart
// ✅ Good: Use StatelessWidget for static content
class StaticText extends StatelessWidget {
  final String text;
  
  const StaticText({super.key, required this.text});
  
  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}

// ✅ Good: Use StatefulWidget for interactive content
class InteractiveButton extends StatefulWidget {
  @override
  _InteractiveButtonState createState() => _InteractiveButtonState();
}

class _InteractiveButtonState extends State<InteractiveButton> {
  bool _isPressed = false;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      child: Container(
        color: _isPressed ? Colors.grey : Colors.blue,
        child: Text('Press Me'),
      ),
    );
  }
}
```

### 2. Minimize StatefulWidget Usage

```dart
// ❌ Avoid: Unnecessary StatefulWidget
class UnnecessaryStateful extends StatefulWidget {
  @override
  _UnnecessaryStatefulState createState() => _UnnecessaryStatefulState();
}

class _UnnecessaryStatefulState extends State<UnnecessaryStateful> {
  @override
  Widget build(BuildContext context) {
    return Text('Static text'); // No state needed!
  }
}

// ✅ Better: Use StatelessWidget
class BetterStateless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Static text');
  }
}
```

### 3. Proper State Management

```dart
// ✅ Good: Local state management
class LocalStateExample extends StatefulWidget {
  @override
  _LocalStateExampleState createState() => _LocalStateExampleState();
}

class _LocalStateExampleState extends State<LocalStateExample> {
  String _inputText = '';
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) {
            setState(() {
              _inputText = value;
            });
          },
        ),
        Text('You typed: $_inputText'),
      ],
    );
  }
}
```

### 4. Efficient setState Usage

```dart
// ✅ Good: Batch state changes
void _updateMultipleValues() {
  setState(() {
    _value1 = newValue1;
    _value2 = newValue2;
    _value3 = newValue3;
  });
}

// ❌ Avoid: Multiple setState calls
void _updateMultipleValues() {
  setState(() => _value1 = newValue1);
  setState(() => _value2 = newValue2);
  setState(() => _value3 = newValue3);
}
```

## 🎯 Performance Considerations

### StatelessWidget Performance
- **Faster**: No state management overhead
- **Less Memory**: No state object to maintain
- **Efficient Rebuilds**: Only rebuilds when parent changes

### StatefulWidget Performance
- **Slower**: State management overhead
- **More Memory**: State object maintained
- **Controlled Rebuilds**: Only rebuilds when setState is called

## 📚 Examples in Our App

### StatelessWidget Examples

```dart
// BasicWidgetsPage - Static content display
class BasicWidgetsPage extends StatelessWidget {
  const BasicWidgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text('Basic Widgets'),
          Container(/* ... */),
          SizedBox(/* ... */),
          ClipRRect(/* ... */),
          RichText(/* ... */),
        ],
      ),
    );
  }
}
```

### StatefulWidget Examples

```dart
// HomePage - Manages navigation state
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Navigation state
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}

// InputWidgetsPage - Manages form state
class InputWidgetsPage extends StatefulWidget {
  @override
  _InputWidgetsPageState createState() => _InputWidgetsPageState();
}

class _InputWidgetsPageState extends State<InputWidgetsPage> {
  final TextEditingController _nameController = TextEditingController();
  bool _obscurePassword = true; // Password visibility state
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(controller: _nameController),
        TextField(
          obscureText: _obscurePassword,
          suffixIcon: IconButton(
            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
          ),
        ),
      ],
    );
  }
}
```

## 🎯 Key Takeaways

1. **Choose Wisely**: Use StatelessWidget by default, StatefulWidget when needed
2. **Performance Matters**: StatelessWidgets are more efficient
3. **State Management**: Only use state when necessary
4. **Lifecycle Awareness**: Understand when each lifecycle method is called
5. **Best Practices**: Follow patterns for efficient widget usage

## 📖 Further Reading

- [Flutter Widget Lifecycle](https://docs.flutter.dev/development/ui/widgets-intro)
- [StatefulWidget API](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html)
- [StatelessWidget API](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html)
- [Flutter Performance Best Practices](https://docs.flutter.dev/perf/best-practices)

---

**Previous**: [Flutter Widgets](widgets.md) | **Next**: [MaterialApp Class](material-app.md)
