# Flutter – GridView

## 📖 Overview

The **GridView** widget is a scrollable grid of widgets. It displays its children in a two-dimensional array and is commonly used for displaying collections of items in a grid layout, such as photo galleries, product catalogs, or dashboard widgets.

## 🎯 What is GridView?

GridView is a widget that arranges its children in a grid pattern. It's similar to ListView but displays items in a two-dimensional layout instead of a linear list. GridView is perfect for displaying items that have similar dimensions and need to be organized in a grid format.

### Key Features

- **Grid Layout**: Displays items in rows and columns
- **Scrollable**: Supports both vertical and horizontal scrolling
- **Efficient**: Only renders visible items for performance
- **Flexible**: Various constructors for different use cases
- **Responsive**: Adapts to different screen sizes
- **Customizable**: Configurable spacing, cross-axis count, and aspect ratios

## 🏗️ Basic Structure

```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
  ),
  itemCount: 10,
  itemBuilder: (context, index) {
    return Container(
      color: Colors.blue,
      child: Center(child: Text('Item $index')),
    );
  },
)
```

## 📋 Key Properties

### Essential Properties

| Property | Type | Description |
|----------|------|-------------|
| `gridDelegate` | SliverGridDelegate | Controls the layout of the grid |
| `children` | List<Widget> | The list of widgets to display |
| `scrollDirection` | Axis | Direction of scrolling (vertical/horizontal) |
| `padding` | EdgeInsetsGeometry | Padding around the grid |
| `shrinkWrap` | bool | Whether to size the grid to its content |

### Advanced Properties

| Property | Type | Description |
|----------|------|-------------|
| `physics` | ScrollPhysics | How the grid should respond to scrolling |
| `controller` | ScrollController | Controls the scroll position |
| `cacheExtent` | double | Number of pixels to cache beyond visible area |
| `addAutomaticKeepAlives` | bool | Whether to keep items alive |
| `addRepaintBoundaries` | bool | Whether to add repaint boundaries |

## 🎨 Basic Usage Examples

### Simple GridView

```dart
GridView.count(
  crossAxisCount: 2,
  children: [
    Container(color: Colors.red, child: Center(child: Text('Item 1'))),
    Container(color: Colors.green, child: Center(child: Text('Item 2'))),
    Container(color: Colors.blue, child: Center(child: Text('Item 3'))),
    Container(color: Colors.yellow, child: Center(child: Text('Item 4'))),
  ],
)
```

### GridView with Spacing

```dart
GridView.count(
  crossAxisCount: 3,
  crossAxisSpacing: 10,
  mainAxisSpacing: 10,
  padding: EdgeInsets.all(16),
  children: List.generate(9, (index) {
    return Container(
      color: Colors.primaries[index % Colors.primaries.length],
      child: Center(child: Text('Item ${index + 1}')),
    );
  }),
)
```

### GridView.builder

```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 1.0,
  ),
  itemCount: 20,
  itemBuilder: (context, index) {
    return Card(
      child: Center(child: Text('Item ${index + 1}')),
    );
  },
)
```

## 📚 Example in Our App

In the Flutter Widgets Demo app, we use GridView as follows:

```dart
// GridView demonstration
GridView.builder(
  padding: const EdgeInsets.all(16.0),
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    childAspectRatio: 1.0,
  ),
  itemCount: 12,
  itemBuilder: (context, index) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tapped grid item ${index + 1}')),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              size: 48,
              color: Colors.primaries[index % Colors.primaries.length],
            ),
            const SizedBox(height: 8),
            Text(
              'Grid ${index + 1}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  },
),
```

### Breakdown of Our GridView

- **GridView.builder**: Efficient constructor for dynamic grids
- **SliverGridDelegateWithFixedCrossAxisCount**: 2 columns with fixed spacing
- **itemCount**: 12 items in the grid
- **itemBuilder**: Creates each grid item dynamically
- **Card**: Wraps each item in a material design card
- **InkWell**: Provides tap feedback
- **onTap**: Handles tap interactions with SnackBar feedback

## 🎯 Common Use Cases

### 1. Photo Gallery

