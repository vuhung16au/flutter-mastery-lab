# Progress Indicators in Flutter

## Overview

Flutter provides two main types of progress indicators: `LinearProgressIndicator` and `CircularProgressIndicator`. These widgets are used to show progress of operations or loading states in your application.

## Key Features

- **Linear Progress**: Horizontal progress bar
- **Circular Progress**: Circular spinning indicator
- **Determinate/Indeterminate**: Can show specific progress or infinite loading
- **Customizable**: Color, size, and styling can be customized
- **Accessible**: Built-in accessibility support

## Types of Progress Indicators

### 1. LinearProgressIndicator

A horizontal progress bar that can be either determinate (shows specific progress) or indeterminate (continuous animation).

### 2. CircularProgressIndicator

A circular spinning indicator that can also be determinate or indeterminate.

## Basic Usage

### Linear Progress Indicator
```dart
LinearProgressIndicator(value: 0.7)
```

### Circular Progress Indicator
```dart
CircularProgressIndicator()
```

## Properties

### LinearProgressIndicator Properties

- `value`: Progress value between 0.0 and 1.0 (double)
- `backgroundColor`: Color of the background track (Color)
- `valueColor`: Color of the progress bar (Color)
- `minHeight`: Minimum height of the progress bar (double)

### CircularProgressIndicator Properties

- `value`: Progress value between 0.0 and 1.0 (double)
- `backgroundColor`: Color of the background track (Color)
- `valueColor`: Color of the progress indicator (Color)
- `strokeWidth`: Width of the progress line (double)

## Examples

### Determinate Linear Progress
```dart
LinearProgressIndicator(
  value: 0.7,
  backgroundColor: Colors.grey[300],
  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
)
```

### Indeterminate Linear Progress
```dart
LinearProgressIndicator()
```

### Determinate Circular Progress
```dart
CircularProgressIndicator(
  value: 0.7,
  backgroundColor: Colors.grey[300],
  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
)
```

### Indeterminate Circular Progress
```dart
CircularProgressIndicator()
```

### Custom Styled Progress
```dart
LinearProgressIndicator(
  value: 0.8,
  backgroundColor: Colors.grey[200],
  valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
  minHeight: 10,
)
```

## Common Use Cases

### 1. File Upload Progress
```dart
Column(
  children: [
    Text('Uploading file...'),
    LinearProgressIndicator(value: uploadProgress),
    Text('${(uploadProgress * 100).toInt()}%'),
  ],
)
```

### 2. Loading States
```dart
Center(
  child: Column(
    children: [
      CircularProgressIndicator(),
      SizedBox(height: 16),
      Text('Loading...'),
    ],
  ),
)
```

### 3. Form Submission
```dart
ElevatedButton(
  onPressed: isSubmitting ? null : submitForm,
  child: isSubmitting 
    ? Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          SizedBox(width: 8),
          Text('Submitting...'),
        ],
      )
    : Text('Submit'),
)
```

## Best Practices

1. **Use Appropriate Type**: Choose linear for file operations, circular for general loading
2. **Provide Context**: Always include text or context with progress indicators
3. **Handle Edge Cases**: Consider what happens when progress is 0% or 100%
4. **Accessibility**: Ensure progress indicators are accessible to screen readers
5. **Performance**: Avoid unnecessary rebuilds when updating progress

## Implementation in Demo App

In our demo app, progress indicators are used in:

- Dashboard tab showing both linear and circular examples
- Settings tab for various loading states
- Interactive examples with different progress values

## Code Example from Demo

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const Text(
      'Progress Indicators',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    const SizedBox(height: 16),
    const LinearProgressIndicator(value: 0.7),
    const SizedBox(height: 8),
    const Text('Linear Progress: 70%'),
    const SizedBox(height: 16),
    const Center(child: CircularProgressIndicator()),
    const SizedBox(height: 8),
    const Center(child: Text('Circular Progress')),
  ],
)
```

## State Management

### Using StatefulWidget
```dart
class ProgressExample extends StatefulWidget {
  @override
  _ProgressExampleState createState() => _ProgressExampleState();
}

class _ProgressExampleState extends State<ProgressExample> {
  double _progress = 0.0;

  void _updateProgress() {
    setState(() {
      _progress += 0.1;
      if (_progress > 1.0) _progress = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(value: _progress),
        ElevatedButton(
          onPressed: _updateProgress,
          child: Text('Update Progress'),
        ),
      ],
    );
  }
}
```

## Related Widgets

- `RefreshIndicator`: Pull-to-refresh functionality
- `FutureBuilder`: For async operations with loading states
- `StreamBuilder`: For real-time data with progress
- `AnimatedBuilder`: For custom progress animations
