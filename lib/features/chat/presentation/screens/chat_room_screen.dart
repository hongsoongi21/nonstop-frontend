import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nonstop/features/chat/domain/entities/chat_message.dart';
import 'package:nonstop/features/chat/presentation/providers/chat_provider.dart';

class ChatRoomScreen extends ConsumerStatefulWidget {
  final int roomId;

  const ChatRoomScreen({
    super.key,
    required this.roomId,
  });

  @override
  ConsumerState<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends ConsumerState<ChatRoomScreen> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatRoomProvider(widget.roomId));
    final notifier = ref.read(chatRoomProvider(widget.roomId).notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room ${widget.roomId}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    reverse: true, // Start from bottom
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      // Reverse index access if messages are ordered NEWEST -> OLDEST
                      // If messages are OLDEST -> NEWEST, we need to reverse the list or use index.
                      // Usually we store NEWEST first for reverse list view.
                      final message = state.messages[index];
                      return _buildMessageBubble(message);
                    },
                  ),
          ),
          _buildInputArea(notifier),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final isMe = message.senderId == 0; // Assuming 0 is me for now
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.content,
              style: TextStyle(color: isMe ? Colors.white : Colors.black),
            ),
            if (message.isSending)
              const Icon(Icons.access_time, size: 12, color: Colors.white70),
            if (message.hasError)
              const Icon(Icons.error, size: 12, color: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea(ChatRoomNotifier notifier) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _sendMessage(notifier),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _sendMessage(notifier),
          ),
        ],
      ),
    );
  }

  void _sendMessage(ChatRoomNotifier notifier) {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      notifier.sendMessage(text);
      _textController.clear();
    }
  }
}
