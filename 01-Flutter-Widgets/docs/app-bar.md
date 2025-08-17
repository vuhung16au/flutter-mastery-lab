# Flutter - AppBar Widget

## 📖 Overview

The **AppBar** widget is a Material Design app bar that displays at the top of the screen. It typically contains the app title, navigation actions, and other interactive elements. AppBar is one of the most commonly used widgets in Flutter applications.

## 🎯 What is AppBar?

AppBar is a widget that implements the Material Design app bar. It provides a consistent way to display the app title, navigation controls, and action buttons at the top of the screen. AppBar automatically handles safe areas and provides a consistent look across different platforms.

### Key Features

- **Title Display**: Shows the app or page title
- **Navigation Controls**: Back button, drawer toggle, etc.
- **Action Buttons**: Menu items, search, settings, etc.
- **Flexible Space**: Customizable area for additional content
- **Material Design**: Follows Material Design guidelines
- **Platform Adaptation**: Adapts to iOS and Android conventions

## 🏗️ Basic Structure

```dart
AppBar(
  title: Text('My App'),
  leading: IconButton(
    icon: Icon(Icons.menu),
    onPressed: () {},
  ),
  actions: [
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () {},
    ),
  ],
)
```

## 📋 Key Properties

### Essential Properties

| Property | Type | Description |
|----------|------|-------------|
| `title` | Widget | The primary widget displayed in the app bar |
| `leading` | Widget | Widget to display before the title |
| `actions` | List<Widget> | Widgets to display after the title |
| `backgroundColor` | Color | The background color of the app bar |
| `foregroundColor` | Color | The foreground color (text, icons) |
| `elevation` | double | The elevation of the app bar |

### Advanced Properties

| Property | Type | Description |
|----------|------|-------------|
| `flexibleSpace` | Widget | Widget displayed behind the app bar content |
| `bottom` | PreferredSizeWidget | Widget displayed below the app bar |
| `automaticallyImplyLeading` | bool | Whether to automatically add leading widget |
| `centerTitle` | bool | Whether to center the title |
| `titleSpacing` | double | Spacing around the title |
| `toolbarHeight` | double | Height of the app bar |

## 🎨 Basic Usage Examples

### Simple AppBar

```dart
AppBar(
  title: Text('Simple AppBar'),
)
```

### AppBar with Actions

```dart
AppBar(
  title: Text('AppBar with Actions'),
  actions: [
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () {
        // Handle search
      },
    ),
    IconButton(
      icon: Icon(Icons.more_vert),
      onPressed: () {
        // Handle menu
      },
    ),
  ],
)
```

### AppBar with Custom Colors

```dart
AppBar(
  title: Text('Custom Colors'),
  backgroundColor: Colors.blue,
  foregroundColor: Colors.white,
  elevation: 8,
)
```

## 📚 Example in Our App

In the Flutter Widgets Demo app, we use AppBar as follows:

```dart
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
```

### Breakdown of Our AppBar

- **title**: Displays "Flutter Widgets Demo" as the app title
- **backgroundColor**: Sets blue background color
- **foregroundColor**: Sets white text and icon color
- **elevation**: Adds shadow effect with elevation of 4
- **actions**: Includes an info button that shows a SnackBar

## 🎯 Common Use Cases

### 1. Basic Navigation AppBar

```dart
AppBar(
  title: Text('Page Title'),
  leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () => Navigator.pop(context),
  ),
)
```

### 2. AppBar with Drawer

```dart
AppBar(
  title: Text('App with Drawer'),
  automaticallyImplyLeading: true, // Shows hamburger menu
  actions: [
    IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {},
    ),
  ],
)
```

### 3. AppBar with Search

```dart
AppBar(
  title: TextField(
    decoration: InputDecoration(
      hintText: 'Search...',
      border: InputBorder.none,
      hintStyle: TextStyle(color: Colors.white70),
    ),
    style: TextStyle(color: Colors.white),
  ),
  actions: [
    IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        // Clear search
      },
    ),
  ],
)
```

### 4. AppBar with Bottom Widget

