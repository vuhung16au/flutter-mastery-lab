# HTTP Operations in Flutter

## Overview
HTTP operations are essential for Flutter applications to communicate with web services and APIs. This component demonstrates comprehensive HTTP operations including GET, POST, PUT, DELETE requests with proper error handling, loading states, and data management.

## Key Concepts

### 1. HTTP Methods
- **GET**: Fetching data from servers
- **POST**: Creating new resources
- **PUT/PATCH**: Updating existing resources
- **DELETE**: Removing resources

### 2. Error Handling
Proper error management for network requests and response validation.

### 3. Loading States
User feedback during async operations to prevent UI freezes.

## Implementation

### Basic HTTP Operations

#### Complete HTTP Operations Implementation
```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpOperationsPage extends StatefulWidget {
  const HttpOperationsPage({super.key});

  @override
  State<HttpOperationsPage> createState() => _HttpOperationsPageState();
}

class _HttpOperationsPageState extends State<HttpOperationsPage> {
  List<Map<String, dynamic>> _posts = [];
  bool _isLoading = false;
  String _status = '';

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  // GET - Fetching Data
  Future<void> _fetchPosts() async {
    setState(() {
      _isLoading = true;
      _status = 'Fetching posts...';
    });

    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=5'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _posts = data.cast<Map<String, dynamic>>();
          _status = 'Fetched ${_posts.length} posts successfully';
        });
      } else {
        setState(() {
          _status = 'Failed to fetch posts: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _status = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // POST - Creating Data
  Future<void> _createPost() async {
    setState(() {
      _status = 'Creating post...';
    });

    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': 'New Post',
          'body': 'This is a new post created via HTTP POST',
          'userId': 1,
        }),
      );

      if (response.statusCode == 201) {
        setState(() {
          _status = 'Post created successfully';
        });
        _fetchPosts(); // Refresh the list
      } else {
        setState(() {
          _status = 'Failed to create post: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _status = 'Error creating post: $e';
      });
    }
  }

  // PUT - Updating Data
  Future<void> _updatePost(int id) async {
    setState(() {
      _status = 'Updating post...';
    });

    try {
      final response = await http.put(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id': id,
          'title': 'Updated Post',
          'body': 'This post has been updated via HTTP PUT',
          'userId': 1,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _status = 'Post updated successfully';
        });
        _fetchPosts(); // Refresh the list
      } else {
        setState(() {
          _status = 'Failed to update post: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _status = 'Error updating post: $e';
      });
    }
  }

  // DELETE - Removing Data
  Future<void> _deletePost(int id) async {
    setState(() {
      _status = 'Deleting post...';
    });

    try {
      final response = await http.delete(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
      );

      if (response.statusCode == 200) {
        setState(() {
          _status = 'Post deleted successfully';
        });
        _fetchPosts(); // Refresh the list
      } else {
        setState(() {
          _status = 'Failed to delete post: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _status = 'Error deleting post: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HTTP Operations'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            child: Column(
              children: [
                Text(
                  'Status: $_status',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _isLoading ? null : _fetchPosts,
                      child: const Text('Fetch'),
                    ),
                    ElevatedButton(
                      onPressed: _createPost,
                      child: const Text('Create'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _posts.length,
                    itemBuilder: (context, index) {
                      final post = _posts[index];
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(post['title'] ?? ''),
                          subtitle: Text(post['body'] ?? ''),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _updatePost(post['id']),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _deletePost(post['id']),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
```

## Advanced HTTP Patterns

### 1. HTTP Service Class

#### Reusable HTTP Client
```dart
class HttpService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const Duration timeout = Duration(seconds: 30);

  // GET Request
  static Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: _getHeaders(),
      ).timeout(timeout);

      return _handleResponse(response);
    } catch (e) {
      throw HttpException('GET request failed: $e');
    }
  }

  // POST Request
  static Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: _getHeaders(),
        body: json.encode(data),
      ).timeout(timeout);

      return _handleResponse(response);
    } catch (e) {
      throw HttpException('POST request failed: $e');
    }
  }

  // PUT Request
  static Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: _getHeaders(),
        body: json.encode(data),
      ).timeout(timeout);

      return _handleResponse(response);
    } catch (e) {
      throw HttpException('PUT request failed: $e');
    }
  }

  // DELETE Request
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: _getHeaders(),
      ).timeout(timeout);

      return _handleResponse(response);
    } catch (e) {
      throw HttpException('DELETE request failed: $e');
    }
  }

  // PATCH Request
  static Future<Map<String, dynamic>> patch(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl$endpoint'),
        headers: _getHeaders(),
        body: json.encode(data),
      ).timeout(timeout);

      return _handleResponse(response);
    } catch (e) {
      throw HttpException('PATCH request failed: $e');
    }
  }

  static Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'User-Agent': 'Flutter HTTP Client',
    };
  }

  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return {'success': true};
      }
      return json.decode(response.body);
    } else {
      throw HttpException(
        'HTTP ${response.statusCode}: ${response.reasonPhrase}',
      );
    }
  }
}

class HttpException implements Exception {
  final String message;
  HttpException(this.message);

  @override
  String toString() => message;
}
```

