import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_states.dart';
import '../../../../shared/components/glass_container.dart';
import '../providers/friend_management_provider.dart';
import '../../domain/entities/friend.dart';

class FriendsScreen extends ConsumerStatefulWidget {
  const FriendsScreen({super.key});

  @override
  ConsumerState<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends ConsumerState<FriendsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Load friends and requests on init
    Future.microtask(() {
      ref.read(friendManagementProvider.notifier).loadFriends();
      ref.read(friendManagementProvider.notifier).loadRequests();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final friendState = ref.watch(friendManagementProvider);
    final friends = friendState.friends;
    final requests = friendState.requests;
    final searchResults = friendState.searchResults;
    final isLoading = friendState.isLoading;
    final error = friendState.error;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.backgroundGradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Do\'stlar',
                      style: AppTypography.headline4.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              // Tabs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: GlassContainer(
                  padding: const EdgeInsets.all(4),
                  borderRadius: BorderRadius.circular(12),
                  opacity: 0.5,
                  blur: 15,
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    labelColor: AppColors.textOnPrimary,
                    unselectedLabelColor: AppColors.textSecondary,
                    labelStyle: AppTypography.button,
                    tabs: [
                      Tab(
                        child: Text(
                          'Do\'stlar (${friends.length})',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'So\'rovlar',
                              style: TextStyle(fontSize: 12),
                            ),
                            if (requests.isNotEmpty) ...[
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.error,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '${requests.length}',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const Tab(
                        child: Text('Qidirish', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              // Error Message
              if (error != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  child: GlassContainer(
                    color: AppColors.error.withValues(alpha: 0.1),
                    borderColor: AppColors.error.withValues(alpha: 0.3),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: AppColors.error,
                          size: 20,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            error,
                            style: AppTypography.body2.copyWith(
                              color: AppColors.error,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Tab Views
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Friends List
                    _buildFriendsList(friends, isLoading),
                    // Friend Requests
                    _buildRequestsList(requests, isLoading),
                    // Search
                    _buildSearch(searchResults, isLoading),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFriendsList(List<Friend> friends, bool isLoading) {
    if (isLoading && friends.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (friends.isEmpty) {
      return _buildEmptyState(
        icon: Icons.people_outline,
        title: 'Hali do\'stlaringiz yo\'q',
        subtitle: 'Qidiruv orqali do\'stlar qo\'shing',
      );
    }

    return AppRefreshIndicator(
      onRefresh: () =>
          ref.read(friendManagementProvider.notifier).loadFriends(),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        itemCount: friends.length,
        itemBuilder: (context, index) {
          final friend = friends[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: _buildFriendCard(
              friend: friend,
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'delete') {
                    _showDeleteConfirmation(friend);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.person_remove, color: AppColors.error),
                        SizedBox(width: 8),
                        Text('Do\'stlikdan chiqarish'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRequestsList(List<Friend> requests, bool isLoading) {
    if (isLoading && requests.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (requests.isEmpty) {
      return _buildEmptyState(
        icon: Icons.mail_outline,
        title: 'So\'rovlar yo\'q',
        subtitle: 'Do\'stlik so\'rovlari bu yerda ko\'rinadi',
      );
    }

    return AppRefreshIndicator(
      onRefresh: () =>
          ref.read(friendManagementProvider.notifier).loadRequests(),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final request = requests[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: _buildFriendCard(
              friend: request,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Accept Button
                  IconButton(
                    onPressed: () => _acceptRequest(request),
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Reject Button
                  IconButton(
                    onPressed: () => _rejectRequest(request),
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearch(List<Friend> searchResults, bool isLoading) {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: GlassContainer(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            borderRadius: BorderRadius.circular(12),
            opacity: 0.5,
            blur: 15,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Foydalanuvchilarni qidiring...',
                hintStyle: AppTypography.body2.copyWith(
                  color: AppColors.textSecondary,
                ),
                icon: const Icon(Icons.search, color: AppColors.textSecondary),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (value) {
                ref
                    .read(friendManagementProvider.notifier)
                    .searchUsers(value.trim());
              },
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // Search Results
        Expanded(
          child: _searchController.text.isEmpty
              ? _buildEmptyState(
                  icon: Icons.search,
                  title: 'Qidirishni boshlang',
                  subtitle: 'Yuqoridagi qidiruv qatoriga yozing',
                )
              : isLoading
              ? const Center(child: CircularProgressIndicator())
              : searchResults.isEmpty
              ? _buildEmptyState(
                  icon: Icons.person_search,
                  title: 'Natija topilmadi',
                  subtitle: 'Boshqa ism bilan qidirib ko\'ring',
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    final user = searchResults[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: _buildFriendCard(
                        friend: user,
                        trailing: _buildActionButton(user),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildFriendCard({required Friend friend, Widget? trailing}) {
    return GlassContainer(
      padding: const EdgeInsets.all(AppSpacing.md),
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary.withValues(alpha: 0.2),
            backgroundImage: friend.profileImageUrl != null
                ? NetworkImage(friend.profileImageUrl!)
                : null,
            child: friend.profileImageUrl == null
                ? Text(
                    friend.nickname[0].toUpperCase(),
                    style: AppTypography.headline6.copyWith(
                      color: AppColors.primary,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: AppSpacing.md),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  friend.nickname,
                  style: AppTypography.subtitle1.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (friend.universityName != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    friend.universityName!,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
                if (friend.majorName != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    friend.majorName!,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Trailing
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  Widget _buildActionButton(Friend user) {
    switch (user.status) {
      case FriendStatus.accepted:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Do\'st',
            style: AppTypography.caption.copyWith(
              color: AppColors.success,
              fontWeight: FontWeight.w600,
            ),
          ),
        );

      case FriendStatus.pendingSent:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.warning.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Yuborildi',
            style: AppTypography.caption.copyWith(
              color: AppColors.warning,
              fontWeight: FontWeight.w600,
            ),
          ),
        );

      case FriendStatus.pendingReceived:
        return ElevatedButton(
          onPressed: () => _acceptRequest(user),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text('Qabul qilish'),
        );

      default:
        return ElevatedButton(
          onPressed: () => _sendRequest(user),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text('Qo\'shish'),
        );
    }
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: GlassContainer(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 48, color: AppColors.primary),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                title,
                style: AppTypography.headline6.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                subtitle,
                style: AppTypography.body2.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendRequest(Friend user) async {
    final success = await ref
        .read(friendManagementProvider.notifier)
        .sendRequest(user.id);
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Do\'stlik so\'rovi yuborildi')),
      );
      // Refresh search to update status
      ref
          .read(friendManagementProvider.notifier)
          .searchUsers(_searchController.text.trim());
    }
  }

  Future<void> _acceptRequest(Friend user) async {
    final success = await ref
        .read(friendManagementProvider.notifier)
        .acceptRequest(user.id);
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Do\'stlik so\'rovi qabul qilindi')),
      );
    }
  }

  Future<void> _rejectRequest(Friend user) async {
    final success = await ref
        .read(friendManagementProvider.notifier)
        .deleteFriend(user.id);
    if (success && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('So\'rov rad etildi')));
      ref.read(friendManagementProvider.notifier).loadRequests();
    }
  }

  Future<void> _showDeleteConfirmation(Friend friend) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Do\'stlikdan chiqarish'),
        content: Text('${friend.nickname} bilan do\'stlikni tugatmoqchimisiz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Bekor qilish'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Chiqarish'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final success = await ref
          .read(friendManagementProvider.notifier)
          .deleteFriend(friend.id);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Do\'stlikdan chiqarildi')),
        );
      }
    }
  }
}
