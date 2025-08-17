# BottomNavigationBar Widget in Flutter

## 📖 Overview

The **BottomNavigationBar** widget is a Material Design navigation component that displays a row of small items at the bottom of the screen. It's commonly used for primary navigation between different sections of an application.

## 🎯 What is BottomNavigationBar?

BottomNavigationBar provides a way to navigate between different top-level views in an app. It displays a row of items, typically with icons and labels, and allows users to switch between different sections of the application.

### Key Features

- **Primary Navigation**: Main navigation between app sections
- **Icon and Label Support**: Each item can have an icon and label
- **Selection State**: Shows which item is currently selected
- **Material Design**: Follows Material Design guidelines
- **Responsive**: Adapts to different screen sizes
- **Accessible**: Supports accessibility features

## 🏗️ Basic Structure

```dart
BottomNavigationBar(
  currentIndex: _selectedIndex,
  onTap: (index) {
    setState(() {
      _selectedIndex = index;
    });
  },
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
  ],
)
```

## 📋 Key Properties

### Essential Properties

| Property | Type | Description |
|----------|------|-------------|
| `items` | List<BottomNavigationBarItem> | The navigation items to display |
| `currentIndex` | int | The index of the currently selected item |
| `onTap` | ValueChanged<int> | Callback when an item is tapped |
| `type` | BottomNavigationBarType | The type of navigation bar |

### Advanced Properties

| Property | Type | Description |
|----------|------|-------------|
| `backgroundColor` | Color | Background color of the navigation bar |
| `selectedItemColor` | Color | Color of the selected item |
| `unselectedItemColor` | Color | Color of unselected items |
| `elevation` | double | Elevation/shadow of the navigation bar |
| `showUnselectedLabels` | bool | Whether to show labels for unselected items |

## 🎨 Basic Usage Examples

### Simple BottomNavigationBar

```dart
BottomNavigationBar(
  currentIndex: 0,
  onTap: (index) {
    print('Tapped index: $index');
  },
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
  ],
)
```

### BottomNavigationBar with Custom Colors

```dart
BottomNavigationBar(
  currentIndex: _selectedIndex,
  onTap: (index) => setState(() => _selectedIndex = index),
  backgroundColor: Colors.blue,
  selectedItemColor: Colors.white,
  unselectedItemColor: Colors.white70,
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
  ],
)
```

## 📚 Example in Our App

In the Flutter Widgets Demo app, we use BottomNavigationBar as follows:

```dart
bottomNavigationBar: BottomNavigationBar(
  type: BottomNavigationBarType.fixed,
  currentIndex: _currentIndex,
  onTap: (index) {
    setState(() {
      _currentIndex = index;
    });
  },
  items: const [
    BottomNavigationBarItem(
      icon: Icon(Icons.widgets),
      label: 'Basic',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.view_compact),
      label: 'Layout',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.input),
      label: 'Input',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.list),
      label: 'Lists',
    ),
  ],
),
```

### Breakdown of Our BottomNavigationBar

- **type**: Fixed type to show all items
- **currentIndex**: Tracks the currently selected tab
- **onTap**: Updates the selected index and switches pages
- **items**: Four navigation items for different widget categories

## 🎯 Common Use Cases

### 1. Basic Navigation

```dart
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
```

### 2. Navigation with Badges

```dart
BottomNavigationBar(
  currentIndex: _selectedIndex,
  onTap: (index) => setState(() => _selectedIndex = index),
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Stack(
        children: [
          Icon(Icons.notifications),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: BoxConstraints(
                minWidth: 12,
                minHeight: 12,
              ),
              child: Text(
                '3',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      label: 'Notifications',
    ),
  ],
)
```

### 3. Navigation with Custom Icons

```dart
BottomNavigationBar(
  currentIndex: _selectedIndex,
  onTap: (index) => setState(() => _selectedIndex = index),
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite_outline),
      activeIcon: Icon(Icons.favorite),
      label: 'Favorites',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings_outlined),
      activeIcon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ],
)
```

## 💡 Best Practices

### 1. Appropriate Number of Items

```dart
// ✅ Good: 3-5 items (optimal for mobile)
BottomNavigationBar(
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  ],
)

// ❌ Avoid: Too many items (hard to tap accurately)
BottomNavigationBar(
  items: [
    // 6+ items make it difficult to use
  ],
)
```

### 2. Clear Labels

```dart
// ✅ Good: Clear, concise labels
BottomNavigationBarItem(
  icon: Icon(Icons.home),
  label: 'Home',
)

// ❌ Avoid: Unclear or long labels
BottomNavigationBarItem(
  icon: Icon(Icons.home),
  label: 'Go to the main home screen', // Too long
)
```

### 3. Consistent Icons

```dart
// ✅ Good: Consistent icon style
BottomNavigationBar(
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  ],
)

// ❌ Avoid: Mixed icon styles
BottomNavigationBar(
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    // Mixing outlined and filled icons can be confusing
  ],
)
```

### 4. Proper State Management

```dart
// ✅ Good: Proper state management
class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: _navigationItems,
      ),
    );
  }
}

// ❌ Avoid: Missing state management
BottomNavigationBar(
  currentIndex: 0, // Always 0, never changes
  onTap: (index) {
    // No state update
  },
)
```

## 🔧 Advanced Features

### 1. Shifting BottomNavigationBar

```dart
BottomNavigationBar(
  type: BottomNavigationBarType.shifting, // Shifting type
  currentIndex: _selectedIndex,
  onTap: (index) => setState(() => _selectedIndex = index),
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
      backgroundColor: Colors.blue,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
      backgroundColor: Colors.red,
    ),
  ],
)
```

### 2. Custom BottomNavigationBar

```dart
class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.home, 'Home'),
          _buildNavItem(1, Icons.search, 'Search'),
          _buildNavItem(2, Icons.person, 'Profile'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.blue : Colors.grey,
            size: isSelected ? 28 : 24,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
              fontSize: isSelected ? 12 : 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
```

### 3. Animated BottomNavigationBar

```dart
class AnimatedBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavigationBarItem> items;

  const AnimatedBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  _AnimatedBottomNavigationBarState createState() =>
      _AnimatedBottomNavigationBarState();
}

class _AnimatedBottomNavigationBarState
    extends State<AnimatedBottomNavigationBar>
    with TickerProviderStateMixin {
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
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: (index) {
        _controller.forward().then((_) => _controller.reverse());
        widget.onTap(index);
      },
      items: widget.items,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

## 🎯 Key Takeaways

1. **Primary Navigation**: Use for main app sections
2. **Limited Items**: Keep to 3-5 items for usability
3. **Clear Labels**: Use concise, descriptive labels
4. **Consistent Design**: Maintain consistent icon and color schemes
5. **State Management**: Properly manage selection state

## 📖 Further Reading

- [BottomNavigationBar API Documentation](https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html)
- [Material Design Bottom Navigation Guidelines](https://material.io/design/components/bottom-navigation.html)
- [Flutter Navigation Tutorial](https://docs.flutter.dev/ui/navigation)
- [Flutter State Management](https://docs.flutter.dev/development/data-and-backend/state-mgmt/intro)

---

**Previous**: [FloatingActionButton](floating-action-button.md) | **Next**: [Drawer Widget](drawer.md)
