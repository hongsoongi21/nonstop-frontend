import 'package:flutter/material.dart';
import 'package:nonstop/shared/components/glass_container.dart';

import '../../core/mock/mock_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// Post card component for displaying board posts
class PostCard extends StatelessWidget {
  final Post post;
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
          // Header with category and timestamp
          Row(
            children: [
              // Category badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Color(post.categoryColor).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                ),
                child: Text(
                  post.categoryName,
                  style: AppTypography.caption.copyWith(
                    color: Color(post.categoryColor),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const Spacer(),

              // Timestamp
              Text(
                post.timeAgo,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),

          SizedBox(height: AppSpacing.sm),

          // Title
          Text(
            post.title,
            style: AppTypography.body1.copyWith(
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: AppSpacing.sm),

          // Content preview
          Text(
            post.content,
            style: AppTypography.body2.copyWith(
              color: AppColors.textSecondary,
              height: 1.4,
            ),
            maxLines: showFullContent ? null : 3,
            overflow: showFullContent ? null : TextOverflow.ellipsis,
          ),

          if (!showFullContent && post.content.length > 100) ...[
            SizedBox(height: AppSpacing.xs),
            Text(
              'Read more...',
              style: AppTypography.caption.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],

          SizedBox(height: AppSpacing.md),

          // Author info
          Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 16,
                backgroundImage: post.authorAvatar != null
                    ? NetworkImage(post.authorAvatar!)
                    : null,
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                child: post.authorAvatar == null
                    ? Text(
                        post.author.isNotEmpty ? post.author[0].toUpperCase() : '?',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : null,
              ),

              SizedBox(width: AppSpacing.sm),

              // Author name
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.author,
                      style: AppTypography.body2.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (post.isAnonymous) ...[
                      SizedBox(height: 2),
                      Text(
                        'Anonymous',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textHint,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: AppSpacing.md),

          // Tags
          if (post.tags.isNotEmpty) ...[
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: post.tags.map((tag) => Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm + 2,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    width: 1,
                  ),
                ),
                child: Text(
                  '#$tag',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primary.withOpacity(0.8),
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
              )).toList(),
            ),
            SizedBox(height: AppSpacing.md),
          ],

          // Actions
          Row(
            children: [
              // Like button
              _ActionButton(
                icon: Icons.favorite_border,
                label: '${post.likes}',
                onTap: onLike,
                color: post.likes > 0 ? AppColors.error : AppColors.textSecondary,
              ),

              SizedBox(width: AppSpacing.lg),

              // Comment button
              _ActionButton(
                icon: Icons.chat_bubble_outline,
                label: '${post.comments}',
                onTap: onComment,
                color: AppColors.textSecondary,
              ),

              const Spacer(),

              // Share button
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.share_outlined,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Compact post card for list views
class PostListCard extends StatelessWidget {
  final Post post;
  final VoidCallback? onTap;

  const PostListCard({
    super.key,
    required this.post,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: AppSpacing.sm),
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      onTap: onTap,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category indicator
          Container(
            width: 4,
            height: 60,
            decoration: BoxDecoration(
              color: Color(post.categoryColor),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          SizedBox(width: AppSpacing.md),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and category
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        post.title,
                        style: AppTypography.body2.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: AppSpacing.sm),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.xs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Color(post.categoryColor).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                      ),
                      child: Text(
                        post.categoryName,
                        style: AppTypography.caption.copyWith(
                          color: Color(post.categoryColor),
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: AppSpacing.xs),

                // Content preview
                Text(
                  post.content,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: AppSpacing.sm),

                // Stats
                Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      size: 14,
                      color: AppColors.error,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '${post.likes}',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(width: AppSpacing.md),
                    Icon(
                      Icons.chat_bubble,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '${post.comments}',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      post.timeAgo,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textHint,
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

/// Action button for post interactions
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color? color;

  const _ActionButton({
    required this.icon,
    required this.label,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 4,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: color ?? AppColors.textSecondary,
            ),
            SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: AppTypography.caption.copyWith(
                color: color ?? AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
