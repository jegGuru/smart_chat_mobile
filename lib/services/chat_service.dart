```dart
import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:smart_chat/models/chat_message.dart';
import 'package:smart_chat/utils/api.dart';

class ChatService {
  WebSocketChannel? _channel;
  final _messageController = StreamController<ChatMessage>.broadcast();
  final _api = Api();

  Stream<ChatMessage> get messageStream => _messageController.stream;

  Future<void> connect(String wsUrl) async {
    _channel = WebSocketChannel.connect(Uri.parse('$wsUrl/ws/smartchat'));
    
    _channel!.stream.listen(
      (data) {
        if (data != 'ping') {
          final message = ChatMessage.fromJson(data);
          _messageController.add(message);
        }
      },
      onError: (error) {
        print('WebSocket Error: $error');
        disconnect();
      },
      onDone: () {
        print('WebSocket Connection Closed');
        disconnect();
      },
    );

    // Keep alive ping
    Timer.periodic(const Duration(seconds: 15), (timer) {
      if (_channel != null) {
        _channel!.sink.add('ping');
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> disconnect() async {
    await _channel?.sink.close();
    _channel = null;
  }

  Future<List<ChatMessage>> getChatHistory() async {
    try {
      final response = await _api.post('/history');
      return (response.data['result'] as List)
          .map((json) => ChatMessage.fromJson(json))
          .toList();
    } catch (e) {
      throw 'Failed to load chat history: $e';
    }
  }

  Future<void> sendMessage(String message, String chatId, String userId) async {
    if (_channel == null) {
      throw 'WebSocket not connected';
    }

    final messageData = {
      'chat_id': chatId,
      'msg': message,
      'from': userId,
      'llm_ques': 'NO',
      'code': '',
    };

    _channel!.sink.add(messageData);
  }
}
```