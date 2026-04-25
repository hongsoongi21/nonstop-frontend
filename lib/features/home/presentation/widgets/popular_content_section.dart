import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/popular_board_item.dart';

/// Renders the "popular boards" section. Uses a `Table` so the badge
/// column auto-sizes to the longest board name in this batch
/// (`IntrinsicColumnWidth`) — body text columns line up across all rows
/// regardless of locale or label length, with no hard-coded widths.
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
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: Table(
        columnWidths: const {
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          for (int i = 0; i < items.length; i++)
            _buildRow(
              context,
              items[i],
              isLast: i == items.length - 1,
            ),
        ],
      ),
    );
  }

  TableRow _buildRow(
    BuildContext context,
    PopularBoardItem board, {
    required bool isLast,
  }) {
    final topPost = board.topPost;
    final l10n = AppLocalizations.of(context)!;

    final divider = isLast
        ? const Border()
        : const Border(
            bottom: BorderSide(color: AppColors.divider, width: 0.5),
          );

    // Badge cell — wrapped in a Container so the divider line spans the
    // full row width (badge + body cells share the same bottom border).
    final badgeCell = _Cell(
      onTap: topPost == null
          ? null
          : () => GoRouter.of(context).push(
                Routes.boardDetailPath(topPost.id.toString()),
              ),
      border: divider,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.xs,
        AppSpacing.sm,
      ),
      child: Container(
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
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.caption.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );

    final bodyCell = _Cell(
      onTap: topPost == null
          ? null
          : () => GoRouter.of(context).push(
                Routes.boardDetailPath(topPost.id.toString()),
              ),
      border: divider,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xs,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: topPost == null
          ? Text(
              l10n.homePopularBoardNoPost,
              style: AppTypography.body2.copyWith(
                color: AppColors.textTertiary,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  topPost.title ?? '(제목 없음)',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.body2.copyWith(
                    color: AppColors.textPrimary,
                  ),
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
    );

    return TableRow(children: [badgeCell, bodyCell]);
  }
}

/// Single table cell with optional row-spanning ripple
/// (`TableRowInkWell` makes taps register across the entire `TableRow`,
/// not just one cell, so badge + body act as a single hit target).
class _Cell extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Border border;
  final VoidCallback? onTap;

  const _Cell({
    required this.child,
    required this.padding,
    required this.border,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Container(
      decoration: BoxDecoration(border: border),
      child: Padding(padding: padding, child: child),
    );
    if (onTap == null) return content;
    return TableRowInkWell(onTap: onTap, child: content);
  }
}
