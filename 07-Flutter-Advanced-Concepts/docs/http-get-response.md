# HTTP GET Response in Flutter

## Overview
This document covers how to handle HTTP GET responses in Flutter applications, including parsing JSON data, handling different response types, and implementing proper error handling for GET requests.

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

## Basic GET Response Handling

### Simple GET Request with Response
```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetResponseService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  static Future<Map<String, dynamic>> getUser(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users/$id'));
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching user: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users'));
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }
}
```

### GET Request with Query Parameters
```dart
class GetResponseService {
  static Future<List<Map<String, dynamic>>> getPostsByUser(int userId) async {
    try {
      final uri = Uri.parse('$baseUrl/posts').replace(
        queryParameters: {'userId': userId.toString()},
      );
      
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching posts: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> searchPosts(String query) async {
    try {
      final uri = Uri.parse('$baseUrl/posts').replace(
        queryParameters: {'q': query},
      );
      
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to search posts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching posts: $e');
    }
  }
}
```

## Advanced GET Response Handling

### Response with Headers
```dart
class GetResponseService {
  static Future<Map<String, dynamic>> getUserWithHeaders(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer your-token-here',
          'User-Agent': 'Flutter-App/1.0',
        },
      );
      
      // Check response headers
      final contentType = response.headers['content-type'];
      final contentLength = response.headers['content-length'];
      
      print('Content-Type: $contentType');
      print('Content-Length: $contentLength');
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching user: $e');
    }
  }
}
```

### Response with Timeout
```dart
class GetResponseService {
  static Future<Map<String, dynamic>> getUserWithTimeout(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/$id'),
      ).timeout(
        Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('Request timed out', Duration(seconds: 10));
        },
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load user: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('Request timed out');
    } catch (e) {
      throw Exception('Error fetching user: $e');
    }
  }
}
```

## Response Data Models

### User Model
```dart
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final Address address;
  final Company company;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.address,
    required this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo geo;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class Geo {
  final String lat;
  final String lng;

  Geo({required this.lat, required this.lng});

  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);
  Map<String, dynamic> toJson() => _$GeoToJson(this);
}

@JsonSerializable()
class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  factory Company.fromJson(Map<String, dynamic> json) => _$CompanyFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
```

### Post Model
```dart
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

## Response Handling with Models

### Typed Response Handling
```dart
class GetResponseService {
  static Future<User> getUserTyped(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users/$id'));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return User.fromJson(jsonData);
      } else {
        throw Exception('Failed to load user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching user: $e');
    }
  }

  static Future<List<Post>> getPostsTyped() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/posts'));
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching posts: $e');
    }
  }
}
```

## Dio Implementation

### Dio GET Response Handling
```dart
import 'package:dio/dio.dart';

