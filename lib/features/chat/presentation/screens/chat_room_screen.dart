import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nonstop/core/l10n/app_localizations.dart';
import 'package:nonstop/core/theme/app_colors.dart';
import 'package:nonstop/features/chat/domain/entities/chat_message.dart';
import 'package:nonstop/features/chat/presentation/providers/chat_provider.dart';
import 'package:nonstop/features/chat/presentation/screens/fullscreen_image_viewer.dart';
import 'package:nonstop/features/chat/presentation/widgets/message_bubble.dart';
import 'package:nonstop/features/chat/presentation/widgets/chat_input_bar.dart';
import 'package:nonstop/features/chat/presentation/widgets/date_separator.dart';

class ChatRoomScreen extends ConsumerStatefulWidget {
  final int roomId;
  final String? roomName;

  const ChatRoomScreen({
    super.key,
    required this.roomId,
    this.roomName,
  });

  @override
  ConsumerState<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends ConsumerState<ChatRoomScreen> {
  final _scrollController = ScrollController();
  bool _showScrollToBottom = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Show scroll-to-bottom button when scrolled up
    final showButton = _scrollController.offset > 200;
    if (showButton != _showScrollToBottom) {
      setState(() => _showScrollToBottom = showButton);
    }

    // Infinite scroll: load more when near top (list is reversed)
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      ref.read(chatRoomProvider(widget.roomId).notifier).loadMore();
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatRoomProvider(widget.roomId));
    final currentUserId = ref.watch(currentUserIdProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomName ?? AppLocalizations.of(context).chat),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                _buildMessageList(state, currentUserId),
                if (_showScrollToBottom)
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: FloatingActionButton.small(
                      onPressed: _scrollToBottom,
                      child: const Icon(Icons.keyboard_arrow_down),
                    ),
                  ),
              ],
            ),
          ),
          ChatInputBar(
            onSend: (text) {
              ref.read(chatRoomProvider(widget.roomId).notifier).sendMessage(text);
            },
            onAttachmentTap: () => _showImagePicker(context),
            hintText: AppLocalizations.of(context).messageHint,
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList(ChatRoomState state, int? currentUserId) {
    if (state.isLoading && state.messages.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      controller: _scrollController,
      reverse: true,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      itemCount: state.messages.length + (state.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        // Show loading indicator at end (top when reversed)
        if (state.isLoadingMore && index == state.messages.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          );
        }

        final message = state.messages[index];
        final isMe = message.senderId == currentUserId;

        // Check if we need date separator
        final showDateSeparator = _shouldShowDateSeparator(state.messages, index);

        // Compute read status for sent messages
        final readStatus = state.readStatusByUser;
        bool isMessageRead = false;
        if (isMe && readStatus.isNotEmpty) {
          // A message is "read" if any other user's lastReadMessageId >= this message id
          isMessageRead = readStatus.values.any((lastRead) => lastRead >= message.id);
        }

        return Column(
          children: [
            MessageBubble(
              message: message,
              isMe: isMe,
              isRead: isMessageRead,
              onImageTap: () {
                if (message.type == MessageType.image) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FullscreenImageViewer(imageUrl: message.content),
                    ),
                  );
                }
              },
            ),
            if (showDateSeparator) DateSeparator(date: message.sentAt),
          ],
        );
      },
    );
  }

  bool _shouldShowDateSeparator(List<ChatMessage> messages, int index) {
    // Since list is reversed, check if current message is from different day than previous
    if (index == messages.length - 1) return true; // Always show for oldest message

    final current = messages[index];
    final next = messages[index + 1];

    return !_isSameDay(current.sentAt, next.sentAt);
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  void _showImagePicker(BuildContext context) {
    // Capture notifier reference before async operations
    final notifier = ref.read(chatRoomProvider(widget.roomId).notifier);
    final l10n = AppLocalizations.of(context);

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: AppColors.primary),
              title: Text(l10n.camera),
              onTap: () async {
                Navigator.pop(context);
                final picker = ImagePicker();
                final file = await picker.pickImage(
                  source: ImageSource.camera,
                  maxWidth: 1080,
                  imageQuality: 85,
                );
                if (file != null) {
                  notifier.sendImageMessage(file.path);
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: AppColors.primary),
              title: Text(l10n.gallery),
              onTap: () async {
                Navigator.pop(context);
                final picker = ImagePicker();
                final file = await picker.pickImage(
                  source: ImageSource.gallery,
                  maxWidth: 1080,
                  imageQuality: 85,
                );
                if (file != null) {
                  notifier.sendImageMessage(file.path);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
