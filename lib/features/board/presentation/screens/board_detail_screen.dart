import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/post.entity.dart';
import '../../domain/entities/comment.entity.dart';
import '../../../../core/utils/date_utils.dart';
import '../providers/post_detail_provider.dart';

class BoardDetailScreen extends ConsumerStatefulWidget {
  final String boardId;

  const BoardDetailScreen({super.key, required this.boardId});

  @override
  ConsumerState<BoardDetailScreen> createState() => _BoardDetailScreenState();
}

class _BoardDetailScreenState extends ConsumerState<BoardDetailScreen> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();
  bool _isAnonymous = false;
  int? _replyingToId;

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postId = int.parse(widget.boardId);
    final detailState = ref.watch(postDetailProvider(postId));
    final post = detailState.post;
    final comments = detailState.comments;
    final isLoading = detailState.isLoading;
    final error = detailState.error;

    if (isLoading && post == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Fixed: Handle null post with proper error message or loading state
    if (post == null) {
      if (error != null) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(child: Text(error)),
        );
      }
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

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
                    '${post.viewCount} views   ${post.likeCount} likes   ${post.commentCount} comments',
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
                          onTap: () {
                            setState(() => _replyingToId = null);
                            _commentFocusNode.requestFocus();
                          },
                        ),
                        const SizedBox(width: AppSpacing.lg),
                        _TwitterActionButton(
                          icon: post.isLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: post.isLiked ? AppColors.error : null,
                          onTap: () => ref
                              .read(postDetailProvider(postId).notifier)
                              .toggleLike(),
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
                  if (comments.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text('No comments yet. Be the first!'),
                      ),
                    )
                  else
                    ..._buildCommentsList(comments, postId),
                ],
              ),
            ),
          ),

          // Bottom Input Area
          if (_replyingToId != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: AppColors.primary.withValues(alpha: 0.1),
              child: Row(
                children: [
                  const Text('Replying to comment...'),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => setState(() => _replyingToId = null),
                  ),
                ],
              ),
            ),
          _buildInputArea(postId),
        ],
      ),
    );
  }

  List<Widget> _buildCommentsList(List<CommentEntity> comments, int postId) {
    List<Widget> list = [];
    final notifier = ref.read(postDetailProvider(postId).notifier);

    for (var comment in comments) {
      list.add(
        _CommentItem(
          comment: comment,
          onReply: () {
            setState(() => _replyingToId = comment.id);
            _commentFocusNode.requestFocus();
          },
          onLike: () => notifier.toggleCommentLike(comment.id),
          onEdit: () => _showEditCommentDialog(comment, notifier),
          onDelete: () => _showDeleteCommentDialog(comment.id, notifier),
        ),
      );
      // Add nested replies
      if (comment.replies.isNotEmpty) {
        for (var reply in comment.replies) {
          list.add(
            _CommentItem(
              comment: reply,
              isReply: true,
              onReply: () {
                setState(() => _replyingToId = reply.id);
                _commentFocusNode.requestFocus();
              },
              onLike: () => notifier.toggleCommentLike(reply.id),
              onEdit: () => _showEditCommentDialog(reply, notifier),
              onDelete: () => _showDeleteCommentDialog(reply.id, notifier),
            ),
          );
        }
      }
    }
    return list;
  }

  Widget _buildPostHeader(PostEntity post) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
          child: Text(
            post.writerNickname.isNotEmpty
                ? post.writerNickname[0].toUpperCase()
                : '?',
            style: AppTypography.headline6.copyWith(color: AppColors.primary),
          ),
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
                      post.isWriterAnonymous
                          ? 'Anonymous'
                          : post.writerNickname,
                      style: AppTypography.body1.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '• ${timeAgo(post.createdAt)}',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
              Text(
                'Student',
                style: AppTypography.caption.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        if (post.isMine)
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: AppColors.textSecondary),
            onSelected: (value) {
              if (value == 'edit') {
                _showEditPostDialog(post);
              } else if (value == 'delete') {
                _showDeletePostDialog(post.id);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'edit', child: Text('Edit')),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete', style: TextStyle(color: AppColors.error)),
              ),
            ],
          )
        else
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
            color: AppColors.textSecondary,
          ),
      ],
    );
  }

  void _showEditPostDialog(PostEntity post) {
    final titleController = TextEditingController(text: post.title);
    final contentController = TextEditingController(text: post.content);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Post'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(postDetailProvider(post.id).notifier)
                  .updatePost(
                    title: titleController.text,
                    content: contentController.text,
                    isAnonymous: post.isWriterAnonymous,
                    isSecret: post.isSecret,
                  );
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDeletePostDialog(int postId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Post'),
        content: const Text('Are you sure you want to delete this post?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(postDetailProvider(postId).notifier).deletePost();
              Navigator.pop(context); // Pop dialog
              context.pop(); // Pop screen
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showEditCommentDialog(
    CommentEntity comment,
    PostDetailNotifier notifier,
  ) {
    final contentController = TextEditingController(text: comment.content);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Comment'),
        content: TextField(
          controller: contentController,
          decoration: const InputDecoration(labelText: 'Content'),
          maxLines: 2,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              notifier.updateComment(comment.id, contentController.text);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDeleteCommentDialog(int commentId, PostDetailNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Comment'),
        content: const Text('Are you sure you want to delete this comment?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              notifier.deleteComment(commentId);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea(int postId) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
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
                  activeThumbColor: AppColors.primary,
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
                    icon: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      if (_commentController.text.trim().isEmpty) return;
                      ref
                          .read(postDetailProvider(postId).notifier)
                          .addComment(
                            _commentController.text.trim(),
                            upperCommentId: _replyingToId,
                            isAnonymous: _isAnonymous,
                          );
                      _commentController.clear();
                      setState(() => _replyingToId = null);
                      _commentFocusNode.unfocus();
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
      icon: Icon(icon, size: 22, color: color ?? AppColors.textSecondary),
      padding: const EdgeInsets.all(AppSpacing.sm),
      constraints: const BoxConstraints(),
      splashRadius: 24,
    );
  }
}

class _CommentItem extends StatelessWidget {
  final CommentEntity comment;
  final bool isReply;
  final VoidCallback? onReply;
  final VoidCallback? onLike;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const _CommentItem({
    required this.comment,
    this.isReply = false,
    this.onReply,
    this.onLike,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: isReply ? 40.0 : 0, bottom: AppSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.grey[200],
            child: Text(
              comment.writerNickname.isNotEmpty
                  ? comment.writerNickname[0].toUpperCase()
                  : '?',
            ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            comment.isWriterAnonymous
                                ? 'Anonymous'
                                : comment.writerNickname,
                            style: AppTypography.body2.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (comment.isMine)
                            PopupMenuButton<String>(
                              icon: const Icon(
                                Icons.more_horiz,
                                size: 16,
                                color: AppColors.textSecondary,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onSelected: (value) {
                                if (value == 'edit') {
                                  onEdit?.call();
                                } else if (value == 'delete') {
                                  onDelete?.call();
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'edit',
                                  child: Text('Edit'),
                                ),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(comment.content, style: AppTypography.body2),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      timeAgo(comment.createdAt),
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: onLike,
                      child: Row(
                        children: [
                          Icon(
                            comment.isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 14,
                            color: comment.isLiked
                                ? AppColors.error
                                : AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${comment.likeCount}',
                            style: AppTypography.caption.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isReply) ...[
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: onReply,
                        child: Text(
                          'Reply',
                          style: AppTypography.caption.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
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