class DioGetResponseService {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 3),
  ));

  static Future<User> getUser(int id) async {
    try {
      final response = await _dio.get('/users/$id');
      return User.fromJson(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout');
      } else if (e.response != null) {
        throw Exception('HTTP ${e.response!.statusCode}: ${e.response!.statusMessage}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    }
  }

  static Future<List<Post>> getPosts() async {
    try {
      final response = await _dio.get('/posts');
      return (response.data as List)
          .map((json) => Post.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception('Failed to fetch posts: ${e.message}');
    }
  }
}
```

## Response Caching

### Simple Response Cache
```dart
class ResponseCache {
  static final Map<String, dynamic> _cache = {};
  static const Duration _cacheExpiry = Duration(minutes: 5);

  static Future<T> getCachedResponse<T>(
    String key,
    Future<T> Function() fetchFunction,
  ) async {
    if (_cache.containsKey(key)) {
      final cachedData = _cache[key];
      if (cachedData['timestamp'].add(_cacheExpiry).isAfter(DateTime.now())) {
        return cachedData['data'] as T;
      } else {
        _cache.remove(key);
      }
    }

    final data = await fetchFunction();
    _cache[key] = {
      'data': data,
      'timestamp': DateTime.now(),
    };

    return data;
  }

  static void clearCache() {
    _cache.clear();
  }
}

class CachedGetResponseService {
  static Future<User> getUserCached(int id) async {
    return await ResponseCache.getCachedResponse(
      'user_$id',
      () => GetResponseService.getUserTyped(id),
    );
  }

  static Future<List<Post>> getPostsCached() async {
    return await ResponseCache.getCachedResponse(
      'posts',
      () => GetResponseService.getPostsTyped(),
    );
  }
}
```

## Error Handling

### Comprehensive Error Handling
```dart
class GetResponseErrorHandler {
  static String handleError(dynamic error, String operation) {
    if (error is SocketException) {
      return 'No internet connection. Please check your network.';
    } else if (error is TimeoutException) {
      return 'Request timed out. Please try again.';
    } else if (error is FormatException) {
      return 'Invalid response format. Please try again.';
    } else if (error.toString().contains('404')) {
      return 'Resource not found.';
    } else if (error.toString().contains('500')) {
      return 'Server error. Please try again later.';
    } else if (error.toString().contains('401')) {
      return 'Unauthorized access. Please login again.';
    } else if (error.toString().contains('403')) {
      return 'Access forbidden.';
    } else {
      return 'Error during $operation: ${error.toString()}';
    }
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'Retry',
          textColor: Colors.white,
          onPressed: () {
            // Implement retry logic
          },
        ),
      ),
    );
  }
}
```

## UI Components

### User List Widget
```dart
class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<User> _users = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final users = await GetResponseService.getUsersTyped();
      setState(() {
        _users = users;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = GetResponseErrorHandler.handleError(e, 'loading users');
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text(_error!, textAlign: TextAlign.center),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadUsers,
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadUsers,
      child: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(user.name[0].toUpperCase()),
            ),
            title: Text(user.name),
            subtitle: Text(user.email),
            trailing: IconButton(
              icon: Icon(Icons.phone),
              onPressed: () => _callUser(user.phone),
            ),
          );
        },
      ),
    );
  }

  void _callUser(String phone) {
    // Implement call functionality
    print('Calling $phone');
  }
}
```

### Post Detail Widget
```dart
class PostDetail extends StatefulWidget {
  final int postId;

  const PostDetail({Key? key, required this.postId}) : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  Post? _post;
  User? _user;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPost();
  }

  Future<void> _loadPost() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final post = await GetResponseService.getPostTyped(widget.postId);
      final user = await GetResponseService.getUserTyped(post.userId);
      
      setState(() {
        _post = post;
        _user = user;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = GetResponseErrorHandler.handleError(e, 'loading post');
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Loading...')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, size: 64, color: Colors.red),
              SizedBox(height: 16),
              Text(_error!, textAlign: TextAlign.center),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadPost,
                child: Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_post == null || _user == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Not Found')),
        body: Center(child: Text('Post not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadPost,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _post!.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 16),
            Text(
              _post!.body,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 24),
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(_user!.name[0].toUpperCase()),
                ),
                title: Text(_user!.name),
                subtitle: Text(_user!.email),
                trailing: IconButton(
                  icon: Icon(Icons.email),
                  onPressed: () => _emailUser(_user!.email),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _emailUser(String email) {
    // Implement email functionality
    print('Emailing $email');
  }
}
```

## Best Practices
1. **Always handle errors** properly for all GET requests
2. **Use typed models** for better type safety
3. **Implement caching** for frequently accessed data
4. **Add loading states** to improve user experience
5. **Handle network timeouts** appropriately
6. **Validate response data** before using it
7. **Use proper HTTP status codes** for error handling
8. **Implement retry logic** for failed requests
9. **Cache responses** to reduce network calls
10. **Test error scenarios** thoroughly

## Example Implementation
See the main application for a complete implementation of HTTP GET response handling with proper error handling, caching, and UI components.
