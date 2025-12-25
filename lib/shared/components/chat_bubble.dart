import 'package:flutter/material.dart';

import '../../core/mock/mock_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// Chat bubble component for displaying messages
class ChatBubble extends StatelessWidget {
  final Message message;
  final bool isMe;
  final bool showAvatar;
  final bool showTime;

  const ChatBubble({
    super.key,
    required this.message,
    this.isMe = false,
    this.showAvatar = true,
    this.showTime = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSpacing.xs,
        horizontal: AppSpacing.md,
      ),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe && showAvatar) ...[
            CircleAvatar(
              radius: 16,
              backgroundImage: message.sender.avatarUrl != null
                  ? NetworkImage(message.sender.avatarUrl!)
                  : null,
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              child: message.sender.avatarUrl == null
                  ? Text(
                      message.sender.name.isNotEmpty
                          ? message.sender.name[0].toUpperCase()
                          : '?',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : null,
            ),
            SizedBox(width: AppSpacing.sm),
          ],

          // Message bubble
          Flexible(
            child: Container(
              padding: EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: isMe
                    ? AppColors.messageBubbleSent
                    : AppColors.messageBubbleReceived,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isMe ? AppSpacing.radiusMd : 4),
                  topRight: Radius.circular(isMe ? 4 : AppSpacing.radiusMd),
                  bottomLeft: Radius.circular(AppSpacing.radiusMd),
                  bottomRight: Radius.circular(AppSpacing.radiusMd),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sender name (only for received messages in group chat)
                  if (!isMe && showAvatar) ...[
                    Text(
                      message.sender.name,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: AppSpacing.xs),
                  ],

                  // Message content
                  Text(
                    message.content,
                    style: AppTypography.body2.copyWith(
                      color: isMe ? Colors.white : AppColors.textPrimary,
                      height: 1.4,
                    ),
                  ),

                  // Timestamp
                  if (showTime) ...[
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      message.timeAgo,
                      style: AppTypography.caption.copyWith(
                        color: (isMe ? Colors.white : AppColors.textSecondary)
                            .withValues(alpha: 0.7),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          if (isMe && showAvatar) ...[
            SizedBox(width: AppSpacing.sm),
            CircleAvatar(
              radius: 16,
              backgroundImage: message.sender.avatarUrl != null
                  ? NetworkImage(message.sender.avatarUrl!)
                  : null,
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              child: message.sender.avatarUrl == null
                  ? Text(
                      message.sender.name.isNotEmpty
                          ? message.sender.name[0].toUpperCase()
                          : '?',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : null,
            ),
          ],
        ],
      ),
    );
  }
}

/// Chat input component
class ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onSend;
  final bool isTyping;
  final String hintText;

  const ChatInput({
    super.key,
    required this.controller,
    this.onSend,
    this.isTyping = false,
    this.hintText = 'Type a message...',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.border),
        ),
      ),
      child: Row(
        children: [
          // Attachment button
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.attach_file,
              color: AppColors.textSecondary,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),

          SizedBox(width: AppSpacing.sm),

          // Text input
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTypography.body2.copyWith(
                  color: AppColors.textHint,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.background,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
              ),
              maxLines: 4,
              minLines: 1,
              textCapitalization: TextCapitalization.sentences,
            ),
          ),

          SizedBox(width: AppSpacing.sm),

          // Send button
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: onSend,
              icon: Icon(
                Icons.send,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(AppSpacing.sm),
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }
}

/// Typing indicator component
class TypingIndicator extends StatelessWidget {
  final String userName;

  const TypingIndicator({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSpacing.sm,
        horizontal: AppSpacing.md,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.chatTyping.withValues(alpha: 0.2),
            child: Icon(
              Icons.person,
              size: 16,
              color: AppColors.chatTyping,
            ),
          ),

          SizedBox(width: AppSpacing.sm),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.messageBubbleReceived,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(AppSpacing.radiusMd),
                bottomLeft: Radius.circular(AppSpacing.radiusMd),
                bottomRight: Radius.circular(AppSpacing.radiusMd),
              ),
            ),
            child: Row(
              children: [
                Text(
                  '$userName is typing',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(width: AppSpacing.sm),
                SizedBox(
                  width: 20,
                  height: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      3,
                      (index) => AnimatedContainer(
                        duration: Duration(milliseconds: 300 + (index * 100)),
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.chatTyping,
                          shape: BoxShape.circle,
                        ),
                        curve: Curves.easeInOut,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Conversation list item
class ConversationListItem extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback? onTap;

  const ConversationListItem({
    super.key,
    required this.conversation,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            // Avatar with online indicator
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: conversation.conversationAvatar.isNotEmpty
                      ? NetworkImage(conversation.conversationAvatar)
                      : null,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  child: conversation.conversationAvatar.isEmpty
                      ? Text(
                          conversation.conversationName.isNotEmpty
                              ? conversation.conversationName[0].toUpperCase()
                              : '?',
                          style: AppTypography.body1.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : null,
                ),
                if (conversation.otherParticipant.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: AppColors.chatOnline,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.surface,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(width: AppSpacing.md),

            // Conversation info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    conversation.conversationName,
                    style: AppTypography.body1.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 2),

                  // Last message
                  Text(
                    conversation.lastMessage.content,
                    style: AppTypography.body2.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            SizedBox(width: AppSpacing.sm),

            // Timestamp and unread count
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  conversation.lastMessage.timeAgo,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textHint,
                  ),
                ),

                if (conversation.unreadCount > 0) ...[
                  SizedBox(height: AppSpacing.xs),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: Text(
                      conversation.unreadCount.toString(),
                      style: AppTypography.caption.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
