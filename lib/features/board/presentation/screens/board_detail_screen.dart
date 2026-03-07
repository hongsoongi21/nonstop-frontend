import 'package:dice_bear/dice_bear.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/l10n/app_localizations.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/post.entity.dart';
import '../../domain/entities/comment.entity.dart';
import '../../domain/entities/board.entity.dart';
import '../../../../core/utils/date_utils.dart';
import '../providers/post_detail_provider.dart';
import '../providers/board_provider.dart';
import '../../../../shared/components/report_dialog.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../features/chat/presentation/providers/chat_provider.dart';
import '../../../../features/friends/presentation/providers/friend_management_provider.dart';
import '../../../../core/supabase/supabase_provider.dart';
import '../../../../core/constants/routes.dart';

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
  bool _writerAllowChat = true;
  bool _hasFetchedPermission = false;

  Future<void> _fetchWriterChatPermission(PostEntity post) async {
    if (post.isMine || post.writerAuthId == null) return;
    try {
      final supabase = ref.read(supabaseClientProvider);
      final settings = await supabase
          .from('user_settings')
          .select('allow_message_requests')
          .eq('user_id', post.writerAuthId!)
          .maybeSingle();
      if (mounted) {
        setState(() {
          _writerAllowChat =
              settings?['allow_message_requests'] as bool? ?? true;
        });
      }
    } catch (_) {
      // Default to true if fetch fails
    }
  }

  bool _isAnonymousBoard() {
    final boardState = ref.read(boardProvider);
    return boardState.selectedBoard?.type == BoardType.anonymous;
  }

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

    if (post == null) {
      if (error != null) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(child: Text(error)),
        );
      }
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (!post.isMine && !_hasFetchedPermission) {
      _hasFetchedPermission = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _fetchWriterChatPermission(post);
      });
    }

    return Scaffold(
      backgroundColor: context.surfaceColor,
      appBar: _buildAppBar(context),
      body: _buildBody(context, post, comments, postId),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AppBar(
      backgroundColor: context.surfaceColor,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        color: context.textPrimaryColor,
        onPressed: () => GoRouter.of(context).pop(),
      ),
      title: Text(
        l10n.post,
        style: AppTypography.headline5.copyWith(
          fontWeight: FontWeight.w700,
          color: context.textPrimaryColor,
          letterSpacing: -0.3,
        ),
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                context.dividerColor.withValues(alpha: 0.3),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    PostEntity post,
    List<CommentEntity> comments,
    int postId,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPostHeader(context, post),
                const SizedBox(height: 20),
                _buildPostContent(post),
                const SizedBox(height: 24),
                Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        context.dividerColor.withValues(alpha: 0.4),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _buildActionButtons(context, post, postId),
                const SizedBox(height: 8),
                Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        context.dividerColor.withValues(alpha: 0.4),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _buildCommentsSection(context, comments, postId),
              ],
            ),
          ),
        ),
        if (_replyingToId != null)
          Container(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.06),
              border: Border(
                top: BorderSide(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.reply_rounded, size: 16, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  l10n.replyingToComment,
                  style: AppTypography.body2.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => setState(() => _replyingToId = null),
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.close_rounded,
                      size: 18,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        _buildInputArea(context, postId),
      ],
    );
  }

  Widget _buildPostContent(PostEntity post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (post.category != null) ...[
          _buildCategoryPill(post),
          const SizedBox(height: 16),
        ],
        Text(
          post.title,
          style: AppTypography.headline3.copyWith(
            fontWeight: FontWeight.w700,
            color: context.textPrimaryColor,
            height: 1.3,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          post.content,
          style: AppTypography.body1.copyWith(
            color: context.textPrimaryColor,
            height: 1.65,
            letterSpacing: 0.1,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 16,
          children: [
            _buildStatItem(Icons.visibility_outlined, '${post.viewCount}'),
            _buildStatItem(Icons.favorite_border, '${post.likeCount}'),
            _buildStatItem(Icons.chat_bubble_outline, '${post.commentCount}'),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String count) {
    return Builder(
      builder: (context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: context.textTertiaryColor),
          const SizedBox(width: 4),
          Text(
            count,
            style: AppTypography.body2.copyWith(
              color: context.textTertiaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryPill(PostEntity post) {
    if (post.category == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.1),
            AppColors.primary.withValues(alpha: 0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Text(
        post.category!,
        style: AppTypography.caption.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    PostEntity post,
    int postId,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _ActionButton(
            icon: Icons.chat_bubble_outline_rounded,
            label: l10n.comment,
            onTap: () {
              setState(() => _replyingToId = null);
              _commentFocusNode.requestFocus();
            },
          ),
          const SizedBox(width: 24),
          Semantics(
            identifier: 'board_detail_like_btn',
            child: _ActionButton(
              icon: post.isLiked
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              label: l10n.like,
              color: post.isLiked ? AppColors.primary : null,
              isActive: post.isLiked,
              onTap: () =>
                  ref.read(postDetailProvider(postId).notifier).toggleLike(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsSection(
    BuildContext context,
    List<CommentEntity> comments,
    int postId,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              l10n.comments,
              style: AppTypography.headline4.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: context.surfaceVariantColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${comments.length}',
                style: AppTypography.caption.copyWith(
                  color: context.textSecondaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (comments.isEmpty)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.comment_outlined,
                    size: 48,
                    color: context.textTertiaryColor.withValues(alpha: 0.4),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.noCommentsYet,
                    style: AppTypography.body1.copyWith(
                      color: context.textTertiaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.beFirstToComment,
                    style: AppTypography.body2.copyWith(
                      color: context.textTertiaryColor,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          ..._buildCommentsList(comments, postId),
      ],
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
          onReport: () async {
            await showReportDialog(
              context: context,
              targetType: ReportTargetType.comment,
              targetId: comment.id,
            );
          },
          onAddFriend: comment.isWriterAnonymous || comment.isMine
              ? null
              : () async {
                  if (comment.writerId != null) {
                    final error = await ref
                        .read(friendManagementProvider.notifier)
                        .sendRequest(comment.writerId.toString());
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            error ?? '친구 요청을 보냈습니다',
                          ),
                          backgroundColor:
                              error == null ? AppColors.success : AppColors.error,
                        ),
                      );
                    }
                  }
                },
          onStartChat: comment.isMine
              ? null
              : () async {
                  if (comment.writerId != null) {
                    final room = await ref
                        .read(chatListProvider.notifier)
                        .createOneToOneRoom(comment.writerId!, roomName: comment.isWriterAnonymous ? '익명' : null);
                    if (room != null && mounted) {
                      GoRouter.of(context).push(
                        '${Routes.chat}/${room.id}',
                        extra: room.name,
                      );
                    }
                  }
                },
        ),
      );
      // Add nested replies (동일 선상에 배치, 부모 닉네임 멘션 표시)
      if (comment.replies.isNotEmpty) {
        // 부모 댓글 닉네임 (익명이면 "익명" 표시)
        final parentNickname = comment.isWriterAnonymous
            ? AppLocalizations.of(context)!.anonymous
            : comment.writerNickname;

        for (var reply in comment.replies) {
          list.add(
            _CommentItem(
              comment: reply,
              isReply: true,
              parentNickname: parentNickname,
              onLike: () => notifier.toggleCommentLike(reply.id),
              onEdit: () => _showEditCommentDialog(reply, notifier),
              onDelete: () => _showDeleteCommentDialog(reply.id, notifier),
              onReport: () async {
                await showReportDialog(
                  context: context,
                  targetType: ReportTargetType.comment,
                  targetId: reply.id,
                );
              },
              onAddFriend: reply.isWriterAnonymous || reply.isMine
                  ? null
                  : () async {
                      if (reply.writerId != null) {
                        final error = await ref
                            .read(friendManagementProvider.notifier)
                            .sendRequest(reply.writerId.toString());
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                error ?? '친구 요청을 보냈습니다',
                              ),
                              backgroundColor:
                                  error == null ? AppColors.success : AppColors.error,
                            ),
                          );
                        }
                      }
                    },
              onStartChat: reply.isMine
                  ? null
                  : () async {
                      if (reply.writerId != null) {
                        final room = await ref
                            .read(chatListProvider.notifier)
                            .createOneToOneRoom(reply.writerId!, roomName: reply.isWriterAnonymous ? '익명' : null);
                        if (room != null && mounted) {
                          GoRouter.of(context).push(
                            '${Routes.chat}/${room.id}',
                            extra: room.name,
                          );
                        }
                      }
                    },
            ),
          );
        }
      }
    }
    return list;
  }

  /// 게시글 작성자 아바타 - 익명은 DiceBear, 일반은 이니셜
  Widget _buildPostAuthorAvatar(PostEntity post) {
    if (post.isWriterAnonymous || _isAnonymousBoard()) {
      // 익명 유저: DiceBear 아바타 (게시글 ID를 seed로 사용)
      final avatar = DiceBearBuilder(
        seed: 'post-anon-${post.id}',
        sprite: DiceBearSprite.funEmoji,
      ).build();

      return ClipOval(
        child: SizedBox(
          width: 48,
          height: 48,
          child: avatar.toImage(),
        ),
      );
    }

    // 일반 유저: 이니셜 아바타
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.12),
            AppColors.primary.withValues(alpha: 0.06),
          ],
        ),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          post.writerNickname.isNotEmpty
              ? post.writerNickname[0].toUpperCase()
              : '?',
          style: AppTypography.headline5.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildPostHeader(BuildContext context, PostEntity post) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPostAuthorAvatar(post),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (post.isWriterAnonymous || _isAnonymousBoard()) ? l10n.anonymous : post.writerNickname,
                style: AppTypography.body1.copyWith(
                  fontWeight: FontWeight.w700,
                  color: context.textPrimaryColor,
                  letterSpacing: -0.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      l10n.student,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    timeAgo(post.createdAt),
                    style: AppTypography.caption.copyWith(
                      color: context.textTertiaryColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (post.isMine)
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_horiz_rounded,
              color: context.textSecondaryColor,
              size: 22,
            ),
            offset: const Offset(0, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onSelected: (value) {
              if (value == 'edit') {
                _showEditPostDialog(post);
              } else if (value == 'delete') {
                _showDeletePostDialog(post.id);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'edit', child: Text(l10n.edit)),
              PopupMenuItem(
                value: 'delete',
                child: Text(
                  l10n.delete,
                  style: const TextStyle(color: AppColors.error),
                ),
              ),
            ],
          )
        else
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_horiz_rounded,
              color: context.textSecondaryColor,
              size: 22,
            ),
            offset: const Offset(0, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onSelected: (value) async {
              if (value == 'report') {
                await showReportDialog(
                  context: context,
                  targetType: ReportTargetType.post,
                  targetId: post.id,
                );
              } else if (value == 'add_friend') {
                if (post.writerId != null) {
                  final error = await ref
                      .read(friendManagementProvider.notifier)
                      .sendRequest(post.writerId.toString());
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          error ?? '친구 요청을 보냈습니다',
                        ),
                        backgroundColor:
                            error == null ? AppColors.success : AppColors.error,
                      ),
                    );
                  }
                }
              } else if (value == 'start_chat') {
                if (post.writerId != null) {
                  final room = await ref
                      .read(chatListProvider.notifier)
                      .createOneToOneRoom(
                        post.writerId!,
                        roomName: post.isWriterAnonymous ? '익명' : null,
                      );
                  if (room != null && mounted) {
                    GoRouter.of(context).push(
                      '${Routes.chat}/${room.id}',
                      extra: room.name,
                    );
                  }
                }
              }
            },
            itemBuilder: (context) => [
              if (!post.isWriterAnonymous)
                const PopupMenuItem(
                  value: 'add_friend',
                  child: Row(
                    children: [
                      Icon(Icons.person_add_outlined, size: 20),
                      SizedBox(width: 8),
                      Text('친구 추가'),
                    ],
                  ),
                ),
              if (_writerAllowChat)
                const PopupMenuItem(
                  value: 'start_chat',
                  child: Row(
                    children: [
                      Icon(Icons.chat_bubble_outline, size: 20),
                      SizedBox(width: 8),
                      Text('채팅하기'),
                    ],
                  ),
                ),
              PopupMenuItem(
                value: 'report',
                child: Text(
                  l10n.report,
                  style: const TextStyle(color: AppColors.error),
                ),
              ),
            ],
          ),
      ],
    );
  }

  void _showEditPostDialog(PostEntity post) {
    final titleController = TextEditingController(text: post.title);
    final contentController = TextEditingController(text: post.content);
    final l10n = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.editPost),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: l10n.title),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: l10n.content),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
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
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }

  void _showDeletePostDialog(int postId) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deletePost),
        content: Text(l10n.confirmDeletePost),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              ref.read(postDetailProvider(postId).notifier).deletePost();
              Navigator.pop(context); // Pop dialog
              GoRouter.of(context).pop(); // Pop screen
            },
            child: Text(
              l10n.deletePost,
              style: const TextStyle(color: AppColors.error),
            ),
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
    final l10n = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.editComment),
        content: TextField(
          controller: contentController,
          decoration: InputDecoration(labelText: l10n.content),
          maxLines: 2,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              notifier.updateComment(comment.id, contentController.text);
              Navigator.pop(context);
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }

  void _showDeleteCommentDialog(int commentId, PostDetailNotifier notifier) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteComment),
        content: Text(l10n.confirmDeleteComment),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              notifier.deleteComment(commentId);
              Navigator.pop(context);
            },
            child: Text(
              l10n.deleteComment,
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea(BuildContext context, int postId) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        border: Border(
          top: BorderSide(
            color: context.dividerColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            offset: const Offset(0, -4),
            blurRadius: 12,
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => setState(() => _isAnonymous = !_isAnonymous),
              behavior: HitTestBehavior.opaque,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _isAnonymous
                            ? AppColors.primary
                            : context.borderColor,
                        width: 2,
                      ),
                      color: _isAnonymous
                          ? AppColors.primary
                          : Colors.transparent,
                    ),
                    child: _isAnonymous
                        ? const Icon(
                            Icons.check,
                            size: 12,
                            color: AppColors.textOnPrimary,
                          )
                        : null,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n.postAnonymously,
                    style: AppTypography.body2.copyWith(
                      color: _isAnonymous
                          ? context.textPrimaryColor
                          : context.textSecondaryColor,
                      fontWeight: _isAnonymous
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Semantics(
                    identifier: 'board_detail_comment_input',
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: context.surfaceVariantColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: context.borderColor.withValues(alpha: 0.5),
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: _commentController,
                        focusNode: _commentFocusNode,
                        maxLines: null,
                        style: AppTypography.body2,
                        decoration: InputDecoration(
                          hintText: l10n.writeComment,
                          hintStyle: AppTypography.body2.copyWith(
                            color: context.textTertiaryColor,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          filled: false,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Semantics(
                  identifier: 'board_detail_comment_send',
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.primary, AppColors.primaryDark],
                      ),
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          offset: const Offset(0, 2),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(22),
                        onTap: () {
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
                        child: const Center(
                          child: Icon(
                            Icons.send_rounded,
                            color: AppColors.textOnPrimary,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
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

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;
  final bool isActive;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? context.textSecondaryColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: effectiveColor),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTypography.body2.copyWith(
                color: effectiveColor,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommentItem extends StatelessWidget {
  final CommentEntity comment;
  final bool isReply;
  final String? parentNickname; // 대댓글인 경우 부모 댓글 닉네임
  final VoidCallback? onReply;
  final VoidCallback? onLike;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onReport;
  final VoidCallback? onAddFriend;
  final VoidCallback? onStartChat;

  const _CommentItem({
    required this.comment,
    this.isReply = false,
    this.parentNickname,
    this.onReply,
    this.onLike,
    this.onEdit,
    this.onDelete,
    this.onReport,
    this.onAddFriend,
    this.onStartChat,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAvatar(),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: context.surfaceVariantColor.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: context.borderColor.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    comment.isWriterAnonymous
                                        ? l10n.anonymous
                                        : comment.writerNickname,
                                    style: AppTypography.body2.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: context.textPrimaryColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // 대댓글인 경우 부모 댓글 멘션 표시
                                if (isReply && parentNickname != null) ...[
                                  const SizedBox(width: 6),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 12,
                                    color: context.textTertiaryColor,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '@$parentNickname',
                                    style: AppTypography.caption.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          _CommentMenu(
                            isMine: comment.isMine,
                            isWriterAnonymous: comment.isWriterAnonymous,
                            onEdit: onEdit,
                            onDelete: onDelete,
                            onReport: onReport,
                            onAddFriend: onAddFriend,
                            onStartChat: onStartChat,
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        comment.content,
                        style: AppTypography.body2.copyWith(
                          color: context.textPrimaryColor,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                _CommentStatsRow(
                  comment: comment,
                  isReply: isReply,
                  onLike: onLike,
                  onReply: onReply,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 아바타 위젯 생성 - 익명 유저는 DiceBear, 일반 유저는 이니셜
  Widget _buildAvatar() {
    if (comment.isWriterAnonymous) {
      // 익명 유저: DiceBear 아바타 사용 (댓글 ID를 seed로 사용하여 일관성 유지)
      final avatar = DiceBearBuilder(
        seed: 'anon-${comment.id}',
        sprite: DiceBearSprite.funEmoji,
      ).build();

      return ClipOval(
        child: SizedBox(
          width: 36,
          height: 36,
          child: avatar.toImage(),
        ),
      );
    }

    // 일반 유저: 이니셜 아바타
    return Builder(
      builder: (context) => Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              context.surfaceVariantColor,
              context.surfaceVariantColor.withValues(alpha: 0.6),
            ],
          ),
          shape: BoxShape.circle,
          border: Border.all(
            color: context.borderColor.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            comment.writerNickname.isNotEmpty
                ? comment.writerNickname[0].toUpperCase()
                : '?',
            style: AppTypography.body2.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: context.textSecondaryColor,
            ),
          ),
        ),
      ),
    );
  }
}

class _CommentMenu extends StatelessWidget {
  final bool isMine;
  final bool isWriterAnonymous;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onReport;
  final VoidCallback? onAddFriend;
  final VoidCallback? onStartChat;

  const _CommentMenu({
    required this.isMine,
    this.isWriterAnonymous = false,
    this.onEdit,
    this.onDelete,
    this.onReport,
    this.onAddFriend,
    this.onStartChat,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_horiz_rounded,
        size: 18,
        color: context.textTertiaryColor,
      ),
      padding: EdgeInsets.zero,
      offset: const Offset(0, 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (value) {
        if (value == 'edit') {
          onEdit?.call();
        } else if (value == 'delete') {
          onDelete?.call();
        } else if (value == 'report') {
          onReport?.call();
        } else if (value == 'add_friend') {
          onAddFriend?.call();
        } else if (value == 'start_chat') {
          onStartChat?.call();
        }
      },
      itemBuilder: (context) => isMine
          ? [
              PopupMenuItem(value: 'edit', child: Text(l10n.editComment)),
              PopupMenuItem(
                value: 'delete',
                child: Text(
                  l10n.deleteComment,
                  style: const TextStyle(color: AppColors.error),
                ),
              ),
            ]
          : [
              if (!isWriterAnonymous)
                const PopupMenuItem(
                  value: 'add_friend',
                  child: Row(
                    children: [
                      Icon(Icons.person_add_outlined, size: 20),
                      SizedBox(width: 8),
                      Text('친구 추가'),
                    ],
                  ),
                ),
              const PopupMenuItem(
                value: 'start_chat',
                child: Row(
                  children: [
                    Icon(Icons.chat_bubble_outline, size: 20),
                    SizedBox(width: 8),
                    Text('채팅하기'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'report',
                child: Text(
                  l10n.report,
                  style: const TextStyle(color: AppColors.error),
                ),
              ),
            ],
    );
  }
}

class _CommentStatsRow extends StatelessWidget {
  final CommentEntity comment;
  final bool isReply;
  final VoidCallback? onLike;
  final VoidCallback? onReply;

  const _CommentStatsRow({
    required this.comment,
    required this.isReply,
    this.onLike,
    this.onReply,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Row(
        children: [
          Text(
            timeAgo(comment.createdAt),
            style: AppTypography.caption.copyWith(
              color: context.textTertiaryColor,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 16),
          InkWell(
            onTap: onLike,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Row(
                children: [
                  Icon(
                    comment.isLiked
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    size: 15,
                    color: comment.isLiked
                        ? AppColors.primary
                        : context.textTertiaryColor,
                  ),
                  if (comment.likeCount > 0) ...[
                    const SizedBox(width: 4),
                    Text(
                      '${comment.likeCount}',
                      style: AppTypography.caption.copyWith(
                        fontWeight: FontWeight.w600,
                        color: comment.isLiked
                            ? AppColors.primary
                            : context.textTertiaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (!isReply) ...[
            const SizedBox(width: 12),
            InkWell(
              onTap: onReply,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: Row(
                  children: [
                    Icon(
                      Icons.reply_rounded,
                      size: 15,
                      color: context.textTertiaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      l10n.reply,
                      style: AppTypography.caption.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.textTertiaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
