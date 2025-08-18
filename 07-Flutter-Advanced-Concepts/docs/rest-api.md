# Implementing REST API in Flutter

## Overview
This document covers how to implement REST API integration in Flutter applications using both the `http` package and `dio` package. It includes best practices for making HTTP requests, handling responses, and managing API state.

## Dependencies
```yaml
dependencies:
  http: ^1.2.2
  dio: ^5.4.3
  json_annotation: ^4.9.0

dev_dependencies:
  json_serializable: ^6.8.0
  build_runner: ^2.4.13
```

## Basic HTTP Implementation

### Simple GET Request
```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  static Future<List<dynamic>> getPosts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/posts'));
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
```

### POST Request
```dart
class ApiService {
  static Future<Map<String, dynamic>> createPost({
    required String title,
    required String body,
    required int userId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'title': title,
          'body': body,
          'userId': userId,
        }),
      );

      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to create post');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
```

## Advanced HTTP Implementation

### HTTP Client with Interceptors
```dart
class ApiClient {
  static final http.Client _client = http.Client();
  static const String baseUrl = 'https://api.example.com';
  static const String apiKey = 'your-api-key';

  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
    'Accept': 'application/json',
  };

  static Future<http.Response> get(String endpoint) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
      );
      return _handleResponse(response);
    } catch (e) {
      throw ApiException('GET request failed: $e');
    }
  }

  static Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
        body: json.encode(data),
      );
      return _handleResponse(response);
    } catch (e) {
      throw ApiException('POST request failed: $e');
    }
  }

  static Future<http.Response> put(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _client.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
        body: json.encode(data),
      );
      return _handleResponse(response);
    } catch (e) {
      throw ApiException('PUT request failed: $e');
    }
  }

  static Future<http.Response> delete(String endpoint) async {
    try {
      final response = await _client.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
      );
      return _handleResponse(response);
    } catch (e) {
      throw ApiException('DELETE request failed: $e');
    }
  }

  static http.Response _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      throw ApiException('HTTP ${response.statusCode}: ${response.reasonPhrase}');
    }
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}
```

## Dio Implementation

### Basic Dio Setup
```dart
import 'package:dio/dio.dart';

class DioClient {
  static Dio? _dio;
  
  static Dio get dio {
    _dio ??= Dio(BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));
    
    // Add interceptors
    _dio!.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
    
    return _dio!;
  }
}
```

### Dio with Interceptors
```dart
class ApiService {
  static final Dio _dio = DioClient.dio;

  static void setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add auth token
          options.headers['Authorization'] = 'Bearer ${getAuthToken()}';
          handler.next(options);
        },
        onResponse: (response, handler) {
          // Handle successful responses
          handler.next(response);
        },
        onError: (error, handler) {
          // Handle errors
          if (error.response?.statusCode == 401) {
            // Handle unauthorized
            handleUnauthorized();
          }
          handler.next(error);
        },
      ),
    );
  }

  static String? getAuthToken() {
    // Get token from secure storage
    return null;
  }

  static void handleUnauthorized() {
    // Handle unauthorized access
    print('Unauthorized access');
  }
}
```

## Data Models

### Post Model
```dart
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  final int id;
  final String title;
  final String body;
  final int userId;

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
```

