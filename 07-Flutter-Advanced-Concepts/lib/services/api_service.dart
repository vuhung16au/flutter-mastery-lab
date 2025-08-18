import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  static Future<List<Map<String, dynamic>>> getPosts() async {
    final uri = Uri.parse('$baseUrl/posts');
    try {
      final response = await http
          .get(
            uri,
            headers: const {
              'Accept': 'application/json',
              'Content-Type': 'application/json; charset=utf-8',
              // Some public APIs (including CDNs in front of jsonplaceholder)
              // occasionally block requests without a User-Agent.
              'User-Agent': 'flutter_advanced_concepts/1.0 (dart:io)',
            },
          )
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(json.decode(response.body));
      }
      throw Exception(
        'Failed to load posts (status: ${response.statusCode})',
      );
    } catch (e) {
      // Surface the original error without nesting it repeatedly
      throw Exception('Network request failed: $e');
    }
  }

  static Future<Map<String, dynamic>> getUser(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users/$id'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
