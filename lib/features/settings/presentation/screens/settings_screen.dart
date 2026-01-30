import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_loading_indicator.dart';
import '../../../../shared/components/main_scaffold.dart' as scaffold;
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../profile/domain/entities/user_settings.dart';
import '../../../profile/presentation/providers/profile_provider.dart';

/// Settings screen for user preferences
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileProvider);
    final isLoaded = ref.watch(isProfileLoadedProvider);
    final isLoading = ref.watch(profileLoadingProvider);
    final error = ref.watch(profileErrorProvider);

    return scaffold.AppScaffold(
      title: 'Settings',
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withOpacity(0.05),
              AppColors.surface,
              AppColors.secondary.withOpacity(0.05),
            ],
          ),
        ),
        child: isLoading && !isLoaded
            ? const Center(child: AppLoadingIndicator())
            : error != null
            ? _buildErrorView(context, ref, error)
            : isLoaded && state.settings != null
            ? _buildSettingsView(context, ref, state.settings!)
            : const Center(child: Text('Settings not loaded')),
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

  Widget _buildSettingsView(
    BuildContext context,
    WidgetRef ref,
    UserSettings settings,
  ) {
    final notifier = ref.read(profileProvider.notifier);

    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Notifications
          _buildSectionHeader('Notifications'),
          _buildSwitchTile(
            title: 'Push Notifications',
            value: settings.enablePushNotifications,
            onChanged: (value) =>
                notifier.updateNotificationSettings(push: value),
          ),
          _buildSwitchTile(
            title: 'Email Notifications',
            value: settings.enableEmailNotifications,
            onChanged: (value) =>
                notifier.updateNotificationSettings(email: value),
          ),
          _buildSwitchTile(
            title: 'Board Notifications',
            value: settings.enableBoardNotifications,
            onChanged: (value) =>
                notifier.updateNotificationSettings(board: value),
          ),
          _buildSwitchTile(
            title: 'Chat Notifications',
            value: settings.enableChatNotifications,
            onChanged: (value) =>
                notifier.updateNotificationSettings(chat: value),
          ),
          _buildSwitchTile(
            title: 'Timetable Notifications',
            value: settings.enableTimetableNotifications,
            onChanged: (value) =>
                notifier.updateNotificationSettings(timetable: value),
          ),
          _buildSwitchTile(
            title: 'Sound Notifications',
            value: settings.enableSoundNotifications,
            onChanged: (value) =>
                notifier.updateNotificationSettings(sound: value),
          ),

          SizedBox(height: AppSpacing.lg),

          // Privacy
          _buildSectionHeader('Privacy'),
          _buildSwitchTile(
            title: 'Allow Friend Requests',
            value: settings.allowFriendRequests,
            onChanged: (value) =>
                notifier.updatePrivacySettings(friendRequests: value),
          ),
          _buildSwitchTile(
            title: 'Show Online Status',
            value: settings.showOnlineStatus,
            onChanged: (value) =>
                notifier.updatePrivacySettings(onlineStatus: value),
          ),
          _buildSwitchTile(
            title: 'Allow Message Requests',
            value: settings.allowMessageRequests,
            onChanged: (value) =>
                notifier.updatePrivacySettings(messageRequests: value),
          ),
          _buildSwitchTile(
            title: 'Show Profile to Strangers',
            value: settings.showProfileToStrangers,
            onChanged: (value) =>
                notifier.updatePrivacySettings(profileVisibility: value),
          ),

          SizedBox(height: AppSpacing.xl),

          // Account Section
          _buildSectionHeader('Account'),
          _buildLogoutButton(context, ref),

          SizedBox(height: AppSpacing.xxxl),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3), width: 1),
      ),
      child: ListTile(
        leading: Icon(Icons.logout, color: AppColors.error),
        title: Text(
          'Logout',
          style: AppTypography.bodyLarge.copyWith(
            color: AppColors.error,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: AppColors.error),
        onTap: () => _showLogoutDialog(context, ref),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await ref.read(authProvider.notifier).signOut();
              if (context.mounted) {
                context.go(Routes.login);
              }
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(
        title,
        style: AppTypography.headlineSmall.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withOpacity(0.3), width: 1),
      ),
      child: SwitchListTile(
        title: Text(
          title,
          style: AppTypography.bodyLarge.copyWith(color: AppColors.textPrimary),
        ),
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.primary,
      ),
    );
  }
}
