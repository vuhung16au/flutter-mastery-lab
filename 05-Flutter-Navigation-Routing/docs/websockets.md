# Flutter - WebSockets

## Overview
WebSockets provide real-time bidirectional communication between Flutter applications and servers. This component demonstrates how to implement WebSocket connections, handle real-time messaging, and manage connection states in Flutter applications.

## Key Concepts

### 1. WebSocket Channel
Manages the WebSocket connection and provides streams for sending and receiving messages.

### 2. Real-time Communication
Bidirectional data flow that enables instant message exchange between client and server.

### 3. Connection Management
Handling connection states, reconnection logic, and error recovery.

## Implementation

### Basic WebSocket Connection

#### Simple WebSocket Setup
```dart
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketsPage extends StatefulWidget {
  const WebSocketsPage({super.key});

  @override
  State<WebSocketsPage> createState() => _WebSocketsPageState();
}

class _WebSocketsPageState extends State<WebSocketsPage> {
  WebSocketChannel? _channel;
  final List<String> _messages = [];
  final TextEditingController _messageController = TextEditingController();
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _connectToWebSocket();
  }

  void _connectToWebSocket() {
    try {
      // Using a public WebSocket echo server for demo
      _channel = WebSocketChannel.connect(
        Uri.parse('wss://echo.websocket.org'),
      );
      
      _channel!.stream.listen(
        (message) {
          setState(() {
            _messages.add('Received: $message');
          });
        },
        onDone: () {
          setState(() {
            _isConnected = false;
            _messages.add('WebSocket connection closed');
          });
        },
        onError: (error) {
          setState(() {
            _isConnected = false;
            _messages.add('WebSocket error: $error');
          });
        },
      );
      
      setState(() {
        _isConnected = true;
        _messages.add('Connected to WebSocket server');
      });
    } catch (e) {
      setState(() {
        _messages.add('Failed to connect: $e');
      });
    }
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty && _channel != null) {
      _channel!.sink.add(_messageController.text);
      setState(() {
        _messages.add('Sent: ${_messageController.text}');
      });
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _channel?.sink.close();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebSockets Demo'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: _isConnected ? Colors.green : Colors.red,
            child: Row(
              children: [
                Icon(
                  _isConnected ? Icons.wifi : Icons.wifi_off,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                Text(
                  _isConnected ? 'Connected' : 'Disconnected',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(_messages[index]),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _isConnected ? _sendMessage : null,
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

## Advanced WebSocket Patterns

### 1. WebSocket Service Class

#### Reusable WebSocket Manager
```dart
class WebSocketService {
  WebSocketChannel? _channel;
  bool _isConnected = false;
  final StreamController<String> _messageController = StreamController<String>.broadcast();
  final StreamController<bool> _connectionController = StreamController<bool>.broadcast();
  
  Stream<String> get messageStream => _messageController.stream;
  Stream<bool> get connectionStream => _connectionController.stream;
  bool get isConnected => _isConnected;

  Future<void> connect(String url) async {
    try {
      _channel = WebSocketChannel.connect(Uri.parse(url));
      
      _channel!.stream.listen(
        (message) {
          _messageController.add(message.toString());
        },
        onDone: () {
          _setConnectionStatus(false);
        },
        onError: (error) {
          _setConnectionStatus(false);
          _messageController.add('Error: $error');
        },
      );
      
      _setConnectionStatus(true);
    } catch (e) {
      _setConnectionStatus(false);
      _messageController.add('Connection failed: $e');
    }
  }

  void sendMessage(String message) {
    if (_isConnected && _channel != null) {
      _channel!.sink.add(message);
    }
  }

  void _setConnectionStatus(bool connected) {
    _isConnected = connected;
    _connectionController.add(connected);
  }

  Future<void> disconnect() async {
    await _channel?.sink.close();
    _setConnectionStatus(false);
  }

  void dispose() {
    _channel?.sink.close();
    _messageController.close();
    _connectionController.close();
  }
}
```

### 2. WebSocket with Reconnection

#### Auto-reconnect Implementation
```dart
class ReconnectingWebSocket {
  WebSocketChannel? _channel;
  bool _isConnected = false;
  bool _shouldReconnect = true;
  int _reconnectAttempts = 0;
  final int _maxReconnectAttempts = 5;
  final Duration _reconnectDelay = const Duration(seconds: 2);
  
  final StreamController<String> _messageController = StreamController<String>.broadcast();
  final StreamController<bool> _connectionController = StreamController<bool>.broadcast();

  Stream<String> get messageStream => _messageController.stream;
  Stream<bool> get connectionStream => _connectionController.stream;
  bool get isConnected => _isConnected;