```dart
AppBar(
  title: Text('AppBar with Bottom'),
  bottom: TabBar(
    tabs: [
      Tab(text: 'Tab 1'),
      Tab(text: 'Tab 2'),
      Tab(text: 'Tab 3'),
    ],
  ),
)
```

### 5. AppBar with Flexible Space

```dart
AppBar(
  title: Text('Flexible AppBar'),
  flexibleSpace: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue, Colors.purple],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ),
)
```

## 💡 Best Practices

### 1. Consistent Navigation

```dart
// ✅ Good: Consistent back button behavior
AppBar(
  title: Text('Page Title'),
  leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () => Navigator.pop(context),
  ),
)

// ❌ Avoid: Inconsistent navigation
AppBar(
  title: Text('Page Title'),
  // Missing back button when needed
)
```

### 2. Appropriate Action Buttons

```dart
// ✅ Good: Contextual actions
AppBar(
  title: Text('Email List'),
  actions: [
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () => _searchEmails(),
    ),
    IconButton(
      icon: Icon(Icons.add),
      onPressed: () => _composeEmail(),
    ),
  ],
)

// ❌ Avoid: Generic actions
AppBar(
  title: Text('Email List'),
  actions: [
    IconButton(
      icon: Icon(Icons.star),
      onPressed: () => _genericAction(), // Not contextual
    ),
  ],
)
```

### 3. Proper Color Usage

```dart
// ✅ Good: Good contrast
AppBar(
  title: Text('My App'),
  backgroundColor: Colors.blue,
  foregroundColor: Colors.white, // Good contrast
)

// ❌ Avoid: Poor contrast
AppBar(
  title: Text('My App'),
  backgroundColor: Colors.blue,
  foregroundColor: Colors.blue, // Poor contrast
)
```

### 4. Responsive Design

```dart
// ✅ Good: Responsive title
AppBar(
  title: Text(
    'Very Long App Title That Might Overflow',
    overflow: TextOverflow.ellipsis,
  ),
)

// ❌ Avoid: Fixed width that might overflow
AppBar(
  title: SizedBox(
    width: 200,
    child: Text('Very Long App Title'),
  ),
)
```

## 🔧 Advanced Features

### 1. Custom AppBar with Gradient

```dart
AppBar(
  title: Text('Gradient AppBar'),
  flexibleSpace: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.blue.shade400,
          Colors.blue.shade800,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ),
)
```

### 2. AppBar with Search Animation

```dart
class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _SearchAppBarState createState() => _SearchAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _isSearching
          ? TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.white70),
              ),
              style: TextStyle(color: Colors.white),
            )
          : Text('My App'),
      actions: [
        IconButton(
          icon: Icon(_isSearching ? Icons.close : Icons.search),
          onPressed: () {
            setState(() {
              _isSearching = !_isSearching;
            });
          },
        ),
      ],
    );
  }
}
```

### 3. AppBar with Bottom Tabs

```dart
AppBar(
  title: Text('Tabbed AppBar'),
  bottom: TabBar(
    tabs: [
      Tab(icon: Icon(Icons.home), text: 'Home'),
      Tab(icon: Icon(Icons.business), text: 'Business'),
      Tab(icon: Icon(Icons.school), text: 'School'),
    ],
  ),
)
```

## 🎯 Key Takeaways

1. **Navigation Hub**: AppBar serves as the primary navigation element
2. **Consistent Design**: Provides consistent Material Design appearance
3. **Flexible Layout**: Can be customized with various widgets and properties
4. **Platform Adaptation**: Automatically adapts to platform conventions
5. **User Experience**: Essential for intuitive app navigation

## 📖 Further Reading

- [AppBar API Documentation](https://api.flutter.dev/flutter/material/AppBar-class.html)
- [Material Design App Bar Guidelines](https://material.io/design/components/app-bars-top.html)
- [Flutter Navigation Tutorial](https://docs.flutter.dev/ui/navigation)
- [Flutter Theming](https://docs.flutter.dev/ui/design/themes)

---

**Previous**: [Scaffold Class](scaffold.md) | **Next**: [FloatingActionButton](floating-action-button.md)
