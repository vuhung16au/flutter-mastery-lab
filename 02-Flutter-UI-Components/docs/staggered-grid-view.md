# Staggered Grid View in Flutter

## Overview

The `StaggeredGridView` widget is a third-party package that provides a grid layout where items can have different sizes, creating a Pinterest-style masonry layout. It's perfect for displaying content with varying heights in an organized grid format.

## Key Features

- **Variable Item Sizes**: Items can have different heights and widths
- **Masonry Layout**: Pinterest-style staggered arrangement
- **Responsive**: Adapts to different screen sizes
- **Customizable**: Highly customizable grid parameters
- **Performance**: Efficient rendering for large datasets

## Installation

Add to `pubspec.yaml`:
```yaml
dependencies:
  flutter_staggered_grid_view: ^0.7.0
```

## Basic Usage

```dart
MasonryGridView.count(
  crossAxisCount: 2,
  mainAxisSpacing: 8,
  crossAxisSpacing: 8,
  itemCount: 10,
  itemBuilder: (context, index) {
    return Card(
      child: Container(
        height: 100 + (index * 20),
        color: Colors.primaries[index % Colors.primaries.length],
        child: Center(
          child: Text(
            'Item $index',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  },
)
```

## Types of Staggered Grid Views

### 1. MasonryGridView.count
Creates a grid with a fixed number of columns.

### 2. MasonryGridView.extent
Creates a grid with items that have a maximum width.

### 3. StaggeredGridView.count
Creates a grid with custom staggered tile sizes.

### 4. StaggeredGridView.extent
Creates a grid with custom staggered tile extents.

## Properties

### Common Properties

- `crossAxisCount`: Number of columns in the grid (int)
- `mainAxisSpacing`: Spacing between rows (double)
- `crossAxisSpacing`: Spacing between columns (double)
- `itemCount`: Number of items in the grid (int)
- `itemBuilder`: Builder function for creating items (IndexedWidgetBuilder)
- `padding`: Padding around the grid (EdgeInsetsGeometry?)
- `shrinkWrap`: Whether the grid should shrink-wrap its content (bool)
- `physics`: Scroll physics for the grid (ScrollPhysics?)

## Examples

### Basic Masonry Grid
```dart
MasonryGridView.count(
  crossAxisCount: 2,
  mainAxisSpacing: 8,
  crossAxisSpacing: 8,
  itemCount: 10,
  itemBuilder: (context, index) {
    return Card(
      child: Container(
        height: 100 + (index * 20),
        color: Colors.primaries[index % Colors.primaries.length],
        child: Center(
          child: Text(
            'Item $index',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  },
)
```

### Staggered Grid with Custom Tiles
```dart
StaggeredGridView.count(
  crossAxisCount: 2,
  mainAxisSpacing: 8,
  crossAxisSpacing: 8,
  itemCount: 10,
  itemBuilder: (context, index) {
    return Card(
      child: Container(
        color: Colors.primaries[index % Colors.primaries.length],
        child: Center(
          child: Text(
            'Item $index',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  },
  staggeredTileBuilder: (index) {
    return StaggeredTile.count(
      1,
      (index % 3 == 0) ? 2 : 1,
    );
  },
)
```

### Image Grid
```dart
MasonryGridView.count(
  crossAxisCount: 2,
  mainAxisSpacing: 8,
  crossAxisSpacing: 8,
  itemCount: imageUrls.length,
  itemBuilder: (context, index) {
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrls[index],
          fit: BoxFit.cover,
        ),
      ),
    );
  },
)
```

## Common Use Cases

### 1. Photo Galleries
- Pinterest-style image layouts
- Social media feeds
- Portfolio displays

### 2. Content Cards
- Blog post previews
- Product cards
- News articles

### 3. Dashboard Widgets
- Analytics widgets
- Quick action cards
- Status indicators

## Best Practices

1. **Optimize Images**: Use appropriately sized images for better performance
2. **Consistent Spacing**: Maintain consistent spacing between items
3. **Responsive Design**: Test on different screen sizes
4. **Loading States**: Show loading indicators while content loads
5. **Error Handling**: Handle cases where images fail to load

## Implementation in Demo App

In our demo app, StaggeredGridView is used in:

- Dashboard tab for showcasing different sized cards
- Interactive examples with varying item heights
- Color-coded demonstration of the masonry layout

## Code Example from Demo

```dart
MasonryGridView.count(
  crossAxisCount: 2,
  mainAxisSpacing: 8,
  crossAxisSpacing: 8,
  itemCount: 10,
  itemBuilder: (context, index) {
    return Card(
      child: Container(
        height: 100 + (index * 20),
        color: Colors.primaries[index % Colors.primaries.length],
        child: Center(
          child: Text(
            'Item $index',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  },
)
```

## Performance Considerations

### Lazy Loading
```dart
MasonryGridView.builder(
  crossAxisCount: 2,
  itemCount: items.length,
  itemBuilder: (context, index) {
    // Only build visible items
    return ItemCard(item: items[index]);
  },
)
```

### Caching
```dart
// Use cached network image for better performance
CachedNetworkImage(
  imageUrl: imageUrl,
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
)
```

## Related Widgets

- `GridView`: Standard grid layout with fixed item sizes
- `ListView`: Vertical list layout
- `CustomScrollView`: Custom scrollable layouts
- `SliverGrid`: Sliver-based grid layouts
