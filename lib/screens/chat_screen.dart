import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:smart_chat/providers/chat_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChatProvider>().loadChatHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Handle logout
            },
          ),
        ],
      ),
      body: Consumer<ChatProvider>(
        builder: (context, chatProvider, child) {
          if (chatProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Chat(
            messages: _convertMessages(chatProvider.messages),
            onSendPressed: _handleSendPressed,
            user: const types.User(id: '1'), // Current user ID
          );
        },
      ),
    );
  }

  List<types.Message> _convertMessages(List<ChatMessage> messages) {
    // Convert your ChatMessage model to flutter_chat_types Message
    return [];
  }

  void _handleSendPressed(types.PartialText message) {
    context.read<ChatProvider>().sendMessage(message.text);
  }
}