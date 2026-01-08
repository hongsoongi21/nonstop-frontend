import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nonstop/shared/components/glass_container.dart';

import '../../../../core/mock/mock_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/components/post_card.dart'; // Reuse for header parts if possible, but might be easier to rebuild

class BoardDetailScreen extends ConsumerStatefulWidget {
  final String boardId;

  const BoardDetailScreen({
    super.key,
    required this.boardId,
  });

  @override
  ConsumerState<BoardDetailScreen> createState() => _BoardDetailScreenState();
}

class _BoardDetailScreenState extends ConsumerState<BoardDetailScreen> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();
  bool _isAnonymous = false;

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // In a real app, use a provider to fetch/watch the specific post
    final post = MockData.posts.firstWhere(
      (p) => p.id == widget.boardId,
      orElse: () => MockData.posts.first, // Fallback for dev
    );

    final comments = MockData.getCommentsByPostId(widget.boardId);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Post',
          style: AppTypography.headline6.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Post Header (Author, Time, Menu)
                  _buildPostHeader(post),

                  const SizedBox(height: AppSpacing.md),

                  // Category
                  _buildCategoryPill(post),

                  const SizedBox(height: AppSpacing.md),

                  // Title
                  Text(
                    post.title,
                    style: AppTypography.headline5.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.sm),

                  // Content
                  Text(
                    post.content,
                    style: AppTypography.body1.copyWith(
                      color: AppColors.textPrimary,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // Stats Text
                  Text(
                    '${post.views} views   ${post.likes} likes   ${post.comments} comments',
                    style: AppTypography.body2.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),
                  const Divider(height: 1),

                  // Action Buttons Row (Twitter Style)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _TwitterActionButton(
                          icon: Icons.chat_bubble_outline,
                          onTap: () => _commentFocusNode.requestFocus(),
                        ),
                        const SizedBox(width: AppSpacing.lg),
                        _TwitterActionButton(
                          icon: post.likes > 0 ? Icons.favorite : Icons.favorite_border,
                          color: post.likes > 0 ? AppColors.error : null,
                          onTap: () {},
                        ),
                        const SizedBox(width: AppSpacing.lg),
                        _TwitterActionButton(
                          icon: Icons.bookmark_border,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  const SizedBox(height: AppSpacing.lg),

                  // Comments Section Title
                  Text(
                    'Comments',
                    style: AppTypography.headline6.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Comments List
                  ...comments.map((comment) => _CommentItem(comment: comment)),
                ],
              ),
            ),
          ),

          // Bottom Input Area
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildPostHeader(Post post) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: post.authorAvatar != null
              ? NetworkImage(post.authorAvatar!)
              : null,
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
          child: post.authorAvatar == null
              ? Text(
                  post.author.isNotEmpty ? post.author[0].toUpperCase() : '?',
                  style: AppTypography.headline6.copyWith(
                    color: AppColors.primary,
                  ),
                )
              : null,
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      post.isAnonymous ? 'Anonymous' : post.author,
                      style: AppTypography.body1.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '• ${post.timeAgo}',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
              Text(
                post.university != null && post.major != null
                    ? '${post.university} • ${post.major}'
                    : 'Student',
                style: AppTypography.caption.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert),
          color: AppColors.textSecondary,
        ),
      ],
    );
  }

  Widget _buildCategoryPill(Post post) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Color(post.categoryColor).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        post.categoryName, // e.g. "General" or mapped name
        style: AppTypography.caption.copyWith(
          color: Color(post.categoryColor),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Anonymous Toggle
            Row(
              children: [
                Switch(
                  value: _isAnonymous,
                  onChanged: (val) => setState(() => _isAnonymous = val),
                  activeColor: AppColors.primary,
                ),
                Text(
                  'Post Anonymously',
                  style: AppTypography.body2.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6FA),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _commentController,
                      focusNode: _commentFocusNode,
                      decoration: const InputDecoration(
                        hintText: 'Reply...',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        filled: false,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                    onPressed: () {
                      // Send comment logic
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TwitterActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  const _TwitterActionButton({
    required this.icon,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        icon,
        size: 22,
        color: color ?? AppColors.textSecondary,
      ),
      padding: const EdgeInsets.all(AppSpacing.sm),
      constraints: const BoxConstraints(),
      splashRadius: 24,
    );
  }
}

class _CommentItem extends StatelessWidget {
  final Comment comment;

  const _CommentItem({required this.comment});

  @override
  Widget build(BuildContext context) {
    final bool isReply = comment.parentId != null;
    
    return Padding(
      padding: EdgeInsets.only(
        left: isReply ? 40.0 : 0,
        bottom: AppSpacing.lg,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: comment.authorAvatar != null
                ? NetworkImage(comment.authorAvatar!)
                : null,
            backgroundColor: Colors.grey[200],
            child: comment.authorAvatar == null
                ? Text(comment.author[0])
                : null,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F6FA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.author,
                        style: AppTypography.body2.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        comment.content,
                        style: AppTypography.body2,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      comment.timeAgo,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '${comment.likes} Likes',
                      style: AppTypography.caption.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Reply',
                      style: AppTypography.caption.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