### 2. API Models and Serialization

#### Data Models with JSON Serialization
```dart
class Post {
  final int? id;
  final String title;
  final String body;
  final int userId;

  Post({
    this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int?,
      title: json['title'] as String,
      body: json['body'] as String,
      userId: json['userId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'body': body,
      'userId': userId,
    };
  }

  Post copyWith({
    int? id,
    String? title,
    String? body,
    int? userId,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      userId: userId ?? this.userId,
    );
  }
}

class PostService {
  // GET - Fetch all posts
  static Future<List<Post>> getPosts({int? limit}) async {
    final endpoint = limit != null ? '/posts?_limit=$limit' : '/posts';
    final response = await HttpService.get(endpoint);
    
    if (response is List) {
      return response.map((json) => Post.fromJson(json)).toList();
    }
    throw HttpException('Invalid response format');
  }

  // GET - Fetch single post
  static Future<Post> getPost(int id) async {
    final response = await HttpService.get('/posts/$id');
    return Post.fromJson(response);
  }

  // POST - Create new post
  static Future<Post> createPost(Post post) async {
    final response = await HttpService.post('/posts', post.toJson());
    return Post.fromJson(response);
  }

  // PUT - Update post
  static Future<Post> updatePost(Post post) async {
    if (post.id == null) {
      throw ArgumentError('Post ID is required for update');
    }
    final response = await HttpService.put('/posts/${post.id}', post.toJson());
    return Post.fromJson(response);
  }

  // PATCH - Partial update
  static Future<Post> patchPost(int id, Map<String, dynamic> updates) async {
    final response = await HttpService.patch('/posts/$id', updates);
    return Post.fromJson(response);
  }

  // DELETE - Delete post
  static Future<void> deletePost(int id) async {
    await HttpService.delete('/posts/$id');
  }
}
```

### 3. Advanced HTTP Features

#### File Upload
```dart
import 'dart:io';

class FileUploadService {
  static Future<Map<String, dynamic>> uploadFile(
    String endpoint,
    File file,
    String fieldName,
  ) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://jsonplaceholder.typicode.com$endpoint'),
      );

      request.files.add(
        await http.MultipartFile.fromPath(fieldName, file.path),
      );

      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(responseData);
      } else {
        throw HttpException('Upload failed: ${response.statusCode}');
      }
    } catch (e) {
      throw HttpException('File upload failed: $e');
    }
  }

  static Future<Map<String, dynamic>> uploadMultipleFiles(
    String endpoint,
    List<File> files,
    String fieldName,
  ) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://jsonplaceholder.typicode.com$endpoint'),
      );

      for (int i = 0; i < files.length; i++) {
        request.files.add(
          await http.MultipartFile.fromPath(
            '$fieldName[$i]',
            files[i].path,
          ),
        );
      }

      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(responseData);
      } else {
        throw HttpException('Upload failed: ${response.statusCode}');
      }
    } catch (e) {
      throw HttpException('Multiple file upload failed: $e');
    }
  }
}
```

#### Authentication and Headers
```dart
class AuthenticatedHttpService {
  static String? _authToken;

  static void setAuthToken(String token) {
    _authToken = token;
  }

  static void clearAuthToken() {
    _authToken = null;
  }

  static Map<String, String> _getAuthHeaders() {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'User-Agent': 'Flutter HTTP Client',
    };

    if (_authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }

    return headers;
  }

  static Future<Map<String, dynamic>> authenticatedGet(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com$endpoint'),
        headers: _getAuthHeaders(),
      ).timeout(const Duration(seconds: 30));

      return _handleAuthenticatedResponse(response);
    } catch (e) {
      throw HttpException('Authenticated GET request failed: $e');
    }
  }

  static Future<Map<String, dynamic>> authenticatedPost(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com$endpoint'),
        headers: _getAuthHeaders(),
        body: json.encode(data),
      ).timeout(const Duration(seconds: 30));

      return _handleAuthenticatedResponse(response);
    } catch (e) {
      throw HttpException('Authenticated POST request failed: $e');
    }
  }

  static Map<String, dynamic> _handleAuthenticatedResponse(http.Response response) {
    if (response.statusCode == 401) {
      // Token expired or invalid
      clearAuthToken();
      throw HttpException('Authentication failed');
    } else if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return {'success': true};
      }
      return json.decode(response.body);
    } else {
      throw HttpException(
        'HTTP ${response.statusCode}: ${response.reasonPhrase}',
      );
    }
  }
}
```

## Error Handling and Retry Logic

