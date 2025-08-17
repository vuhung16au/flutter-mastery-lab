# Checkbox Widget in Flutter

## Overview

The `Checkbox` widget in Flutter is used to create checkboxes for user input. It's commonly used for boolean selections, multiple choice questions, and settings toggles.

## Key Features

- **Boolean Selection**: Simple true/false selection
- **Customizable**: Color, size, and shape can be customized
- **State Management**: Integrates with state management systems
- **Accessibility**: Built-in accessibility support
- **Material Design**: Follows Material Design guidelines

## Basic Usage

```dart
Checkbox(
  value: isChecked,
  onChanged: (bool? value) {
    setState(() {
      isChecked = value ?? false;
    });
  },
)
```

## Properties

### Required Properties

- `value`: Current state of the checkbox (bool?)
- `onChanged`: Callback when checkbox state changes (ValueChanged<bool?>?)

### Optional Properties

- `activeColor`: Color when checkbox is checked (Color?)
- `checkColor`: Color of the check mark (Color?)
- `fillColor`: Color of the checkbox fill (MaterialStateProperty<Color?>?)
- `hoverColor`: Color when hovering over the checkbox (Color?)
- `focusColor`: Color when the checkbox has focus (Color?)
- `overlayColor`: Color of the overlay (MaterialStateProperty<Color?>?)
- `splashRadius`: Radius of the splash effect (double?)
- `materialTapTargetSize`: Size of the tap target (MaterialTapTargetSize?)
- `visualDensity`: Visual density of the checkbox (VisualDensity?)
- `autofocus`: Whether the checkbox should have focus (bool)
- `tristate`: Whether the checkbox can have three states (bool)

## Examples

### Basic Checkbox
```dart
bool isChecked = false;

Checkbox(
  value: isChecked,
  onChanged: (bool? value) {
    setState(() {
      isChecked = value ?? false;
    });
  },
)
```

### Checkbox with Custom Colors
```dart
Checkbox(
  value: isChecked,
  onChanged: (bool? value) {
    setState(() {
      isChecked = value ?? false;
    });
  },
  activeColor: Colors.green,
  checkColor: Colors.white,
)
```

### CheckboxListTile
```dart
CheckboxListTile(
  title: Text('Enable notifications'),
  subtitle: Text('Receive push notifications'),
  value: notificationsEnabled,
  onChanged: (bool? value) {
    setState(() {
      notificationsEnabled = value ?? false;
    });
  },
)
```

### Multiple Checkboxes
```dart
class MultipleCheckboxExample extends StatefulWidget {
  @override
  _MultipleCheckboxExampleState createState() => _MultipleCheckboxExampleState();
}

class _MultipleCheckboxExampleState extends State<MultipleCheckboxExample> {
  Map<String, bool> checkboxes = {
    'Option 1': false,
    'Option 2': false,
    'Option 3': false,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: checkboxes.entries.map((entry) {
        return CheckboxListTile(
          title: Text(entry.key),
          value: entry.value,
          onChanged: (bool? value) {
            setState(() {
              checkboxes[entry.key] = value ?? false;
            });
          },
        );
      }).toList(),
    );
  }
}
```

## Common Use Cases

### 1. Settings Toggles
```dart
CheckboxListTile(
  title: Text('Dark Mode'),
  subtitle: Text('Use dark theme'),
  value: isDarkMode,
  onChanged: (bool? value) {
    setState(() {
      isDarkMode = value ?? false;
    });
  },
)
```

### 2. Terms and Conditions
```dart
CheckboxListTile(
  title: Text('I agree to the terms and conditions'),
  value: agreedToTerms,
  onChanged: (bool? value) {
    setState(() {
      agreedToTerms = value ?? false;
    });
  },
)
```

### 3. Multiple Selection
```dart
List<String> selectedItems = [];

Column(
  children: ['Apple', 'Banana', 'Orange'].map((item) {
    return CheckboxListTile(
      title: Text(item),
      value: selectedItems.contains(item),
      onChanged: (bool? value) {
        setState(() {
          if (value == true) {
            selectedItems.add(item);
          } else {
            selectedItems.remove(item);
          }
        });
      },
    );
  }).toList(),
)
```

## Best Practices

1. **Use CheckboxListTile**: For better UX when you have text labels
2. **Provide Clear Labels**: Always include descriptive text
3. **Handle Null Values**: Always provide fallback values for null states
4. **Group Related Options**: Use consistent styling for related checkboxes
5. **Consider Accessibility**: Ensure checkboxes are accessible to screen readers

## Implementation in Demo App

In our demo app, checkboxes are used in:

- Settings tab for configuration options
- Interactive examples with different states
- Form validation examples

## Code Example from Demo

```dart
CheckboxListTile(
  title: const Text('Enable notifications'),
  subtitle: const Text('Receive push notifications'),
  value: true,
  onChanged: (bool? value) {
    // Handle checkbox change
  },
),
CheckboxListTile(
  title: const Text('Dark mode'),
  subtitle: const Text('Use dark theme'),
  value: false,
  onChanged: (bool? value) {
    // Handle checkbox change
  },
),
```

## State Management

### Using StatefulWidget
```dart
class CheckboxExample extends StatefulWidget {
  @override
  _CheckboxExampleState createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value ?? false;
        });
      },
    );
  }
}
```

### Using Provider/Riverpod
```dart
// With Provider
Consumer<CheckboxProvider>(
  builder: (context, provider, child) {
    return Checkbox(
      value: provider.isChecked,
      onChanged: (bool? value) {
        provider.toggleCheckbox(value ?? false);
      },
    );
  },
)
```

## Related Widgets

- `Switch`: Toggle switch for boolean values
- `Radio`: Single selection from multiple options
- `Slider`: Range selection widget
- `ToggleButtons`: Multiple toggle buttons
- `Chip`: Compact selection widget
