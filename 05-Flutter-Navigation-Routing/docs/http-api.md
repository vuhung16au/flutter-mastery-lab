# Implementing REST API in Flutter

## Overview
This component demonstrates how to integrate REST APIs in Flutter applications, including making HTTP requests, handling responses, and managing API data.

## Key Components Used

### 1. http Package
- **Purpose**: Makes HTTP requests to REST APIs
- **Usage**: GET, POST, PUT, DELETE operations

### 2. FutureBuilder
- **Purpose**: Handles asynchronous API calls
- **Usage**: Manages loading states and responses

### 3. JsonDecoder
- **Purpose**: Parses JSON responses
- **Usage**: Converts JSON strings to Dart objects

### 4. Dio (Alternative)
- **Purpose**: Advanced HTTP client
- **Usage**: More features than http package

## Implementation Steps

1. **Add Dependencies**:
   ```yaml
   dependencies:
     http: ^1.1.0
     dio: ^5.3.0
   ```

2. **Make GET Request**:
   ```dart
   Future<List<dynamic>> fetchUsers() async {
     final response = await http.get(
       Uri.parse('https://jsonplaceholder.typicode.com/users'),
     );
     
     if (response.statusCode == 200) {
       return jsonDecode(response.body);
     } else {
       throw Exception('Failed to load users');
     }
   }
   ```

3. **Make POST Request**:
   ```dart
   Future<void> createUser(String name, String email) async {
     final response = await http.post(
       Uri.parse('https://jsonplaceholder.typicode.com/users'),
       headers: {'Content-Type': 'application/json'},
       body: jsonEncode({
         'name': name,
         'email': email,
       }),
     );
     
     if (response.statusCode == 201) {
       print('User created successfully');
     } else {
       throw Exception('Failed to create user');
     }
   }
   ```

4. **Handle API Response**:
   ```dart
   FutureBuilder<List<dynamic>>(
     future: fetchUsers(),
     builder: (context, snapshot) {
       if (snapshot.connectionState == ConnectionState.waiting) {
         return CircularProgressIndicator();
       } else if (snapshot.hasError) {
         return Text('Error: ${snapshot.error}');
       } else if (snapshot.hasData) {
         return ListView.builder(
           itemCount: snapshot.data!.length,
           itemBuilder: (context, index) {
             final user = snapshot.data![index];
             return ListTile(
               title: Text(user['name']),
               subtitle: Text(user['email']),
             );
           },
         );
       }
       return Text('No data available');
     },
   )
   ```

## API Features
- **HTTP Methods**: GET, POST, PUT, DELETE
- **Request Headers**: Custom headers and authentication
- **Response Handling**: Status codes and error handling
- **JSON Parsing**: Automatic JSON to Dart conversion
- **Timeout Handling**: Request timeout configuration

## Best Practices
- Implement proper error handling
- Use appropriate HTTP status codes
- Handle loading states
- Implement retry logic
- Secure API keys and sensitive data
