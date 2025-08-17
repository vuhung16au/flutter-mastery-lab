# Scaffold class in Flutter

## 📖 Overview

The **Scaffold** class implements the basic Material Design visual layout structure. It provides a framework for implementing the basic Material Design layout of the visual interface. Scaffold is designed to be a single page of material design app.

## 🎯 What is Scaffold?

Scaffold is a widget that provides a framework for implementing the basic Material Design visual layout structure. It provides APIs for showing drawers, snack bars, and bottom sheets. Scaffold is designed to be a single page of material design app.

### Key Features

- **AppBar**: Top app bar with title and actions
- **Body**: Main content area
- **Drawer**: Side navigation panel
- **BottomNavigationBar**: Bottom navigation
- **FloatingActionButton**: Floating action button
- **SnackBar**: Temporary messages
- **BottomSheet**: Modal bottom sheets

## 🏗️ Basic Structure

```dart
Scaffold(
  appBar: AppBar(title: Text('My App')),
  body: Center(child: Text('Hello World')),
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
)
```

## 📋 Key Properties

### Essential Properties

| Property | Type | Description |
|----------|------|-------------|
| `appBar` | PreferredSizeWidget | The app bar to display |
| `body` | Widget | The primary content of the scaffold |
| `floatingActionButton` | Widget | The floating action button |
| `drawer` | Widget | The drawer to display |
| `bottomNavigationBar` | Widget | The bottom navigation bar |
| `backgroundColor` | Color | The background color of the scaffold |

### Advanced Properties

| Property | Type | Description |
|----------|------|-------------|
| `endDrawer` | Widget | The end drawer to display |
| `bottomSheet` | Widget | The persistent bottom sheet |
| `resizeToAvoidBottomInset` | bool | Whether to resize when keyboard appears |
| `extendBody` | bool | Whether to extend body behind app bar |
| `extendBodyBehindAppBar` | bool | Whether to extend body behind app bar |

## 🎨 Basic Usage Examples

### Simple Scaffold

```dart
Scaffold(
  appBar: AppBar(
    title: Text('Simple Scaffold'),
  ),
  body: Center(
    child: Text('Hello World'),
  ),
)
```

### Scaffold with All Components

```dart
Scaffold(
  appBar: AppBar(
    title: Text('Complete Scaffold'),
    actions: [
      IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {},
      ),
    ],
  ),
  drawer: Drawer(
    child: ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.blue),
          child: Text('Drawer Header'),
        ),
        ListTile(
          title: Text('Item 1'),
          onTap: () {},
        ),
      ],
    ),
  ),
  body: Center(
    child: Text('Main Content'),
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
  bottomNavigationBar: BottomNavigationBar(
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    ],
  ),
)
```

## 📚 Example in Our App

In the Flutter Widgets Demo app, we use Scaffold extensively:

```dart
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar Widget demonstration
      appBar: AppBar(
        title: const Text('Flutter Widgets Demo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('This is a SnackBar!')),
              );
            },
          ),
        ],
      ),
      
      // Drawer Widget demonstration
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Flutter Widgets'),
            ),
            ListTile(
              leading: const Icon(Icons.widgets),
              title: const Text('Basic Widgets'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 0);
              },
            ),
            // ... more list tiles
          ],
        ),
      ),
      
      body: _pages[_currentIndex],
      
      // FloatingActionButton demonstration
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
      
      // BottomNavigationBar Widget demonstration
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.widgets), label: 'Basic'),
          BottomNavigationBarItem(icon: Icon(Icons.view_compact), label: 'Layout'),
          BottomNavigationBarItem(icon: Icon(Icons.input), label: 'Input'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Lists'),
        ],
      ),
    );
  }
}
```

## 🎯 Common Use Cases

### 1. Basic Page Layout

```dart
Scaffold(
  appBar: AppBar(title: Text('My Page')),
  body: SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        Text('Content goes here'),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          child: Text('Action Button'),
        ),
      ],
    ),
  ),
)
```

### 2. Navigation Layout

