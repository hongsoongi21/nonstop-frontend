import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nonstop/core/l10n/app_localizations.dart';
import 'package:nonstop/core/theme/app_colors.dart';
import 'package:nonstop/core/theme/app_spacing.dart';
import 'package:nonstop/core/theme/app_typography.dart';
import 'package:nonstop/core/widgets/app_loading_skeleton.dart';
import 'package:nonstop/features/auth/presentation/providers/auth_provider.dart';
import 'package:nonstop/features/chat/domain/entities/chat_room.dart';
import 'package:nonstop/features/chat/presentation/providers/chat_provider.dart';
import 'package:nonstop/features/chat/presentation/widgets/chat_room_tile.dart';
import 'package:nonstop/features/chat/presentation/widgets/connection_status_bar.dart';
import 'package:nonstop/features/chat/presentation/widgets/create_chat_bottom_sheet.dart';

/// Clean, minimal chat screen following Swiss design principles
/// - Simple header with title and action icons
/// - Clean dividers between chat items
/// - No unnecessary gradients or shadows
/// - Clear visual hierarchy
class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  bool _isSearching = false;
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatListProvider);
    final currentUser = ref.watch(currentUserProvider);
    final currentUserId = currentUser?.id != null ? int.tryParse(currentUser!.id) : null;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isDarkMode ? AppColors.backgroundDark : AppColors.background;
    final surfaceColor = isDarkMode ? AppColors.surfaceDark : AppColors.surface;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Clean header
            _buildHeader(context, isDarkMode),

            // Search bar (animated)
            if (_isSearching)
              _buildSearchBar(isDarkMode),

            // Subtle divider
            Container(
              height: 1,
              color: isDarkMode
                  ? AppColors.borderDark.withValues(alpha: 0.5)
                  : AppColors.border.withValues(alpha: 0.3),
            ),

            // Connection status
            const ConnectionStatusBar(),

            // Chat list
            Expanded(
              child: Container(
                color: surfaceColor,
                child: RefreshIndicator(
                  onRefresh: () => ref.read(chatListProvider.notifier).loadRooms(),
                  color: AppColors.primary,
                  backgroundColor: surfaceColor,
                  child: _buildChatList(context, chatState, currentUserId, isDarkMode),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDarkMode) {
    final textPrimaryColor = isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final iconColor = isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          // Title - clean, bold
          Text(
            AppLocalizations.of(context).chat,
            style: AppTypography.headline4.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 28,
              letterSpacing: -0.5,
              color: textPrimaryColor,
            ),
          ),

          const Spacer(),

          // Search icon
          _buildHeaderIcon(
            icon: Icons.search_rounded,
            onTap: () => _showSearch(context),
            isDarkMode: isDarkMode,
            iconColor: iconColor,
          ),

          const SizedBox(width: AppSpacing.sm),

          // Add icon
          _buildHeaderIcon(
            icon: Icons.add,
            onTap: () => _showCreateChatSheet(context),
            isDarkMode: isDarkMode,
            iconColor: iconColor,
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon({
    required IconData icon,
    required VoidCallback onTap,
    required bool isDarkMode,
    required Color iconColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        borderRadius: BorderRadius.circular(8),
        splashColor: AppColors.primary.withValues(alpha: 0.1),
        highlightColor: AppColors.primary.withValues(alpha: 0.05),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            size: 26,
            color: iconColor,
          ),
        ),
      ),
    );
  }

  Widget _buildChatList(
    BuildContext context,
    ChatListState state,
    int? currentUserId,
    bool isDarkMode,
  ) {
    final borderColor = isDarkMode ? AppColors.borderDark : AppColors.border;

    if (state.isLoading && state.rooms.isEmpty) {
      return ListView.separated(
        padding: const EdgeInsets.only(top: 0, bottom: 88),
        itemCount: 6,
        separatorBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(left: 84),
          height: 1,
          color: borderColor.withValues(alpha: 0.3),
        ),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: SkeletonLayouts.listItem(hasAvatar: true, hasSubtitle: true),
        ),
      );
    }

    if (state.error != null && state.rooms.isEmpty) {
      return _buildErrorState(context, isDarkMode);
    }

    if (state.rooms.isEmpty) {
      return _buildEmptyState(context, isDarkMode);
    }

    final numberedRooms = _numberAnonymousRooms(state.rooms);
    final filteredRooms = _searchQuery.isEmpty
        ? numberedRooms
        : numberedRooms.where((room) {
            final name = room.name?.toLowerCase() ?? '';
            final lastMsg = room.lastMessage?.content.toLowerCase() ?? '';
            return name.contains(_searchQuery) || lastMsg.contains(_searchQuery);
          }).toList();

    if (filteredRooms.isEmpty && _searchQuery.isNotEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Text(
            AppLocalizations.of(context).noResults,
            style: AppTypography.bodyLarge.copyWith(
              color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(top: 0, bottom: 88),
      itemCount: filteredRooms.length,
      separatorBuilder: (context, index) => Container(
        margin: const EdgeInsets.only(left: 84),
        height: 1,
        color: borderColor.withValues(alpha: 0.3),
      ),
      itemBuilder: (context, index) {
        final room = filteredRooms[index];
        return ChatRoomTile(
          room: room,
          currentUserId: currentUserId,
        );
      },
    );
  }

  Widget _buildErrorState(BuildContext context, bool isDarkMode) {
    final textPrimaryColor = isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final textSecondaryColor = isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.wifi_off_rounded,
                      size: 40,
                      color: AppColors.error.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    AppLocalizations.of(context).chatLoadError,
                    style: AppTypography.body1.copyWith(
                      color: textPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Pull down to retry',
                    style: AppTypography.body2.copyWith(
                      color: textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, bool isDarkMode) {
    final l10n = AppLocalizations.of(context);
    final textPrimaryColor = isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final textSecondaryColor = isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondary;
    final primaryColor = isDarkMode ? AppColors.primaryLight : AppColors.primary;

    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.chat_bubble_outline_rounded,
                      size: 56,
                      color: primaryColor.withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    l10n.chatListEmpty,
                    style: AppTypography.headline5.copyWith(
                      color: textPrimaryColor,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    l10n.chatListEmptyHint,
                    style: AppTypography.body2.copyWith(
                      color: textSecondaryColor,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  // Start conversation button
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        _showCreateChatSheet(context);
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.add_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Start a conversation',
                              style: AppTypography.button.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSearch(BuildContext context) {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _searchQuery = '';
      }
    });
  }

  Widget _buildSearchBar(bool isDarkMode) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: TextField(
        controller: _searchController,
        autofocus: true,
        style: AppTypography.bodyLarge.copyWith(
          color: isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: l10n.search,
          hintStyle: AppTypography.bodyLarge.copyWith(
            color: isDarkMode ? AppColors.textTertiaryDark : AppColors.textHint,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: isDarkMode ? AppColors.textTertiaryDark : AppColors.textTertiary,
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: isDarkMode ? AppColors.textTertiaryDark : AppColors.textTertiary,
                  ),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                )
              : null,
          filled: true,
          fillColor: isDarkMode ? AppColors.surfaceVariantDark : AppColors.surfaceVariant,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
        ),
        onChanged: (value) {
          setState(() => _searchQuery = value.toLowerCase());
        },
      ),
    );
  }

  List<ChatRoom> _numberAnonymousRooms(List<ChatRoom> rooms) {
    final l10n = AppLocalizations.of(context);
    int anonymousCount = 0;
    final result = <ChatRoom>[];
    for (final room in rooms) {
      if (room.isAnonymous) {
        anonymousCount++;
        if (anonymousCount == 1) {
          // First anonymous room: clear the name so UI falls back to l10n.anonymous.
          result.add(room.copyWith(name: null));
        } else {
          result.add(room.copyWith(
            name: l10n.anonymousRoomWithCount(anonymousCount),
          ));
        }
      } else {
        result.add(room);
      }
    }
    return result;
  }

  void _showCreateChatSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CreateChatBottomSheet(),
    );
  }
}
