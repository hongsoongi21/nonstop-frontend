import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../features/board/domain/entities/post.entity.dart';
import '../../core/utils/date_utils.dart';

/// Post card component for displaying board posts
class PostCard extends StatelessWidget {
  final PostEntity post;
  final VoidCallback? onTap;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final bool showFullContent;

  const PostCard({
    super.key,
    required this.post,
    this.onTap,
    this.onLike,
    this.onComment,
    this.showFullContent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(
            color: AppColors.border.withAlpha(100),
            width: 0.5,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildCategoryChip(),
          _buildContent(),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar
        CircleAvatar(
          radius: 24,
          backgroundColor: post.isWriterAnonymous 
              ? AppColors.border.withAlpha(50)
              : AppColors.primary.withAlpha(20),
          child: post.isWriterAnonymous
              ? Text(
                  'A',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                )
              : Text(
                  post.writerNickname.isNotEmpty
                      ? post.writerNickname[0].toUpperCase()
                      : '?',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
        ),

        SizedBox(width: AppSpacing.md),

        // Name & Details
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
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: AppSpacing.sm),
                  Text(
                    '•',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textHint,
                    ),
                  ),
                  SizedBox(width: AppSpacing.sm),
                  Text(
                    timeAgo(post.createdAt),
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textHint,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2),
              Text(
                'Student', // Fallback text
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        // Menu Icon
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.more_vert,
            size: 20,
            color: AppColors.textSecondary,
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }

  Widget _buildCategoryChip() {
    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.md),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(20),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Text(
        'General', // Fallback category
        style: AppTypography.caption.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            post.title,
            style: AppTypography.headline6.copyWith(
              fontWeight: FontWeight.w700,
              height: 1.3,
              fontSize: 18,
            ),
          ),

          SizedBox(height: AppSpacing.sm),

          // Content
          Text(
            post.content,
            style: AppTypography.body2.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
              fontSize: 15,
            ),
            maxLines: showFullContent ? null : 3,
            overflow: showFullContent ? null : TextOverflow.ellipsis,
          ),

          if (!showFullContent && post.content.length > 100) ...[
            SizedBox(height: AppSpacing.xs),
            GestureDetector(
              onTap: onTap,
              child: Text(
                'Read more...',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textHint,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Views
          _StatItem(
            icon: Icons.remove_red_eye,
            count: post.viewCount.toInt(),
            color: AppColors.textSecondary,
          ),

          SizedBox(width: AppSpacing.lg),

          // Likes
          _StatItem(
            icon: post.isLiked ? Icons.favorite : Icons.favorite_border,
            count: post.likeCount,
            color: post.isLiked ? AppColors.error : AppColors.textSecondary,
            onTap: onLike,
          ),

          SizedBox(width: AppSpacing.lg),

          // Comments
          _StatItem(
            icon: Icons.chat_bubble_outline,
            count: post.commentCount,
            color: AppColors.textSecondary,
            onTap: onComment,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final int count;
  final Color color;
  final VoidCallback? onTap;

  const _StatItem({
    required this.icon,
    required this.count,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color),
            SizedBox(width: 6),
            Text(
              '$count',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
