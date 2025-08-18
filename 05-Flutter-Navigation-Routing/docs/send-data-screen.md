# Flutter - Send Data to Screen

## Overview
Sending data to screens is a fundamental pattern in Flutter navigation. This component demonstrates various methods for passing data between screens, including custom objects, complex data structures, and different data passing strategies.

## Key Concepts

### 1. Data Passing Methods
- Constructor parameters (most common and type-safe)
- Route arguments
- Global state management
- Callback functions

### 2. Type Safety
Using strongly typed parameters ensures compile-time safety and better IDE support.

### 3. Data Validation
Validating data before passing it to ensure data integrity and prevent runtime errors.

## Implementation

### Basic Data Passing

#### Custom Data Objects
```dart
class UserData {
  final String name;
  final String email;
  final int age;
  final bool isActive;

  const UserData({
    required this.name,
    required this.email,
    required this.age,
    required this.isActive,
  });

  @override
  String toString() {
    return 'UserData(name: $name, email: $email, age: $age, isActive: $isActive)';
  }
}

class SendDataPage extends StatelessWidget {
  const SendDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Data to Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Send Data Demo'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final userData = UserData(
                  name: 'John Doe',
                  email: 'john@example.com',
                  age: 25,
                  isActive: true,
                );
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DataReceiverPage(userData: userData),
                  ),
                );
              },
              child: const Text('Send User Data'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final userData = UserData(
                  name: 'Jane Smith',
                  email: 'jane@example.com',
                  age: 30,
                  isActive: false,
                );
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DataReceiverPage(userData: userData),
                  ),
                );
              },
              child: const Text('Send Another User'),
            ),
          ],
        ),
      ),
    );
  }
}

class DataReceiverPage extends StatelessWidget {
  final UserData userData;

  const DataReceiverPage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User: ${userData.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard('Name', userData.name),
            _buildInfoCard('Email', userData.email),
            _buildInfoCard('Age', userData.age.toString()),
            _buildInfoCard('Status', userData.isActive ? 'Active' : 'Inactive'),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Go Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(label),
        subtitle: Text(value),
      ),
    );
  }
}
```

## Advanced Data Passing Patterns

### 1. Complex Data Structures

#### Nested Objects and Lists
```dart
class Address {
  final String street;
  final String city;
  final String state;
  final String zipCode;

  const Address({
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
  });

  @override
  String toString() {
    return '$street, $city, $state $zipCode';
  }
}

class Order {
  final String id;
  final List<String> items;
  final double total;
  final DateTime orderDate;
  final Address shippingAddress;

  const Order({
    required this.id,
    required this.items,
    required this.total,
    required this.orderDate,
    required this.shippingAddress,
  });
}

class ComplexDataPage extends StatelessWidget {
  const ComplexDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Order(
      id: 'ORD-12345',
      items: ['Laptop', 'Mouse', 'Keyboard'],
      total: 1299.99,
      orderDate: DateTime.now(),
      shippingAddress: const Address(
        street: '123 Main St',
        city: 'New York',
        state: 'NY',
        zipCode: '10001',
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Complex Data')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderDetailPage(order: order),
              ),
            );
          },
          child: const Text('View Order Details'),
        ),
      ),
    );
  }
}

class OrderDetailPage extends StatelessWidget {
  final Order order;

  const OrderDetailPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order ${order.id}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('Order Information', [
              _buildInfoRow('Order ID', order.id),
              _buildInfoRow('Order Date', _formatDate(order.orderDate)),
              _buildInfoRow('Total', '\$${order.total.toStringAsFixed(2)}'),
            ]),
            const SizedBox(height: 20),
            _buildSection('Items', [
              for (int i = 0; i < order.items.length; i++)
                _buildInfoRow('Item ${i + 1}', order.items[i]),
            ]),
            const SizedBox(height: 20),
            _buildSection('Shipping Address', [
              _buildInfoRow('Street', order.shippingAddress.street),
              _buildInfoRow('City', order.shippingAddress.city),
              _buildInfoRow('State', order.shippingAddress.state),
              _buildInfoRow('ZIP Code', order.shippingAddress.zipCode),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return ListTile(
      title: Text(label),
      subtitle: Text(value),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
```

### 2. Data with Callbacks

