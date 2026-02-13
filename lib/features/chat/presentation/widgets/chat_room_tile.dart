import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nonstop/core/constants/routes.dart';
import 'package:nonstop/core/theme/app_colors.dart';
import 'package:nonstop/core/theme/app_spacing.dart';
import 'package:nonstop/core/theme/app_typography.dart';
import 'package:nonstop/features/chat/domain/entities/chat_room.dart';

/// Clean, minimal chat room tile following Swiss design principles
/// - Clear visual hierarchy through typography
/// - Restrained use of color (only for status indicators)
/// - Generous whitespace
/// - No unnecessary shadows or gradients
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final hasUnread = room.unreadCount > 0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap ?? () => context.push('${Routes.chat}/${room.id}'),
        splashColor: (isDarkMode ? AppColors.primaryLight : AppColors.primary)
            .withValues(alpha: 0.08),
        highlightColor: (isDarkMode ? AppColors.primaryLight : AppColors.primary)
            .withValues(alpha: 0.04),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md + 2,
          ),
          child: Row(
            children: [
              _buildAvatar(context),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: _buildContent(context, hasUnread)),
              const SizedBox(width: AppSpacing.md),
              _buildTrailing(context, hasUnread),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isGroup = room.type == ChatRoomType.group;
    final displayName = room.name ?? 'Chat';
    final initial = displayName.isNotEmpty ? displayName[0].toUpperCase() : '?';

    // Determine avatar image URL
    final imageUrl = room.imageUrl;
    final hasImage = imageUrl != null && imageUrl.isNotEmpty;

    // Avatar colors based on name hash for consistency
    final avatarColor = _getAvatarColor(displayName);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Main avatar
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: hasImage ? null : avatarColor.withValues(alpha: 0.15),
            border: Border.all(
              color: isDarkMode
                  ? AppColors.borderDark.withValues(alpha: 0.3)
                  : AppColors.border.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          child: ClipOval(
            child: hasImage
                ? CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => _buildInitialAvatar(
                      initial,
                      avatarColor,
                      isDarkMode,
                    ),
                    errorWidget: (context, url, error) => _buildInitialAvatar(
                      initial,
                      avatarColor,
                      isDarkMode,
                    ),
                  )
                : _buildInitialAvatar(initial, avatarColor, isDarkMode),
          ),
        ),

        // Online indicator - positioned at bottom-left of avatar
        if (!isGroup)
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: AppColors.chatOnline,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDarkMode ? AppColors.backgroundDark : AppColors.background,
                  width: 2.5,
                ),
              ),
            ),
          ),

        // Group indicator
        if (isGroup)
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.primaryLight : AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDarkMode ? AppColors.backgroundDark : AppColors.background,
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.people_rounded,
                size: 11,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInitialAvatar(String initial, Color color, bool isDarkMode) {
    return Container(
      color: color.withValues(alpha: isDarkMode ? 0.2 : 0.12),
      child: Center(
        child: Text(
          initial,
          style: AppTypography.headline5.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool hasUnread) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final displayName = room.name ?? 'Chat';
    final hasLastMessage = room.lastMessage != null;
    final lastMessageContent = hasLastMessage ? room.lastMessage!.content : '';

    final textPrimaryColor = isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final textSecondaryColor = isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final textHintColor = isDarkMode ? AppColors.textTertiaryDark : AppColors.textHint;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Username - bold, clear hierarchy
        Text(
          displayName,
          style: AppTypography.body1.copyWith(
            fontWeight: hasUnread ? FontWeight.w700 : FontWeight.w600,
            fontSize: 16,
            letterSpacing: -0.2,
            height: 1.2,
            color: textPrimaryColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        const SizedBox(height: 4),

        // Message preview - single line, muted
        if (hasLastMessage)
          Text(
            lastMessageContent,
            style: AppTypography.body2.copyWith(
              color: hasUnread ? textSecondaryColor : textHintColor,
              fontSize: 14,
              height: 1.3,
              fontWeight: hasUnread ? FontWeight.w500 : FontWeight.w400,
              letterSpacing: 0,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        else
          Text(
            'No messages yet',
            style: AppTypography.body2.copyWith(
              color: textHintColor,
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
      ],
    );
  }

  Widget _buildTrailing(BuildContext context, bool hasUnread) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final timestamp = room.lastMessage?.sentAt ?? room.updatedAt;
    final textHintColor = isDarkMode ? AppColors.textTertiaryDark : AppColors.textHint;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Time - simple, clean text
        if (timestamp != null)
          Text(
            _formatTimeAgo(timestamp),
            style: AppTypography.caption.copyWith(
              color: textHintColor,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              letterSpacing: 0,
            ),
          ),

        if (hasUnread) ...[
          const SizedBox(height: 6),
          // Unread badge - clean blue circle
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: room.unreadCount > 9 ? 6 : 0,
              vertical: 0,
            ),
            constraints: const BoxConstraints(
              minWidth: 22,
              minHeight: 22,
            ),
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.primaryLight : AppColors.primary,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Center(
              child: Text(
                room.unreadCount > 99 ? '99+' : room.unreadCount.toString(),
                style: AppTypography.caption.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  height: 1.0,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  /// Format timestamp as "Xm ago", "Xh ago", "Xd ago"
  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()}w ago';
    } else {
      return '${(difference.inDays / 30).floor()}mo ago';
    }
  }

  /// Generate consistent color based on name
  Color _getAvatarColor(String name) {
    final hash = name.hashCode.abs();
    final colors = [
      const Color(0xFF6366F1), // Indigo
      const Color(0xFF8B5CF6), // Violet
      const Color(0xFFEC4899), // Pink
      const Color(0xFFF59E0B), // Amber
      const Color(0xFF10B981), // Emerald
      const Color(0xFF06B6D4), // Cyan
      const Color(0xFF3B82F6), // Blue
      const Color(0xFFEF4444), // Red
    ];
    return colors[hash % colors.length];
  }
}
