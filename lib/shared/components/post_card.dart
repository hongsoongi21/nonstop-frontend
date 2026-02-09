import 'package:dice_bear/dice_bear.dart';
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
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final surfaceColor = isDarkMode ? AppColors.surfaceDark : AppColors.surface;
    final borderColor = isDarkMode ? AppColors.borderDark : AppColors.border;
    final shadowColor = isDarkMode ? Colors.black26 : AppColors.shadow;
    final shadowMediumColor = isDarkMode ? Colors.black38 : AppColors.shadowMedium;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(
          color: borderColor,
          width: AppSpacing.borderWidth,
        ),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: shadowMediumColor,
            blurRadius: 16,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          _buildCategoryChip(context),
          _buildContent(context),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textPrimaryColor = isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final textSecondaryColor = isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final textHintColor = isDarkMode ? AppColors.textTertiaryDark : AppColors.textHint;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar
        _buildAvatar(),

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
                        color: textPrimaryColor,
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
                      color: textHintColor,
                    ),
                  ),
                  SizedBox(width: AppSpacing.sm),
                  Text(
                    timeAgo(post.createdAt),
                    style: AppTypography.caption.copyWith(
                      color: textHintColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2),
              Text(
                'Student', // Fallback text
                style: AppTypography.caption.copyWith(
                  color: textSecondaryColor,
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
            color: textSecondaryColor,
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }

  /// 아바타 위젯 - 익명은 DiceBear, 일반은 이니셜
  Widget _buildAvatar() {
    if (post.isWriterAnonymous) {
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
    return CircleAvatar(
      radius: 24,
      backgroundColor: AppColors.primary.withAlpha(20),
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
    );
  }

  Widget _buildCategoryChip(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDarkMode ? AppColors.primaryLight : AppColors.primary;

    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.md),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor.withValues(alpha: 0.12),
            AppColors.tertiary.withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.3),
          width: AppSpacing.borderWidth,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.tertiary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            'General', // Fallback category
            style: AppTypography.caption.copyWith(
              color: primaryColor,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textPrimaryColor = isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final textSecondaryColor = isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final textHintColor = isDarkMode ? AppColors.textTertiaryDark : AppColors.textHint;

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            post.title,
            style: AppTypography.headline6.copyWith(
              color: textPrimaryColor,
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
              color: textSecondaryColor,
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
                  color: textHintColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final surfaceVariantColor = isDarkMode ? AppColors.surfaceVariantDark : AppColors.surfaceVariant;
    final borderColor = isDarkMode ? AppColors.borderDark : AppColors.border;
    final textSecondaryColor = isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.lg),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: surfaceVariantColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
          color: borderColor.withValues(alpha: 0.5),
          width: AppSpacing.borderWidthThin,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Views
          _StatItem(
            icon: Icons.remove_red_eye_outlined,
            count: post.viewCount.toInt(),
            color: textSecondaryColor,
          ),

          SizedBox(width: AppSpacing.xl),

          // Likes
          _StatItem(
            icon: post.isLiked ? Icons.favorite : Icons.favorite_border,
            count: post.likeCount,
            color: post.isLiked ? AppColors.accent : textSecondaryColor,
            onTap: onLike,
          ),

          SizedBox(width: AppSpacing.xl),

          // Comments
          _StatItem(
            icon: Icons.chat_bubble_outline,
            count: post.commentCount,
            color: textSecondaryColor,
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textSecondaryColor = isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      splashColor: AppColors.ripple,
      highlightColor: AppColors.ripple.withValues(alpha: 0.5),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: AppSpacing.sm),
            Text(
              '$count',
              style: AppTypography.caption.copyWith(
                color: textSecondaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
