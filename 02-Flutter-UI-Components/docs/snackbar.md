# Snackbar in Flutter

## Overview

The `SnackBar` widget in Flutter is used to display brief messages to users at the bottom of the screen. It's perfect for showing feedback, notifications, and temporary information without interrupting the user's workflow.

## Key Features

- **Temporary Display**: Automatically disappears after a set duration
- **Non-intrusive**: Doesn't block user interaction
- **Customizable**: Color, duration, and content can be customized
- **Action Buttons**: Can include action buttons for user interaction
- **Accessibility**: Built-in accessibility support

## Basic Usage

```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('This is a SnackBar message'),
    duration: Duration(seconds: 2),
  ),
)
```

## Properties

### Required Properties

- `content`: The main content of the SnackBar (Widget)

### Optional Properties

- `backgroundColor`: Background color of the SnackBar (Color?)
- `elevation`: Elevation of the SnackBar (double?)
- `margin`: Margin around the SnackBar (EdgeInsetsGeometry?)
- `padding`: Padding inside the SnackBar (EdgeInsetsGeometry?)
- `width`: Width of the SnackBar (double?)
- `shape`: Shape of the SnackBar (ShapeBorder?)
- `behavior`: How the SnackBar should behave (SnackBarBehavior?)
- `action`: Action button (SnackBarAction?)
- `duration`: How long the SnackBar should be displayed (Duration?)
- `animation`: Animation for showing/hiding the SnackBar (Animation<double>?)
- `onVisible`: Callback when SnackBar becomes visible (VoidCallback?)

## Examples

### Basic SnackBar
```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Operation completed successfully'),
  ),
)
```

### SnackBar with Custom Duration
```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Message will disappear in 5 seconds'),
    duration: Duration(seconds: 5),
  ),
)
```

### SnackBar with Action Button
```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Item deleted'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Undo the deletion
      },
    ),
  ),
)
```

### Custom Styled SnackBar
```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Custom styled SnackBar'),
    backgroundColor: Colors.green,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    margin: EdgeInsets.all(10),
  ),
)
```

### SnackBar with Icon
```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Row(
      children: [
        Icon(Icons.check_circle, color: Colors.white),
        SizedBox(width: 8),
        Text('Success!'),
      ],
    ),
    backgroundColor: Colors.green,
  ),
)
```

## Common Use Cases

### 1. Success Messages
```dart
void showSuccessMessage() {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Operation completed successfully'),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    ),
  );
}
```

### 2. Error Messages
```dart
void showErrorMessage(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ),
  );
}
```

### 3. Undo Actions
```dart
void deleteItem() {
  // Delete the item
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Item deleted'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Restore the item
        },
      ),
    ),
  );
}
```

### 4. Network Status
```dart
void showNetworkStatus(bool isConnected) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        isConnected ? 'Connected to network' : 'No internet connection'
      ),
      backgroundColor: isConnected ? Colors.green : Colors.red,
      duration: Duration(seconds: 3),
    ),
  );
}
```

## Best Practices

1. **Keep Messages Short**: SnackBar messages should be concise and clear
2. **Use Appropriate Duration**: 2-4 seconds is usually sufficient
3. **Provide Actions When Needed**: Include undo/retry actions for destructive operations
4. **Use Consistent Styling**: Maintain consistent colors and styling across your app
5. **Consider Accessibility**: Ensure messages are accessible to screen readers
6. **Don't Overuse**: Avoid showing too many SnackBars in quick succession

## Implementation in Demo App

In our demo app, SnackBar is used in:

- Slidable actions for delete/archive operations
- User feedback for various interactions
- Demo examples showing different SnackBar configurations

## Code Example from Demo

```dart
ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Text('This is a Snackbar example!'),
    duration: Duration(seconds: 2),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: null,
    ),
  ),
)
```

## Global SnackBar Management

### Using ScaffoldMessenger
```dart
// Show SnackBar globally
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text('Global message')),
);

// Hide current SnackBar
ScaffoldMessenger.of(context).hideCurrentSnackBar();

// Remove all SnackBars
ScaffoldMessenger.of(context).removeCurrentSnackBar();
```

### Custom SnackBar Service
```dart
class SnackBarService {
  static void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  static void showInfo(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
```

## Related Widgets

- `Toast`: Alternative to SnackBar for brief messages
- `Dialog`: Modal dialogs for more important messages
- `Banner`: Banner messages at the top of the screen
- `Tooltip`: Hover tooltips for additional information
- `AlertDialog`: Confirmation dialogs for important actions
