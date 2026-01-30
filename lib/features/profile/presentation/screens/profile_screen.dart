import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_loading_indicator.dart';
import '../../../../shared/components/main_scaffold.dart' as scaffold;
import '../../../board/domain/entities/post.entity.dart';
import '../../domain/entities/user_profile.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_filter_tabs.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_post_card.dart';
import '../widgets/profile_stats.dart';

/// Main profile screen with glassmorphism design
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileProvider);
    final isLoaded = ref.watch(isProfileLoadedProvider);
    final isLoading = ref.watch(profileLoadingProvider);
    final error = ref.watch(profileErrorProvider);

    return scaffold.AppScaffold(
      showAppBar: false,
      padding: EdgeInsets.zero,
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
        ),
        child: isLoading && !isLoaded
            ? const Center(child: AppLoadingIndicator())
            : error != null
                ? _buildErrorView(context, ref, error)
                : isLoaded
                    ? _buildProfileView(context, ref, state.profile!, state.stats!)
                    : const Center(child: Text('Profil ma\'lumotlari yuklanmadi')),
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, WidgetRef ref, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: AppColors.error.withOpacity(0.5),
          ),
          SizedBox(height: AppSpacing.md),
          Text(
            'Error occurred',
            style: AppTypography.headlineSmall.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            error,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSpacing.lg),
          ElevatedButton(
            onPressed: () => ref.read(profileProvider.notifier).refresh(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileView(
    BuildContext context,
    WidgetRef ref,
    UserProfile profile,
    stats,
  ) {
    final notifier = ref.read(profileProvider.notifier);
    final myPostsAsync = ref.watch(myPostsProvider);

    return RefreshIndicator(
      onRefresh: () async {
        await notifier.refresh();
        ref.invalidate(myPostsProvider);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            // Profile Header - Hero section
            ProfileHeader(
              profile: profile,
              onNotificationPressed: () => _showNotifications(context),
              onSettingsPressed: () => _showSettings(context),
            ),

            // Profile Stats - positioned just below header
            ProfileStats(
              profile: profile,
              stats: stats,
              onEditProfilePressed: () => _navigateToEditProfile(context),
            ),

            SizedBox(height: AppSpacing.sm),

            // Filter Tabs
            ProfileFilterTabs(
              onTabChanged: (index) => _onFilterTabChanged(context, index),
            ),

            SizedBox(height: AppSpacing.xs),

            // Posts List
            myPostsAsync.when(
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: AppLoadingIndicator(),
                ),
              ),
              error: (error, stack) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text(
                    '게시글을 불러오지 못했습니다',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
              data: (posts) => posts.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Text(
                          '작성한 게시글이 없습니다',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    )
                  : Column(
                      children: posts.map((post) => ProfilePostCard(
                        post: ProfilePost(
                          title: post.title,
                          preview: post.content,
                          views: post.viewCount,
                          likes: post.likeCount,
                          comments: post.commentCount,
                        ),
                        onTap: () => _onRealPostTapped(context, post),
                      )).toList(),
                    ),
            ),

            // Bottom padding
            SizedBox(height: AppSpacing.xxxl),
          ],
        ),
      ),
    );
  }

  void _showNotifications(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notifications - coming soon!')),
    );
  }

  void _showSettings(BuildContext context) {
    context.push(Routes.settings);
  }

  void _navigateToEditProfile(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit Profile - coming soon!')),
    );
  }

  void _onFilterTabChanged(BuildContext context, int index) {
    final filters = ['All Posts', 'Comments', 'Bookmarks', 'Favorites'];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Filter: ${filters[index]}')),
    );
  }

  void _onPostTapped(BuildContext context, ProfilePost post) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opened: ${post.title}')),
    );
  }

  void _onRealPostTapped(BuildContext context, PostEntity post) {
    // Navigate to post detail screen
    context.push('/board/post/${post.id}');
  }
}
