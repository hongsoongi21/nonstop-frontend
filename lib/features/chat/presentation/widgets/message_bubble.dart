import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:nonstop/core/theme/app_colors.dart';
import 'package:nonstop/core/theme/app_spacing.dart';
import 'package:nonstop/core/theme/app_typography.dart';
import 'package:nonstop/features/chat/domain/entities/chat_message.dart';

/// Message bubble widget for displaying individual chat messages
/// Supports text, images, and system messages with distinct visual styles
class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isMe;
  final bool showAvatar;
  final bool isRead;
  final VoidCallback? onImageTap;
  final VoidCallback? onLongPress;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.showAvatar = true,
    this.isRead = false,
    this.onImageTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    // System messages have a completely different design
    if (_isSystemMessage) {
      return _buildSystemMessage();
    }

    return _buildUserMessage(context);
  }

  bool get _isSystemMessage {
    return message.type == MessageType.systemInvite ||
        message.type == MessageType.systemLeave ||
        message.type == MessageType.systemKick;
  }

  Widget _buildSystemMessage() {
    String text;
    IconData icon;
    Color color;

    switch (message.type) {
      case MessageType.systemInvite:
        text = '${message.content}님이 초대되었습니다';
        icon = Icons.person_add_rounded;
        color = AppColors.chatOnline;
        break;
      case MessageType.systemLeave:
        text = '${message.content}님이 나갔습니다';
        icon = Icons.exit_to_app_rounded;
        color = AppColors.textHint;
        break;
      case MessageType.systemKick:
        text = '${message.content}님이 강퇴되었습니다';
        icon = Icons.block_rounded;
        color = AppColors.error;
        break;
      default:
        text = message.content;
        icon = Icons.info_outline_rounded;
        color = AppColors.info;
    }

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: AppSpacing.md,
        horizontal: AppSpacing.lg,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    color.withValues(alpha: 0.3),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 14,
                  color: color.withValues(alpha: 0.7),
                ),
                SizedBox(width: AppSpacing.xs),
                Text(
                  text,
                  style: AppTypography.caption.copyWith(
                    color: color.withValues(alpha: 0.8),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withValues(alpha: 0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserMessage(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: AppSpacing.xs,
          horizontal: AppSpacing.md,
        ),
        child: Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Left side for received messages
            if (!isMe) ...[
              if (showAvatar)
                _buildAvatar()
              else
                SizedBox(width: 32), // Spacing for alignment
              SizedBox(width: AppSpacing.sm),
            ],

            // Message content
            Flexible(
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  _buildMessageBubble(context),
                  SizedBox(height: 2),
                  _buildMetadata(),
                ],
              ),
            ),

            // Right side for sent messages
            if (isMe) ...[
              SizedBox(width: AppSpacing.xs),
              if (showAvatar) _buildAvatar(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.8),
            AppColors.primaryDark,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          '?',
          style: AppTypography.body2.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(BuildContext context) {
    if (message.type == MessageType.image) {
      return _buildImageBubble();
    }
    return _buildTextBubble();
  }

  Widget _buildTextBubble() {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 280,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm + 2,
      ),
      decoration: BoxDecoration(
        color: isMe ? AppColors.messageBubbleSent : AppColors.messageBubbleReceived,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isMe ? AppSpacing.radiusMd : 4),
          topRight: Radius.circular(isMe ? 4 : AppSpacing.radiusMd),
          bottomLeft: Radius.circular(AppSpacing.radiusMd),
          bottomRight: Radius.circular(AppSpacing.radiusMd),
        ),
        boxShadow: [
          BoxShadow(
            color: isMe
                ? AppColors.primary.withValues(alpha: 0.15)
                : AppColors.shadow.withValues(alpha: 0.5),
            blurRadius: isMe ? 8 : 4,
            offset: Offset(0, isMe ? 2 : 1),
          ),
        ],
      ),
      child: Text(
        message.content,
        style: AppTypography.body2.copyWith(
          color: isMe ? Colors.white : AppColors.textPrimary,
          height: 1.45,
          fontSize: 14.5,
          letterSpacing: 0.1,
        ),
      ),
    );
  }

  Widget _buildImageBubble() {
    return GestureDetector(
      onTap: onImageTap,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 240,
          maxHeight: 320,
          minWidth: 180,
          minHeight: 120,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withValues(alpha: 0.6),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              CachedNetworkImage(
                imageUrl: message.content,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppColors.surfaceSecondary,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isMe ? AppColors.primary : AppColors.textHint,
                          ),
                        ),
                        SizedBox(height: AppSpacing.sm),
                        Text(
                          'Loading image...',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textHint,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.error.withValues(alpha: 0.1),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.broken_image_rounded,
                          size: 48,
                          color: AppColors.error.withValues(alpha: 0.5),
                        ),
                        SizedBox(height: AppSpacing.sm),
                        Text(
                          'Failed to load image',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.error,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Tap overlay hint
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.fullscreen_rounded,
                        size: 14,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                      SizedBox(width: AppSpacing.xs),
                      Text(
                        'Tap to view',
                        style: AppTypography.caption.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetadata() {
    final timeFormat = DateFormat('HH:mm');
    final timeString = timeFormat.format(message.sentAt);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isMe) ...[
          Text(
            timeString,
            style: AppTypography.caption.copyWith(
              color: AppColors.textHint,
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
        if (isMe) ...[
          _buildStatusIndicator(),
          SizedBox(width: 4),
          Text(
            timeString,
            style: AppTypography.caption.copyWith(
              color: AppColors.textHint,
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildStatusIndicator() {
    if (message.isSending) {
      return SizedBox(
        width: 12,
        height: 12,
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
          valueColor: AlwaysStoppedAnimation<Color>(
            AppColors.textHint.withValues(alpha: 0.6),
          ),
        ),
      );
    }

    if (message.hasError) {
      return Icon(
        Icons.error_outline_rounded,
        size: 14,
        color: AppColors.error,
      );
    }

    if (isRead) {
      return Icon(
        Icons.done_all_rounded,
        size: 14,
        color: AppColors.primary,
      );
    }

    return Icon(
      Icons.done_rounded,
      size: 14,
      color: AppColors.textHint.withValues(alpha: 0.7),
    );
  }
}
