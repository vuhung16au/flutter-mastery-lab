# HTTP GET Response in Flutter

This document covers how to handle HTTP GET responses in Flutter applications, including parsing JSON data, error handling, and displaying the results.

## Overview

HTTP GET requests are the most common way to fetch data from APIs. This guide demonstrates how to make GET requests, handle responses, parse JSON data, and display the results in your Flutter UI.

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

### Basic HTTP GET Request

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const Duration timeout = Duration(seconds: 30);

  // Basic GET request
  static Future<Map<String, dynamic>> getData(String endpoint) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl$endpoint'))
          .timeout(timeout);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // GET request with query parameters
  static Future<Map<String, dynamic>> getDataWithParams(
    String endpoint,
    Map<String, String> queryParams,
  ) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint').replace(
        queryParameters: queryParams,
      );

      final response = await http.get(uri).timeout(timeout);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // GET request with headers
  static Future<Map<String, dynamic>> getDataWithHeaders(
    String endpoint,
    Map<String, String> headers,
  ) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl$endpoint'),
            headers: headers,
          )
          .timeout(timeout);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
```

### Data Models

```dart
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}

@JsonSerializable()
class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Comment {
  final int id;
  final int postId;
  final String name;
  final String email;
  final String body;

  Comment({
    required this.id,
    required this.postId,
    required this.name,
    required this.email,
    required this.body,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
```

### Repository Pattern for GET Requests

```dart
class PostRepository {
  // Get all posts
  static Future<List<Post>> getPosts() async {
    try {
      final response = await HttpService.getData('/posts');
      
      if (response is List) {
        return response.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      throw Exception('Failed to fetch posts: $e');
    }
  }

  // Get post by ID
  static Future<Post> getPost(int id) async {
    try {
      final response = await HttpService.getData('/posts/$id');
      return Post.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch post: $e');
    }
  }

  // Get posts by user
  static Future<List<Post>> getPostsByUser(int userId) async {
    try {
      final response = await HttpService.getDataWithParams(
        '/posts',
        {'userId': userId.toString()},
      );
      
      if (response is List) {
        return response.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      throw Exception('Failed to fetch user posts: $e');
    }
  }
}

class UserRepository {
  // Get all users
  static Future<List<User>> getUsers() async {
    try {
      final response = await HttpService.getData('/users');
      
      if (response is List) {
        return response.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }

  // Get user by ID
  static Future<User> getUser(int id) async {
    try {
      final response = await HttpService.getData('/users/$id');
      return User.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }
}

class CommentRepository {
  // Get comments for a post
  static Future<List<Comment>> getComments(int postId) async {
    try {
      final response = await HttpService.getDataWithParams(
        '/comments',
        {'postId': postId.toString()},
      );
      
      if (response is List) {
        return response.map((json) => Comment.fromJson(json)).toList();
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      throw Exception('Failed to fetch comments: $e');
    }
  }
}
```

### UI Implementation

```dart
import 'package:flutter/material.dart';

class HttpGetDemoPage extends StatefulWidget {
  @override
  _HttpGetDemoPageState createState() => _HttpGetDemoPageState();
}

class _HttpGetDemoPageState extends State<HttpGetDemoPage> {
  List<Post> _posts = [];
  List<User> _users = [];
  bool _isLoading = false;
  String? _error;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      if (_selectedTab == 0) {
        final posts = await PostRepository.getPosts();
        setState(() {
          _posts = posts;
        });
      } else {
        final users = await UserRepository.getUsers();
        setState(() {
          _users = users;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP GET Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            color: Theme.of(context).primaryColor,
            child: Row(
              children: [
                Expanded(
                  child: _buildTabButton('Posts', 0),
                ),
                Expanded(
                  child: _buildTabButton('Users', 1),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int tabIndex) {
    final isSelected = _selectedTab == tabIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = tabIndex;
        });
        _loadData();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Colors.white : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
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
            Text(
              'Error: $_error',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadData,
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_selectedTab == 0) {
      return _buildPostsList();
    } else {
      return _buildUsersList();
    }
  }

  Widget _buildPostsList() {
    if (_posts.isEmpty) {
      return Center(
        child: Text(
          'No posts found',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          final post = _posts[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        child: Text('${post.id}'),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Post #${post.id}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              'User ID: ${post.userId}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    post.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    post.body,
                    style: TextStyle(fontSize: 14),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _viewPostDetails(post),
                          child: Text('View Details'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _viewComments(post.id),
                          child: Text('Comments'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUsersList() {
    if (_users.isEmpty) {
      return Center(
        child: Text(
          'No users found',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16.0),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(user.name[0].toUpperCase()),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              title: Text(
                user.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('@${user.username}'),
                  Text(user.email),
                  Text(user.phone),
                ],
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => _viewUserDetails(user),
            ),
          );
        },
      ),
    );
  }

  void _viewPostDetails(Post post) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Post Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ID: ${post.id}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('User ID: ${post.userId}'),
              SizedBox(height: 16),
              Text(
                'Title:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(post.title),
              SizedBox(height: 16),
              Text(
                'Body:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(post.body),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _viewUserDetails(User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('User Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ID: ${user.id}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Name: ${user.name}'),
              Text('Username: @${user.username}'),
              Text('Email: ${user.email}'),
              Text('Phone: ${user.phone}'),
              Text('Website: ${user.website}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _viewComments(int postId) async {
    try {
      final comments = await CommentRepository.getComments(postId);
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Comments for Post #$postId'),
          content: Container(
            width: double.maxFinite,
            height: 400,
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 8.0),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          comment.email,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(comment.body),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        ),
      );
    } catch (e) {
      _showSnackBar('Error loading comments: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
```

### Advanced GET Request with Caching

```dart
import 'package:shared_preferences/shared_preferences.dart';

class CachedHttpService {
  static const String _cacheKey = 'http_cache';
  static const Duration _cacheExpiry = Duration(minutes: 5);

  static Future<Map<String, dynamic>> getDataWithCache(String endpoint) async {
    try {
      // Try to get cached data first
      final cachedData = await _getCachedData(endpoint);
      if (cachedData != null) {
        return cachedData;
      }

      // If no cache, fetch from API
      final data = await HttpService.getData(endpoint);
      
      // Cache the data
      await _cacheData(endpoint, data);
      
      return data;
    } catch (e) {
      throw Exception('Failed to get data: $e');
    }
  }

  static Future<Map<String, dynamic>?> _getCachedData(String endpoint) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cacheKey = '${_cacheKey}_$endpoint';
      final timestampKey = '${cacheKey}_timestamp';
      
      final timestamp = prefs.getInt(timestampKey);
      if (timestamp == null) return null;

      final now = DateTime.now().millisecondsSinceEpoch;
      final difference = Duration(milliseconds: now - timestamp);

      if (difference > _cacheExpiry) {
        return null; // Cache expired
      }

      final cachedData = prefs.getString(cacheKey);
      if (cachedData == null) return null;

      return jsonDecode(cachedData);
    } catch (e) {
      return null;
    }
  }

  static Future<void> _cacheData(String endpoint, Map<String, dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cacheKey = '${_cacheKey}_$endpoint';
      final timestampKey = '${cacheKey}_timestamp';
      
      await prefs.setString(cacheKey, jsonEncode(data));
      await prefs.setInt(timestampKey, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      // Cache failed, but don't throw error
      print('Failed to cache data: $e');
    }
  }

  static Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();
      
      for (final key in keys) {
        if (key.startsWith(_cacheKey)) {
          await prefs.remove(key);
        }
      }
    } catch (e) {
      print('Failed to clear cache: $e');
    }
  }
}
```

## Best Practices

1. **Error Handling**: Always handle network errors and timeouts
2. **Loading States**: Show loading indicators during requests
3. **Caching**: Implement caching for better performance
4. **Pagination**: Use pagination for large datasets
5. **Retry Logic**: Implement retry mechanisms for failed requests
6. **Data Validation**: Validate response data before using it
7. **Memory Management**: Dispose of resources properly
8. **Testing**: Write unit tests for HTTP services

## Common Use Cases

### Search with GET Parameters

```dart
class SearchService {
  static Future<List<Post>> searchPosts(String query) async {
    try {
      final response = await HttpService.getDataWithParams(
        '/posts',
        {'q': query},
      );
      
      if (response is List) {
        return response.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      throw Exception('Search failed: $e');
    }
  }
}
```

### Pagination

```dart
class PaginatedPostRepository {
  static Future<Map<String, dynamic>> getPostsPaginated({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await HttpService.getDataWithParams(
        '/posts',
        {
          '_page': page.toString(),
          '_limit': limit.toString(),
        },
      );
      
      return {
        'data': (response as List).map((json) => Post.fromJson(json)).toList(),
        'page': page,
        'limit': limit,
      };
    } catch (e) {
      throw Exception('Failed to fetch posts: $e');
    }
  }
}
```

This implementation provides a comprehensive solution for handling HTTP GET responses in Flutter applications with proper error handling, caching, and UI integration.
