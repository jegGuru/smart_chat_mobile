
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter/material.dart' show Size;

class ChatMessage {
  final String id;
  final String text;
  final String senderId;
  final DateTime timestamp;
  final List<String> images;
  final bool isFromBot;

  ChatMessage({
    required this.id,
    required this.text,
    required this.senderId,
    required this.timestamp,
    this.images = const [],
    this.isFromBot = false,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      text: json['msg'] as String,
      senderId: json['from'] as String,
      timestamp: DateTime.parse(json['time']),
      images: List<String>.from(json['imgs'] ?? []),
      isFromBot: json['from'] == 'llm',
    );
  }

  types.Message toFlutterChatMessage() {
    if (images.isNotEmpty) {
      return types.ImageMessage(
        author: types.User(id: senderId),
        id: id,
        uri: images.first,
        size: const Size(200, 200),
        createdAt: timestamp.millisecondsSinceEpoch,
      );
    }

    return types.TextMessage(
      author: types.User(id: senderId),
      id: id,
      text: text,
      createdAt: timestamp.millisecondsSinceEpoch,
    );
  }
}
