import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nonstop/core/constants/routes.dart';
import 'package:nonstop/features/chat/presentation/providers/chat_provider.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Show user picker to create 1:1 chat
            },
          ),
        ],
      ),
      body: state.isLoading && state.rooms.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(child: Text('Error: ${state.error}'))
              : ListView.separated(
                  itemCount: state.rooms.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (_, index) {
                    final room = state.rooms[index];
                    return ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(room.name ?? 'Chat ${room.id}'),
                      subtitle: Text(room.lastMessage?.content ?? 'No messages'),
                      trailing: room.unreadCount > 0
                          ? CircleAvatar(
                              radius: 10,
                              child: Text(
                                '${room.unreadCount}',
                                style: const TextStyle(fontSize: 10),
                              ),
                            )
                          : null,
                      onTap: () {
                        context.push(Routes.chatRoomPath(room.id.toString()));
                      },
                    );
                  },
                ),
    );
  }
}
