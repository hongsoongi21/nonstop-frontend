import 'package:flutter/material.dart';
import 'package:nonstop/shared/components/glass_container.dart';

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
    return GlassContainer(
      width: double.infinity,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      onTap: onTap,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Author Info & Time
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                child: Text(
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
                      'Student', // Fallback as university/major might not be in PostDto.Response directly
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
          ),

          SizedBox(height: AppSpacing.md),

          // Title
          Text(
            post.title,
            style: AppTypography.headline6.copyWith(
              fontWeight: FontWeight.w700,
              height: 1.3,
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
              onTap: onTap, // Allow tapping "Read more" to open details
              child: Text(
                'Read more...',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textHint,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],

          SizedBox(height: AppSpacing.lg),

          // Footer Stats (Comments, Likes, Views)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Comments
              _StatItem(
                icon: Icons.chat_bubble_outline,
                count: post.commentCount,
                color: AppColors.textSecondary,
                onTap: onComment,
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

              // Views
              _StatItem(
                icon: Icons.bar_chart,
                count: post.viewCount.toInt(),
                color: AppColors.textSecondary,
              ),
            ],
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
