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
              AppColors.primary.withValues(alpha: 0.05),
              AppColors.surface,
              AppColors.secondary.withValues(alpha: 0.05),
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
            color: AppColors.error.withValues(alpha: 0.5),
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
      padding: EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Notifications Section
          _buildSectionHeader('Notifications'),
          SizedBox(height: AppSpacing.sm),
          _buildSettingsCard(
            children: [
              _buildSwitchTile(
                icon: Icons.notifications_active_outlined,
                title: 'Push Notifications',
                subtitle: 'Receive push notifications on this device',
                value: settings.enablePushNotifications,
                onChanged: (value) =>
                    notifier.updateNotificationSettings(push: value),
              ),
              _buildDivider(),
              _buildSwitchTile(
                icon: Icons.email_outlined,
                title: 'Email Notifications',
                subtitle: 'Get updates via email',
                value: settings.enableEmailNotifications,
                onChanged: (value) =>
                    notifier.updateNotificationSettings(email: value),
              ),
              _buildDivider(),
              _buildSwitchTile(
                icon: Icons.dashboard_outlined,
                title: 'Board Notifications',
                subtitle: 'New posts and comments',
                value: settings.enableBoardNotifications,
                onChanged: (value) =>
                    notifier.updateNotificationSettings(board: value),
              ),
              _buildDivider(),
              _buildSwitchTile(
                icon: Icons.chat_bubble_outline,
                title: 'Chat Notifications',
                subtitle: 'New messages and replies',
                value: settings.enableChatNotifications,
                onChanged: (value) =>
                    notifier.updateNotificationSettings(chat: value),
              ),
              _buildDivider(),
              _buildSwitchTile(
                icon: Icons.calendar_today_outlined,
                title: 'Timetable Notifications',
                subtitle: 'Class reminders and updates',
                value: settings.enableTimetableNotifications,
                onChanged: (value) =>
                    notifier.updateNotificationSettings(timetable: value),
              ),
              _buildDivider(),
              _buildSwitchTile(
                icon: Icons.volume_up_outlined,
                title: 'Sound Notifications',
                subtitle: 'Play sound for notifications',
                value: settings.enableSoundNotifications,
                onChanged: (value) =>
                    notifier.updateNotificationSettings(sound: value),
              ),
            ],
          ),

          SizedBox(height: AppSpacing.xl),

          // Privacy Section
          _buildSectionHeader('Privacy'),
          SizedBox(height: AppSpacing.sm),
          _buildSettingsCard(
            children: [
              _buildSwitchTile(
                icon: Icons.person_add_outlined,
                title: 'Allow Friend Requests',
                subtitle: 'Let others send you friend requests',
                value: settings.allowFriendRequests,
                onChanged: (value) =>
                    notifier.updatePrivacySettings(friendRequests: value),
              ),
              _buildDivider(),
              _buildSwitchTile(
                icon: Icons.circle,
                title: 'Show Online Status',
                subtitle: 'Let friends see when you\'re online',
                value: settings.showOnlineStatus,
                onChanged: (value) =>
                    notifier.updatePrivacySettings(onlineStatus: value),
              ),
              _buildDivider(),
              _buildSwitchTile(
                icon: Icons.message_outlined,
                title: 'Allow Message Requests',
                subtitle: 'Receive messages from non-friends',
                value: settings.allowMessageRequests,
                onChanged: (value) =>
                    notifier.updatePrivacySettings(messageRequests: value),
              ),
              _buildDivider(),
              _buildSwitchTile(
                icon: Icons.public,
                title: 'Show Profile to Strangers',
                subtitle: 'Make your profile visible to everyone',
                value: settings.showProfileToStrangers,
                onChanged: (value) =>
                    notifier.updatePrivacySettings(profileVisibility: value),
              ),
            ],
          ),

          SizedBox(height: AppSpacing.xl),

          // Account Section
          _buildSectionHeader('Account'),
          SizedBox(height: AppSpacing.sm),
          _buildSettingsCard(
            children: [
              _buildLogoutButton(context, ref),
            ],
          ),

          SizedBox(height: AppSpacing.xl),

          // Version Info
          _buildVersionInfo(),

          SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => _showLogoutDialog(context, ref),
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.textTertiary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Icon(
                Icons.logout_outlined,
                color: AppColors.textSecondary,
                size: AppSpacing.iconMd,
              ),
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Logout',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xxs),
                  Text(
                    'Sign out of your account',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppColors.textTertiary,
              size: AppSpacing.iconMd,
            ),
          ],
        ),
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
    return Text(
      title,
      style: AppTypography.titleLarge.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
      ),
    );
  }

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: value
                  ? AppColors.primary.withValues(alpha: 0.1)
                  : AppColors.textTertiary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Icon(
              icon,
              color: value ? AppColors.primary : AppColors.textSecondary,
              size: AppSpacing.iconMd,
            ),
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: AppSpacing.xxs),
                Text(
                  subtitle,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: AppSpacing.sm),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.primary,
            activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
            inactiveThumbColor: AppColors.textTertiary,
            inactiveTrackColor: AppColors.border,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: AppColors.border.withValues(alpha: 0.3),
      indent: AppSpacing.md + 40 + AppSpacing.md, // Align with text
    );
  }

  Widget _buildVersionInfo() {
    return Center(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              border: Border.all(
                color: AppColors.border.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.info_outline,
                  size: AppSpacing.iconSm,
                  color: AppColors.textTertiary,
                ),
                SizedBox(width: AppSpacing.xs),
                Text(
                  'Version 1.0.0',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            '© 2024 NonStop',
            style: AppTypography.captionSmall.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