### 1. Retry Mechanism
```dart
class RetryHttpService {
  static Future<Map<String, dynamic>> getWithRetry(
    String endpoint, {
    int maxRetries = 3,
    Duration delay = const Duration(seconds: 1),
  }) async {
    int attempts = 0;
    
    while (attempts < maxRetries) {
      try {
        return await HttpService.get(endpoint);
      } catch (e) {
        attempts++;
        if (attempts >= maxRetries) {
          throw HttpException('Request failed after $maxRetries attempts: $e');
        }
        
        // Exponential backoff
        await Future.delayed(delay * attempts);
      }
    }
    
    throw HttpException('Unexpected error in retry logic');
  }

  static Future<Map<String, dynamic>> postWithRetry(
    String endpoint,
    Map<String, dynamic> data, {
    int maxRetries = 3,
    Duration delay = const Duration(seconds: 1),
  }) async {
    int attempts = 0;
    
    while (attempts < maxRetries) {
      try {
        return await HttpService.post(endpoint, data);
      } catch (e) {
        attempts++;
        if (attempts >= maxRetries) {
          throw HttpException('Request failed after $maxRetries attempts: $e');
        }
        
        await Future.delayed(delay * attempts);
      }
    }
    
    throw HttpException('Unexpected error in retry logic');
  }
}
```

### 2. Error Handling Utilities
```dart
class HttpErrorHandler {
  static void handleError(BuildContext context, dynamic error) {
    String message = 'An error occurred';
    
    if (error is HttpException) {
      message = error.message;
    } else if (error.toString().contains('SocketException')) {
      message = 'No internet connection';
    } else if (error.toString().contains('TimeoutException')) {
      message = 'Request timed out';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'Retry',
          onPressed: () {
            // Implement retry logic
          },
        ),
      ),
    );
  }

  static bool isNetworkError(dynamic error) {
    return error.toString().contains('SocketException') ||
           error.toString().contains('TimeoutException');
  }

  static bool isServerError(dynamic error) {
    if (error is HttpException) {
      return error.message.contains('500') ||
             error.message.contains('502') ||
             error.message.contains('503') ||
             error.message.contains('504');
    }
    return false;
  }
}
```

## Testing HTTP Operations

### 1. Mock HTTP Service
```dart
class MockHttpService {
  static final Map<String, dynamic> _mockData = {
    '/posts': [
      {
        'id': 1,
        'title': 'Mock Post 1',
        'body': 'Mock body 1',
        'userId': 1,
      },
      {
        'id': 2,
        'title': 'Mock Post 2',
        'body': 'Mock body 2',
        'userId': 1,
      },
    ],
  };

  static Future<Map<String, dynamic>> get(String endpoint) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    
    if (_mockData.containsKey(endpoint)) {
      return {'data': _mockData[endpoint]};
    }
    
    throw HttpException('Endpoint not found: $endpoint');
  }

  static Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Simulate creating a new post
    final newPost = {
      'id': DateTime.now().millisecondsSinceEpoch,
      ...data,
    };
    
    return newPost;
  }
}
```

### 2. HTTP Tests
```dart
test('fetch posts successfully', () async {
  final posts = await PostService.getPosts(limit: 5);
  expect(posts, isA<List<Post>>());
  expect(posts.length, lessThanOrEqualTo(5));
});

test('create post successfully', () async {
  final post = Post(
    title: 'Test Post',
    body: 'Test Body',
    userId: 1,
  );
  
  final createdPost = await PostService.createPost(post);
  expect(createdPost.title, equals('Test Post'));
  expect(createdPost.body, equals('Test Body'));
});

test('handle network error', () async {
  expect(
    () => HttpService.get('/invalid-endpoint'),
    throwsA(isA<HttpException>()),
  );
});
```

## Best Practices

### 1. HTTP Configuration
```dart
class HttpConfig {
  static const String baseUrl = 'https://api.example.com';
  static const Duration timeout = Duration(seconds: 30);
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 1);
  
  static Map<String, String> getDefaultHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'User-Agent': 'Flutter App v1.0.0',
    };
  }
}
```

### 2. Response Caching
```dart
class CacheManager {
  static final Map<String, dynamic> _cache = {};
  static const Duration _cacheExpiry = Duration(minutes: 5);

  static void set(String key, dynamic data) {
    _cache[key] = {
      'data': data,
      'timestamp': DateTime.now(),
    };
  }

  static dynamic get(String key) {
    final cached = _cache[key];
    if (cached != null) {
      final timestamp = cached['timestamp'] as DateTime;
      if (DateTime.now().difference(timestamp) < _cacheExpiry) {
        return cached['data'];
      } else {
        _cache.remove(key);
      }
    }
    return null;
  }

  static void clear() {
    _cache.clear();
  }
}
```

## Conclusion

HTTP operations are fundamental to modern Flutter applications. By implementing proper error handling, retry logic, and using structured data models, you can create robust and reliable network communication. Always follow best practices for authentication, caching, and error recovery to ensure your app provides a smooth user experience even when network conditions are poor.
