import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/http_status_bar.dart';
import '../widgets/post_card.dart';

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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          HttpStatusBar(
            status: _status,
            isLoading: _isLoading,
            onFetch: _fetchPosts,
            onCreate: _createPost,
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _posts.length,
                    itemBuilder: (context, index) {
                      final post = _posts[index];
                      return PostCard(
                        post: post,
                        onUpdate: () => _updatePost(post['id']),
                        onDelete: () => _deletePost(post['id']),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
