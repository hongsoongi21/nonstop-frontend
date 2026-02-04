import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_states.dart';
import 'package:nonstop/core/l10n/app_localizations.dart';
import '../../../../core/widgets/app_loading_skeleton.dart';
import '../../../../shared/components/glass_container.dart';
import '../../../../shared/components/main_scaffold.dart';
import '../../../../shared/components/post_card_compact.dart';
import '../../../../shared/components/report_dialog.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../notification/presentation/providers/notification_provider.dart';
import '../providers/board_provider.dart';
import '../../domain/entities/community.entity.dart';
import '../../domain/entities/post.entity.dart';

class BoardScreen extends ConsumerStatefulWidget {
  const BoardScreen({super.key});

  @override
  ConsumerState<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends ConsumerState<BoardScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen for needsRefresh flag and trigger refresh
    ref.listen<BoardState>(boardProvider, (previous, next) {
      if (next.needsRefresh && !next.isLoading) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(boardProvider.notifier).refreshIfNeeded();
        });
      }
    });
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final boardState = ref.watch(boardProvider);
    final posts = boardState.posts;
    final isLoading = boardState.isLoading;
    final error = boardState.error;
    final communities = boardState.communities;
    final selectedCommunity = boardState.selectedCommunity;
    final boards = boardState.boards;
    final selectedBoard = boardState.selectedBoard;
    final unreadCount = ref.watch(unreadNotificationCountProvider);

    return AppScaffold(
      title: l10n.board,
      showAppBar: false,
      backgroundColor: AppColors.surface,
      padding: EdgeInsets.zero,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                final currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                  currentFocus.unfocus();
                }
              },
              child: SafeArea(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header & Community Selector
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      AppSpacing.md,
                      AppSpacing.lg,
                      AppSpacing.sm,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.board,
                                style: AppTypography.headline4.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: isDark ? Colors.white : AppColors.textPrimary,
                                  letterSpacing: -0.5,
                                  height: 1.1,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              if (communities.isNotEmpty)
                                GestureDetector(
                                  onTap: () => _showCommunityPicker(
                                    context,
                                    communities,
                                    selectedCommunity,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(alpha: 0.08),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: AppColors.primary.withValues(alpha: 0.15),
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 6,
                                          height: 6,
                                          decoration: const BoxDecoration(
                                            color: AppColors.primary,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Flexible(
                                          child: Text(
                                            selectedCommunity?.name ??
                                                l10n.selectCommunity,
                                            style: AppTypography.body2.copyWith(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: AppColors.primary,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Row(
                          children: [
                            // Notification Icon
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.surface.withValues(alpha: 0.3),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.textSecondary.withValues(alpha: 0.1),
                                  width: 1,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  IconButton(
                                    onPressed: () =>
                                        context.push(Routes.notifications),
                                    icon: Icon(
                                      Icons.notifications_outlined,
                                      color: isDark ? Colors.white : AppColors.textPrimary,
                                      size: 22,
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    constraints: const BoxConstraints(
                                      minWidth: 44,
                                      minHeight: 44,
                                    ),
                                  ),
                                  if (unreadCount > 0)
                                    Positioned(
                                      right: 6,
                                      top: 6,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.error,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: AppColors.background,
                                            width: 2,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.error.withValues(alpha: 0.4),
                                              blurRadius: 6,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        constraints: const BoxConstraints(
                                          minWidth: 18,
                                          minHeight: 18,
                                        ),
                                        child: Text(
                                          unreadCount > 99
                                              ? '99+'
                                              : unreadCount.toString(),
                                          style: const TextStyle(
                                            color: AppColors.textOnPrimary,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            height: 1.2,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Write Button
                            GestureDetector(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                if (selectedBoard != null) {
                                  context.go(Routes.boardCreatePath());
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(l10n.pleaseSelectBoardFirst),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withValues(alpha: 0.3),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.edit_rounded,
                                      size: 18,
                                      color: AppColors.textOnPrimary,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      l10n.write,
                                      style: AppTypography.button.copyWith(
                                        color: AppColors.textOnPrimary,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Boards (Chips)
                  if (boards.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(
                        top: AppSpacing.xs,
                        bottom: AppSpacing.sm,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                        ),
                        child: Row(
                          children: boards.asMap().entries.map((entry) {
                            final board = entry.value;
                            final isSelected = board.id == selectedBoard?.id;
                            final isFirst = entry.key == 0;

                            return Padding(
                              padding: EdgeInsets.only(
                                right: AppSpacing.sm,
                                left: isFirst ? 0 : 0,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  HapticFeedback.selectionClick();
                                  ref.read(boardProvider.notifier).selectBoard(board);
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeOutCubic,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.surface.withValues(alpha: 0.4),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primary
                                          : AppColors.textSecondary.withValues(alpha: 0.1),
                                      width: isSelected ? 1.5 : 1,
                                    ),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: AppColors.primary.withValues(alpha: 0.25),
                                              blurRadius: 12,
                                              offset: const Offset(0, 4),
                                            ),
                                            BoxShadow(
                                              color: AppColors.primary.withValues(alpha: 0.1),
                                              blurRadius: 24,
                                              offset: const Offset(0, 8),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Text(
                                    board.name,
                                    style: AppTypography.button.copyWith(
                                      color: isSelected
                                          ? AppColors.textOnPrimary
                                          : AppColors.textSecondary,
                                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                                      fontSize: 14,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.sm,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: AppColors.textSecondary.withValues(alpha: 0.08),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        autofocus: false,
                        style: AppTypography.body1.copyWith(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        decoration: InputDecoration(
                          hintText: l10n.searchPosts,
                          hintStyle: AppTypography.body2.copyWith(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Icon(
                              Icons.search_rounded,
                              color: Colors.white.withValues(alpha: 0.5),
                              size: 22,
                            ),
                          ),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: 50,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          isDense: true,
                        ),
                        onChanged: (value) {
                          // Search functionality not yet implemented
                        },
                      ),
                    ),
                  ),

                  // Error Message
                  if (error != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      child: GlassContainer(
                        color: AppColors.error.withValues(alpha: 0.1),
                        borderColor: AppColors.error.withValues(alpha: 0.3),
                        child: Row(
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: AppColors.error,
                              size: 20,
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                error,
                                style: AppTypography.body2.copyWith(
                                  color: AppColors.error,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  ref.read(boardProvider.notifier).clearError(),
                              icon: Icon(
                                Icons.close,
                                color: AppColors.error,
                                size: 20,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Posts List
                  Expanded(
                    child: AppRefreshIndicator(
                      onRefresh: () =>
                          ref.read(boardProvider.notifier).refreshPosts(),
                      child: isLoading && posts.isEmpty
                          ? ListView.builder(
                              padding: const EdgeInsets.only(
                                left: AppSpacing.lg,
                                right: AppSpacing.lg,
                                top: AppSpacing.md,
                                bottom: 100,
                              ),
                              itemCount: 5,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppSpacing.lg,
                                ),
                                child: SkeletonLayouts.post(),
                              ),
                            )
                          : posts.isEmpty
                              ? _buildEmptyState(context, selectedBoard?.name ?? l10n.board)
                              : ListView.separated(
                                  padding: const EdgeInsets.only(
                                    left: AppSpacing.md,
                                    right: AppSpacing.md,
                                    top: AppSpacing.sm,
                                    bottom: 100,
                                  ),
                                  itemCount: posts.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: AppSpacing.xs),
                                  itemBuilder: (context, index) {
                                    final post = posts[index];
                                    return PostCardCompact(
                                      post: post,
                                      onTap: () => context.go(
                                        Routes.boardDetailPath(
                                          post.id.toString(),
                                        ),
                                      ),
                                      onMenuTap: () => _showPostMenu(context, post),
                                    );
                                  },
                                ),
                    ),
                  ),
                ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCommunityPicker(
    BuildContext context,
    List<Community> communities,
    Community? selectedCommunity,
  ) {
    final user = ref.read(currentUserProvider);
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              l10n.selectCommunity,
              style: AppTypography.headline6.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
                color: isDark ? Colors.white : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            ...communities.map((c) {
              final isLocked = c.universityRequired && user?.university == null;
              final isSelected = c.id == selectedCommunity?.id;

              return Container(
                margin: const EdgeInsets.only(bottom: AppSpacing.xs),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.08)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary.withValues(alpha: 0.2)
                        : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  leading: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textSecondary.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          c.name,
                          style: AppTypography.body1.copyWith(
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                            color: isSelected
                                ? AppColors.primary
                                : (isDark ? Colors.white : AppColors.textPrimary),
                          ),
                        ),
                      ),
                      if (isLocked) ...[
                        const SizedBox(width: 8),
                        Icon(
                          Icons.lock_rounded,
                          size: 18,
                          color: AppColors.textSecondary.withValues(alpha: 0.6),
                        ),
                      ],
                    ],
                  ),
                  subtitle: isLocked
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            l10n.universityVerificationRequired,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.error,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : null,
                  onTap: () {
                    HapticFeedback.selectionClick();
                    if (isLocked) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            l10n.universityVerificationRequiredAccess,
                          ),
                          backgroundColor: AppColors.error,
                        ),
                      );
                      return;
                    }
                    ref.read(boardProvider.notifier).selectCommunity(c);
                    Navigator.pop(context);
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showPostMenu(BuildContext context, PostEntity post) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.flag_outlined, color: AppColors.error),
                title: Text(
                  l10n.report,
                  style: const TextStyle(color: AppColors.error),
                ),
                onTap: () {
                  Navigator.pop(context);
                  showReportDialog(
                    context: context,
                    targetType: ReportTargetType.post,
                    targetId: post.id,
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.block_outlined, color: AppColors.textSecondary),
                title: Text(
                  l10n.blockUser,
                  style: TextStyle(color: isDark ? Colors.white : AppColors.textPrimary),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implement block user
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Coming soon')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, String boardName) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            // Use solid color to prevent transition glitches
            color: isDark ? AppColors.surfaceDark : AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppColors.textSecondary.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.article_outlined,
                  size: 52,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                l10n.noPostsInBoard(boardName),
                style: AppTypography.headline6.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                l10n.beFirstToPost,
                style: AppTypography.body2.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 15,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton.icon(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  context.go(Routes.boardCreatePath());
                },
                icon: const Icon(Icons.add_rounded, size: 20),
                label: Text(l10n.createFirstPost),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textOnPrimary,
                  elevation: 0,
                  shadowColor: AppColors.primary.withValues(alpha: 0.3),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  textStyle: AppTypography.button.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
