# Flutter - Arguments in Named Routes

## Overview
Arguments in named routes allow you to pass data between screens when using named route navigation. This component demonstrates how to pass various types of data through navigation while maintaining type safety and clean code structure.

## Key Concepts

### 1. Data Passing Methods
There are several ways to pass data with named routes:
- Constructor parameters (most common)
- Route arguments
- RouteSettings
- Global state management

### 2. Type Safety
Using constructor parameters provides compile-time type checking and better IDE support.

### 3. Data Validation
Arguments can be validated before being passed to ensure data integrity.

## Implementation

### Method 1: Constructor Parameters (Recommended)

#### Passing Data
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ArgumentsDetailPage(
      name: 'John Doe',
      age: 25,
      email: 'john@example.com',
    ),
  ),
);
```

#### Receiving Data
```dart
class ArgumentsDetailPage extends StatelessWidget {
  final String name;
  final int age;
  final String email;

  const ArgumentsDetailPage({
    super.key,
    required this.name,
    required this.age,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arguments Detail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: $name'),
            Text('Age: $age'),
            Text('Email: $email'),
          ],
        ),
      ),
    );
  }
}
```

### Method 2: Route Arguments

#### Setting up Route with Arguments
```dart
MaterialApp(
  onGenerateRoute: (settings) {
    if (settings.name == '/arguments-detail') {
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (context) => ArgumentsDetailPage(
          name: args['name'] as String,
          age: args['age'] as int,
          email: args['email'] as String,
        ),
      );
    }
    return null;
  },
)
```

#### Navigation with Arguments
```dart
Navigator.pushNamed(
  context,
  '/arguments-detail',
  arguments: {
    'name': 'John Doe',
    'age': 25,
    'email': 'john@example.com',
  },
);
```

### Method 3: Complex Data Objects

#### Creating Data Models
```dart
class UserData {
  final String name;
  final int age;
  final String email;
  final bool isActive;
  final List<String> interests;

  const UserData({
    required this.name,
    required this.age,
    required this.email,
    required this.isActive,
    required this.interests,
  });

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'email': email,
      'isActive': isActive,
      'interests': interests,
    };
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'] as String,
      age: json['age'] as int,
      email: json['email'] as String,
      isActive: json['isActive'] as bool,
      interests: List<String>.from(json['interests']),
    );
  }
}
```

#### Passing Complex Objects
```dart
final userData = UserData(
  name: 'Alice Johnson',
  age: 30,
  email: 'alice@example.com',
  isActive: true,
  interests: ['Flutter', 'Dart', 'Mobile Development'],
);

Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => UserDetailPage(userData: userData),
  ),
);
```

## Advanced Patterns

### 1. Optional Arguments
```dart
class DetailPage extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Map<String, dynamic>? extraData;

  const DetailPage({
    super.key,
    required this.title,
    this.subtitle,
    this.extraData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
        children: [
          if (subtitle != null) Text(subtitle!),
          if (extraData != null) 
            Text('Extra: ${extraData!['key']}'),
        ],
      ),
    );
  }
}
```

### 2. Argument Validation
```dart
class ArgumentsDetailPage extends StatelessWidget {
  final String name;
  final int age;
  final String email;

  const ArgumentsDetailPage({
    super.key,
    required this.name,
    required this.age,
    required this.email,
  }) : assert(name.isNotEmpty, 'Name cannot be empty'),
       assert(age > 0, 'Age must be positive'),
       assert(email.contains('@'), 'Invalid email format');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User: $name')),
      body: _buildUserInfo(),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      children: [
        _buildInfoCard('Name', name),
        _buildInfoCard('Age', age.toString()),
        _buildInfoCard('Email', email),
      ],
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Card(
      child: ListTile(
        title: Text(label),
        subtitle: Text(value),
      ),
    );
  }
}
```

### 3. Dynamic Arguments
```dart
class DynamicArgumentsPage extends StatelessWidget {
  final Map<String, dynamic> arguments;