  Future<void> connect(String url) async {
    if (_isConnected) return;
    
    try {
      _channel = WebSocketChannel.connect(Uri.parse(url));
      
      _channel!.stream.listen(
        (message) {
          _messageController.add(message.toString());
        },
        onDone: () {
          _handleDisconnection();
        },
        onError: (error) {
          _handleDisconnection();
          _messageController.add('Error: $error');
        },
      );
      
      _setConnectionStatus(true);
      _reconnectAttempts = 0; // Reset reconnect attempts on successful connection
    } catch (e) {
      _handleDisconnection();
      _messageController.add('Connection failed: $e');
    }
  }

  void _handleDisconnection() {
    _setConnectionStatus(false);
    
    if (_shouldReconnect && _reconnectAttempts < _maxReconnectAttempts) {
      _scheduleReconnect();
    }
  }

  void _scheduleReconnect() {
    _reconnectAttempts++;
    _messageController.add('Attempting to reconnect... (${_reconnectAttempts}/$_maxReconnectAttempts)');
    
    Future.delayed(_reconnectDelay * _reconnectAttempts, () {
      if (_shouldReconnect && !_isConnected) {
        connect('wss://echo.websocket.org'); // Replace with your URL
      }
    });
  }

  void sendMessage(String message) {
    if (_isConnected && _channel != null) {
      _channel!.sink.add(message);
    }
  }

  void _setConnectionStatus(bool connected) {
    _isConnected = connected;
    _connectionController.add(connected);
  }

  void stopReconnecting() {
    _shouldReconnect = false;
  }

  Future<void> disconnect() async {
    _shouldReconnect = false;
    await _channel?.sink.close();
    _setConnectionStatus(false);
  }

  void dispose() {
    _shouldReconnect = false;
    _channel?.sink.close();
    _messageController.close();
    _connectionController.close();
  }
}
```

### 3. WebSocket with JSON Messages

#### Structured Message Handling
```dart
import 'dart:convert';

class WebSocketMessage {
  final String type;
  final Map<String, dynamic> data;
  final String? id;

  WebSocketMessage({
    required this.type,
    required this.data,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'data': data,
      if (id != null) 'id': id,
    };
  }

  factory WebSocketMessage.fromJson(Map<String, dynamic> json) {
    return WebSocketMessage(
      type: json['type'] as String,
      data: json['data'] as Map<String, dynamic>,
      id: json['id'] as String?,
    );
  }
}

class JSONWebSocketService {
  WebSocketChannel? _channel;
  bool _isConnected = false;
  final StreamController<WebSocketMessage> _messageController = StreamController<WebSocketMessage>.broadcast();
  final StreamController<bool> _connectionController = StreamController<bool>.broadcast();

  Stream<WebSocketMessage> get messageStream => _messageController.stream;
  Stream<bool> get connectionStream => _connectionController.stream;
  bool get isConnected => _isConnected;

  Future<void> connect(String url) async {
    try {
      _channel = WebSocketChannel.connect(Uri.parse(url));
      
      _channel!.stream.listen(
        (message) {
          try {
            final json = jsonDecode(message.toString());
            final wsMessage = WebSocketMessage.fromJson(json);
            _messageController.add(wsMessage);
          } catch (e) {
            _messageController.add(WebSocketMessage(
              type: 'error',
              data: {'message': 'Invalid JSON: $e'},
            ));
          }
        },
        onDone: () {
          _setConnectionStatus(false);
        },
        onError: (error) {
          _setConnectionStatus(false);
        },
      );
      
      _setConnectionStatus(true);
    } catch (e) {
      _setConnectionStatus(false);
    }
  }

  void sendMessage(WebSocketMessage message) {
    if (_isConnected && _channel != null) {
      _channel!.sink.add(jsonEncode(message.toJson()));
    }
  }

  void sendSimpleMessage(String type, Map<String, dynamic> data) {
    sendMessage(WebSocketMessage(type: type, data: data));
  }

  void _setConnectionStatus(bool connected) {
    _isConnected = connected;
    _connectionController.add(connected);
  }

  Future<void> disconnect() async {
    await _channel?.sink.close();
    _setConnectionStatus(false);
  }

