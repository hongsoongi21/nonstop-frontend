import 'package:flutter/material.dart';

import '../../../../../core/mock/mock_data.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../shared/components/main_scaffold.dart';
import '../../../../../shared/components/post_card.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  PostCategory _selectedCategory = PostCategory.free;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedCategory = PostCategory.values[_tabController.index];
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredPosts = MockData.getPostsByCategory(_selectedCategory);

    return AppScaffold(
      title: 'Board',
      actions: [
        IconButton(
          onPressed: () {}, // TODO: Navigate to create post
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
        onPressed: () {}, // TODO: Navigate to create post
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

          // Posts list
          Expanded(
            child: filteredPosts.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: filteredPosts.length,
                    itemBuilder: (context, index) {
                      final post = filteredPosts[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: AppSpacing.md),
                        child: PostCard(
                          post: post,
                          onTap: () {}, // TODO: Navigate to post details
                          onLike: () {}, // TODO: Handle like
                          onComment: () {}, // TODO: Navigate to comments
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
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
              'No ${categoryNames[_selectedCategory]} posts yet',
              style: AppTypography.headline6.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: AppSpacing.sm),

            Text(
              categoryDescriptions[_selectedCategory]!,
              style: AppTypography.body2.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: AppSpacing.xl),

            AppFab(
              onPressed: () {}, // TODO: Navigate to create post
              icon: Icons.add,
              tooltip: 'Create First Post',
            ),
          ],
        ),
      ),
    );
  }
}
