import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_states.dart';
import '../../../../shared/components/main_scaffold.dart';
import '../../../../shared/components/post_card.dart';
import '../providers/board_provider.dart';

class BoardScreen extends ConsumerStatefulWidget {
  const BoardScreen({super.key});

  @override
  ConsumerState<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends ConsumerState<BoardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      final category = PostCategory.values[_tabController.index];
      ref.read(boardProvider.notifier).changeCategory(category);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final boardState = ref.watch(boardProvider);
    final filteredPosts = boardState.filteredPosts;
    final isLoading = boardState.isLoading;
    final error = boardState.error;

    return AppScaffold(
      title: 'Board',
      actions: [
        IconButton(
          onPressed: () => context.go(Routes.boardCreatePath()),
          icon: const Icon(Icons.add),
          tooltip: 'Create Post',
        ),
        IconButton(
          onPressed: () {}, // TODO: Navigate to search
          icon: const Icon(Icons.search),
          tooltip: 'Search',
        ),
      ],
      floatingActionButton: AppFab(
        onPressed: () => context.go(Routes.boardCreatePath()),
        icon: Icons.edit,
        tooltip: 'New Post',
      ),
      body: Column(
        children: [
          // Category tabs
          Container(
            margin: EdgeInsets.only(bottom: AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicator: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              labelStyle: AppTypography.button.copyWith(
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: AppTypography.button,
              tabs: const [
                Tab(text: 'Erkin'),
                Tab(text: 'Sirli'),
                Tab(text: 'Savol'),
                Tab(text: 'Bozor'),
              ],
            ),
          ),

          // Error message
          if (error != null)
            Container(
              margin: EdgeInsets.only(bottom: AppSpacing.md),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
              ),
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

          // Posts list
          Expanded(
            child: AppRefreshIndicator(
              onRefresh: () => ref.read(boardProvider.notifier).refreshPosts(),
              child: filteredPosts.isEmpty && !isLoading
                  ? _buildEmptyState(boardState.selectedCategory)
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: isLoading ? 0 : filteredPosts.length,
                      itemBuilder: (context, index) {
                        final post = filteredPosts[index];
                        final likesCount = boardState.getPostLikes(post.id);

                        return Padding(
                          padding: EdgeInsets.only(bottom: AppSpacing.md),
                          child: PostCard(
                            post: post.copyWith(likes: likesCount),
                            onTap: () {
                              // TODO: Navigate to post details
                            },
                            onLike: () => ref.read(boardProvider.notifier).toggleLike(post.id),
                            onComment: () {
                              // Simulate adding a comment
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
    );
  }

  Widget _buildEmptyState(PostCategory selectedCategory) {
    final categoryNames = {
      PostCategory.free: 'Erkin',
      PostCategory.secret: 'Sirli',
      PostCategory.question: 'Savol',
      PostCategory.market: 'Bozor',
    };

    final categoryDescriptions = {
      PostCategory.free: 'Share your thoughts and connect with fellow students',
      PostCategory.secret: 'Post anonymously and share what\'s on your mind',
      PostCategory.question: 'Ask questions and get help from the community',
      PostCategory.market: 'Buy, sell, or trade items with other students',
    };

    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.forum_outlined,
                size: 64,
                color: AppColors.primary,
              ),
            ),

            SizedBox(height: AppSpacing.lg),

            Text(
              'No ${categoryNames[selectedCategory]} posts yet',
              style: AppTypography.headline6.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: AppSpacing.sm),

            Text(
              categoryDescriptions[selectedCategory]!,
              style: AppTypography.body2.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: AppSpacing.xl),

            AppFab(
              onPressed: () => context.go(Routes.boardCreatePath()),
              icon: Icons.add,
              tooltip: 'Create First Post',
            ),
          ],
        ),
      ),
    );
  }
}
