# Flutter - TextField

## 📖 Overview

The **TextField** widget is a Material Design text input widget that allows users to enter text. It's one of the most commonly used input widgets in Flutter applications for collecting user data, such as names, emails, passwords, and other text-based information.

## 🎯 What is TextField?

TextField is a widget that creates a text input field where users can type and edit text. It provides various customization options for styling, validation, and user interaction. TextField is essential for forms and any interface that requires user text input.

### Key Features

- **Text Input**: Allows users to enter and edit text
- **Customizable**: Extensive styling and decoration options
- **Validation**: Built-in support for input validation
- **Keyboard Types**: Different keyboard types for different input types
- **Accessibility**: Full accessibility support
- **Interactive**: Rich interaction capabilities

## 🏗️ Basic Structure

```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Enter your name',
    border: OutlineInputBorder(),
  ),
  onChanged: (value) {
    print('Text changed: $value');
  },
)
```

## 📋 Key Properties

### Essential Properties

| Property | Type | Description |
|----------|------|-------------|
| `controller` | TextEditingController | Controls the text being edited |
| `decoration` | InputDecoration | Visual styling and labels |
| `onChanged` | ValueChanged<String> | Called when text changes |
| `onSubmitted` | ValueChanged<String> | Called when user submits |
| `keyboardType` | TextInputType | Type of keyboard to show |

### Advanced Properties

| Property | Type | Description |
|----------|------|-------------|
| `obscureText` | bool | Whether to hide the text (for passwords) |
| `maxLines` | int | Maximum number of lines |
| `maxLength` | int | Maximum number of characters |
| `enabled` | bool | Whether the field is interactive |
| `readOnly` | bool | Whether the field is read-only |

## 🎨 Basic Usage Examples

### Simple TextField

```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Enter text',
  ),
)
```

### TextField with Border

```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Username',
    border: OutlineInputBorder(),
  ),
)
```

### Password TextField

```dart
TextField(
  obscureText: true,
  decoration: InputDecoration(
    labelText: 'Password',
    border: OutlineInputBorder(),
  ),
)
```

## 📚 Example in Our App

In the Flutter Widgets Demo app, we use TextField extensively:

```dart
// TextField Widget demonstration
TextField(
  controller: _nameController,
  decoration: const InputDecoration(
    labelText: 'Name',
    hintText: 'Enter your name',
    prefixIcon: Icon(Icons.person),
    border: OutlineInputBorder(),
  ),
),

const SizedBox(height: 16),

TextField(
  controller: _emailController,
  keyboardType: TextInputType.emailAddress,
  decoration: const InputDecoration(
    labelText: 'Email',
    hintText: 'Enter your email',
    prefixIcon: Icon(Icons.email),
    border: OutlineInputBorder(),
  ),
),

const SizedBox(height: 16),

TextField(
  controller: _passwordController,
  obscureText: _obscurePassword,
  decoration: InputDecoration(
    labelText: 'Password',
    hintText: 'Enter your password',
    prefixIcon: const Icon(Icons.lock),
    suffixIcon: IconButton(
      icon: Icon(
        _obscurePassword ? Icons.visibility : Icons.visibility_off,
      ),
      onPressed: () {
        setState(() {
          _obscurePassword = !_obscurePassword;
        });
      },
    ),
    border: const OutlineInputBorder(),
  ),
),
```

### Breakdown of Our TextField Usage

- **Name field**: Basic text input with person icon
- **Email field**: Email keyboard type with email icon
- **Password field**: Obscured text with visibility toggle
- **Controllers**: Manage text state
- **Decoration**: Consistent styling with borders and icons

## 🎯 Common Use Cases

### 1. Basic Form Input

```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Full Name',
    hintText: 'Enter your full name',
    prefixIcon: Icon(Icons.person),
    border: OutlineInputBorder(),
  ),
  onChanged: (value) {
    // Handle text changes
  },
)
```

### 2. Email Input

```dart
TextField(
  keyboardType: TextInputType.emailAddress,
  decoration: InputDecoration(
    labelText: 'Email Address',
    hintText: 'example@email.com',
    prefixIcon: Icon(Icons.email),
    border: OutlineInputBorder(),
  ),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  },
)
```

### 3. Password Input with Toggle

```dart
class PasswordTextField extends StatefulWidget {
  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        border: OutlineInputBorder(),
      ),
    );
  }
}
```

### 4. Search Input

```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Search',
    hintText: 'Search for items...',
    prefixIcon: Icon(Icons.search),
    suffixIcon: IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        // Clear search
      },
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
    ),
  ),
  onChanged: (value) {
    // Handle search
  },
)
```

### 5. Multi-line Text Input

```dart
TextField(
  maxLines: 3,
  decoration: InputDecoration(
    labelText: 'Description',
    hintText: 'Enter a description...',
    border: OutlineInputBorder(),
  ),
)
```

## 💡 Best Practices

### 1. Use Controllers for State Management