```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    crossAxisSpacing: 4,
    mainAxisSpacing: 4,
  ),
  itemCount: photos.length,
  itemBuilder: (context, index) {
    return GestureDetector(
      onTap: () {
        // Open photo in full screen
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: NetworkImage(photos[index].url),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  },
)
```

### 2. Product Grid

```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 0.75,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
  ),
  itemCount: products.length,
  itemBuilder: (context, index) {
    final product = products[index];
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                image: DecorationImage(
                  image: NetworkImage(product.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  '\$${product.price}',
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  },
)
```

### 3. Dashboard Widgets

```dart
GridView.count(
  crossAxisCount: 2,
  childAspectRatio: 1.5,
  crossAxisSpacing: 16,
  mainAxisSpacing: 16,
  padding: EdgeInsets.all(16),
  children: [
    _buildDashboardCard('Users', '1,234', Icons.people, Colors.blue),
    _buildDashboardCard('Revenue', '\$12,345', Icons.attach_money, Colors.green),
    _buildDashboardCard('Orders', '567', Icons.shopping_cart, Colors.orange),
    _buildDashboardCard('Products', '89', Icons.inventory, Colors.purple),
  ],
)

Widget _buildDashboardCard(String title, String value, IconData icon, Color color) {
  return Card(
    elevation: 4,
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: color),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    ),
  );
}
```

### 4. Responsive Grid

```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 200,
    childAspectRatio: 1.0,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
  ),
  itemCount: items.length,
  itemBuilder: (context, index) {
    return Container(
      color: Colors.primaries[index % Colors.primaries.length],
      child: Center(child: Text('Item ${index + 1}')),
    );
  },
)
```

## 💡 Best Practices

### 1. Use Appropriate Grid Delegate

```dart
// ✅ Good: Use SliverGridDelegateWithFixedCrossAxisCount for fixed columns
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 1.0,
  ),
  itemCount: items.length,
  itemBuilder: (context, index) => _buildGridItem(index),
)

// ✅ Good: Use SliverGridDelegateWithMaxCrossAxisExtent for responsive grids
GridView.builder(
  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 200,
    childAspectRatio: 1.0,
  ),
  itemCount: items.length,
  itemBuilder: (context, index) => _buildGridItem(index),
)
```

### 2. Optimize Child Aspect Ratio

```dart
// ✅ Good: Appropriate aspect ratio for content
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 0.75, // Good for product cards
  ),
  itemCount: products.length,
  itemBuilder: (context, index) => ProductCard(product: products[index]),
)

// ❌ Avoid: Poor aspect ratio
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 3.0, // Too wide for most content
  ),
  itemCount: items.length,
  itemBuilder: (context, index) => _buildGridItem(index),
)
```

### 3. Handle Empty States

```dart
// ✅ Good: Handle empty grid state
Widget build(BuildContext context) {
  if (items.isEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.grid_off, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('No items to display', style: TextStyle(fontSize: 18, color: Colors.grey)),
        ],
      ),
    );
  }

  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    itemCount: items.length,
    itemBuilder: (context, index) => _buildGridItem(index),
  );
}
```

### 4. Use Appropriate Cross Axis Count

```dart
// ✅ Good: Responsive cross axis count
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
    childAspectRatio: 1.0,
  ),
  itemCount: items.length,
  itemBuilder: (context, index) => _buildGridItem(index),
)

// ❌ Avoid: Fixed count that doesn't adapt
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 4, // Might be too many on small screens
    childAspectRatio: 1.0,
  ),
  itemCount: items.length,
  itemBuilder: (context, index) => _buildGridItem(index),
)
```

## 🔧 Advanced Features

### 1. GridView with Custom Grid Delegate