```dart
Scaffold(
  appBar: AppBar(title: Text('Navigation')),
  drawer: Drawer(
    child: ListView(
      children: [
        DrawerHeader(child: Text('Menu')),
        ListTile(title: Text('Home'), onTap: () {}),
        ListTile(title: Text('Profile'), onTap: () {}),
        ListTile(title: Text('Settings'), onTap: () {}),
      ],
    ),
  ),
  body: Center(child: Text('Main Content')),
  bottomNavigationBar: BottomNavigationBar(
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ],
  ),
)
```

### 3. Form Layout

```dart
Scaffold(
  appBar: AppBar(title: Text('Form')),
  body: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        TextField(decoration: InputDecoration(labelText: 'Name')),
        SizedBox(height: 16),
        TextField(decoration: InputDecoration(labelText: 'Email')),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {},
          child: Text('Submit'),
        ),
      ],
    ),
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.save),
  ),
)
```

### 4. List Layout

```dart
Scaffold(
  appBar: AppBar(title: Text('List')),
  body: ListView.builder(
    itemCount: 100,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text('Item $index'),
        subtitle: Text('Description for item $index'),
        onTap: () {},
      );
    },
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
)
```

## 💡 Best Practices

### 1. Proper Body Content

```dart
// ✅ Good: Use appropriate body widgets
Scaffold(
  appBar: AppBar(title: Text('My App')),
  body: SingleChildScrollView(
    child: Column(
      children: [
        // Content that might overflow
      ],
    ),
  ),
)

// ❌ Avoid: Content that might overflow
Scaffold(
  appBar: AppBar(title: Text('My App')),
  body: Column(
    children: [
      // Content that might overflow without scrolling
    ],
  ),
)
```

### 2. Consistent Navigation

```dart
// ✅ Good: Consistent navigation pattern
Scaffold(
  appBar: AppBar(
    title: Text('Page Title'),
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    ),
  ),
  body: Content(),
)

// ❌ Avoid: Inconsistent navigation
Scaffold(
  appBar: AppBar(title: Text('Page Title')), // No back button
  body: Content(),
)
```

### 3. Proper Floating Action Button Usage

```dart
// ✅ Good: Contextual FAB
Scaffold(
  body: ListView(...),
  floatingActionButton: FloatingActionButton(
    onPressed: () {
      // Add new item to list
    },
    child: Icon(Icons.add),
    tooltip: 'Add item',
  ),
)

// ❌ Avoid: Generic FAB without context
Scaffold(
  body: Content(),
  floatingActionButton: FloatingActionButton(
    onPressed: () {
      // Generic action
    },
    child: Icon(Icons.star),
  ),
)
```

## 🔧 Advanced Features

### 1. SnackBar Integration

```dart
Scaffold(
  body: Center(
    child: ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Action completed!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {},
            ),
          ),
        );
      },
      child: Text('Show SnackBar'),
    ),
  ),
)
```

### 2. Bottom Sheet Integration

```dart
Scaffold(
  body: Center(
    child: ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            height: 200,
            child: Center(child: Text('Bottom Sheet')),
          ),
        );
      },
      child: Text('Show Bottom Sheet'),
    ),
  ),
)
```

### 3. Custom Background

```dart
Scaffold(
  backgroundColor: Colors.grey[100],
  appBar: AppBar(title: Text('Custom Background')),
  body: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue, Colors.purple],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Center(child: Text('Gradient Background')),
  ),
)
```

## 🎯 Key Takeaways

1. **Layout Framework**: Scaffold provides the basic Material Design layout structure
2. **Component Integration**: Integrates AppBar, Drawer, FAB, and BottomNavigationBar
3. **Responsive Design**: Handles keyboard appearance and screen resizing
4. **Material Design**: Follows Material Design guidelines
5. **Flexible**: Can be customized for various use cases

## 📖 Further Reading

- [Scaffold API Documentation](https://api.flutter.dev/flutter/material/Scaffold-class.html)
- [Material Design Guidelines](https://material.io/design)
- [Flutter Layout Tutorial](https://docs.flutter.dev/ui/layout)
- [Flutter Navigation](https://docs.flutter.dev/ui/navigation)

---

**Previous**: [MaterialApp Class](material-app.md) | **Next**: [AppBar Widget](app-bar.md)
