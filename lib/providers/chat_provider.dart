import 'package:flutter/foundation.dart';
import 'package:smart_chat/services/chat_service.dart';
import 'package:smart_chat/models/chat_message.dart';

class ChatProvider with ChangeNotifier {
  List<ChatMessage> _messages = [];
  bool _isLoading = false;
  String? _error;

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;
  String? get error => _error;

  final _chatService = ChatService();

  Future<void> sendMessage(String message) async {
    try {
      _isLoading = true;
      notifyListeners();

      final newMessage = await _chatService.sendMessage(message);
      _messages.add(newMessage);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadChatHistory() async {
    try {
      _isLoading = true;
      notifyListeners();

      _messages = await _chatService.getChatHistory();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}