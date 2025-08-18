# Flutter - Return Data from Screen

## Overview
Returning data from a screen is a common pattern in Flutter applications, especially for modal dialogs, selection screens, and configuration pages. This component demonstrates how to get data back from a screen when it's closed, using async/await patterns and proper result handling.

## Key Concepts

### 1. Async Navigation
Using `await` with `Navigator.push()` to wait for the result from the navigated screen.

### 2. Return Values
Screens can return data when they are popped from the navigation stack.

### 3. Result Handling
Processing the returned data in the calling screen with proper null checking.

## Implementation

### Basic Return Data Pattern

#### Sending Data Back
```dart
class SelectionPage extends StatelessWidget {
  const SelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select an Option'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Choose an option:'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 'Option A'),
              child: const Text('Option A'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 'Option B'),
              child: const Text('Option B'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 'Option C'),
              child: const Text('Option C'),
            ),
          ],
        ),
      ),
    );
  }
}
```

#### Receiving Data
```dart
class ReturnDataPage extends StatelessWidget {
  const ReturnDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Return Data from Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Return Data Demo'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectionPage(),
                  ),
                );
                if (result != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected: $result')),
                  );
                }
              },
              child: const Text('Select an Option'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Advanced Patterns

### 1. Complex Data Return

#### Returning Custom Objects
```dart
class UserSelection {
  final String name;
  final int age;
  final String email;

  const UserSelection({
    required this.name,
    required this.age,
    required this.email,
  });
}

