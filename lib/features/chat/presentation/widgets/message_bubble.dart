import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:nonstop/core/l10n/app_localizations.dart';
import 'package:nonstop/core/theme/app_colors.dart';
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
    return Builder(
      builder: (context) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
        final textSecondaryColor = isDarkMode
            ? AppColors.textSecondaryDark
            : AppColors.textSecondary;

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
            color = textSecondaryColor;
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
          margin: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 1.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        color.withValues(alpha: 0.2),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: color.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icon,
                      size: 14,
                      color: color.withValues(alpha: 0.8),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      text,
                      style: AppTypography.caption.copyWith(
                        color: color.withValues(alpha: 0.9),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: 1.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color.withValues(alpha: 0.2),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUserMessage(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 8,
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
                const SizedBox(width: 36),
              const SizedBox(width: 10),
            ],

            // Message content
            Flexible(
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  _buildMessageBubble(context),
                  const SizedBox(height: 4),
                  _buildMetadata(),
                ],
              ),
            ),

            // Right side for sent messages
            if (isMe) ...[
              const SizedBox(width: 10),
              if (showAvatar) _buildAvatar(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isMe
              ? AppColors.primaryGradient
              : [
                  AppColors.tertiary,
                  AppColors.tertiaryDark,
                ],
        ),
        boxShadow: [
          BoxShadow(
            color: (isMe ? AppColors.primary : AppColors.tertiary)
                .withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          '?',
          style: AppTypography.body1.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
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
    // Theme-aware colors will be obtained from context in the parent widget
    // For now, using the static colors which work well for both themes
    return Builder(
      builder: (context) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
        final receivedBubbleColor = isDarkMode
            ? AppColors.messageBubbleReceivedDark
            : AppColors.messageBubbleReceived;
        final receivedTextColor = isDarkMode
            ? AppColors.textPrimaryDark
            : AppColors.textPrimary;

        return Container(
          constraints: const BoxConstraints(
            maxWidth: 280,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            gradient: isMe
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: AppColors.primaryGradient,
                  )
                : null,
            color: isMe ? null : receivedBubbleColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isMe ? 20 : 6),
              topRight: Radius.circular(isMe ? 6 : 20),
              bottomLeft: const Radius.circular(20),
              bottomRight: const Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: isMe
                    ? AppColors.primary.withValues(alpha: 0.25)
                    : AppColors.shadow.withValues(alpha: isDarkMode ? 0.3 : 0.08),
                blurRadius: isMe ? 12 : 6,
                offset: Offset(0, isMe ? 3 : 2),
              ),
            ],
          ),
          child: Text(
            message.content,
            style: AppTypography.body2.copyWith(
              color: isMe ? Colors.white : receivedTextColor,
              height: 1.5,
              fontSize: 15,
              fontWeight: isMe ? FontWeight.w500 : FontWeight.w400,
              letterSpacing: 0.15,
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageBubble() {
    final bool isLocalFile = message.isSending && !message.content.startsWith('http');

    return Builder(
      builder: (context) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
        final surfaceVariantColor = isDarkMode
            ? AppColors.surfaceVariantDark
            : AppColors.surfaceVariant;
        final textSecondaryColor = isDarkMode
            ? AppColors.textSecondaryDark
            : AppColors.textSecondary;
        final shadowColor = isDarkMode ? Colors.black38 : AppColors.shadowMedium;

        return GestureDetector(
          onTap: isLocalFile ? null : onImageTap,
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 260,
              maxHeight: 340,
              minWidth: 200,
              minHeight: 140,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  if (isLocalFile)
                    Image.file(
                      File(message.content),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: surfaceVariantColor,
                        child: Center(
                          child: Icon(
                            Icons.broken_image_rounded,
                            size: 36,
                            color: textSecondaryColor,
                          ),
                        ),
                      ),
                    )
                  else
                    CachedNetworkImage(
                      imageUrl: message.content,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              surfaceVariantColor,
                              surfaceVariantColor.withValues(alpha: 0.7),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 32,
                                height: 32,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    isMe ? AppColors.primary : AppColors.tertiary,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Loading image...',
                                style: AppTypography.caption.copyWith(
                                  color: textSecondaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.errorLight,
                              AppColors.errorLight.withValues(alpha: 0.7),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.broken_image_rounded,
                                  size: 36,
                                  color: AppColors.error,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Failed to load',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.error,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  // Upload progress overlay for local files
                  if (isLocalFile)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                        ),
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  AppLocalizations.of(context)!.uploading,
                                  style: AppTypography.caption.copyWith(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  // Tap overlay hint (only for loaded images)
                  if (!isLocalFile)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.7),
                              Colors.black.withValues(alpha: 0.3),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.fullscreen_rounded,
                              size: 16,
                              color: Colors.white.withValues(alpha: 0.95),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Tap to view full size',
                              style: AppTypography.caption.copyWith(
                                color: Colors.white.withValues(alpha: 0.95),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.2,
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
      },
    );
  }

  Widget _buildMetadata() {
    final timeFormat = DateFormat('HH:mm');
    final timeString = timeFormat.format(message.sentAt);

    return Builder(
      builder: (context) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
        final textSecondaryColor = isDarkMode
            ? AppColors.textSecondaryDark
            : AppColors.textSecondary;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isMe) ...[
                Text(
                  timeString,
                  style: AppTypography.caption.copyWith(
                    color: textSecondaryColor.withValues(alpha: 0.7),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
              if (isMe) ...[
                _buildStatusIndicator(context),
                const SizedBox(width: 5),
                Text(
                  timeString,
                  style: AppTypography.caption.copyWith(
                    color: textSecondaryColor.withValues(alpha: 0.7),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusIndicator(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textSecondaryColor = isDarkMode
        ? AppColors.textSecondaryDark
        : AppColors.textSecondary;
    final primaryColor = isDarkMode ? AppColors.primaryLight : AppColors.primary;

    if (message.isSending) {
      return SizedBox(
        width: 14,
        height: 14,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            textSecondaryColor.withValues(alpha: 0.5),
          ),
        ),
      );
    }

    if (message.hasError) {
      return Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: AppColors.errorLight,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.priority_high_rounded,
          size: 12,
          color: AppColors.error,
        ),
      );
    }

    if (isRead) {
      return Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryColor.withValues(alpha: 0.15),
              primaryColor.withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          Icons.done_all_rounded,
          size: 12,
          color: primaryColor,
        ),
      );
    }

    return Icon(
      Icons.done_rounded,
      size: 14,
      color: textSecondaryColor.withValues(alpha: 0.6),
    );
  }
}
