# Icon Widget in Flutter

## Overview

The `Icon` widget in Flutter is used to display icons in your application. It's one of the most fundamental UI components and is widely used throughout Flutter applications.

## Key Features

- **Material Design Icons**: Built-in support for Material Design icon set
- **Customizable**: Size, color, and style can be easily modified
- **Lightweight**: Efficient rendering and minimal memory footprint
- **Accessible**: Supports accessibility features

## Basic Usage

```dart
Icon(
  Icons.favorite,
  color: Colors.red,
  size: 50,
)
```

## Properties

### Required Properties

- `icon`: The icon to display (IconData)

### Optional Properties

- `size`: The size of the icon (double)
- `color`: The color of the icon (Color)
- `semanticLabel`: Accessibility label for screen readers (String)

## Examples

### Basic Icon
```dart
Icon(Icons.star)
```

### Colored Icon
```dart
Icon(
  Icons.favorite,
  color: Colors.red,
)
```

### Large Icon
```dart
Icon(
  Icons.home,
  size: 100,
  color: Colors.blue,
)
```

### Icon with Semantic Label
```dart
Icon(
  Icons.accessibility,
  semanticLabel: 'Accessibility icon',
)
```

## Common Icon Categories

### Navigation Icons
- `Icons.home`
- `Icons.navigation`
- `Icons.arrow_back`
- `Icons.arrow_forward`

### Action Icons
- `Icons.add`
- `Icons.delete`
- `Icons.edit`
- `Icons.save`

### Status Icons
- `Icons.check`
- `Icons.error`
- `Icons.warning`
- `Icons.info`

### Social Icons
- `Icons.favorite`
- `Icons.share`
- `Icons.thumb_up`
- `Icons.thumb_down`

## Best Practices

1. **Use Semantic Labels**: Always provide semantic labels for accessibility
2. **Consistent Sizing**: Maintain consistent icon sizes throughout your app
3. **Color Consistency**: Use your app's color scheme for icons
4. **Meaningful Icons**: Choose icons that clearly represent their function

## Implementation in Demo App

In our demo app, the Icon widget is used in:

- Component list items (leading icons)
- Tab navigation
- Bottom navigation
- Various dialog examples

## Code Example from Demo

```dart
Icon(
  Icons.favorite,
  color: Colors.red,
  size: 50,
)
```

This creates a red heart icon with a size of 50 pixels.

## Related Widgets

- `IconButton`: Icon that responds to taps
- `ImageIcon`: Icon created from an image
- `Text`: For displaying text instead of icons
- `SizedBox`: For controlling icon container size