  const DynamicArgumentsPage({
    super.key,
    required this.arguments,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dynamic Arguments')),
      body: ListView.builder(
        itemCount: arguments.length,
        itemBuilder: (context, index) {
          final key = arguments.keys.elementAt(index);
          final value = arguments[key];
          return ListTile(
            title: Text(key),
            subtitle: Text(value.toString()),
          );
        },
      ),
    );
  }
}
```

## Error Handling

### 1. Null Safety
```dart
class SafeArgumentsPage extends StatelessWidget {
  final String? name;
  final int? age;
  final String? email;

  const SafeArgumentsPage({
    super.key,
    this.name,
    this.age,
    this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Safe Arguments')),
      body: Column(
        children: [
          Text('Name: ${name ?? 'Not provided'}'),
          Text('Age: ${age?.toString() ?? 'Not provided'}'),
          Text('Email: ${email ?? 'Not provided'}'),
        ],
      ),
    );
  }
}
```

### 2. Type Checking
```dart
class TypeSafeArgumentsPage extends StatelessWidget {
  final Map<String, dynamic> arguments;

  const TypeSafeArgumentsPage({
    super.key,
    required this.arguments,
  });

  String? get name => arguments['name'] as String?;
  int? get age => arguments['age'] as int?;
  String? get email => arguments['email'] as String?;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Type Safe Arguments')),
      body: Column(
        children: [
          if (name != null) Text('Name: $name'),
          if (age != null) Text('Age: $age'),
          if (email != null) Text('Email: $email'),
        ],
      ),
    );
  }
}
```

## Best Practices

### 1. Use Strongly Typed Parameters
```dart
// Good
class UserDetailPage extends StatelessWidget {
  final User user;
  
  const UserDetailPage({super.key, required this.user});
}

// Avoid
class UserDetailPage extends StatelessWidget {
  final Map<String, dynamic> userData;
  
  const UserDetailPage({super.key, required this.userData});
}
```

### 2. Validate Arguments
```dart
class ValidatedArgumentsPage extends StatelessWidget {
  final String name;
  final int age;

  const ValidatedArgumentsPage({
    super.key,
    required this.name,
    required this.age,
  }) : assert(name.isNotEmpty, 'Name is required'),
       assert(age >= 0, 'Age must be non-negative');
}
```

### 3. Use Default Values
```dart
class DefaultArgumentsPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color backgroundColor;

  const DefaultArgumentsPage({
    super.key,
    required this.title,
    this.subtitle = 'Default subtitle',
    this.backgroundColor = Colors.white,
  });
}
```

### 4. Document Your Arguments
```dart
/// A page that displays user information
/// 
/// [userData] - The user data to display
/// [showEditButton] - Whether to show the edit button
/// [onEdit] - Callback when edit button is pressed
class UserDetailPage extends StatelessWidget {
  final UserData userData;
  final bool showEditButton;
  final VoidCallback? onEdit;

  const UserDetailPage({
    super.key,
    required this.userData,
    this.showEditButton = false,
    this.onEdit,
  });
}
```

## Testing

### 1. Unit Tests
```dart
testWidgets('displays user information correctly', (tester) async {
  final userData = UserData(
    name: 'Test User',
    age: 25,
    email: 'test@example.com',
    isActive: true,
    interests: ['Testing'],
  );

  await tester.pumpWidget(
    MaterialApp(
      home: UserDetailPage(userData: userData),
    ),
  );

  expect(find.text('Test User'), findsOneWidget);
  expect(find.text('25'), findsOneWidget);
  expect(find.text('test@example.com'), findsOneWidget);
});
```

### 2. Navigation Tests
```dart
testWidgets('navigates with correct arguments', (tester) async {
  await tester.pumpWidget(const MyApp());

  await tester.tap(find.text('User Details'));
  await tester.pumpAndSettle();

  expect(find.text('John Doe'), findsOneWidget);
  expect(find.text('25'), findsOneWidget);
});
```

## Conclusion

Arguments in named routes provide a flexible and type-safe way to pass data between screens in Flutter applications. By using constructor parameters, you can ensure compile-time type checking and better code maintainability. Always validate your arguments and handle edge cases to create robust navigation systems.