```dart
// ✅ Good: Use TextEditingController
class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _nameController,
      decoration: InputDecoration(labelText: 'Name'),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}

// ❌ Avoid: No controller management
TextField(
  decoration: InputDecoration(labelText: 'Name'),
  onChanged: (value) {
    // Hard to manage state
  },
)
```

### 2. Appropriate Keyboard Types

```dart
// ✅ Good: Use appropriate keyboard types
TextField(
  keyboardType: TextInputType.emailAddress,
  decoration: InputDecoration(labelText: 'Email'),
)

TextField(
  keyboardType: TextInputType.phone,
  decoration: InputDecoration(labelText: 'Phone'),
)

TextField(
  keyboardType: TextInputType.number,
  decoration: InputDecoration(labelText: 'Age'),
)

// ❌ Avoid: Wrong keyboard type
TextField(
  keyboardType: TextInputType.text, // Wrong for email
  decoration: InputDecoration(labelText: 'Email'),
)
```

### 3. Proper Validation

```dart
// ✅ Good: Proper validation
TextField(
  decoration: InputDecoration(
    labelText: 'Email',
    errorText: _emailError,
  ),
  onChanged: (value) {
    setState(() {
      if (value.isEmpty) {
        _emailError = 'Email is required';
      } else if (!value.contains('@')) {
        _emailError = 'Please enter a valid email';
      } else {
        _emailError = null;
      }
    });
  },
)

// ❌ Avoid: No validation
TextField(
  decoration: InputDecoration(labelText: 'Email'),
  // No validation
)
```

### 4. Consistent Styling

```dart
// ✅ Good: Consistent styling
class AppTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final IconData? prefixIcon;

  const AppTextField({
    required this.label,
    this.hint,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        border: OutlineInputBorder(),
      ),
    );
  }
}

// Usage
AppTextField(
  label: 'Name',
  hint: 'Enter your name',
  prefixIcon: Icons.person,
)

// ❌ Avoid: Inconsistent styling
TextField(
  decoration: InputDecoration(labelText: 'Name'), // No border
)
TextField(
  decoration: InputDecoration(
    labelText: 'Email',
    border: OutlineInputBorder(), // Different style
  ),
)
```

## 🔧 Advanced Features

### 1. TextField with Form Validation

```dart
class ValidatedForm extends StatefulWidget {
  @override
  _ValidatedFormState createState() => _ValidatedFormState();
}

class _ValidatedFormState extends State<ValidatedForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Form is valid
                print('Name: ${_nameController.text}');
                print('Email: ${_emailController.text}');
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
```

### 2. TextField with Auto-complete

```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Country',
    border: OutlineInputBorder(),
  ),
  onChanged: (value) {
    // Filter suggestions based on input
  },
  onTap: () {
    // Show suggestions
  },
)
```

### 3. TextField with Character Counter

```dart
TextField(
  maxLength: 100,
  decoration: InputDecoration(
    labelText: 'Description',
    border: OutlineInputBorder(),
    counterText: '${_textController.text.length}/100',
  ),
  controller: _textController,
  onChanged: (value) {
    setState(() {
      // Update counter
    });
  },
)
```

### 4. Animated TextField

```dart
class AnimatedTextField extends StatefulWidget {
  @override
  _AnimatedTextFieldState createState() => _AnimatedTextFieldState();
}

class _AnimatedTextFieldState extends State<AnimatedTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFocused = false;

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
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return TextField(
          decoration: InputDecoration(
            labelText: 'Animated Field',
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue,
                width: 2 * _animation.value,
              ),
            ),
          ),
          onTap: () {
            setState(() {
              _isFocused = true;
            });
            _controller.forward();
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

### 5. TextField with Custom Input Formatter

```dart
TextField(
  inputFormatters: [
    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Only numbers
    LengthLimitingTextInputFormatter(10), // Max 10 characters
  ],
  decoration: InputDecoration(
    labelText: 'Phone Number',
    border: OutlineInputBorder(),
  ),
)
```

### 6. TextField with Rich Text

```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Rich Text Input',
    border: OutlineInputBorder(),
  ),
  style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
  textCapitalization: TextCapitalization.sentences,
  textInputAction: TextInputAction.done,
  onSubmitted: (value) {
    // Handle submission
  },
)
```

## 🎯 Key Takeaways

1. **User Input**: TextField is essential for collecting user text input
2. **Controllers**: Use TextEditingController for proper state management
3. **Validation**: Implement proper validation for data integrity
4. **Accessibility**: TextField provides full accessibility support
5. **Customization**: Extensive styling and interaction options

## 📖 Further Reading

- [TextField API Documentation](https://api.flutter.dev/flutter/material/TextField-class.html)
- [TextEditingController API Documentation](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html)
- [Flutter Forms Tutorial](https://docs.flutter.dev/ui/forms)
- [Flutter Input and Form Widgets](https://docs.flutter.dev/development/ui/widgets/input)

---

**Previous**: [GridView Widget](grid-view.md) | **Next**: [Back to Documentation Overview](../README.md)