class UserSelectionPage extends StatelessWidget {
  const UserSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select User')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('John Doe'),
            subtitle: const Text('john@example.com'),
            onTap: () => Navigator.pop(
              context,
              const UserSelection(
                name: 'John Doe',
                age: 25,
                email: 'john@example.com',
              ),
            ),
          ),
          ListTile(
            title: const Text('Jane Smith'),
            subtitle: const Text('jane@example.com'),
            onTap: () => Navigator.pop(
              context,
              const UserSelection(
                name: 'Jane Smith',
                age: 30,
                email: 'jane@example.com',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

#### Handling Complex Data
```dart
ElevatedButton(
  onPressed: () async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UserSelectionPage(),
      ),
    );
    
    if (result != null && result is UserSelection && context.mounted) {
      setState(() {
        selectedUser = result;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Selected: ${result.name}'),
        ),
      );
    }
  },
  child: const Text('Select User'),
)
```

### 2. Multiple Choice Selection

#### Returning Lists
```dart
class MultiSelectionPage extends StatefulWidget {
  const MultiSelectionPage({super.key});

  @override
  State<MultiSelectionPage> createState() => _MultiSelectionPageState();
}

class _MultiSelectionPageState extends State<MultiSelectionPage> {
  final List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi Selection'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, selectedItems),
            child: const Text('Done'),
          ),
        ],
      ),
      body: ListView(
        children: [
          'Item 1',
          'Item 2',
          'Item 3',
          'Item 4',
          'Item 5',
        ].map((item) => CheckboxListTile(
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
        )).toList(),
      ),
    );
  }
}
```

### 3. Form Data Return

#### Returning Form Results
```dart
class FormData {
  final String name;
  final String email;
  final bool isSubscribed;

  const FormData({
    required this.name,
    required this.email,
    required this.isSubscribed,
  });
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isSubscribed = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form'),
        actions: [
          TextButton(
            onPressed: _submitForm,
            child: const Text('Submit'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
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
              CheckboxListTile(
                title: const Text('Subscribe to newsletter'),
                value: _isSubscribed,
                onChanged: (bool? value) {
                  setState(() {
                    _isSubscribed = value ?? false;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final formData = FormData(
        name: _nameController.text,
        email: _emailController.text,
        isSubscribed: _isSubscribed,
      );
      Navigator.pop(context, formData);
    }
  }
}
```

## Error Handling

### 1. Null Safety
```dart
ElevatedButton(
  onPressed: () async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SelectionPage(),
      ),
    );
    
    // Handle null result (user cancelled)
    if (result == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No option selected')),
        );
      }
      return;
    }
    
    // Process the result
    if (context.mounted) {
      setState(() {
        selectedOption = result as String;
      });
    }
  },
  child: const Text('Select Option'),
)
```

### 2. Type Checking
```dart
ElevatedButton(
  onPressed: () async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UserSelectionPage(),
      ),
    );
    
    if (result != null && result is UserSelection && context.mounted) {
      // Safe to use result as UserSelection
      setState(() {
        selectedUser = result;
      });
    } else if (result != null && context.mounted) {
      // Handle unexpected type
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unexpected data type received'),
        ),
      );
    }
  },
  child: const Text('Select User'),
)
```

### 3. Context Safety
```dart
ElevatedButton(
  onPressed: () async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SelectionPage(),
      ),
    );
    
    // Always check if context is still mounted
    if (!context.mounted) return;
    
    if (result != null) {
      setState(() {
        selectedOption = result as String;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selected: $result')),
      );
    }
  },
  child: const Text('Select Option'),
)
```

## Best Practices

### 1. Use Appropriate Return Types
```dart
// Good - Clear return type
class SelectionResult {
  final String value;
  final bool isValid;

  const SelectionResult({
    required this.value,
    required this.isValid,
  });
}

// Avoid - Generic types
Navigator.pop(context, {'value': 'option', 'isValid': true});
```

### 2. Handle Cancellation
```dart
ElevatedButton(
  onPressed: () async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SelectionPage(),
      ),
    );
    
    // Always handle the case where user cancels
    if (result == null) {
      // User cancelled or went back
      return;
    }
    
    // Process the result
    _handleSelection(result);
  },
  child: const Text('Select'),
)
```

### 3. Use Loading States
```dart
class SelectionPage extends StatefulWidget {
  const SelectionPage({super.key});

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  bool _isLoading = false;

  Future<void> _processSelection(String option) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate async processing
      await Future.delayed(const Duration(seconds: 1));
      
      if (mounted) {
        Navigator.pop(context, option);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Option')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                ElevatedButton(
                  onPressed: () => _processSelection('Option A'),
                  child: const Text('Option A'),
                ),
                ElevatedButton(
                  onPressed: () => _processSelection('Option B'),
                  child: const Text('Option B'),
                ),
              ],
            ),
    );
  }
}
```

## Testing

### 1. Unit Tests
```dart
testWidgets('returns selected option', (tester) async {
  String? result;
  
  await tester.pumpWidget(
    MaterialApp(
      home: Builder(
        builder: (context) => ElevatedButton(
          onPressed: () async {
            result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectionPage(),
              ),
            );
          },
          child: const Text('Select'),
        ),
      ),
    ),
  );

  await tester.tap(find.text('Select'));
  await tester.pumpAndSettle();

  await tester.tap(find.text('Option A'));
  await tester.pumpAndSettle();

  expect(result, equals('Option A'));
});
```

### 2. Integration Tests
```dart
testWidgets('complete selection flow', (tester) async {
  await tester.pumpWidget(const MyApp());

  await tester.tap(find.text('Select an Option'));
  await tester.pumpAndSettle();

  await tester.tap(find.text('Option B'));
  await tester.pumpAndSettle();

  expect(find.text('Selected: Option B'), findsOneWidget);
});
```

## Common Use Cases

### 1. Settings/Configuration
```dart
// Return user preferences
class SettingsResult {
  final ThemeMode themeMode;
  final String language;
  final bool notificationsEnabled;

  const SettingsResult({
    required this.themeMode,
    required this.language,
    required this.notificationsEnabled,
  });
}
```

### 2. File/Image Selection
```dart
// Return selected file information
class FileSelectionResult {
  final String filePath;
  final String fileName;
  final int fileSize;

  const FileSelectionResult({
    required this.filePath,
    required this.fileName,
    required this.fileSize,
  });
}
```

### 3. Date/Time Selection
```dart
// Return selected date/time
class DateTimeSelectionResult {
  final DateTime selectedDateTime;
  final bool isAllDay;

  const DateTimeSelectionResult({
    required this.selectedDateTime,
    required this.isAllDay,
  });
}
```

## Conclusion

Returning data from screens is a powerful pattern in Flutter that enables rich user interactions and data flow between screens. By following best practices for null safety, type checking, and error handling, you can create robust and user-friendly applications that properly handle user selections and form submissions.
