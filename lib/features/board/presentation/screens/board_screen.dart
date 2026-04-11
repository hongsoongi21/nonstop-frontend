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
import '../../../../shared/components/block_user_dialog.dart';
import '../../../../shared/components/report_dialog.dart';
import '../../../notification/presentation/providers/notification_provider.dart';
import '../providers/board_provider.dart';
import '../../domain/entities/community.entity.dart';
import '../../domain/entities/post.entity.dart';
import '../../domain/entities/board.entity.dart';
import '../../../../core/utils/date_utils.dart';
import '../widgets/board_display.dart';

/// Filter options for board posts
enum BoardFilter { latest, trending, mostCommented }

class BoardScreen extends ConsumerStatefulWidget {
  const BoardScreen({super.key});

  @override
  ConsumerState<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends ConsumerState<BoardScreen> {
  BoardFilter _selectedFilter = BoardFilter.latest;
  bool _showSearch = false;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  bool _isAnonymousBoard() {
    final boardState = ref.read(boardProvider);
    return boardState.selectedBoard?.type == BoardType.anonymous;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
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
    final l10n = AppLocalizations.of(context);
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

    // Sort posts based on filter
    final sortedPosts = _getSortedPosts(posts);
    final filteredPosts = _searchQuery.isEmpty
        ? sortedPosts
        : sortedPosts.where((post) {
            return post.title.toLowerCase().contains(_searchQuery) ||
                   post.content.toLowerCase().contains(_searchQuery);
          }).toList();

    return AppScaffold(
      title: l10n.board,
      showAppBar: false,
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      padding: EdgeInsets.zero,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          final currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            currentFocus.unfocus();
          }
          if (_showSearch) {
            setState(() {
              _showSearch = false;
              _searchQuery = '';
              _searchController.clear();
            });
          }
        },
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // === MINIMAL HEADER ===
                  _buildMinimalHeader(
                    context,
                    isDark: isDark,
                    unreadCount: unreadCount,
                    communities: communities,
                    selectedCommunity: selectedCommunity,
                    l10n: l10n,
                  ),

                  // === SEARCH BAR (Animated) ===
                  AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                    child: _showSearch
                        ? _buildSearchBar(context, isDark, l10n)
                        : const SizedBox.shrink(),
                  ),

                  // === BOARD CHIPS (smaller, subtle) ===
                  if (boards.isNotEmpty)
                    _buildBoardChips(context, boards, selectedBoard, isDark, l10n: l10n),

                  // === FILTER PILLS ===
                  _buildFilterPills(context, isDark, l10n),

                  // === ERROR MESSAGE ===
                  if (error != null) _buildErrorMessage(context, error),

