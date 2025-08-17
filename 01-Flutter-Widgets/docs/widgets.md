# Flutter - Widgets

## 📖 Overview

Widgets are the fundamental building blocks of Flutter applications. Everything in Flutter is a widget - from simple text and buttons to complex layouts and animations. Widgets describe what their view should look like given their current configuration and state.

## 🎯 What are Widgets?

Widgets are **immutable descriptions** of part of a user interface. They are lightweight objects that are created and destroyed frequently. Widgets form a hierarchy based on composition, where each widget nests inside its parent and can receive context from its parent.

### Key Characteristics

- **Immutable**: Once created, widgets cannot be changed
- **Lightweight**: Designed to be created and destroyed frequently
- **Composable**: Can be combined to create complex UIs
- **Declarative**: Describe what the UI should look like, not how to build it

## 🏗️ Widget Hierarchy

Flutter uses a **widget tree** to represent the UI:

```
MaterialApp
└── Scaffold
    ├── AppBar
    ├── Body
    │   └── Column
    │       ├── Text
    │       ├── Container
    │       └── ElevatedButton
    └── FloatingActionButton
```

## 📋 Types of Widgets

### 1. Stateless Widgets
Widgets that don't change over time.

```dart
class MyText extends StatelessWidget {
  final String text;
  
  const MyText({super.key, required this.text});
  
  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
```

### 2. Stateful Widgets
Widgets that can change their state over time.

```dart
class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Count: $count'),
        ElevatedButton(
          onPressed: () => setState(() => count++),
          child: Text('Increment'),
        ),
      ],
    );
  }
}
```

### 3. Inherited Widgets
Widgets that pass data down the widget tree.

```dart
class ThemeData extends InheritedWidget {
  final Color primaryColor;
  
  const ThemeData({
    super.key,
    required this.primaryColor,
    required super.child,
  });
  
  static ThemeData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeData>()!;
  }
  
  @override
  bool updateShouldNotify(ThemeData oldWidget) {
    return primaryColor != oldWidget.primaryColor;
  }
}
```

## 🎨 Widget Categories

### Layout Widgets
- **Row/Column**: Linear layouts
- **Stack**: Overlapping layouts
- **Container**: Versatile layout widget
- **Padding**: Adds padding around child
- **Center**: Centers child widget

### Input Widgets
- **TextField**: Text input
- **ElevatedButton**: Material button
- **Checkbox**: Boolean selection
- **Switch**: Toggle switch
- **Slider**: Range selection

### Display Widgets
- **Text**: Text display
- **Image**: Image display
- **Icon**: Icon display
- **RichText**: Multi-style text
- **Container**: Styled container

### Navigation Widgets
- **AppBar**: Top app bar
- **Drawer**: Side navigation
- **BottomNavigationBar**: Bottom navigation
- **TabBar**: Tab navigation

## 🔧 Widget Lifecycle

### Stateless Widget Lifecycle
1. **Constructor**: Widget is created
2. **build()**: Widget builds its UI
3. **Dispose**: Widget is destroyed

### Stateful Widget Lifecycle
1. **Constructor**: Widget is created
2. **createState()**: State object is created
3. **initState()**: State is initialized
4. **build()**: Widget builds its UI
5. **setState()**: Triggers rebuild (can happen multiple times)
6. **dispose()**: State is cleaned up

## 💡 Best Practices

### 1. Widget Composition
```dart
// Good: Compose widgets
Widget build(BuildContext context) {
  return Column(
    children: [
      HeaderWidget(),
      ContentWidget(),
      FooterWidget(),
    ],
  );
}

// Avoid: Large monolithic widgets
Widget build(BuildContext context) {
  return Column(
    children: [
      // 100+ lines of widget code
    ],
  );
}
```

### 2. Const Constructors
```dart
// Good: Use const for immutable widgets
const Text('Hello World');

// Avoid: Creating new instances unnecessarily
Text('Hello World'); // Creates new instance each time
```

### 3. Key Usage
```dart
// Good: Use keys for dynamic lists
ListView.builder(
  itemBuilder: (context, index) => ListTile(
    key: ValueKey(items[index].id),
    title: Text(items[index].title),
  ),
);
```

### 4. Widget Extraction
```dart
// Good: Extract reusable widgets
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
```

## 🎯 Common Widget Patterns

### 1. Conditional Rendering
```dart
Widget build(BuildContext context) {
  return Column(
    children: [
      if (isVisible) Text('Visible Text'),
      if (hasError) 
        Text('Error Message', style: TextStyle(color: Colors.red)),
    ],
  );
}
```

### 2. List Generation
```dart
Widget build(BuildContext context) {
  return Column(
    children: [
      for (int i = 0; i < 5; i++) 
        Text('Item $i'),
    ],
  );
}
```

### 3. Widget Spreading
```dart
Widget build(BuildContext context) {
  final widgets = [
    Text('First'),
    Text('Second'),
    Text('Third'),
  ];
  
  return Column(
    children: [
      ...widgets,
      Text('Additional'),
    ],
  );
}
```

## 🔍 Widget Inspector

Flutter provides a **Widget Inspector** for debugging:

1. **Hot Reload**: `r` in terminal
2. **Hot Restart**: `R` in terminal
3. **Widget Inspector**: Available in Flutter DevTools
4. **Debug Paint**: Shows widget boundaries

## 📚 Example in Our App

In the Flutter Widgets Demo app, we use various widgets:

```dart
// Main app structure
MaterialApp(
  title: 'Flutter Widgets Demo',
  theme: ThemeData(primarySwatch: Colors.blue),
  home: HomePage(), // Scaffold widget
)

// Home page with multiple widgets
Scaffold(
  appBar: AppBar(title: Text('Flutter Widgets Demo')),
  body: _pages[_currentIndex], // Different widget pages
  drawer: Drawer(child: ListView(...)),
  floatingActionButton: FloatingActionButton(...),
  bottomNavigationBar: BottomNavigationBar(...),
)
```

## 🎯 Key Takeaways

1. **Everything is a Widget**: UI, layout, and even the app itself
2. **Widgets are Immutable**: Create new instances instead of modifying
3. **Composition over Inheritance**: Build complex UIs by combining simple widgets
4. **Performance Matters**: Use const constructors and efficient rebuilds
5. **State Management**: Choose between Stateless and Stateful appropriately

## 📖 Further Reading

- [Flutter Widget Catalog](https://docs.flutter.dev/development/ui/widgets)
- [Flutter Widget Lifecycle](https://docs.flutter.dev/development/ui/widgets-intro)
- [Flutter Performance Best Practices](https://docs.flutter.dev/perf/best-practices)

---

**Next**: [Stateful vs Stateless Widgets](stateful-stateless.md)
