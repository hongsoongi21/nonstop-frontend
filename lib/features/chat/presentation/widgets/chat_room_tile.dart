import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nonstop/core/constants/routes.dart';
import 'package:nonstop/core/theme/app_colors.dart';
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
    final hasUnread = room.unreadCount > 0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap ?? () => context.push('${Routes.chat}/${room.id}'),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            gradient: hasUnread
                ? LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColors.primary.withValues(alpha: 0.03),
                      Colors.transparent,
                    ],
                  )
                : null,
          ),
          child: Row(
            children: [
              _buildAvatar(),
              const SizedBox(width: 14),
              Expanded(child: _buildContent()),
              const SizedBox(width: 10),
              _buildTrailing(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    final isGroup = room.type == ChatRoomType.group;
    final displayName = room.name ?? 'Chat';
    final initial = displayName.isNotEmpty ? displayName[0].toUpperCase() : '?';
    final hasUnread = room.unreadCount > 0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _getAvatarGradient(displayName),
            ),
            boxShadow: [
              BoxShadow(
                color: _getAvatarGradient(displayName)[0].withValues(alpha: 0.3),
                blurRadius: hasUnread ? 12 : 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              initial,
              style: AppTypography.headline4.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 22,
                letterSpacing: 0,
              ),
            ),
          ),
        ),
        if (isGroup)
          Positioned(
            right: -1,
            bottom: -1,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: AppColors.primaryGradient,
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.surface,
                  width: 2.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.people_rounded,
                size: 12,
                color: Colors.white,
              ),
            ),
          ),
        // Online indicator (example - would need actual online status)
        if (!isGroup && hasUnread)
          Positioned(
            right: 2,
            top: 2,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: AppColors.chatOnline,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.surface,
                  width: 2.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.chatOnline.withValues(alpha: 0.5),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
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
    final hasUnread = room.unreadCount > 0;

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
        Text(
          displayName,
          style: AppTypography.body1.copyWith(
            fontWeight: hasUnread ? FontWeight.w800 : FontWeight.w700,
            fontSize: 17,
            letterSpacing: -0.4,
            height: 1.2,
            color: hasUnread ? AppColors.textPrimary : AppColors.textPrimary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        const SizedBox(height: 5),

        // Last message preview
        if (hasLastMessage)
          Text(
            messagePreview,
            style: AppTypography.body2.copyWith(
              color: hasUnread ? AppColors.textSecondary : AppColors.textTertiary,
              fontSize: 14.5,
              height: 1.3,
              fontWeight: hasUnread ? FontWeight.w500 : FontWeight.w400,
              letterSpacing: 0.1,
            ),
            maxLines: 2,
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
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              gradient: hasUnread
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary.withValues(alpha: 0.12),
                        AppColors.primary.withValues(alpha: 0.06),
                      ],
                    )
                  : null,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              _formatTimestamp(timestamp),
              style: AppTypography.caption.copyWith(
                color: hasUnread ? AppColors.primary : AppColors.textTertiary,
                fontSize: 12,
                fontWeight: hasUnread ? FontWeight.w700 : FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
          ),

        if (hasUnread) ...[
          const SizedBox(height: 8),
          // Unread badge with gradient and glow
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: room.unreadCount > 99 ? 7 : 8,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFF6B6B),
                  Color(0xFFEF4444),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                  spreadRadius: 1,
                ),
              ],
            ),
            constraints: const BoxConstraints(
              minWidth: 24,
              minHeight: 24,
            ),
            child: Center(
              child: Text(
                room.unreadCount > 99 ? '99+' : room.unreadCount.toString(),
                style: AppTypography.caption.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  height: 1.0,
                  letterSpacing: 0.2,
                ),
              ),
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
