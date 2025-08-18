# Implementing REST API in Flutter

This document covers how to implement REST API integration in Flutter applications using the `http` package and proper architecture patterns.

## Overview

REST API integration is essential for most modern Flutter applications. This guide demonstrates how to create a robust API layer with proper error handling, data models, and state management.

## Setup

### Dependencies

Add the following dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  http: ^1.2.2
  json_annotation: ^4.9.0

dev_dependencies:
  json_serializable: ^6.8.0
  build_runner: ^2.4.13
```

## Implementation

### Data Models

```dart
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String name;
  final String email;
  final String? avatar;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Post {
  final int id;
  final String title;
  final String body;
  final int userId;
  final List<String> tags;
  final int reactions;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    required this.tags,
    required this.reactions,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}

@JsonSerializable()
class ApiResponse<T> {
  final List<T> data;
  final int total;
  final int page;
  final int limit;
  final bool hasNext;

  ApiResponse({
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
    required this.hasNext,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return ApiResponse<T>(
      data: (json['data'] as List).map((item) => fromJsonT(item)).toList(),
      total: json['total'] as int,
      page: json['page'] as int,
      limit: json['limit'] as int,
      hasNext: json['hasNext'] as bool,
    );
  }
}
```

### API Service

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ApiService {
  static const String baseUrl = 'https://dummyjson.com';
  static const Duration timeout = Duration(seconds: 30);

  // HTTP Headers
  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Generic GET request
  static Future<T> get<T>(
    String endpoint, {
    Map<String, String>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint').replace(
        queryParameters: queryParameters,
      );

      final response = await http
          .get(uri, headers: _headers)
          .timeout(timeout);

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      throw ApiException('GET request failed: $e');
    }
  }

  // Generic POST request
  static Future<T> post<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final response = await http
          .post(
            uri,
            headers: _headers,
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(timeout);

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      throw ApiException('POST request failed: $e');
    }
  }

  // Generic PUT request
  static Future<T> put<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final response = await http
          .put(
            uri,
            headers: _headers,
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(timeout);

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      throw ApiException('PUT request failed: $e');
    }
  }

  // Generic DELETE request
  static Future<T> delete<T>(
    String endpoint, {
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final response = await http
          .delete(uri, headers: _headers)
          .timeout(timeout);

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      throw ApiException('DELETE request failed: $e');
    }
  }

  // Handle HTTP response
  static T _handleResponse<T>(
    http.Response response,
    T Function(Map<String, dynamic>)? fromJson,
  ) {
    if (kDebugMode) {
      print('API Response: ${response.statusCode} - ${response.body}');
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return null as T;
      }

      final jsonData = jsonDecode(response.body);
      
      if (fromJson != null) {
        return fromJson(jsonData);
      } else {
        return jsonData as T;
      }
    } else {
      throw ApiException(
        'HTTP ${response.statusCode}: ${response.reasonPhrase}',
        statusCode: response.statusCode,
      );
    }
  }
}

// Custom API Exception
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}
```

### Repository Pattern

```dart
class UserRepository {
  // Get all users
  static Future<ApiResponse<User>> getUsers({
    int page = 1,
    int limit = 10,
  }) async {
    return await ApiService.get<ApiResponse<User>>(
      '/users',
      queryParameters: {
        'page': page.toString(),
        'limit': limit.toString(),
      },
      fromJson: (json) => ApiResponse.fromJson(json, User.fromJson),
    );
  }

  // Get user by ID
  static Future<User> getUser(int id) async {
    return await ApiService.get<User>(
      '/users/$id',
      fromJson: User.fromJson,
    );
  }

  // Create new user
  static Future<User> createUser({
    required String name,
    required String email,
  }) async {
    return await ApiService.post<User>(
      '/users/add',
      body: {
        'name': name,
        'email': email,
      },
      fromJson: User.fromJson,
    );
  }

  // Update user
  static Future<User> updateUser({
    required int id,
    String? name,
    String? email,
  }) async {
    return await ApiService.put<User>(
      '/users/$id',
      body: {
        if (name != null) 'name': name,
        if (email != null) 'email': email,
      },
      fromJson: User.fromJson,
    );
  }

  // Delete user
  static Future<void> deleteUser(int id) async {
    await ApiService.delete('/users/$id');
  }
}

class PostRepository {
  // Get all posts
  static Future<ApiResponse<Post>> getPosts({
    int page = 1,
    int limit = 10,
  }) async {
    return await ApiService.get<ApiResponse<Post>>(
      '/posts',
      queryParameters: {
        'page': page.toString(),
        'limit': limit.toString(),
      },
      fromJson: (json) => ApiResponse.fromJson(json, Post.fromJson),
    );
  }

  // Get posts by user
  static Future<List<Post>> getPostsByUser(int userId) async {
    return await ApiService.get<List<Post>>(
      '/posts/user/$userId',
      fromJson: (json) => (json['posts'] as List)
          .map((post) => Post.fromJson(post))
          .toList(),
    );
  }

  // Create new post
  static Future<Post> createPost({
    required String title,
    required String body,
    required int userId,
    List<String>? tags,
  }) async {
    return await ApiService.post<Post>(
      '/posts/add',
      body: {
        'title': title,
        'body': body,
        'userId': userId,
        if (tags != null) 'tags': tags,
      },
      fromJson: Post.fromJson,
    );
  }
}
```

### State Management with Provider

```dart
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = [];
  bool _isLoading = false;
  String? _error;
  int _currentPage = 1;
  bool _hasNextPage = true;

  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasNextPage => _hasNextPage;

  Future<void> loadUsers({bool refresh = false}) async {
    if (_isLoading) return;

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      if (refresh) {
        _currentPage = 1;
        _users.clear();
      }

      final response = await UserRepository.getUsers(
        page: _currentPage,
        limit: 10,
      );

      if (refresh) {
        _users = response.data;
      } else {
        _users.addAll(response.data);
      }

      _currentPage = response.page + 1;
      _hasNextPage = response.hasNext;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createUser({
    required String name,
    required String email,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final newUser = await UserRepository.createUser(
        name: name,
        email: email,
      );

      _users.insert(0, newUser);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUser({
    required int id,
    String? name,
    String? email,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final updatedUser = await UserRepository.updateUser(
        id: id,
        name: name,
        email: email,
      );

      final index = _users.indexWhere((user) => user.id == id);
      if (index != -1) {
        _users[index] = updatedUser;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      _isLoading = true;
      notifyListeners();

      await UserRepository.deleteUser(id);
      _users.removeWhere((user) => user.id == id);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
```

### UI Implementation

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestApiDemoPage extends StatefulWidget {
  @override
  _RestApiDemoPageState createState() => _RestApiDemoPageState();
}

class _RestApiDemoPageState extends State<RestApiDemoPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().loadUsers(refresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REST API Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => context.read<UserProvider>().loadUsers(refresh: true),
          ),
        ],
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          if (userProvider.isLoading && userProvider.users.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          if (userProvider.error != null && userProvider.users.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 64, color: Colors.red),
                  SizedBox(height: 16),
                  Text(
                    'Error: ${userProvider.error}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => userProvider.loadUsers(refresh: true),
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Add User Form
              Card(
                margin: EdgeInsets.all(16.0),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add New User',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: userProvider.isLoading ? null : _addUser,
                              child: Text('Add User'),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _clearForm,
                              child: Text('Clear'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Users List
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => userProvider.loadUsers(refresh: true),
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: userProvider.users.length + 1,
                    itemBuilder: (context, index) {
                      if (index == userProvider.users.length) {
                        if (userProvider.hasNextPage) {
                          return Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(
                              child: ElevatedButton(
                                onPressed: userProvider.isLoading 
                                  ? null 
                                  : () => userProvider.loadUsers(),
                                child: Text('Load More'),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      }

                      final user = userProvider.users[index];
                      return Card(
                        margin: EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(user.name[0].toUpperCase()),
                          ),
                          title: Text(user.name),
                          subtitle: Text(user.email),
                          trailing: PopupMenuButton(
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'edit',
                                child: Text('Edit'),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                            ],
                            onSelected: (value) {
                              if (value == 'edit') {
                                _editUser(user);
                              } else if (value == 'delete') {
                                _deleteUser(user);
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _addUser() async {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty) {
      _showSnackBar('Please fill in all fields');
      return;
    }

    await context.read<UserProvider>().createUser(
      name: _nameController.text,
      email: _emailController.text,
    );

    _clearForm();
  }

  void _editUser(User user) {
    _nameController.text = user.name;
    _emailController.text = user.email;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await context.read<UserProvider>().updateUser(
                id: user.id,
                name: _nameController.text,
                email: _emailController.text,
              );
              Navigator.of(context).pop();
              _clearForm();
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  void _deleteUser(User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete User'),
        content: Text('Are you sure you want to delete ${user.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await context.read<UserProvider>().deleteUser(user.id);
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _clearForm() {
    _nameController.clear();
    _emailController.clear();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
```

## Advanced Features

### Caching with SharedPreferences

```dart
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static const String _usersKey = 'cached_users';
  static const String _lastUpdateKey = 'last_update';
  static const Duration _cacheExpiry = Duration(minutes: 5);

  static Future<void> cacheUsers(List<User> users) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = users.map((user) => user.toJson()).toList();
    await prefs.setString(_usersKey, jsonEncode(usersJson));
    await prefs.setInt(_lastUpdateKey, DateTime.now().millisecondsSinceEpoch);
  }

  static Future<List<User>?> getCachedUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final lastUpdate = prefs.getInt(_lastUpdateKey);
    
    if (lastUpdate == null) return null;

    final now = DateTime.now().millisecondsSinceEpoch;
    final difference = Duration(milliseconds: now - lastUpdate);

    if (difference > _cacheExpiry) {
      return null; // Cache expired
    }

    final usersJson = prefs.getString(_usersKey);
    if (usersJson == null) return null;

    final usersList = jsonDecode(usersJson) as List;
    return usersList.map((json) => User.fromJson(json)).toList();
  }

  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usersKey);
    await prefs.remove(_lastUpdateKey);
  }
}
```

### Offline Support

```dart
class OfflineUserRepository {
  static Future<List<User>> getUsersOffline() async {
    try {
      // Try to get cached data first
      final cachedUsers = await CacheService.getCachedUsers();
      if (cachedUsers != null) {
        return cachedUsers;
      }

      // If no cache, try API
      final response = await UserRepository.getUsers();
      await CacheService.cacheUsers(response.data);
      return response.data;
    } catch (e) {
      // If API fails, return empty list or throw error
      throw Exception('No internet connection and no cached data available');
    }
  }
}
```

## Best Practices

1. **Error Handling**: Always handle network errors gracefully
2. **Loading States**: Show loading indicators during API calls
3. **Caching**: Implement caching for better user experience
4. **Pagination**: Use pagination for large datasets
5. **Retry Logic**: Implement retry mechanisms for failed requests
6. **Offline Support**: Handle offline scenarios
7. **Security**: Use HTTPS and implement proper authentication
8. **Testing**: Write unit tests for API services

## Common Use Cases

### Authentication

```dart
class AuthService {
  static Future<String> login(String email, String password) async {
    final response = await ApiService.post<Map<String, dynamic>>(
      '/auth/login',
      body: {
        'email': email,
        'password': password,
      },
    );

    return response['token'] as String;
  }

  static Future<void> logout() async {
    await ApiService.post('/auth/logout');
  }
}
```

### File Upload

```dart
class FileUploadService {
  static Future<String> uploadFile(File file) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${ApiService.baseUrl}/upload'),
    );

    request.files.add(
      await http.MultipartFile.fromPath('file', file.path),
    );

    final response = await request.send();
    final responseData = await response.stream.bytesToString();
    final jsonData = jsonDecode(responseData);

    return jsonData['url'] as String;
  }
}
```

This implementation provides a comprehensive solution for implementing REST API integration in Flutter applications with proper architecture, error handling, and state management.