#### Passing Functions as Data
```dart
class CallbackDataPage extends StatefulWidget {
  const CallbackDataPage({super.key});

  @override
  State<CallbackDataPage> createState() => _CallbackDataPageState();
}

class _CallbackDataPageState extends State<CallbackDataPage> {
  String _selectedColor = 'No color selected';

  void _onColorSelected(String color) {
    setState(() {
      _selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Callback Data')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected Color: $_selectedColor',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ColorPickerPage(
                      onColorSelected: _onColorSelected,
                    ),
                  ),
                );
              },
              child: const Text('Pick a Color'),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorPickerPage extends StatelessWidget {
  final Function(String) onColorSelected;

  const ColorPickerPage({super.key, required this.onColorSelected});

  @override
  Widget build(BuildContext context) {
    final colors = ['Red', 'Green', 'Blue', 'Yellow', 'Purple', 'Orange'];

    return Scaffold(
      appBar: AppBar(title: const Text('Color Picker')),
      body: ListView.builder(
        itemCount: colors.length,
        itemBuilder: (context, index) {
          final color = colors[index];
          return ListTile(
            title: Text(color),
            leading: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: _getColorFromName(color),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onTap: () {
              onColorSelected(color);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  Color _getColorFromName(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'yellow':
        return Colors.yellow;
      case 'purple':
        return Colors.purple;
      case 'orange':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
```

### 3. Data with Validation

#### Validated Data Objects
```dart
class ValidatedUserData {
  final String name;
  final String email;
  final int age;
  final String phoneNumber;

  const ValidatedUserData({
    required this.name,
    required this.email,
    required this.age,
    required this.phoneNumber,
  }) : assert(name.isNotEmpty, 'Name cannot be empty'),
       assert(email.contains('@'), 'Invalid email format'),
       assert(age >= 0, 'Age must be non-negative'),
       assert(phoneNumber.length >= 10, 'Phone number too short');

  bool get isValidEmail {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
  }

  bool get isAdult => age >= 18;

  String get displayName {
    if (name.length > 20) {
      return '${name.substring(0, 20)}...';
    }
    return name;
  }

  @override
  String toString() {
    return 'ValidatedUserData(name: $name, email: $email, age: $age, phone: $phoneNumber)';
  }
}

class ValidatedDataPage extends StatelessWidget {
  const ValidatedDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Validated Data')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                try {
                  final userData = ValidatedUserData(
                    name: 'John Doe',
                    email: 'john@example.com',
                    age: 25,
                    phoneNumber: '1234567890',
                  );
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ValidatedDataReceiverPage(
                        userData: userData,
                      ),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Validation error: $e')),
                  );
                }
              },
              child: const Text('Send Valid Data'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                try {
                  final userData = ValidatedUserData(
                    name: '', // This will cause validation error
                    email: 'invalid-email',
                    age: -5,
                    phoneNumber: '123',
                  );
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ValidatedDataReceiverPage(
                        userData: userData,
                      ),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Validation error: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Send Invalid Data'),
            ),
          ],
        ),
      ),
    );
  }
}

class ValidatedDataReceiverPage extends StatelessWidget {
  final ValidatedUserData userData;

  const ValidatedDataReceiverPage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User: ${userData.displayName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard('Name', userData.name),
            _buildInfoCard('Email', userData.email),
            _buildInfoCard('Age', '${userData.age} (${userData.isAdult ? 'Adult' : 'Minor'})'),
            _buildInfoCard('Phone', userData.phoneNumber),
            const SizedBox(height: 20),
            Card(
              color: userData.isValidEmail ? Colors.green.shade50 : Colors.red.shade50,
              child: ListTile(
                title: Text('Email Validation'),
                subtitle: Text(
                  userData.isValidEmail ? 'Valid email format' : 'Invalid email format',
                ),
                leading: Icon(
                  userData.isValidEmail ? Icons.check : Icons.error,
                  color: userData.isValidEmail ? Colors.green : Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Go Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(label),
        subtitle: Text(value),
      ),
    );
  }
}
```

## Data Passing Strategies

