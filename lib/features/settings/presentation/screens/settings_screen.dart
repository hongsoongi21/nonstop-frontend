import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/providers/locale_provider.dart';
import '../../../../core/providers/package_info_provider.dart';
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
      title: AppLocalizations.of(context)!.settings,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withValues(alpha: 0.05),
              context.surfaceColor,
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
            : Center(child: Text(AppLocalizations.of(context)!.settingsNotLoaded)),
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
          // Language Section
          _buildSectionHeader(AppLocalizations.of(context)!.language),
          SizedBox(height: AppSpacing.sm),
          _buildLanguageSection(context, ref),

          SizedBox(height: AppSpacing.xl),

          // Notifications Section
          _buildSectionHeader(AppLocalizations.of(context)!.notifications),
          SizedBox(height: AppSpacing.sm),
          _buildSettingsCard(
            children: [
              _buildSwitchTile(
                context: context,
                icon: Icons.notifications_active_outlined,
                title: AppLocalizations.of(context)!.pushNotifications,
                subtitle: AppLocalizations.of(context)!.pushNotificationsSubtitle,
                value: settings.enablePushNotifications,
                onChanged: (value) =>
                    notifier.updateNotificationSettings(push: value),
              ),
              _buildDivider(),
              _buildSwitchTile(
                context: context,
                icon: Icons.email_outlined,
                title: AppLocalizations.of(context)!.emailNotifications,
                subtitle: AppLocalizations.of(context)!.emailNotificationsSubtitle,
                value: settings.enableEmailNotifications,
                onChanged: (value) =>
                    notifier.updateNotificationSettings(email: value),
              ),
              _buildDivider(),
              _buildSwitchTile(
                context: context,
                icon: Icons.dashboard_outlined,
                title: AppLocalizations.of(context)!.boardNotifications,
                subtitle: AppLocalizations.of(context)!.boardNotificationsSubtitle,
                value: settings.enableBoardNotifications,
                onChanged: (value) =>
                    notifier.updateNotificationSettings(board: value),
              ),
              _buildDivider(),
              _buildSwitchTile(
                context: context,
                icon: Icons.chat_bubble_outline,
                title: AppLocalizations.of(context)!.chatNotifications,
                subtitle: AppLocalizations.of(context)!.chatNotificationsSubtitle,
                value: settings.enableChatNotifications,
                onChanged: (value) =>
                    notifier.updateNotificationSettings(chat: value),
              ),
              _buildDivider(),
              _buildSwitchTile(
                context: context,
                icon: Icons.calendar_today_outlined,
                title: AppLocalizations.of(context)!.timetableNotifications,
                subtitle: AppLocalizations.of(context)!.timetableNotificationsSubtitle,
                value: settings.enableTimetableNotifications,
                onChanged: (value) =>
                    notifier.updateNotificationSettings(timetable: value),
              ),
              _buildDivider(),
              _buildSwitchTile(
                context: context,
                icon: Icons.volume_up_outlined,
                title: AppLocalizations.of(context)!.soundNotifications,
                subtitle: AppLocalizations.of(context)!.soundNotificationsSubtitle,
                value: settings.enableSoundNotifications,
                onChanged: (value) =>
                    notifier.updateNotificationSettings(sound: value),
              ),
            ],
          ),

          SizedBox(height: AppSpacing.xl),

          // Privacy Section
          _buildSectionHeader(AppLocalizations.of(context)!.privacy),
          SizedBox(height: AppSpacing.sm),
          _buildSettingsCard(
            children: [
              _buildSwitchTile(
                context: context,
                icon: Icons.person_add_outlined,
                title: AppLocalizations.of(context)!.allowFriendRequests,
                subtitle: AppLocalizations.of(context)!.allowFriendRequestsSubtitle,
                value: settings.allowFriendRequests,
                onChanged: (value) =>
                    notifier.updatePrivacySettings(friendRequests: value),
              ),
              _buildDivider(),
              _buildSwitchTile(
                context: context,
                icon: Icons.circle,
                title: AppLocalizations.of(context)!.showOnlineStatus,
                subtitle: AppLocalizations.of(context)!.showOnlineStatusSubtitle,
                value: settings.showOnlineStatus,
                onChanged: (value) =>
                    notifier.updatePrivacySettings(onlineStatus: value),
              ),
              _buildDivider(),
              _buildSwitchTile(
                context: context,
                icon: Icons.message_outlined,
                title: AppLocalizations.of(context)!.allowMessageRequests,
                subtitle: AppLocalizations.of(context)!.allowMessageRequestsSubtitle,
                value: settings.allowMessageRequests,
                onChanged: (value) =>
                    notifier.updatePrivacySettings(messageRequests: value),
              ),
              _buildDivider(),
              _buildSwitchTile(
                context: context,
                icon: Icons.public,
                title: AppLocalizations.of(context)!.showProfileToStrangers,
                subtitle: AppLocalizations.of(context)!.showProfileToStrangersSubtitle,
                value: settings.showProfileToStrangers,
                onChanged: (value) =>
                    notifier.updatePrivacySettings(profileVisibility: value),
              ),
            ],
          ),

          SizedBox(height: AppSpacing.xl),

          // Blocked Users Section
          _buildSettingsCard(
            children: [
              _buildNavigationTile(
                context: context,
                icon: Icons.block,
                title: AppLocalizations.of(context)!.blockedUsers,
                onTap: () => GoRouter.of(context).push(Routes.blockedUsers),
              ),
            ],
          ),

          SizedBox(height: AppSpacing.xl),

          // Account Section
          _buildSectionHeader(AppLocalizations.of(context)!.account),
          SizedBox(height: AppSpacing.sm),
          _buildSettingsCard(
            children: [
              _buildLogoutButton(context, ref),
              _buildDivider(),
              _buildDeleteAccountButton(context, ref),
            ],
          ),

          SizedBox(height: AppSpacing.xl),

          // Version Info
          _buildVersionInfo(ref),

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
                color: context.textTertiaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Icon(
                Icons.logout_outlined,
                color: context.textSecondaryColor,
                size: AppSpacing.iconMd,
              ),
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.logout,
                    style: AppTypography.bodyLarge.copyWith(
                      color: context.textPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xxs),
                  Text(
                    AppLocalizations.of(context)!.logoutSubtitle,
                    style: AppTypography.bodySmall.copyWith(
                      color: context.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: context.textTertiaryColor,
              size: AppSpacing.iconMd,
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.logout),
        content: Text(l10n.confirmLogout),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
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
            child: Text(l10n.logout),
          ),
        ],
      ),
    );
  }

  Widget _buildDeleteAccountButton(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return InkWell(
      onTap: () => _showDeleteAccountDialog(context, ref),
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
                color: AppColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Icon(
                Icons.delete_forever_outlined,
                color: AppColors.error,
                size: AppSpacing.iconMd,
              ),
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.deleteAccount,
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xxs),
                  Text(
                    l10n.deleteAccountSubtitle,
                    style: AppTypography.bodySmall.copyWith(
                      color: context.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: context.textTertiaryColor,
              size: AppSpacing.iconMd,
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.deleteAccount),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.confirmDeleteAccount),
            SizedBox(height: AppSpacing.sm),
            Text(
              l10n.deleteAccountWarning,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.error,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              await ref.read(authProvider.notifier).deleteAccount();
              final authState = ref.read(authProvider);
              if (context.mounted) {
                if (authState.failure != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.deleteAccountFailed),
                      backgroundColor: AppColors.error,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.deleteAccountSuccess),
                    ),
                  );
                  context.go(Routes.login);
                }
              }
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(l10n.deleteAccount),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Builder(
      builder: (context) => Text(
        title,
        style: AppTypography.titleLarge.copyWith(
          color: context.textPrimaryColor,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
      ),
    );
  }

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Builder(
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(
            color: context.borderColor.withValues(alpha: 0.5),
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
      ),
    );
  }

  Widget _buildSwitchTile({
    required BuildContext context,
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
                  : context.textTertiaryColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Icon(
              icon,
              color: value ? AppColors.primary : context.textSecondaryColor,
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
                    color: context.textPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: AppSpacing.xxs),
                Text(
                  subtitle,
                  style: AppTypography.bodySmall.copyWith(
                    color: context.textSecondaryColor,
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
            inactiveThumbColor: context.textTertiaryColor,
            inactiveTrackColor: context.borderColor,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
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
                color: context.textTertiaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Icon(
                icon,
                color: context.textSecondaryColor,
                size: AppSpacing.iconMd,
              ),
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                title,
                style: AppTypography.bodyLarge.copyWith(
                  color: context.textPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: context.textTertiaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSection(BuildContext context, WidgetRef ref) {
    final localeState = ref.watch(localeStateProvider);
    final currentLocale = localeState.locale;
    final isUserSelected = localeState.isUserSelected;

    return _buildSettingsCard(
      children: [
        InkWell(
          onTap: () => _showLanguageSelector(context, ref),
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
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                  child: Icon(
                    Icons.language,
                    color: AppColors.primary,
                    size: AppSpacing.iconMd,
                  ),
                ),
                SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.language,
                        style: AppTypography.bodyLarge.copyWith(
                          color: context.textPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: AppSpacing.xxs),
                      Text(
                        AppLocalizations.of(context)!.languageSubtitle,
                        style: AppTypography.bodySmall.copyWith(
                          color: context.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isUserSelected
                          ? AppLocale.getDisplayName(currentLocale)
                          : AppLocalizations.of(context)!.systemDefault,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: AppSpacing.xs),
                    Icon(
                      Icons.chevron_right,
                      color: context.textTertiaryColor,
                      size: AppSpacing.iconMd,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showLanguageSelector(BuildContext context, WidgetRef ref) {
    final localeState = ref.read(localeStateProvider);
    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      backgroundColor: context.surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusXl),
        ),
      ),
      isScrollControlled: true,
      builder: (context) => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                margin: EdgeInsets.only(top: AppSpacing.sm),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: context.borderColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Title
              Padding(
                padding: EdgeInsets.all(AppSpacing.lg),
                child: Text(
                  l10n.language,
                  style: AppTypography.titleLarge.copyWith(
                    color: context.textPrimaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              // System default option
              _buildLanguageOption(
                context: context,
                ref: ref,
                title: l10n.systemDefault,
                subtitle: AppLocale.getDisplayName(AppLocale.getSystemLocale()),
                icon: Icons.phone_android,
                isSelected: !localeState.isUserSelected,
                onTap: () {
                  ref.read(localeStateProvider.notifier).resetToSystemLocale();
                  Navigator.pop(context);
                },
              ),
              Divider(
                height: 1,
                color: context.borderColor.withValues(alpha: 0.3),
                indent: AppSpacing.lg,
                endIndent: AppSpacing.lg,
              ),
              // Language options
              ...AppLocale.supportedLocales.map((locale) => _buildLanguageOption(
                    context: context,
                    ref: ref,
                    title: AppLocale.getDisplayName(locale),
                    flag: AppLocale.getFlag(locale),
                    isSelected: localeState.isUserSelected &&
                        localeState.locale.languageCode == locale.languageCode,
                    onTap: () {
                      ref.read(localeStateProvider.notifier).setLocale(locale);
                      Navigator.pop(context);
                    },
                  )),
              SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
    String? subtitle,
    String? flag,
    IconData? icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            if (flag != null)
              Text(
                flag,
                style: TextStyle(fontSize: 24),
              )
            else if (icon != null)
              Icon(
                icon,
                color: isSelected ? AppColors.primary : context.textSecondaryColor,
                size: 24,
              ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.bodyLarge.copyWith(
                      color: isSelected
                          ? AppColors.primary
                          : context.textPrimaryColor,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: AppTypography.bodySmall.copyWith(
                        color: context.textSecondaryColor,
                      ),
                    ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: AppSpacing.iconMd,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Builder(
      builder: (context) => Divider(
        height: 1,
        thickness: 1,
        color: context.borderColor.withValues(alpha: 0.3),
        indent: AppSpacing.md + 40 + AppSpacing.md, // Align with text
      ),
    );
  }

  Widget _buildVersionInfo(WidgetRef ref) {
    final packageInfoAsync = ref.watch(packageInfoProvider);
    final versionText = packageInfoAsync.when(
      data: (info) => 'Version ${info.version} (${info.buildNumber})',
      loading: () => 'Version ...',
      error: (_, __) => 'Version -',
    );

    return Builder(
      builder: (context) => Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: context.surfaceVariantColor.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                border: Border.all(
                  color: context.borderColor.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: AppSpacing.iconSm,
                    color: context.textTertiaryColor,
                  ),
                  SizedBox(width: AppSpacing.xs),
                  Text(
                    versionText,
                    style: AppTypography.caption.copyWith(
                      color: context.textSecondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSpacing.sm),
            Text(
              '© 2026 NonStop',
              style: AppTypography.captionSmall.copyWith(
                color: context.textTertiaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