                  // === POSTS LIST ===
                  Expanded(
                    child: AppRefreshIndicator(
                      onRefresh: () =>
                          ref.read(boardProvider.notifier).refreshPosts(),
                      child: isLoading && posts.isEmpty
                          ? _buildSkeletonList()
                          : filteredPosts.isEmpty
                              ? _buildEmptyState(context, selectedBoard?.displayName(l10n) ?? l10n.board)
                              : _buildPostsList(context, filteredPosts, isDark, l10n),
                    ),
                  ),
                ],
              ),
            ),

            // === FLOATING ACTION BUTTON ===
            Positioned(
              right: 24,
              bottom: 120,
              child: Semantics(
                identifier: 'board_fab',
                child: _buildFloatingWriteButton(context, selectedBoard, selectedCommunity, l10n),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PostEntity> _getSortedPosts(List<PostEntity> posts) {
    final sorted = List<PostEntity>.from(posts);
    switch (_selectedFilter) {
      case BoardFilter.latest:
        sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case BoardFilter.trending:
        // Trending = combination of likes and recency
        sorted.sort((a, b) {
          final aScore = a.likeCount + a.viewCount ~/ 10;
          final bScore = b.likeCount + b.viewCount ~/ 10;
          return bScore.compareTo(aScore);
        });
        break;
      case BoardFilter.mostCommented:
        sorted.sort((a, b) => b.commentCount.compareTo(a.commentCount));
        break;
    }
    return sorted;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // MINIMAL HEADER - Swiss Design
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildMinimalHeader(
    BuildContext context, {
    required bool isDark,
    required int unreadCount,
    required List<Community> communities,
    required Community? selectedCommunity,
    required AppLocalizations l10n,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, 16, 16, 8),
      child: Row(
        children: [
          // Community selector (compact)
          if (communities.isNotEmpty)
            Flexible(
              child: GestureDetector(
                onTap: () => _showCommunityPicker(
                  context,
                  communities,
                  selectedCommunity,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        (selectedCommunity?.isGlobal == true ? l10n.globalCommunity : selectedCommunity?.name) ?? l10n.selectCommunity,
                        style: AppTypography.headline3.copyWith(
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : AppColors.textPrimary,
                          letterSpacing: -0.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: isDark ? Colors.white54 : AppColors.textSecondary,
                      size: 24,
                    ),
                  ],
                ),
              ),
            )
          else
            Text(
              l10n.board,
              style: AppTypography.headline3.copyWith(
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : AppColors.textPrimary,
                letterSpacing: -0.5,
              ),
            ),

          const Spacer(),

          // Search icon
          _buildHeaderIcon(
            icon: Icons.search_rounded,
            isDark: isDark,
            onTap: () {
              HapticFeedback.lightImpact();
              setState(() => _showSearch = !_showSearch);
              if (_showSearch) {
                Future.delayed(const Duration(milliseconds: 100), () {
                  _searchFocusNode.requestFocus();
                });
              }
            },
          ),

          const SizedBox(width: 8),

          // Notification icon with badge
          Stack(
            children: [
              _buildHeaderIcon(
                icon: Icons.notifications_outlined,
                isDark: isDark,
                onTap: () {
                  HapticFeedback.lightImpact();
                  context.push(Routes.notifications);
                },
              ),
              if (unreadCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark ? AppColors.backgroundDark : AppColors.background,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon({
    required IconData icon,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.black.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isDark ? Colors.white70 : AppColors.textSecondary,
          size: 22,
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SEARCH BAR
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSearchBar(BuildContext context, bool isDark, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, 0, AppSpacing.md, 12),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.black.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: _searchController,
          focusNode: _searchFocusNode,
          style: AppTypography.body2.copyWith(
            color: isDark ? Colors.white : AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: l10n.searchPosts,
            hintStyle: AppTypography.body2.copyWith(
              color: isDark ? Colors.white38 : AppColors.textTertiary,
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: isDark ? Colors.white38 : AppColors.textTertiary,
              size: 20,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          onChanged: (value) {
            setState(() => _searchQuery = value.trim().toLowerCase());
          },
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // FILTER PILLS - Swiss Minimalism
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildFilterPills(BuildContext context, bool isDark, AppLocalizations l10n) {
    final filters = [
      (BoardFilter.latest, l10n.latest),
      (BoardFilter.trending, l10n.trending),
      (BoardFilter.mostCommented, l10n.mostCommented),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, 4, AppSpacing.md, 12),
      child: Row(
        children: filters.map((filter) {
          final isSelected = _selectedFilter == filter.$1;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _selectedFilter = filter.$1);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : (isDark
                          ? Colors.white.withValues(alpha: 0.06)
                          : Colors.black.withValues(alpha: 0.04)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  filter.$2,
                  style: AppTypography.buttonSmall.copyWith(
                    color: isSelected
                        ? Colors.white
                        : (isDark ? Colors.white70 : AppColors.textSecondary),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BOARD CHIPS - Subtle, secondary
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBoardChips(
    BuildContext context,
    List boards,
    dynamic selectedBoard,
    bool isDark, {
    required AppLocalizations l10n,
  }) {
    return Container(
      height: 36,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        itemCount: boards.length,
        itemBuilder: (context, index) {
          final board = boards[index];
          final isSelected = board.id == selectedBoard?.id;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                ref.read(boardProvider.notifier).selectBoard(board);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.12)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary.withValues(alpha: 0.3)
                        : (isDark
                            ? Colors.white.withValues(alpha: 0.1)
                            : Colors.black.withValues(alpha: 0.08)),
                    width: 1,
                  ),
                ),
                child: Text(
                  board.displayName(l10n),
                  style: AppTypography.caption.copyWith(
                    color: isSelected
                        ? AppColors.primary
                        : (isDark ? Colors.white60 : AppColors.textSecondary),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    letterSpacing: 0.1,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // POST CARD - Minimal, title-only
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildPostsList(
    BuildContext context,
    List<PostEntity> posts,
    bool isDark,
    AppLocalizations l10n,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, 0, AppSpacing.md, 120),
      itemCount: posts.length,
      separatorBuilder: (context, index) => Divider(
        color: isDark
            ? Colors.white.withValues(alpha: 0.06)
            : Colors.black.withValues(alpha: 0.06),
        height: 1,
      ),
      itemBuilder: (context, index) {
        final post = posts[index];
        return Semantics(
          identifier: 'board_post_$index',
          child: _buildMinimalPostCard(context, post, isDark, l10n),
        );
      },
    );
  }

  Widget _buildMinimalPostCard(
    BuildContext context,
    PostEntity post,
    bool isDark,
    AppLocalizations l10n,
  ) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        context.go(Routes.boardDetailPath(post.id.toString()));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title first
            Text(
              post.title,
              style: AppTypography.body1.copyWith(
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : AppColors.textPrimary,
                height: 1.4,
                letterSpacing: -0.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            // Content preview - one line
            Text(
              post.content,
              style: AppTypography.body2.copyWith(
                color: isDark ? Colors.white54 : AppColors.textSecondary,
                height: 1.4,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            // Bottom row: Time + stats + menu
            Row(
              children: [
                Text(
                  timeAgo(post.createdAt),
                  style: AppTypography.caption.copyWith(
                    color: isDark ? Colors.white38 : AppColors.textTertiary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 12),
                _buildSmallStat(
                  icon: Icons.remove_red_eye_outlined,
                  count: post.viewCount,
                  isDark: isDark,
                ),
                const SizedBox(width: 12),
                _buildSmallStat(
                  icon: Icons.favorite_border_rounded,
                  count: post.likeCount,
                  isDark: isDark,
                ),
                const SizedBox(width: 12),
                _buildSmallStat(
                  icon: Icons.chat_bubble_outline_rounded,
                  count: post.commentCount,
                  isDark: isDark,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => _showPostMenu(context, post),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.more_horiz,
                      size: 16,
                      color: isDark ? Colors.white30 : AppColors.textTertiary,
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

  Widget _buildSmallStat({
    required IconData icon,
    required int count,
    required bool isDark,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: isDark ? Colors.white30 : AppColors.textTertiary,
        ),
        const SizedBox(width: 4),
        Text(
          _formatCount(count),
          style: AppTypography.captionSmall.copyWith(
            color: isDark ? Colors.white38 : AppColors.textTertiary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // FLOATING WRITE BUTTON
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildFloatingWriteButton(
    BuildContext context,
    dynamic selectedBoard,
    Community? selectedCommunity,
    AppLocalizations l10n,
  ) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        _showWriteOptions(context, selectedBoard, selectedCommunity, l10n);
      },
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.35),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Icon(
          Icons.edit_rounded,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  void _showWriteOptions(BuildContext context, dynamic selectedBoard, Community? selectedCommunity, AppLocalizations l10n) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.cardBackgroundDark : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? Colors.white24 : Colors.black12,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              // Write Post option
              Semantics(
                identifier: 'board_write_post_option',
                child: _buildOptionTile(
                  context: context,
                  icon: Icons.edit_outlined,
                  title: 'Write Post',
                  subtitle: selectedBoard != null
                      ? l10n.postToBoard(selectedBoard.displayName(l10n))
                      : l10n.pleaseSelectBoardFirst,
                  enabled: selectedBoard != null,
                  onTap: () {
                    Navigator.pop(context);
                    if (selectedBoard != null) {
                      context.go(Routes.boardCreatePath());
                    }
                  },
                  isDark: isDark,
                ),
              ),
              // Create Board option - 대학교 커뮤니티일 때만 표시
              if (selectedCommunity != null && !selectedCommunity.isGlobal) ...[
                const SizedBox(height: AppSpacing.sm),
                _buildOptionTile(
                  context: context,
                  icon: Icons.dashboard_customize_outlined,
                  title: 'Create Board',
                  subtitle: 'Create a new discussion board',
                  enabled: true,
                  onTap: () {
                    Navigator.pop(context);
                    _showCreateBoardDialog(context);
                  },
                  isDark: isDark,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required bool enabled,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.black.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: enabled
                    ? AppColors.primary.withValues(alpha: 0.12)
                    : (isDark ? Colors.white12 : Colors.black12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: enabled
                    ? AppColors.primary
                    : (isDark ? Colors.white30 : AppColors.textTertiary),
                size: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.body1.copyWith(
                      fontWeight: FontWeight.w600,
                      color: enabled
                          ? (isDark ? Colors.white : AppColors.textPrimary)
                          : (isDark ? Colors.white30 : AppColors.textTertiary),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTypography.caption.copyWith(
                      color: enabled
                          ? (isDark ? Colors.white60 : AppColors.textSecondary)
                          : (isDark ? Colors.white30 : AppColors.textTertiary),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateBoardDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final l10n = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Create Board',
          style: AppTypography.headline5.copyWith(
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : AppColors.textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Board name field
            TextField(
              controller: nameController,
              autofocus: true,
              style: AppTypography.body1.copyWith(
                color: isDark ? Colors.white : AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                labelText: 'Board Name',
                labelStyle: AppTypography.body2.copyWith(
                  color: isDark ? Colors.white60 : AppColors.textSecondary,
                ),
                hintText: 'e.g., Study Group',
                hintStyle: AppTypography.body2.copyWith(
                  color: isDark ? Colors.white38 : AppColors.textTertiary,
                ),
                filled: true,
                fillColor: isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : Colors.black.withValues(alpha: 0.04),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(AppSpacing.md),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            // Board description field (optional)
            TextField(
              controller: descriptionController,
              style: AppTypography.body1.copyWith(
                color: isDark ? Colors.white : AppColors.textPrimary,
              ),
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description (Optional)',
                labelStyle: AppTypography.body2.copyWith(
                  color: isDark ? Colors.white60 : AppColors.textSecondary,
                ),
                hintText: 'Describe the purpose of this board',
                hintStyle: AppTypography.body2.copyWith(
                  color: isDark ? Colors.white38 : AppColors.textTertiary,
                ),
                filled: true,
                fillColor: isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : Colors.black.withValues(alpha: 0.04),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(AppSpacing.md),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              l10n.cancel,
              style: AppTypography.buttonSmall.copyWith(
                color: isDark ? Colors.white60 : AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              final name = nameController.text.trim();
              if (name.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppLocalizations.of(context)!.boardNameRequired),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return;
              }

              Navigator.pop(context);

              // Show loading indicator
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Creating board...'),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 1),
                ),
              );

              // Call the provider to create the board
              final result = await ref.read(boardProvider.notifier).createBoard(
                name: name,
                description: descriptionController.text.trim().isEmpty
                    ? null
                    : descriptionController.text.trim(),
              );

              result.fold(
                (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to create board: $error'),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: AppColors.error,
                    ),
                  );
                },
                (board) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.boardCreatedSuccess(board.name)),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: AppColors.success,
                    ),
                  );
                },
              );
            },
            child: Text(
              'Create',
              style: AppTypography.buttonSmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SKELETON LOADING
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildSkeletonList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, 0, AppSpacing.md, 120),
      itemCount: 6,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: SkeletonLayouts.post(),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // ERROR MESSAGE
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildErrorMessage(BuildContext context, String error) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 8),
      child: GlassContainer(
        color: AppColors.error.withValues(alpha: 0.1),
        borderColor: AppColors.error.withValues(alpha: 0.3),
        child: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: AppColors.error,
              size: 18,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                error,
                style: AppTypography.body2.copyWith(
                  color: AppColors.error,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => ref.read(boardProvider.notifier).clearError(),
              child: Icon(
                Icons.close,
                color: AppColors.error,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // COMMUNITY PICKER
  // ═══════════════════════════════════════════════════════════════════════════
  void _showCommunityPicker(
    BuildContext context,
    List<Community> communities,
    Community? selectedCommunity,
  ) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? Colors.white12 : Colors.black12,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.selectCommunity,
              style: AppTypography.headline5.copyWith(
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            ...communities.map((c) {
              final isSelected = c.id == selectedCommunity?.id;
              // 이미 provider에서 필터링되었으므로 lock 체크 불필요

              return GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  ref.read(boardProvider.notifier).selectCommunity(c);
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withValues(alpha: 0.08)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary.withValues(alpha: 0.2)
                          : (isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.06)),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Community 아이콘 (공용 vs 대학교)
                      Text(
                        c.isGlobal ? '🌍' : '🏫',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          c.isGlobal ? l10n.globalCommunity : c.name,
                          style: AppTypography.body1.copyWith(
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                            color: isSelected
                                ? AppColors.primary
                                : (isDark ? Colors.white : AppColors.textPrimary),
                          ),
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          size: 18,
                          color: AppColors.primary,
                        ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // POST MENU
  // ═══════════════════════════════════════════════════════════════════════════
  void _showPostMenu(BuildContext context, PostEntity post) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 12, 8, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? Colors.white12 : Colors.black12,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              _buildMenuOption(
                context,
                icon: Icons.flag_outlined,
                label: l10n.report,
                color: AppColors.error,
                isDark: isDark,
                onTap: () {
                  Navigator.pop(context);
                  showReportDialog(
                    context: context,
                    targetType: ReportTargetType.post,
                    targetId: post.id,
                  );
                },
              ),
              _buildMenuOption(
                context,
                icon: Icons.block_outlined,
                label: l10n.blockUser,
                isDark: isDark,
                onTap: () {
                  Navigator.pop(context);
                  BlockUserDialog.show(
                    context,
                    post.isWriterAnonymous
                        ? l10n.anonymous
                        : post.writerNickname,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isDark,
    required VoidCallback onTap,
    Color? color,
  }) {
    final textColor = color ?? (isDark ? Colors.white : AppColors.textPrimary);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 22, color: textColor),
            const SizedBox(width: 14),
            Text(
              label,
              style: AppTypography.body1.copyWith(
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // EMPTY STATE
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildEmptyState(BuildContext context, String boardName) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Minimal icon
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : Colors.black.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.article_outlined,
                size: 32,
                color: isDark ? Colors.white30 : AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.noPostsInBoard(boardName),
              style: AppTypography.headline5.copyWith(
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : AppColors.textPrimary,
                letterSpacing: -0.3,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.beFirstToPost,
              style: AppTypography.body2.copyWith(
                color: isDark ? Colors.white54 : AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
