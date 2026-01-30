import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nonstop/core/constants/routes.dart';
import 'package:nonstop/core/theme/app_colors.dart';
import 'package:nonstop/core/theme/app_spacing.dart';
import 'package:nonstop/core/theme/app_typography.dart';
import 'package:nonstop/features/chat/domain/entities/chat_room.dart';

class ChatRoomTile extends StatelessWidget {
  final ChatRoom room;
  final int? currentUserId;
  final VoidCallback? onTap;

  const ChatRoomTile({
    super.key,
    required this.room,
    this.currentUserId,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => context.push('${Routes.chat}/${room.id}'),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.border.withValues(alpha: 0.3),
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            _buildAvatar(),
            SizedBox(width: AppSpacing.md),
            Expanded(child: _buildContent()),
            SizedBox(width: AppSpacing.sm),
            _buildTrailing(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    final isGroup = room.type == ChatRoomType.group;
    final displayName = room.name ?? 'Chat';
    final initial = displayName.isNotEmpty ? displayName[0].toUpperCase() : '?';

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _getAvatarGradient(displayName),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.15),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              initial,
              style: AppTypography.headline4.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        if (isGroup)
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.surface,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: const Icon(
                Icons.people,
                size: 11,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildContent() {
    final displayName = room.name ?? 'Chat';
    final hasLastMessage = room.lastMessage != null;
    final lastMessageContent = hasLastMessage ? room.lastMessage!.content : '';
    final isGroup = room.type == ChatRoomType.group;

    // For group chats, show sender prefix
    String messagePreview = lastMessageContent;
    if (isGroup && hasLastMessage && room.lastMessage!.senderId != currentUserId) {
      // Ideally we'd show sender name, but we only have ID
      // For now, just show the message with a subtle indicator
      messagePreview = lastMessageContent;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Room name with bold geometric styling
        Row(
          children: [
            Expanded(
              child: Text(
                displayName,
                style: AppTypography.body1.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  letterSpacing: -0.3,
                  height: 1.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),

        SizedBox(height: 4),

        // Last message preview
        if (hasLastMessage)
          Text(
            messagePreview,
            style: AppTypography.body2.copyWith(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.3,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        else
          Text(
            'No messages yet',
            style: AppTypography.body2.copyWith(
              color: AppColors.textHint,
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
      ],
    );
  }

  Widget _buildTrailing(BuildContext context) {
    final hasUnread = room.unreadCount > 0;
    final timestamp = room.lastMessage?.sentAt ?? room.updatedAt;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Timestamp with geometric styling
        if (timestamp != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: hasUnread
                  ? AppColors.primary.withValues(alpha: 0.08)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              _formatTimestamp(timestamp),
              style: AppTypography.caption.copyWith(
                color: hasUnread ? AppColors.primary : AppColors.textHint,
                fontSize: 11,
                fontWeight: hasUnread ? FontWeight.w600 : FontWeight.w400,
                letterSpacing: 0.3,
              ),
            ),
          ),

        if (hasUnread) ...[
          SizedBox(height: 6),
          // Unread badge with gradient
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: room.unreadCount > 99 ? 6 : 7,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFF6B6B),
                  Color(0xFFFF5252),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF5252).withValues(alpha: 0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            constraints: const BoxConstraints(
              minWidth: 22,
              minHeight: 22,
            ),
            child: Text(
              room.unreadCount > 99 ? '99+' : room.unreadCount.toString(),
              style: AppTypography.caption.copyWith(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                height: 1.2,
                letterSpacing: 0.2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ],
    );
  }

  String _formatTimestamp(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (messageDate == today) {
      return DateFormat.Hm().format(dateTime); // 14:30
    } else if (messageDate == yesterday) {
      return '어제';
    } else if (now.difference(dateTime).inDays < 7) {
      return DateFormat.E('ko').format(dateTime); // 월, 화, etc
    } else {
      return DateFormat.MMMd('ko').format(dateTime); // 1월 28일
    }
  }

  List<Color> _getAvatarGradient(String name) {
    // Generate consistent gradient based on name hash
    final hash = name.hashCode.abs();
    final gradients = [
      [const Color(0xFF667EEA), const Color(0xFF764BA2)],
      [const Color(0xFFF093FB), const Color(0xFFF5576C)],
      [const Color(0xFF4FACFE), const Color(0xFF00F2FE)],
      [const Color(0xFF43E97B), const Color(0xFF38F9D7)],
      [const Color(0xFFFA709A), const Color(0xFFFEE140)],
      [const Color(0xFF30CFD0), const Color(0xFF330867)],
      [const Color(0xFFA8EDEA), const Color(0xFFFED6E3)],
      [const Color(0xFFFF9A9E), const Color(0xFFFECAB5)],
    ];
    return gradients[hash % gradients.length];
  }
}
