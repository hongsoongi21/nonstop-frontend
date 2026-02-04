import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nonstop/core/l10n/app_localizations.dart';
import 'package:nonstop/core/theme/app_colors.dart';
import 'package:nonstop/core/theme/app_typography.dart';
import 'package:nonstop/features/chat/domain/entities/chat_message.dart';
import 'package:nonstop/features/chat/presentation/providers/chat_provider.dart';
import 'package:nonstop/features/chat/presentation/screens/fullscreen_image_viewer.dart';
import 'package:nonstop/features/chat/presentation/widgets/message_bubble.dart';
import 'package:nonstop/features/chat/presentation/widgets/chat_input_bar.dart';
import 'package:nonstop/features/chat/presentation/widgets/date_separator.dart';
import 'package:nonstop/shared/components/report_dialog.dart';
import 'package:nonstop/shared/components/block_user_dialog.dart';
import 'package:nonstop/features/friends/data/api/friend_api_impl.dart';

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
  int? _otherUserId;
  String? _otherUserName;

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

  void _updateOtherUserInfo(ChatRoomState state) {
    final currentUserId = ref.read(currentUserIdProvider);
    if (currentUserId == null || state.messages.isEmpty) return;

    // Find other user from messages
    final otherMessage = state.messages.firstWhere(
      (m) => m.senderId != currentUserId,
      orElse: () => state.messages.first,
    );

    if (otherMessage.senderId != currentUserId) {
      _otherUserId = otherMessage.senderId;
      _otherUserName = widget.roomName;
    }
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
    final l10n = AppLocalizations.of(context);

    // Update other user info
    _updateOtherUserInfo(state);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // Dismiss keyboard when tapping outside (iOS fix)
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.roomName ?? AppLocalizations.of(context).chat,
          style: AppTypography.headline4.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        shadowColor: AppColors.shadow,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert_rounded, size: 22),
              color: AppColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              offset: const Offset(0, 48),
              onSelected: (value) {
                if (value == 'report') {
                  _handleReportUser();
                } else if (value == 'block') {
                  _handleBlockUser();
                } else if (value == 'leave') {
                  _handleLeaveRoom();
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'report',
                  child: Row(
                    children: [
                      const Icon(Icons.report_outlined, color: AppColors.error),
                      const SizedBox(width: 12),
                      Text(
                        l10n.report,
                        style: AppTypography.body2.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'block',
                  child: Row(
                    children: [
                      const Icon(Icons.block, color: AppColors.error),
                      const SizedBox(width: 12),
                      Text(
                        l10n.blockUser,
                        style: AppTypography.body2.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem(
                  value: 'leave',
                  child: Row(
                    children: [
                      const Icon(Icons.exit_to_app_rounded, color: AppColors.textSecondary),
                      const SizedBox(width: 12),
                      Text(
                        l10n.leaveRoom,
                        style: AppTypography.body2.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.background,
              AppColors.surfaceVariant.withValues(alpha: 0.3),
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  _buildMessageList(state, currentUserId),
                  if (_showScrollToBottom)
                    Positioned(
                      right: 16,
                      bottom: 16,
                      child: TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOutCubic,
                        tween: Tween(begin: 0.0, end: 1.0),
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: child,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: AppColors.primaryGradient,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: FloatingActionButton.small(
                            onPressed: _scrollToBottom,
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            child: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 24,
                            ),
                          ),
                        ),
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
      ),
    ),
    );
  }

  Widget _buildMessageList(ChatRoomState state, int? currentUserId) {
    if (state.isLoading && state.messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Loading messages...',
              style: AppTypography.body2.copyWith(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      reverse: true,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      itemCount: state.messages.length + (state.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        // Show loading indicator at end (top when reversed)
        if (state.isLoadingMore && index == state.messages.length) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
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

        return TweenAnimationBuilder<double>(
          key: ValueKey(message.id),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 15 * (1 - value)),
                child: child,
              ),
            );
          },
          child: Column(
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
                onLongPress: !isMe
                    ? () => _handleReportMessage(context, message.id)
                    : null,
              ),
              if (showDateSeparator) DateSeparator(date: message.sentAt),
            ],
          ),
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
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary.withValues(alpha: 0.1),
                        AppColors.tertiary.withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                title: Text(
                  l10n.camera,
                  style: AppTypography.body1.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Take a photo',
                  style: AppTypography.body2.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
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
              const Divider(height: 1, indent: 72),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.tertiary.withValues(alpha: 0.1),
                        AppColors.primary.withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.photo_library_rounded,
                    color: AppColors.tertiary,
                    size: 24,
                  ),
                ),
                title: Text(
                  l10n.gallery,
                  style: AppTypography.body1.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Choose from gallery',
                  style: AppTypography.body2.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
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
      ),
    );
  }

  Future<void> _handleReportUser() async {
    if (_otherUserId == null) return;

    await showReportDialog(
      context: context,
      targetType: ReportTargetType.user,
      targetId: _otherUserId!,
    );
  }

  Future<void> _handleBlockUser() async {
    if (_otherUserId == null) return;

    final l10n = AppLocalizations.of(context);
    final userName = _otherUserName ?? l10n.chat;

    final confirmed = await BlockUserDialog.show(context, userName);
    if (!confirmed || !mounted) return;

    try {
      final friendApi = ref.read(friendApiProvider);
      final result = await friendApi.blockUser(_otherUserId.toString());

      result.fold(
        (error) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.errorOccurred),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        (_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$userName ${l10n.blockUser}'),
                backgroundColor: AppColors.success,
              ),
            );
            Navigator.of(context).pop();
          }
        },
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorOccurred),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _handleLeaveRoom() async {
    final l10n = AppLocalizations.of(context);

    // 확인 다이얼로그 표시
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          l10n.leaveRoom,
          style: AppTypography.headline5.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          l10n.leaveRoomConfirm,
          style: AppTypography.body2.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              l10n.cancel,
              style: AppTypography.body2.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              l10n.leaveRoom,
              style: AppTypography.body2.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    // 채팅방 나가기 실행
    final success = await ref.read(chatRoomProvider(widget.roomId).notifier).leaveRoom();

    if (!mounted) return;

    if (success) {
      // 채팅 목록에서 제거
      ref.read(chatListProvider.notifier).removeRoom(widget.roomId);

      // 화면 닫기
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.leaveRoomSuccess),
          backgroundColor: AppColors.success,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.errorOccurred),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Future<void> _handleReportMessage(BuildContext context, int messageId) async {
    final l10n = AppLocalizations.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.report_outlined,
                    color: AppColors.error,
                    size: 24,
                  ),
                ),
                title: Text(
                  l10n.report,
                  style: AppTypography.body1.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  'Report this message',
                  style: AppTypography.body2.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  await showReportDialog(
                    context: context,
                    targetType: ReportTargetType.chatMessage,
                    targetId: messageId,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
