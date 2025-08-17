# Expanded Widget in Flutter

## Overview

The `Expanded` widget in Flutter is used to make a child of a `Row`, `Column`, or `Flex` expand to fill the available space. It's essential for creating flexible and responsive layouts.

## Key Features

- **Flexible Layout**: Automatically adjusts to available space
- **Flex Factor**: Controls how much space the widget takes relative to siblings
- **Responsive Design**: Adapts to different screen sizes
- **Layout Control**: Provides precise control over widget sizing

## Basic Usage

```dart
Row(
  children: [
    Expanded(
      flex: 2,
      child: Container(color: Colors.red),
    ),
    Expanded(
      flex: 1,
      child: Container(color: Colors.blue),
    ),
  ],
)
```

## Properties

### Required Properties

- `child`: The widget to expand (Widget)

### Optional Properties

- `flex`: The flex factor (int, default: 1)

## Examples

### Basic Expanded
```dart
Row(
  children: [
    Expanded(
      child: Container(color: Colors.red),
    ),
    Container(
      width: 100,
      color: Colors.blue,
    ),
  ],
)
```

### Expanded with Flex Factor
```dart
Row(
  children: [
    Expanded(
      flex: 2,
      child: Container(color: Colors.red),
    ),
    Expanded(
      flex: 1,
      child: Container(color: Colors.blue),
    ),
  ],
)
```

### Multiple Expanded Widgets
```dart
Column(
  children: [
    Expanded(
      flex: 1,
      child: Container(color: Colors.red),
    ),
    Expanded(
      flex: 2,
      child: Container(color: Colors.green),
    ),
    Expanded(
      flex: 1,
      child: Container(color: Colors.blue),
    ),
  ],
)
```

## Flex Factor Explained

The `flex` parameter determines how much space the `Expanded` widget takes relative to its siblings:

- `flex: 1` - Takes equal space with other flex: 1 widgets
- `flex: 2` - Takes twice as much space as flex: 1 widgets
- `flex: 3` - Takes three times as much space as flex: 1 widgets

## Common Use Cases

### 1. Responsive Layouts
```dart
Row(
  children: [
    Expanded(
      child: Text('This text will expand to fill available space'),
    ),
    Icon(Icons.star),
  ],
)
```

### 2. Sidebar Layout
```dart
Row(
  children: [
    Container(
      width: 200,
      child: Sidebar(),
    ),
    Expanded(
      child: MainContent(),
    ),
  ],
)
```

### 3. Form Layouts
```dart
Row(
  children: [
    Expanded(
      child: TextField(),
    ),
    SizedBox(width: 16),
    ElevatedButton(
      onPressed: () {},
      child: Text('Submit'),
    ),
  ],
)
```

## Best Practices

1. **Use Appropriate Flex Values**: Choose flex values that make sense for your layout
2. **Avoid Nested Expanded**: Don't nest Expanded widgets unnecessarily
3. **Consider Screen Sizes**: Test layouts on different screen sizes
4. **Use with Other Flex Widgets**: Combine with `Flexible` and `Spacer` for complex layouts

## Implementation in Demo App

In our demo app, the Expanded widget is used in:

- Dashboard layout sections
- Progress indicator containers
- Chart containers
- Dialog content areas

## Code Example from Demo

```dart
Column(
  children: [
    Expanded(
      flex: 2,
      child: Container(
        color: Colors.red,
        child: Center(child: Text('Expanded (flex: 2)')),
      ),
    ),
    Expanded(
      flex: 1,
      child: Container(
        color: Colors.blue,
        child: Center(child: Text('Expanded (flex: 1)')),
      ),
    ),
  ],
)
```

This creates a layout where the red container takes twice as much space as the blue container.

## Related Widgets

- `Flexible`: Similar to Expanded but doesn't force the child to fill available space
- `Spacer`: Creates flexible space between widgets
- `Row`: Horizontal flex container
- `Column`: Vertical flex container
- `Flex`: Custom flex container
