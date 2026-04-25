import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/popular_board_item.dart';

class PopularContentSection extends StatelessWidget {
  final List<PopularBoardItem> popularBoards;

  const PopularContentSection({super.key, required this.popularBoards});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 섹션 헤더
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.homePopularTitle,
                style: AppTypography.headline5.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () => context.go(Routes.board),
                child: Text(l10n.homePopularMore),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          // 본문
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (popularBoards.isEmpty) {
      return Card(
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Center(
            child: Text(
              l10n.homePopularEmpty,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
        ),
      );
    }

    final items = popularBoards.take(5).toList();

    return Card(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final board = items[index];
          final isLast = index == items.length - 1;
          return Column(
            children: [
              _PopularBoardRow(board: board),
              if (!isLast)
                const Divider(
                  height: 1,
                  thickness: 0.5,
                  indent: AppSpacing.md,
                  endIndent: AppSpacing.md,
                  color: AppColors.divider,
                ),
            ],
          );
        }),
      ),
    );
  }
}

class _PopularBoardRow extends StatelessWidget {
  final PopularBoardItem board;

  const _PopularBoardRow({required this.board});

  @override
  Widget build(BuildContext context) {
    final topPost = board.topPost;

    final row = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 게시판 명 뱃지
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xxs,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary50,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Text(
              board.boardName,
              style: AppTypography.caption.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          // 게시글 정보
          Expanded(
            child: topPost == null
                ? Text(
                    AppLocalizations.of(context)!.homePopularBoardNoPost,
                    style: AppTypography.body2.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        topPost.title ?? '(제목 없음)',
                        style: AppTypography.body2.copyWith(
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '💬${topPost.commentCount} · ❤️${topPost.likeCount}',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );

    if (topPost == null) return row;

    return InkWell(
      onTap: () => GoRouter.of(context).push(
        Routes.boardDetailPath(topPost.id.toString()),
      ),
      child: row,
    );
  }
}
