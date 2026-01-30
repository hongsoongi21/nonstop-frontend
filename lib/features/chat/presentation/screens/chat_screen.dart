import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nonstop/core/l10n/app_localizations.dart';
import 'package:nonstop/core/theme/app_colors.dart';
import 'package:nonstop/core/theme/app_spacing.dart';
import 'package:nonstop/core/theme/app_typography.dart';
import 'package:nonstop/features/auth/presentation/providers/auth_provider.dart';
import 'package:nonstop/features/chat/presentation/providers/chat_provider.dart';
import 'package:nonstop/features/chat/presentation/widgets/chat_room_tile.dart';
import 'package:nonstop/features/chat/presentation/widgets/connection_status_bar.dart';
import 'package:nonstop/features/chat/presentation/widgets/create_chat_bottom_sheet.dart';
import 'package:nonstop/shared/components/app_background.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatListProvider);
    final currentUser = ref.watch(currentUserProvider);
    final currentUserId = currentUser?.id != null ? int.tryParse(currentUser!.id) : null;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).chat),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Search chats
            },
          ),
        ],
      ),
      body: AppBackground(
        child: Column(
          children: [
            // Connection status at top
            const ConnectionStatusBar(),

            // Chat list
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => ref.read(chatListProvider.notifier).loadRooms(),
                child: _buildChatList(context, chatState, currentUserId),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateChatSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildChatList(BuildContext context, ChatListState state, int? currentUserId) {
    if (state.isLoading && state.rooms.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null && state.rooms.isEmpty) {
      return Center(child: Text(AppLocalizations.of(context).chatLoadError));
    }

    if (state.rooms.isEmpty) {
      return _buildEmptyState(context);
    }

    return ListView.separated(
      padding: const EdgeInsets.only(top: AppSpacing.sm, bottom: 80),
      itemCount: state.rooms.length,
      separatorBuilder: (context, index) => const Divider(height: 1, indent: 72),
      itemBuilder: (context, index) {
        final room = state.rooms[index];
        return ChatRoomTile(
          room: room,
          currentUserId: currentUserId,
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat_bubble_outline, size: 64, color: AppColors.textHint),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.chatListEmpty,
            style: AppTypography.body1.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.chatListEmptyHint,
            style: AppTypography.body2.copyWith(color: AppColors.textHint),
          ),
        ],
      ),
    );
  }

  void _showCreateChatSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CreateChatBottomSheet(),
    );
  }
}
