# Drawer Widget in Flutter

## 📖 Overview

The **Drawer** widget is a Material Design navigation panel that slides in from the left edge of the screen. It provides a way to navigate between different sections of an application and typically contains navigation links, user information, and other app-wide actions.

## 🎯 What is Drawer?

Drawer is a slide-out navigation panel that provides access to different sections of an app. It's commonly used for main navigation, user settings, and other app-wide functionality. The drawer slides in from the left when triggered and can be dismissed by swiping or tapping outside.

### Key Features

- **Slide-out Navigation**: Slides in from the left edge
- **Navigation Links**: Contains links to different app sections
- **User Information**: Often includes user profile and settings
- **Material Design**: Follows Material Design guidelines
- **Gesture Support**: Can be opened with swipe gestures
- **Accessible**: Supports accessibility features

## 🏗️ Basic Structure

```dart
Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      DrawerHeader(
        decoration: BoxDecoration(color: Colors.blue),
        child: Text('Drawer Header'),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text('Home'),
        onTap: () {
          // Handle navigation
        },
      ),
    ],
  ),
)
```

## 📋 Key Properties

### Essential Properties

| Property | Type | Description |
|----------|------|-------------|
| `child` | Widget | The content of the drawer |
| `backgroundColor` | Color | Background color of the drawer |
| `elevation` | double | Elevation/shadow of the drawer |
| `width` | double | Width of the drawer |

### Advanced Properties

| Property | Type | Description |
|----------|------|-------------|
| `shape` | ShapeBorder | Custom shape for the drawer |
| `clipBehavior` | Clip | How to clip the drawer content |
| `semanticLabel` | String | Semantic label for accessibility |

## 🎨 Basic Usage Examples

### Simple Drawer

```dart
Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      DrawerHeader(
        decoration: BoxDecoration(color: Colors.blue),
        child: Text('My App'),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text('Home'),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text('Settings'),
        onTap: () {},
      ),
    ],
  ),
)
```

### Drawer with User Information

```dart
Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      UserAccountsDrawerHeader(
        accountName: Text('John Doe'),
        accountEmail: Text('john.doe@example.com'),
        currentAccountPicture: CircleAvatar(
          backgroundImage: NetworkImage('https://example.com/avatar.jpg'),
        ),
        decoration: BoxDecoration(color: Colors.blue),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text('Home'),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(Icons.person),
        title: Text('Profile'),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text('Settings'),
        onTap: () {},
      ),
    ],
  ),
)
```

## 📚 Example in Our App

In the Flutter Widgets Demo app, we use Drawer as follows:

```dart
drawer: Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Text(
          'Flutter Widgets',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      ListTile(
        leading: const Icon(Icons.widgets),
        title: const Text('Basic Widgets'),
        onTap: () {
          Navigator.pop(context);
          setState(() => _currentIndex = 0);
        },
      ),
      ListTile(
        leading: const Icon(Icons.view_compact),
        title: const Text('Layout Widgets'),
        onTap: () {
          Navigator.pop(context);
          setState(() => _currentIndex = 1);
        },
      ),
      ListTile(
        leading: const Icon(Icons.input),
        title: const Text('Input Widgets'),
        onTap: () {
          Navigator.pop(context);
          setState(() => _currentIndex = 2);
        },
      ),
      ListTile(
        leading: const Icon(Icons.list),
        title: const Text('List Widgets'),
        onTap: () {
          Navigator.pop(context);
          setState(() => _currentIndex = 3);
        },
      ),
    ],
  ),
),
```

### Breakdown of Our Drawer

- **DrawerHeader**: Blue header with "Flutter Widgets" title
- **ListTile items**: Navigation items for different widget categories
- **onTap handlers**: Close drawer and switch to selected page
- **Icons**: Visual indicators for each navigation item

## 🎯 Common Use Cases

### 1. Basic Navigation Drawer

```dart
Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      DrawerHeader(
        decoration: BoxDecoration(color: Colors.blue),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Navigation Menu',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text('Home'),
        onTap: () {
          Navigator.pop(context);
          // Navigate to home
        },
      ),
      ListTile(
        leading: Icon(Icons.search),
        title: Text('Search'),
        onTap: () {
          Navigator.pop(context);
          // Navigate to search
        },
      ),
      ListTile(
        leading: Icon(Icons.person),
        title: Text('Profile'),
        onTap: () {
          Navigator.pop(context);
          // Navigate to profile
        },
      ),
    ],
  ),
)
```

### 2. Drawer with User Account

```dart
Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      UserAccountsDrawerHeader(
        accountName: Text('John Doe'),
        accountEmail: Text('john.doe@example.com'),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text(
            'JD',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text('Home'),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(Icons.favorite),
        title: Text('Favorites'),
        onTap: () {},
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text('Settings'),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(Icons.help),
        title: Text('Help'),
        onTap: () {},
      ),
    ],
  ),
)
```

### 3. Drawer with Sections

