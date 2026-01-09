import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_states.dart';
import '../../../../shared/components/glass_container.dart';
import '../../../../shared/components/main_scaffold.dart';
import '../../../../shared/components/post_card.dart';
import '../providers/board_provider.dart';
import '../../domain/entities/community.entity.dart';

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
    final boardState = ref.watch(boardProvider);
    final posts = boardState.posts;
    final isLoading = boardState.isLoading;
    final error = boardState.error;
    final communities = boardState.communities;
    final selectedCommunity = boardState.selectedCommunity;
    final boards = boardState.boards;
    final selectedBoard = boardState.selectedBoard;

    return AppScaffold(
      title: 'Board',
      showAppBar: false,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.zero,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.backgroundGradient,
          ),
        ),
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header & Community Selector
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Board',
                              style: AppTypography.headline4.copyWith(
                                fontWeight: FontWeight.w900,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            if (communities.isNotEmpty)
                              GestureDetector(
                                onTap: () => _showCommunityPicker(
                                  context,
                                  communities,
                                  selectedCommunity,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      selectedCommunity?.name ??
                                          'Select Community',
                                      style: AppTypography.body2.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_drop_down,
                                      color: AppColors.primary,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            if (selectedBoard != null) {
                              context.go(Routes.boardCreatePath());
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please select a board first'),
                                ),
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: AppColors.brandGradient,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF7C3BEE,
                                  ).withValues(alpha: 0.25),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.edit_square,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Write',
                                  style: AppTypography.button.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Boards (Chips)
                  if (boards.isNotEmpty)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      child: Row(
                        children: boards.map((board) {
                          final isSelected = board.id == selectedBoard?.id;
                          return Padding(
                            padding: const EdgeInsets.only(
                              right: AppSpacing.sm,
                            ),
                            child: GestureDetector(
                              onTap: () => ref
                                  .read(boardProvider.notifier)
                                  .selectBoard(board),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primary
                                      : Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.primary
                                        : Colors.white.withValues(alpha: 0.2),
                                  ),
                                  boxShadow: [
                                    if (isSelected)
                                      BoxShadow(
                                        color: AppColors.primary.withValues(
                                          alpha: 0.3,
                                        ),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                  ],
                                ),
                                child: Text(
                                  board.name,
                                  style: AppTypography.button.copyWith(
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.textSecondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    child: GlassContainer(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      opacity: 0.5,
                      blur: 15,
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search posts...',
                          hintStyle: AppTypography.body2.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          icon: Icon(
                            Icons.search,
                            color: AppColors.textSecondary,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
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
                      child: posts.isEmpty && !isLoading
                          ? _buildEmptyState(selectedBoard?.name ?? 'Board')
                          : ListView.builder(
                              padding: const EdgeInsets.only(
                                left: AppSpacing.md,
                                right: AppSpacing.md,
                                top: AppSpacing.sm,
                                bottom: 80,
                              ),
                              itemCount: posts.length,
                              itemBuilder: (context, index) {
                                final post = posts[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: AppSpacing.md,
                                  ),
                                  child: PostCard(
                                    post: post,
                                    onTap: () => context.go(
                                      Routes.boardDetailPath(
                                        post.id.toString(),
                                      ),
                                    ),
                                    onLike: () => ref
                                        .read(boardProvider.notifier)
                                        .toggleLike(post.id),
                                    onComment: () => context.go(
                                      Routes.boardDetailPath(
                                        post.id.toString(),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
            if (isLoading) const Center(child: CircularProgressIndicator()),
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
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Select Community', style: AppTypography.headline6),
            const SizedBox(height: AppSpacing.md),
            ...communities.map(
              (c) => ListTile(
                title: Text(c.name),
                selected: c.id == selectedCommunity?.id,
                onTap: () {
                  ref.read(boardProvider.notifier).selectCommunity(c);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String boardName) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: GlassContainer(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.forum_outlined,
                  size: 48,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'No posts in $boardName yet',
                style: AppTypography.headline6.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Be the first to start a conversation!',
                style: AppTypography.body2.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton.icon(
                onPressed: () => context.go(Routes.boardCreatePath()),
                icon: const Icon(Icons.add),
                label: const Text('Create First Post'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
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
