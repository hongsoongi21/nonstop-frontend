import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_loading_indicator.dart';
import '../../../../shared/components/main_scaffold.dart' as scaffold;
import '../../domain/entities/user_profile.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_stats.dart';

/// Main profile screen showing user information and stats
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileProvider);
    final isLoaded = ref.watch(isProfileLoadedProvider);
    final isLoading = ref.watch(profileLoadingProvider);
    final error = ref.watch(profileErrorProvider);

    return scaffold.AppScaffold(
      title: 'Profil',
      actions: [
        if (isLoaded)
          IconButton(
            onPressed: () => _showSettings(context),
            icon: const Icon(Icons.settings),
            tooltip: 'Sozlamalar',
          ),
      ],
      body: isLoading && !isLoaded
          ? const Center(child: AppLoadingIndicator())
          : error != null
              ? _buildErrorView(context, ref, error)
              : isLoaded
                  ? _buildProfileView(context, ref, state.profile!, state.stats!)
                  : const Center(child: Text('Profil ma\'lumotlari yuklanmadi')),
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
            'Xatolik yuz berdi',
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
          AppButton(
            text: 'Qayta urinish',
            onPressed: () => ref.read(profileProvider.notifier).refresh(),
            width: 200,
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
    final isEditing = ref.watch(isProfileEditingProvider);
    final notifier = ref.read(profileProvider.notifier);

    return RefreshIndicator(
      onRefresh: () => notifier.refresh(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            // Profile Header
            ProfileHeader(
              profile: profile,
              isEditing: isEditing,
              onEditPressed: () => _toggleEditing(context, ref),
              onAvatarPressed: () => _showAvatarOptions(context),
              onCoverPressed: () => _showCoverOptions(context),
            ),

            // Profile Completion Progress
            if (!isEditing && profile.profileCompletionPercentage < 100)
              _buildProfileCompletion(profile),

            // Profile Stats
            ProfileStats(
              profile: profile,
              stats: stats,
            ),

            // Profile Information Sections
            _buildProfileInfoSection(context, profile),

            // Action Buttons
            _buildActionButtons(context, ref, profile),

            // Bottom padding
            SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCompletion(UserProfile profile) {
    return Container(
      margin: EdgeInsets.all(AppSpacing.md),
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.star,
                color: AppColors.primary,
                size: 20,
              ),
              SizedBox(width: AppSpacing.sm),
              Text(
                'Profil to\'liqligi',
                style: AppTypography.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              const Spacer(),
              Text(
                '${profile.profileCompletionPercentage}%',
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.sm),
          LinearProgressIndicator(
            value: profile.profileCompletionPercentage / 100,
            backgroundColor: AppColors.primary.withOpacity(0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
          SizedBox(height: AppSpacing.xxs),
          Text(
            'Profilni to\'ldirib, ko\'proq imkoniyatlarga ega bo\'ling!',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfoSection(BuildContext context, UserProfile profile) {
    return Card(
      margin: EdgeInsets.all(AppSpacing.md),
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ma\'lumotlar',
              style: AppTypography.titleMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: AppSpacing.md),

            // Email
            if ((profile.showEmail ?? false) && profile.email != null)
              _buildInfoRow(
                icon: Icons.email,
                label: 'Email',
                value: profile.email!,
              ),

            // Phone
            if ((profile.showPhone ?? false) && profile.phoneNumber != null)
              _buildInfoRow(
                icon: Icons.phone,
                label: 'Telefon',
                value: profile.phoneNumber!,
              ),

            // Date of Birth & Age
            if (profile.dateOfBirth != null)
              _buildInfoRow(
                icon: Icons.cake,
                label: 'Tug\'ilgan sana',
                value: '${_formatDate(profile.dateOfBirth!)} (${profile.age} yosh)',
              ),

            // Gender
            if (profile.gender != null)
              _buildInfoRow(
                icon: Icons.person,
                label: 'Jinsi',
                value: profile.gender!,
              ),

            // Website
            if (profile.website != null && profile.website!.isNotEmpty)
              _buildInfoRow(
                icon: Icons.link,
                label: 'Website',
                value: profile.website!,
              ),

            // GPA (if shown)
            if ((profile.showGpa ?? false) && profile.gpa != null)
              _buildInfoRow(
                icon: Icons.grade,
                label: 'GPA',
                value: profile.gpa!.toStringAsFixed(2),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(AppSpacing.xxs),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              icon,
              size: 16,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: AppSpacing.xxs),
                Text(
                  value,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref, UserProfile profile) {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: 'Profilni tahrirlash',
                  onPressed: () => _navigateToEditProfile(context),
                  leadingIcon: Icons.edit,
                ),
              ),
              SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppButton(
                  text: 'Sozlamalar',
                  onPressed: () => _showSettings(context),
                  leadingIcon: Icons.settings,
                  variant: ButtonVariant.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _toggleEditing(BuildContext context, WidgetRef ref) {
    final isEditing = ref.read(isProfileEditingProvider);
    ref.read(profileProvider.notifier).setEditing(!isEditing);
  }

  void _showAvatarOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: const Text('Kamera'),
            onTap: () {
              Navigator.of(context).pop();
              // TODO: Implement camera capture
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Kamera - tez orada!')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Galereya'),
            onTap: () {
              Navigator.of(context).pop();
              // TODO: Implement gallery picker
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Galereya - tez orada!')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: AppColors.error),
            title: const Text('O\'chirish', style: TextStyle(color: AppColors.error)),
            onTap: () {
              Navigator.of(context).pop();
              // TODO: Implement avatar deletion
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Avatar o\'chirish - tez orada!')),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showCoverOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: const Text('Kamera'),
            onTap: () {
              Navigator.of(context).pop();
              // TODO: Implement camera capture
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Kamera - tez orada!')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Galereya'),
            onTap: () {
              Navigator.of(context).pop();
              // TODO: Implement gallery picker
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Galereya - tez orada!')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: AppColors.error),
            title: const Text('O\'chirish', style: TextStyle(color: AppColors.error)),
            onTap: () {
              Navigator.of(context).pop();
              // TODO: Implement cover deletion
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cover o\'chirish - tez orada!')),
              );
            },
          ),
        ],
      ),
    );
  }

  void _navigateToEditProfile(BuildContext context) {
    // TODO: Navigate to edit profile screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil tahrirlash - tez orada!')),
    );
  }

  void _showSettings(BuildContext context) {
    // TODO: Navigate to settings screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sozlamalar - tez orada!')),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }
}
