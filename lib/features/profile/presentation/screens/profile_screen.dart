import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_loading_indicator.dart';
import '../../../../shared/components/main_scaffold.dart' as scaffold;
import '../../../auth/presentation/providers/university_provider.dart';
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
        decoration: BoxDecoration(
          color: context.backgroundColor,
        ),
        child: isLoading && !isLoaded
            ? const Center(child: AppLoadingIndicator())
            : error != null
                ? _buildErrorView(context, ref, error)
                : isLoaded
                    ? _buildProfileView(context, ref, state.profile!, state.stats!)
                    : Center(child: Text(AppLocalizations.of(context)!.profileNotLoaded)),
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
            AppLocalizations.of(context)!.errorOccurred,
            style: AppTypography.headlineSmall.copyWith(
              color: context.textPrimaryColor,
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            error,
            style: AppTypography.bodyMedium.copyWith(
              color: context.textSecondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSpacing.lg),
          ElevatedButton(
            onPressed: () => ref.read(profileProvider.notifier).refresh(),
            child: Text(AppLocalizations.of(context)!.retry),
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
    final selectedFilterIndex = ref.watch(profileFilterIndexProvider);
    final universitiesAsync = ref.watch(universitiesProvider);
    final universityName = universitiesAsync.whenOrNull(
      data: (universities) {
        if (profile.universityId == null) return null;
        final uniId = int.tryParse(profile.universityId.toString());
        if (uniId == null) return null;
        try {
          return universities.firstWhere((u) => u.id == uniId).name;
        } catch (_) {
          return null;
        }
      },
    );

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
              universityName: universityName,
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
              onTabChanged: (index) => _onFilterTabChanged(context, ref, index),
            ),

            SizedBox(height: AppSpacing.xs),

            // Content based on selected tab
            if (selectedFilterIndex == 0)
              // Posts Tab
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
                      AppLocalizations.of(context)!.postsLoadError,
                      style: AppTypography.bodyMedium.copyWith(
                        color: context.textSecondaryColor,
                      ),
                    ),
                  ),
                ),
                data: (posts) => posts.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Text(
                            AppLocalizations.of(context)!.noPostsYet,
                            style: AppTypography.bodyMedium.copyWith(
                              color: context.textSecondaryColor,
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
              )
            else
              // Comments Tab - Coming Soon
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(48),
                  child: Column(
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        size: 48,
                        color: context.textTertiaryColor,
                      ),
                      SizedBox(height: AppSpacing.md),
                      Text(
                        AppLocalizations.of(context)!.comments,
                        style: AppTypography.bodyMedium.copyWith(
                          color: context.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
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
    GoRouter.of(context).push(Routes.notifications);
  }

  void _showSettings(BuildContext context) {
    GoRouter.of(context).push(Routes.settings);
  }

  void _navigateToEditProfile(BuildContext context) {
    GoRouter.of(context).push(Routes.editProfile);
  }

  void _onFilterTabChanged(BuildContext context, WidgetRef ref, int index) {
    ref.read(profileFilterIndexProvider.notifier).state = index;
  }

  void _onPostTapped(BuildContext context, ProfilePost post) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opened: ${post.title}')),
    );
  }

  void _onRealPostTapped(BuildContext context, PostEntity post) {
    // Navigate to post detail screen
    context.go(Routes.boardDetailPath(post.id.toString()));
  }
}
