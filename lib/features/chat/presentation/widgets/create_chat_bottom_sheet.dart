import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nonstop/core/constants/routes.dart';
import 'package:nonstop/core/l10n/app_localizations.dart';
import 'package:nonstop/core/theme/app_colors.dart';
import 'package:nonstop/core/theme/app_spacing.dart';
import 'package:nonstop/core/theme/app_typography.dart';
import 'package:nonstop/features/friends/presentation/providers/friend_management_provider.dart';
import 'package:nonstop/features/friends/domain/entities/friend.dart';
import 'package:nonstop/features/chat/presentation/providers/chat_provider.dart';
import 'package:nonstop/core/extensions/context_extensions.dart';

/// Bottom sheet for creating new 1:1 or group chats
///
/// Features:
/// - Real-time user search
/// - Multi-select with visual chip feedback
/// - Smart routing: 1 user → 1:1, 2+ → group with name input
/// - Elegant visual hierarchy with bold typography
class CreateChatBottomSheet extends ConsumerStatefulWidget {
  const CreateChatBottomSheet({super.key});

  @override
  ConsumerState<CreateChatBottomSheet> createState() =>
      _CreateChatBottomSheetState();
}

class _CreateChatBottomSheetState extends ConsumerState<CreateChatBottomSheet>
    with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  final _groupNameController = TextEditingController();
  final Set<Friend> _selectedUsers = {};
  bool _isCreating = false;
  bool _showGroupNameInput = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();

    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _groupNameController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      ref.read(friendManagementProvider.notifier).searchUsers(query);
    } else {
      ref.read(friendManagementProvider.notifier).searchUsers('');
    }
  }

  void _toggleUserSelection(Friend user) {
    setState(() {
      if (_selectedUsers.contains(user)) {
        _selectedUsers.remove(user);
      } else {
        _selectedUsers.add(user);
      }
      _showGroupNameInput = false;
    });
  }

  Future<void> _createChat() async {
    if (_selectedUsers.isEmpty || _isCreating) return;

    if (_selectedUsers.length == 1) {
      // Create 1:1 chat
      await _createOneToOneChat();
    } else {
      // Show group name input if not already shown
      if (!_showGroupNameInput) {
        setState(() => _showGroupNameInput = true);
        return;
      }

      // Create group chat
      final groupName = _groupNameController.text.trim();
      if (groupName.isEmpty) {
        _showError('Please enter a group name');
        return;
      }
      await _createGroupChat(groupName);
    }
  }

  Future<void> _createOneToOneChat() async {
    setState(() => _isCreating = true);

    final user = _selectedUsers.first;
    final userId = int.tryParse(user.id);

    if (userId == null) {
      _showError('Invalid user ID');
      setState(() => _isCreating = false);
      return;
    }

    final newRoom = await ref.read(chatListProvider.notifier).createOneToOneRoom(userId);

    setState(() => _isCreating = false);

    if (mounted && newRoom != null) {
      GoRouter.of(context).pop();
      GoRouter.of(context).push(Routes.chatRoomPath(newRoom.id.toString()));
    } else if (mounted) {
      _showError('Failed to create chat');
    }
  }

  Future<void> _createGroupChat(String groupName) async {
    setState(() => _isCreating = true);

    final userIds = _selectedUsers
        .map((u) => int.tryParse(u.id))
        .whereType<int>()
        .toList();

    if (userIds.isEmpty) {
      _showError('Invalid user selection');
      setState(() => _isCreating = false);
      return;
    }

    // TODO: Implement createGroupRoom in chat provider
    // For now, show error
    _showError('Group chat creation not yet implemented');
    setState(() => _isCreating = false);
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final friendState = ref.watch(friendManagementProvider);
    final searchResults = friendState.searchResults;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        decoration: BoxDecoration(
          color: context.backgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 32,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            _buildSearchField(),
            if (_selectedUsers.isNotEmpty) _buildSelectedUsers(),
            if (_showGroupNameInput) _buildGroupNameInput(),
            _buildSearchResults(searchResults, friendState.isLoading),
            _buildCreateButton(),
            SizedBox(height: MediaQuery.of(context).padding.bottom + AppSpacing.md),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.borderColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              AppLocalizations.of(context).newChat,
              style: AppTypography.headlineMedium.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 24),
            onPressed: () => GoRouter.of(context).pop(),
            style: IconButton.styleFrom(
              backgroundColor: context.surfaceColor,
              shape: const CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Container(
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: context.borderColor.withValues(alpha: 0.2),
            width: 1.5,
          ),
        ),
        child: TextField(
          controller: _searchController,
          autofocus: true,
          style: AppTypography.bodyLarge,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context).searchUsers,
            hintStyle: AppTypography.bodyLarge.copyWith(
              color: context.textSecondaryColor.withValues(alpha: 0.5),
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: context.textSecondaryColor,
              size: 24,
            ),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, size: 20),
                    onPressed: () {
                      _searchController.clear();
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedUsers() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).selectedCount(_selectedUsers.length),
            style: AppTypography.bodySmall.copyWith(
              color: context.textSecondaryColor,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: _selectedUsers.map((user) {
              return _buildUserChip(user);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildUserChip(Friend user) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: AppColors.primary.withValues(alpha: 0.2),
            child: Text(
              user.nickname[0].toUpperCase(),
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            user.nickname,
            style: AppTypography.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          InkWell(
            onTap: () => _toggleUserSelection(user),
            child: Icon(
              Icons.close,
              size: 16,
              color: context.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupNameInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md)
          .copyWith(bottom: AppSpacing.md),
      child: Container(
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: TextField(
          controller: _groupNameController,
          autofocus: true,
          style: AppTypography.bodyLarge,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context).groupNameHint,
            hintStyle: AppTypography.bodyLarge.copyWith(
              color: context.textSecondaryColor.withValues(alpha: 0.5),
            ),
            prefixIcon: Icon(
              Icons.group_rounded,
              color: AppColors.primary,
              size: 24,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults(List<Friend> results, bool isLoading) {
    return Flexible(
      child: Container(
        constraints: const BoxConstraints(maxHeight: 350),
        child: isLoading
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.xl),
                  child: CircularProgressIndicator(),
                ),
              )
            : results.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final user = results[index];
                      final isSelected = _selectedUsers.contains(user);
                      return _buildUserTile(user, isSelected);
                    },
                  ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.person_search_rounded,
                size: 64,
                color: context.textSecondaryColor.withValues(alpha: 0.3),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                _searchController.text.isEmpty
                    ? 'Start typing to search users'
                    : 'No users found',
                style: AppTypography.bodyMedium.copyWith(
                  color: context.textSecondaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserTile(Friend user, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primary.withValues(alpha: 0.08)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.3)
              : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _toggleUserSelection(user),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                  backgroundImage: user.profileImageUrl != null
                      ? NetworkImage(user.profileImageUrl!)
                      : null,
                  child: user.profileImageUrl == null
                      ? Text(
                          user.nickname[0].toUpperCase(),
                          style: AppTypography.titleMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.nickname,
                        style: AppTypography.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (user.universityName != null)
                        Text(
                          user.universityName!,
                          style: AppTypography.bodySmall.copyWith(
                            color: context.textSecondaryColor,
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? AppColors.primary
                        : context.surfaceColor,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : context.borderColor,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.white,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreateButton() {
    final l10n = AppLocalizations.of(context);
    final canCreate = _selectedUsers.isNotEmpty && !_isCreating;
    final buttonText = _isCreating
        ? 'Creating...'
        : _showGroupNameInput
            ? l10n.createGroup
            : _selectedUsers.length == 1
                ? l10n.startChat
                : _selectedUsers.length > 1
                    ? 'Continue'
                    : 'Select Users';

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: FilledButton(
          onPressed: canCreate ? _createChat : null,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary,
            disabledBackgroundColor: context.surfaceColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: canCreate ? 4 : 0,
          ),
          child: _isCreating
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  buttonText,
                  style: AppTypography.titleMedium.copyWith(
                    color: canCreate ? Colors.white : context.textSecondaryColor,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
        ),
      ),
    );
  }
}
