import 'package:flutter/material.dart';
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
