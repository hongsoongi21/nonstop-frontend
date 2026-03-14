import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/widgets/app_loading_indicator.dart';
import '../../../../shared/components/main_scaffold.dart' as scaffold;
import '../../../friends/data/api/friend_api_impl.dart';
import '../../../friends/data/dto/friend_dto.dart';

// Provider for blocked users
final blockedUsersProvider = FutureProvider<List<BlockedUserDto>>((ref) async {
  final api = ref.watch(friendApiProvider);
  final result = await api.getBlockedUsers();
  return result.fold(
    (error) => throw Exception(error.message),
    (users) => users,
  );
});

/// Screen showing all blocked users with unblock functionality
class BlockedUsersScreen extends ConsumerStatefulWidget {
  const BlockedUsersScreen({super.key});

  @override
  ConsumerState<BlockedUsersScreen> createState() => _BlockedUsersScreenState();
}

class _BlockedUsersScreenState extends ConsumerState<BlockedUsersScreen> {
  bool _isUnblocking = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final blockedUsersAsync = ref.watch(blockedUsersProvider);

    return scaffold.AppScaffold(
      title: l10n.blockedUsers,
      padding: EdgeInsets.zero,
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
        child: blockedUsersAsync.when(
          data: (users) => users.isEmpty
              ? _buildEmptyState(context)
              : _buildUserList(context, users),
          loading: () => const Center(child: AppLoadingIndicator()),
          error: (error, stack) => _buildErrorView(context, error.toString()),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: context.surfaceVariantColor.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.block,
                size: 64,
                color: context.textTertiaryColor,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              l10n.noBlockedUsers,
              style: AppTypography.headline4.copyWith(
                color: context.textPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Users you block will appear here',
              style: AppTypography.body1.copyWith(
                color: context.textSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, String error) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.error.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.errorOccurred,
              style: AppTypography.headline4.copyWith(
                color: context.textPrimaryColor,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              error,
              style: AppTypography.body2.copyWith(
                color: context.textSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: () => ref.refresh(blockedUsersProvider),
              child: Text(l10n.retry),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserList(BuildContext context, List<BlockedUserDto> users) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(blockedUsersProvider);
        await ref.read(blockedUsersProvider.future);
      },
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
        itemCount: users.length,
        separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) {
          final user = users[index];
          return _buildUserCard(context, user);
        },
      ),
    );
  }

  Widget _buildUserCard(BuildContext context, BlockedUserDto user) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
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
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 28,
            backgroundColor: context.borderColor.withValues(alpha: 0.3),
            backgroundImage: user.blockedUser.profileImageUrl != null
                ? NetworkImage(user.blockedUser.profileImageUrl!)
                : null,
            child: user.blockedUser.profileImageUrl == null
                ? Text(
                    user.blockedUser.nickname.isNotEmpty
                        ? user.blockedUser.nickname[0].toUpperCase()
                        : '?',
                    style: AppTypography.headline5.copyWith(
                      color: context.textSecondaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: AppSpacing.md),

          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.blockedUser.nickname,
                  style: AppTypography.body1.copyWith(
                    color: context.textPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.xxs),
                if (user.blockedAt != null)
                  Text(
                    'Blocked ${timeAgo(DateTime.parse(user.blockedAt!))}',
                    style: AppTypography.caption.copyWith(
                      color: context.textSecondaryColor,
                    ),
                  ),
              ],
            ),
          ),

          // Unblock button
          if (_isUnblocking)
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else
            OutlinedButton(
              onPressed: () => _handleUnblock(context, user),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: BorderSide(color: AppColors.primary, width: 1.5),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
              ),
              child: Text(
                l10n.unblock,
                style: AppTypography.buttonSmall.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _handleUnblock(BuildContext context, BlockedUserDto user) async {
    final l10n = AppLocalizations.of(context)!;

    setState(() => _isUnblocking = true);

    try {
      final api = ref.read(friendApiProvider);
      final result = await api.unblockUser(user.blockedUser.userId.toString());

      if (!mounted) return;

      result.fold(
        (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.message),
              backgroundColor: AppColors.error,
            ),
          );
        },
        (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.userUnblocked),
              backgroundColor: AppColors.success,
            ),
          );
          // Refresh the list
          ref.invalidate(blockedUsersProvider);
        },
      );
    } finally {
      if (mounted) {
        setState(() => _isUnblocking = false);
      }
    }
  }
}
