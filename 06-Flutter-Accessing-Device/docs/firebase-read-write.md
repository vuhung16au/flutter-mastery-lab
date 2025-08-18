# Flutter - Read and Write Data on Firebase

This document covers how to implement Firebase Firestore read and write operations in Flutter applications.

## Overview

Firebase Firestore is a NoSQL cloud database that allows you to store, sync, and query data for your mobile and web apps at global scale. This guide demonstrates how to integrate Firebase with Flutter for data persistence.

## Setup

### 1. Firebase Project Setup

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Add your Flutter app to the project
3. Download the configuration files:
   - `google-services.json` for Android (place in `android/app/`)
   - `GoogleService-Info.plist` for iOS (place in `ios/Runner/`)

### 2. Dependencies

Add the following dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  firebase_core: ^3.6.0
  firebase_auth: ^5.3.1
  cloud_firestore: ^5.4.1
  firebase_storage: ^12.3.1
```

### 3. Initialize Firebase

In your `main.dart`:

```dart
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
```

## Implementation

### Data Model

```dart
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String name;
  final String email;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

### Firebase Service

```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Write data
  Future<void> addUser(User user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toJson());
    } catch (e) {
      throw Exception('Failed to add user: $e');
    }
  }

  // Read data
  Future<User?> getUser(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return User.fromJson(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  // Update data
  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(userId).update(data);
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  // Delete data
  Future<void> deleteUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  // Real-time data stream
  Stream<List<User>> getUsersStream() {
    return _firestore
        .collection('users')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => User.fromJson(doc.data()))
            .toList());
  }

  // Query data
  Future<List<User>> searchUsers(String searchTerm) async {
    try {
      QuerySnapshot query = await _firestore
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: searchTerm)
          .where('name', isLessThan: searchTerm + '\uf8ff')
          .get();
      
      return query.docs
          .map((doc) => User.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to search users: $e');
    }
  }
}
```

### UI Implementation

```dart
class FirebaseDemoPage extends StatefulWidget {
  @override
  _FirebaseDemoPageState createState() => _FirebaseDemoPageState();
}

class _FirebaseDemoPageState extends State<FirebaseDemoPage> {
  final FirebaseService _firebaseService = FirebaseService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase Demo')),
      body: Column(
        children: [
          // Add User Form
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                ElevatedButton(
                  onPressed: _addUser,
                  child: Text('Add User'),
                ),
              ],
            ),
          ),
          
          // Real-time Users List
          Expanded(
            child: StreamBuilder<List<User>>(
              stream: _firebaseService.getUsersStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                
                List<User> users = snapshot.data ?? [];
                
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    User user = users[index];
                    return ListTile(
                      title: Text(user.name),
                      subtitle: Text(user.email),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteUser(user.id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addUser() async {
    try {
      User user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        email: _emailController.text,
        createdAt: DateTime.now(),
      );
      
      await _firebaseService.addUser(user);
      _nameController.clear();
      _emailController.clear();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User added successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _deleteUser(String userId) async {
    try {
      await _firebaseService.deleteUser(userId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User deleted successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
```

## Security Rules

Set up Firestore security rules in the Firebase Console:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

## Best Practices

1. **Error Handling**: Always wrap Firebase operations in try-catch blocks
2. **Data Validation**: Validate data before writing to Firestore
3. **Security Rules**: Implement proper security rules for your collections
4. **Offline Support**: Firestore provides offline support by default
5. **Batch Operations**: Use batch writes for multiple operations
6. **Real-time Updates**: Use streams for real-time data synchronization

## Common Operations

### Batch Writes

```dart
Future<void> batchWrite() async {
  WriteBatch batch = _firestore.batch();
  
  batch.set(_firestore.collection('users').doc('user1'), {'name': 'John'});
  batch.update(_firestore.collection('users').doc('user2'), {'age': 25});
  batch.delete(_firestore.collection('users').doc('user3'));
  
  await batch.commit();
}
```

### Transactions

```dart
Future<void> updateUserCount() async {
  await _firestore.runTransaction((transaction) async {
    DocumentReference userCountRef = _firestore.collection('stats').doc('userCount');
    DocumentSnapshot userCountDoc = await transaction.get(userCountRef);
    
    int currentCount = userCountDoc.data()?['count'] ?? 0;
    transaction.update(userCountRef, {'count': currentCount + 1});
  });
}
```

This implementation provides a complete Firebase integration for reading and writing data in Flutter applications.