```dart
Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      DrawerHeader(
        decoration: BoxDecoration(color: Colors.blue),
        child: Text('My App'),
      ),
      ExpansionTile(
        leading: Icon(Icons.category),
        title: Text('Categories'),
        children: [
          ListTile(
            leading: Icon(Icons.sports_soccer),
            title: Text('Sports'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.music_note),
            title: Text('Music'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Movies'),
            onTap: () {},
          ),
        ],
      ),
      ListTile(
        leading: Icon(Icons.favorite),
        title: Text('Favorites'),
        onTap: () {},
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text('Settings'),
        onTap: () {},
      ),
    ],
  ),
)
```

## 💡 Best Practices

### 1. Proper Navigation Handling

```dart
// ✅ Good: Close drawer and navigate
ListTile(
  leading: Icon(Icons.home),
  title: Text('Home'),
  onTap: () {
    Navigator.pop(context); // Close drawer
    Navigator.pushNamed(context, '/home'); // Navigate
  },
)

// ❌ Avoid: Navigate without closing drawer
ListTile(
  leading: Icon(Icons.home),
  title: Text('Home'),
  onTap: () {
    Navigator.pushNamed(context, '/home'); // Drawer stays open
  },
)
```

### 2. Clear Visual Hierarchy

```dart
// ✅ Good: Clear sections with dividers
Drawer(
  child: ListView(
    children: [
      DrawerHeader(...),
      ListTile(...), // Main navigation
      ListTile(...),
      Divider(), // Separate sections
      ListTile(...), // Secondary actions
      ListTile(...),
    ],
  ),
)

// ❌ Avoid: No visual separation
Drawer(
  child: ListView(
    children: [
      DrawerHeader(...),
      ListTile(...),
      ListTile(...),
      ListTile(...), // Hard to distinguish sections
      ListTile(...),
    ],
  ),
)
```

### 3. Consistent Icons and Labels

```dart
// ✅ Good: Consistent icon and label style
ListTile(
  leading: Icon(Icons.home, color: Colors.grey[600]),
  title: Text('Home', style: TextStyle(fontSize: 16)),
  onTap: () {},
)

// ❌ Avoid: Inconsistent styling
ListTile(
  leading: Icon(Icons.home, color: Colors.red, size: 30), // Inconsistent
  title: Text('HOME', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), // Inconsistent
  onTap: () {},
)
```

### 4. Proper Header Design

```dart
// ✅ Good: Informative header
DrawerHeader(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.blue, Colors.purple],
    ),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('My App', style: TextStyle(color: Colors.white, fontSize: 24)),
      SizedBox(height: 8),
      Text('Version 1.0.0', style: TextStyle(color: Colors.white70)),
    ],
  ),
)

// ❌ Avoid: Empty or unclear header
DrawerHeader(
  decoration: BoxDecoration(color: Colors.blue),
  child: Text(''), // Empty header
)
```

## 🔧 Advanced Features

### 1. Custom Drawer with Animation

```dart
class AnimatedDrawer extends StatefulWidget {
  @override
  _AnimatedDrawerState createState() => _AnimatedDrawerState();
}

class _AnimatedDrawerState extends State<AnimatedDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FadeTransition(
        opacity: _animation,
        child: ListView(
          children: [
            DrawerHeader(...),
            // Drawer items
          ],
        ),
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

### 2. Drawer with Search

```dart
Drawer(
  child: Column(
    children: [
      DrawerHeader(
        decoration: BoxDecoration(color: Colors.blue),
        child: Column(
          children: [
            Text('My App', style: TextStyle(color: Colors.white, fontSize: 24)),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ],
        ),
      ),
      Expanded(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {},
            ),
            // More items
          ],
        ),
      ),
    ],
  ),
)
```

### 3. Drawer with Footer

```dart
Drawer(
  child: Column(
    children: [
      DrawerHeader(...),
      Expanded(
        child: ListView(
          children: [
            ListTile(...),
            ListTile(...),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey[300]!),
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.info, color: Colors.grey[600]),
            SizedBox(width: 8),
            Text('Version 1.0.0', style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ),
    ],
  ),
)
```

## 🎯 Key Takeaways

1. **Navigation Hub**: Use for main app navigation
2. **User Information**: Include user profile and settings
3. **Clear Structure**: Organize with headers and sections
4. **Proper Handling**: Close drawer when navigating
5. **Accessibility**: Include proper labels and semantic information

## 📖 Further Reading

- [Drawer API Documentation](https://api.flutter.dev/flutter/material/Drawer-class.html)
- [Material Design Navigation Drawer Guidelines](https://material.io/design/components/navigation-drawer.html)
- [Flutter Navigation Tutorial](https://docs.flutter.dev/ui/navigation)
- [Flutter Accessibility](https://docs.flutter.dev/ui/accessibility)

---

**Previous**: [BottomNavigationBar](bottom-navigation-bar.md) | **Next**: [Container Class](container.md)