```dart
class CustomGridDelegate extends SliverGridDelegate {
  final int crossAxisCount;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  CustomGridDelegate({
    required this.crossAxisCount,
    this.childAspectRatio = 1.0,
    this.crossAxisSpacing = 0.0,
    this.mainAxisSpacing = 0.0,
  });

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final double width = constraints.crossAxisExtent;
    final double itemWidth = (width - (crossAxisCount - 1) * crossAxisSpacing) / crossAxisCount;
    final double itemHeight = itemWidth / childAspectRatio;

    return SliverGridRegularTileLayout(
      crossAxisCount: crossAxisCount,
      mainAxisStride: itemHeight + mainAxisSpacing,
      crossAxisStride: itemWidth + crossAxisSpacing,
      childMainAxisExtent: itemHeight,
      childCrossAxisExtent: itemWidth,
      reverseCrossAxis: false,
    );
  }

  @override
  bool shouldRebuild(covariant SliverGridDelegate oldDelegate) {
    return oldDelegate is CustomGridDelegate &&
        oldDelegate.crossAxisCount != crossAxisCount;
  }
}

// Usage
GridView.builder(
  gridDelegate: CustomGridDelegate(
    crossAxisCount: 3,
    childAspectRatio: 1.0,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
  ),
  itemCount: 20,
  itemBuilder: (context, index) {
    return Container(
      color: Colors.primaries[index % Colors.primaries.length],
      child: Center(child: Text('Item $index')),
    );
  },
)
```

### 2. GridView with Staggered Layout

```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 200,
    childAspectRatio: 1.0,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
  ),
  itemCount: items.length,
  itemBuilder: (context, index) {
    return Container(
      height: 100 + (index % 3) * 50, // Variable heights
      color: Colors.primaries[index % Colors.primaries.length],
      child: Center(child: Text('Item $index')),
    );
  },
)
```

### 3. Animated GridView

```dart
class AnimatedGridView extends StatefulWidget {
  @override
  _AnimatedGridViewState createState() => _AnimatedGridViewState();
}

class _AnimatedGridViewState extends State<AnimatedGridView>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            return Transform.scale(
              scale: _animation.value,
              child: Container(
                color: Colors.primaries[index % Colors.primaries.length],
                child: Center(child: Text('Item $index')),
              ),
            );
          },
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

### 4. GridView with Search and Filter

```dart
class SearchableGridView extends StatefulWidget {
  @override
  _SearchableGridViewState createState() => _SearchableGridViewState();
}

class _SearchableGridViewState extends State<SearchableGridView> {
  List<String> allItems = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'];
  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = allItems;
  }

  void _filterItems(String query) {
    setState(() {
      filteredItems = allItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: TextField(
            onChanged: _filterItems,
            decoration: InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
            ),
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              return Card(
                child: Center(child: Text(filteredItems[index])),
              );
            },
          ),
        ),
      ],
    );
  }
}
```

### 5. GridView with Drag and Drop

```dart
class DraggableGridView extends StatefulWidget {
  @override
  _DraggableGridViewState createState() => _DraggableGridViewState();
}

class _DraggableGridViewState extends State<DraggableGridView> {
  List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Draggable<String>(
          data: items[index],
          feedback: Material(
            elevation: 8,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.blue,
              child: Center(child: Text(items[index])),
            ),
          ),
          childWhenDragging: Container(
            color: Colors.grey[300],
            child: Center(child: Text('')),
          ),
          child: DragTarget<String>(
            onAccept: (data) {
              setState(() {
                final fromIndex = items.indexOf(data);
                final toIndex = index;
                if (fromIndex != toIndex) {
                  final item = items.removeAt(fromIndex);
                  items.insert(toIndex, item);
                }
              });
            },
            builder: (context, candidateData, rejectedData) {
              return Container(
                color: Colors.blue,
                child: Center(child: Text(items[index])),
              );
            },
          ),
        );
      },
    );
  }
}
```

## 🎯 Key Takeaways

1. **Grid Layout**: Use GridView for two-dimensional item arrangements
2. **Performance**: Use GridView.builder for large datasets
3. **Responsive**: Choose appropriate grid delegates for different screen sizes
4. **Flexibility**: Support for various item types and layouts
5. **Customization**: Extensive customization options for different use cases

## 📖 Further Reading

- [GridView API Documentation](https://api.flutter.dev/flutter/widgets/GridView-class.html)
- [SliverGridDelegate API Documentation](https://api.flutter.dev/flutter/rendering/SliverGridDelegate-class.html)
- [Flutter Lists Tutorial](https://docs.flutter.dev/ui/layout/lists)
- [Flutter Performance Best Practices](https://docs.flutter.dev/perf/best-practices)

---

**Previous**: [ListView Class](list-view.md) | **Next**: [TextField Widget](text-field.md)