  void dispose() {
    _channel?.sink.close();
    _messageController.close();
    _connectionController.close();
  }
}
```

## WebSocket UI Components

### 1. Chat Interface

#### Real-time Chat Implementation
```dart
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final WebSocketService _webSocketService = WebSocketService();
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _setupWebSocket();
  }

  void _setupWebSocket() {
    _webSocketService.connect('wss://echo.websocket.org');
    
    _webSocketService.messageStream.listen((message) {
      setState(() {
        _messages.add(ChatMessage(
          text: message,
          isFromMe: false,
          timestamp: DateTime.now(),
        ));
      });
    });

    _webSocketService.connectionStream.listen((connected) {
      if (connected) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Connected to chat server')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Disconnected from chat server'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty && _webSocketService.isConnected) {
      final message = _messageController.text;
      _webSocketService.sendMessage(message);
      
      setState(() {
        _messages.add(ChatMessage(
          text: message,
          isFromMe: true,
          timestamp: DateTime.now(),
        ));
      });
      
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _webSocketService.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          StreamBuilder<bool>(
            stream: _webSocketService.connectionStream,
            builder: (context, snapshot) {
              final isConnected = snapshot.data ?? false;
              return Icon(
                isConnected ? Icons.wifi : Icons.wifi_off,
                color: isConnected ? Colors.green : Colors.red,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                return ChatBubble(message: message);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _webSocketService.isConnected ? _sendMessage : null,
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isFromMe;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isFromMe,
    required this.timestamp,
  });
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isFromMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.isFromMe ? Colors.blue : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: message.isFromMe ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatTime(message.timestamp),
              style: TextStyle(
                fontSize: 12,
                color: message.isFromMe ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
```

### 2. Real-time Dashboard

#### Live Data Display
```dart
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final JSONWebSocketService _webSocketService = JSONWebSocketService();
  Map<String, dynamic> _dashboardData = {};

  @override
  void initState() {
    super.initState();
    _setupWebSocket();
  }

  void _setupWebSocket() {
    _webSocketService.connect('wss://echo.websocket.org');
    
    _webSocketService.messageStream.listen((message) {
      if (message.type == 'dashboard_update') {
        setState(() {
          _dashboardData = message.data;
        });
      }
    });
  }

  @override
  void dispose() {
    _webSocketService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Real-time Dashboard')),
      body: StreamBuilder<bool>(
        stream: _webSocketService.connectionStream,
        builder: (context, snapshot) {
          final isConnected = snapshot.data ?? false;
          
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: isConnected ? Colors.green : Colors.red,
                child: Row(
                  children: [
                    Icon(
                      isConnected ? Icons.wifi : Icons.wifi_off,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isConnected ? 'Live Data' : 'Offline',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _dashboardData.isEmpty
                    ? const Center(child: Text('Waiting for data...'))
                    : ListView(
                        padding: const EdgeInsets.all(16),
                        children: _dashboardData.entries.map((entry) {
                          return Card(
                            child: ListTile(
                              title: Text(entry.key),
                              subtitle: Text(entry.value.toString()),
                            ),
                          );
                        }).toList(),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
```

## Error Handling and Best Practices

### 1. Connection Error Handling
```dart
class WebSocketErrorHandler {
  static void handleConnectionError(BuildContext context, dynamic error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Connection error: $error'),
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

  static void handleMessageError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Message error: $message'),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
```

### 2. WebSocket Configuration
```dart
class WebSocketConfig {
  static const Duration connectionTimeout = Duration(seconds: 10);
  static const Duration pingInterval = Duration(seconds: 30);
  static const int maxReconnectAttempts = 5;
  static const Duration reconnectDelay = Duration(seconds: 2);
  
  static Map<String, String> getHeaders() {
    return {
      'User-Agent': 'Flutter WebSocket Client',
      'Accept': 'application/json',
    };
  }
}
```

## Testing

### 1. WebSocket Mock for Testing
```dart
class MockWebSocketService extends WebSocketService {
  final List<String> sentMessages = [];
  final StreamController<String> _mockMessageController = StreamController<String>.broadcast();

  @override
  Stream<String> get messageStream => _mockMessageController.stream;

  @override
  void sendMessage(String message) {
    sentMessages.add(message);
    // Echo the message back for testing
    _mockMessageController.add('Echo: $message');
  }

  void simulateMessage(String message) {
    _mockMessageController.add(message);
  }

  void simulateConnection(bool connected) {
    _connectionController.add(connected);
  }

  @override
  void dispose() {
    _mockMessageController.close();
    super.dispose();
  }
}
```

### 2. WebSocket Tests
```dart
testWidgets('websocket sends and receives messages', (tester) async {
  final mockService = MockWebSocketService();
  
  await tester.pumpWidget(
    MaterialApp(
      home: WebSocketTestPage(webSocketService: mockService),
    ),
  );

  // Send a message
  await tester.enterText(find.byType(TextField), 'Hello');
  await tester.tap(find.text('Send'));
  await tester.pump();

  expect(mockService.sentMessages, contains('Hello'));
});
```

## Conclusion

WebSockets provide powerful real-time communication capabilities in Flutter applications. By implementing proper connection management, error handling, and message processing, you can create robust real-time features like chat applications, live dashboards, and collaborative tools. Always follow best practices for connection lifecycle management and error recovery to ensure reliable WebSocket communication.