### 1. Multiple Data Objects
```dart
class MultiDataPage extends StatelessWidget {
  const MultiDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = UserData(
      name: 'Alice Johnson',
      email: 'alice@example.com',
      age: 28,
      isActive: true,
    );

    final settings = {
      'theme': 'dark',
      'notifications': true,
      'language': 'en',
    };

    final preferences = ['Flutter', 'Dart', 'Mobile Development'];

    return Scaffold(
      appBar: AppBar(title: const Text('Multiple Data Objects')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiDataReceiverPage(
                      userData: userData,
                      settings: settings,
                      preferences: preferences,
                    ),
                  ),
                );
              },
              child: const Text('Send Multiple Data Objects'),
            ),
          ],
        ),
      ),
    );
  }
}

class MultiDataReceiverPage extends StatelessWidget {
  final UserData userData;
  final Map<String, dynamic> settings;
  final List<String> preferences;

  const MultiDataReceiverPage({
    super.key,
    required this.userData,
    required this.settings,
    required this.preferences,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data for ${userData.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('User Information', [
              _buildInfoRow('Name', userData.name),
              _buildInfoRow('Email', userData.email),
              _buildInfoRow('Age', userData.age.toString()),
              _buildInfoRow('Status', userData.isActive ? 'Active' : 'Inactive'),
            ]),
            const SizedBox(height: 20),
            _buildSection('Settings', [
              for (final entry in settings.entries)
                _buildInfoRow(entry.key, entry.value.toString()),
            ]),
            const SizedBox(height: 20),
            _buildSection('Preferences', [
              for (int i = 0; i < preferences.length; i++)
                _buildInfoRow('Preference ${i + 1}', preferences[i]),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Card(child: Column(children: children)),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return ListTile(
      title: Text(label),
      subtitle: Text(value),
    );
  }
}
```

### 2. Optional Data Parameters
```dart
class OptionalDataPage extends StatelessWidget {
  const OptionalDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Optional Data')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OptionalDataReceiverPage(
                      title: 'Required Title',
                      subtitle: 'Optional Subtitle',
                      extraData: {'key': 'value'},
                    ),
                  ),
                );
              },
              child: const Text('Send with All Data'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OptionalDataReceiverPage(
                      title: 'Required Title Only',
                    ),
                  ),
                );
              },
              child: const Text('Send with Minimal Data'),
            ),
          ],
        ),
      ),
    );
  }
}

class OptionalDataReceiverPage extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Map<String, dynamic>? extraData;

  const OptionalDataReceiverPage({
    super.key,
    required this.title,
    this.subtitle,
    this.extraData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard('Title', title),
            if (subtitle != null) _buildInfoCard('Subtitle', subtitle!),
            if (extraData != null) ...[
              const SizedBox(height: 20),
              const Text(
                'Extra Data:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Card(
                child: Column(
                  children: extraData!.entries.map((entry) {
                    return ListTile(
                      title: Text(entry.key),
                      subtitle: Text(entry.value.toString()),
                    );
                  }).toList(),
                ),
              ),
            ],
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Go Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(label),
        subtitle: Text(value),
      ),
    );
  }
}
```

## Best Practices

### 1. Data Validation
```dart
class DataValidator {
  static String? validateEmail(String email) {
    if (email.isEmpty) return 'Email is required';
    if (!email.contains('@')) return 'Invalid email format';
    return null;
  }

  static String? validateAge(int age) {
    if (age < 0) return 'Age cannot be negative';
    if (age > 150) return 'Age seems invalid';
    return null;
  }

  static String? validatePhone(String phone) {
    if (phone.isEmpty) return 'Phone number is required';
    if (phone.length < 10) return 'Phone number too short';
    return null;
  }
}
```

### 2. Data Serialization
```dart
class SerializableUserData {
  final String name;
  final String email;
  final int age;

  const SerializableUserData({
    required this.name,
    required this.email,
    required this.age,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'age': age,
    };
  }

  factory SerializableUserData.fromJson(Map<String, dynamic> json) {
    return SerializableUserData(
      name: json['name'] as String,
      email: json['email'] as String,
      age: json['age'] as int,
    );
  }

  SerializableUserData copyWith({
    String? name,
    String? email,
    int? age,
  }) {
    return SerializableUserData(
      name: name ?? this.name,
      email: email ?? this.email,
      age: age ?? this.age,
    );
  }
}
```

## Testing

### 1. Data Passing Tests
```dart
testWidgets('passes user data correctly', (tester) async {
  final userData = UserData(
    name: 'Test User',
    email: 'test@example.com',
    age: 25,
    isActive: true,
  );

  await tester.pumpWidget(
    MaterialApp(
      home: DataReceiverPage(userData: userData),
    ),
  );

  expect(find.text('Test User'), findsOneWidget);
  expect(find.text('test@example.com'), findsOneWidget);
  expect(find.text('25'), findsOneWidget);
});
```

### 2. Validation Tests
```dart
test('validates user data correctly', () {
  expect(
    () => ValidatedUserData(
      name: '',
      email: 'invalid',
      age: -1,
      phoneNumber: '123',
    ),
    throwsA(isA<AssertionError>()),
  );
});
```

## Conclusion

Sending data to screens is a crucial aspect of Flutter navigation. By using strongly typed parameters, implementing proper validation, and following best practices for data serialization, you can create robust and maintainable applications. Always validate your data and handle edge cases to ensure a smooth user experience.