### User Model
```dart
@JsonSerializable()
class User {
  final int id;
  final String name;
  final String email;
  final String phone;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

## API Service Implementation

### Complete API Service
```dart
class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static final Dio _dio = DioClient.dio;

  // GET requests
  static Future<List<Post>> getPosts() async {
    try {
      final response = await _dio.get('/posts');
      return (response.data as List)
          .map((json) => Post.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw ApiException('Failed to fetch posts: ${e.message}');
    }
  }

  static Future<Post> getPost(int id) async {
    try {
      final response = await _dio.get('/posts/$id');
      return Post.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException('Failed to fetch post: ${e.message}');
    }
  }

  static Future<List<User>> getUsers() async {
    try {
      final response = await _dio.get('/users');
      return (response.data as List)
          .map((json) => User.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw ApiException('Failed to fetch users: ${e.message}');
    }
  }

  // POST requests
  static Future<Post> createPost(Post post) async {
    try {
      final response = await _dio.post('/posts', data: post.toJson());
      return Post.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException('Failed to create post: ${e.message}');
    }
  }

  // PUT requests
  static Future<Post> updatePost(Post post) async {
    try {
      final response = await _dio.put('/posts/${post.id}', data: post.toJson());
      return Post.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException('Failed to update post: ${e.message}');
    }
  }

  // DELETE requests
  static Future<void> deletePost(int id) async {
    try {
      await _dio.delete('/posts/$id');
    } on DioException catch (e) {
      throw ApiException('Failed to delete post: ${e.message}');
    }
  }
}
```

## State Management with Provider

### API Provider
```dart
import 'package:flutter/foundation.dart';

class ApiProvider with ChangeNotifier {
  List<Post> _posts = [];
  List<User> _users = [];
  bool _isLoading = false;
  String? _error;

  List<Post> get posts => _posts;
  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchPosts() async {
    _setLoading(true);
    try {
      _posts = await ApiService.getPosts();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchUsers() async {
    _setLoading(true);
    try {
      _users = await ApiService.getUsers();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> createPost(Post post) async {
    _setLoading(true);
    try {
      final newPost = await ApiService.createPost(post);
      _posts.add(newPost);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
```

## UI Components

### Posts List Widget
```dart
class PostsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProvider>(
      builder: (context, apiProvider, child) {
        if (apiProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (apiProvider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${apiProvider.error}'),
                ElevatedButton(
                  onPressed: () => apiProvider.fetchPosts(),
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: apiProvider.posts.length,
          itemBuilder: (context, index) {
            final post = apiProvider.posts[index];
            return ListTile(
              title: Text(post.title),
              subtitle: Text(post.body),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deletePost(context, post.id),
              ),
            );
          },
        );
      },
    );
  }

  void _deletePost(BuildContext context, int id) async {
    try {
      await ApiService.deletePost(id);
      // Refresh the list
      context.read<ApiProvider>().fetchPosts();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete post: $e')),
      );
    }
  }
}
```

### Create Post Form
```dart
class CreatePostForm extends StatefulWidget {
  @override
  _CreatePostFormState createState() => _CreatePostFormState();
}

class _CreatePostFormState extends State<CreatePostForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _bodyController,
            decoration: InputDecoration(labelText: 'Body'),
            maxLines: 3,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a body';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _createPost,
            child: Text('Create Post'),
          ),
        ],
      ),
    );
  }

  void _createPost() async {
    if (_formKey.currentState!.validate()) {
      final post = Post(
        id: 0, // Will be assigned by the server
        title: _titleController.text,
        body: _bodyController.text,
        userId: 1, // Default user ID
      );

      try {
        await context.read<ApiProvider>().createPost(post);
        _titleController.clear();
        _bodyController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Post created successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create post: $e')),
        );
      }
    }
  }
}
```

## Error Handling

### Custom Exception Classes
```dart
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

class ValidationException implements Exception {
  final String message;
  final Map<String, String> errors;

  ValidationException(this.message, this.errors);

  @override
  String toString() => 'ValidationException: $message';
}
```

### Error Handler
```dart
class ErrorHandler {
  static String handleError(dynamic error) {
    if (error is ApiException) {
      return error.message;
    } else if (error is NetworkException) {
      return 'Network error: ${error.message}';
    } else if (error is ValidationException) {
      return 'Validation error: ${error.message}';
    } else {
      return 'An unexpected error occurred: $error';
    }
  }

  static void showErrorSnackBar(BuildContext context, dynamic error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(handleError(error)),
        backgroundColor: Colors.red,
      ),
    );
  }
}
```

## Best Practices
1. **Use proper error handling** for all API calls
2. **Implement retry logic** for failed requests
3. **Use interceptors** for common functionality (auth, logging)
4. **Cache responses** when appropriate
5. **Handle loading states** properly
6. **Validate data** before sending to API
7. **Use proper HTTP status codes** for responses
8. **Implement proper authentication** handling
9. **Use environment variables** for API URLs and keys
10. **Test API integration** thoroughly

## Example Implementation
See the main application for a complete implementation of REST API integration with proper error handling, state management, and UI components.
