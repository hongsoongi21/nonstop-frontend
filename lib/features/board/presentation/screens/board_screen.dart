import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_states.dart';
import '../../../../shared/components/glass_container.dart';
import '../../../../shared/components/main_scaffold.dart';
import '../../../../shared/components/post_card.dart';
import '../providers/board_provider.dart';

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
    final filteredPosts = boardState.filteredPosts;
    final isLoading = boardState.isLoading;
    final error = boardState.error;
    final selectedCategory = boardState.selectedCategory;

    return AppScaffold(
      title: 'Board',
      showAppBar: false, // Custom header
      backgroundColor: Colors.transparent, // Handle bg in Stack
      padding: EdgeInsets.zero, // Allow background to be edge-to-edge
      extendBody: true, // Background behind bottom nav
      extendBodyBehindAppBar: true, // Background behind status bar
      body: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.background,
              AppColors.primary.withValues(alpha: 0.05),
              AppColors.secondary.withValues(alpha: 0.1),
            ],
          ),
        ),
        child: Stack(
          children: [

          // Main Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Board',
                        style: AppTypography.headline4.copyWith(
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      GlassContainer(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => context.go(Routes.boardCreatePath()),
                        child: Row(
                          children: [
                            Icon(Icons.edit_square, size: 18, color: AppColors.primary),
                            SizedBox(width: 8),
                            Text(
                              'Write',
                              style: AppTypography.button.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Categories
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                  child: Row(
                    children: PostCategory.values.map((category) {
                      final isSelected = category == selectedCategory;
                      return Padding(
                        padding: const EdgeInsets.only(right: AppSpacing.sm),
                        child: GestureDetector(
                          onTap: () => ref.read(boardProvider.notifier).changeCategory(category),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primary : Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? AppColors.primary : Colors.white.withValues(alpha: 0.2),
                              ),
                              boxShadow: [
                                if (isSelected)
                                  BoxShadow(
                                    color: AppColors.primary.withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                              ],
                            ),
                            child: Text(
                              _getCategoryName(category),
                              style: AppTypography.button.copyWith(
                                color: isSelected ? Colors.white : AppColors.textSecondary,
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
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                  child: GlassContainer(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    borderRadius: BorderRadius.circular(12),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search posts...',
                        hintStyle: AppTypography.body2.copyWith(color: AppColors.textHint),
                        icon: Icon(Icons.search, color: AppColors.textHint),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: (value) {
                        // TODO: Implement search filter in provider
                      },
                    ),
                  ),
                ),

                // Error Message
                if (error != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                    child: GlassContainer(
                      color: AppColors.error.withValues(alpha: 0.1),
                      borderColor: AppColors.error.withValues(alpha: 0.3),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline, color: AppColors.error, size: 20),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              error,
                              style: AppTypography.body2.copyWith(color: AppColors.error),
                            ),
                          ),
                          IconButton(
                            onPressed: () => ref.read(boardProvider.notifier).clearError(),
                            icon: Icon(Icons.close, color: AppColors.error, size: 20),
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
                    onRefresh: () => ref.read(boardProvider.notifier).refreshPosts(),
                    child: filteredPosts.isEmpty && !isLoading
                        ? _buildEmptyState(selectedCategory)
                        : ListView.builder(
                            padding: const EdgeInsets.only(
                              left: AppSpacing.md,
                              right: AppSpacing.md,
                              top: AppSpacing.sm,
                              bottom: 80, // Space for bottom nav
                            ),
                            itemCount: isLoading ? 0 : filteredPosts.length,
                            itemBuilder: (context, index) {
                              final post = filteredPosts[index];
                              final likesCount = boardState.getPostLikes(post.id);

                              return Padding(
                                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                                child: PostCard(
                                  post: post.copyWith(likes: likesCount),
                                  onTap: () {
                                    // TODO: Navigate to post details
                                  },
                                  onLike: () => ref.read(boardProvider.notifier).toggleLike(post.id),
                                  onComment: () {
                                    ref.read(boardProvider.notifier).addComment(
                                          post.id,
                                          'This is a sample comment!',
                                        );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Comment added!')),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }

  String _getCategoryName(PostCategory category) {
    switch (category) {
      case PostCategory.free:
        return 'Erkin';
      case PostCategory.secret:
        return 'Sirli';
      case PostCategory.question:
        return 'Savol';
      case PostCategory.market:
        return 'Bozor';
    }
  }

  Widget _buildEmptyState(PostCategory selectedCategory) {
    final description = {
      PostCategory.free: 'Share your thoughts and connect with fellow students',
      PostCategory.secret: 'Post anonymously and share what\'s on your mind',
      PostCategory.question: 'Ask questions and get help from the community',
      PostCategory.market: 'Buy, sell, or trade items with other students',
    };

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
              SizedBox(height: AppSpacing.lg),
              Text(
                'No ${_getCategoryName(selectedCategory)} posts yet',
                style: AppTypography.headline6.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                description[selectedCategory]!,
                style: AppTypography.body2.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSpacing.lg),
              ElevatedButton.icon(
                onPressed: () => context.go(Routes.boardCreatePath()),
                icon: const Icon(Icons.add),
                label: const Text('Create First Post'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
