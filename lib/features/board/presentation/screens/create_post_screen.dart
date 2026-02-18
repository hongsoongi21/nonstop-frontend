import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nonstop/core/l10n/app_localizations.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../shared/components/glass_container.dart';
import '../../../../shared/components/main_scaffold.dart';
import '../providers/board_provider.dart';
import '../../data/repositories/board_repository_impl.dart';
import '../../domain/entities/board.entity.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  Board? _selectedBoard;
  bool _isAnonymous = false;
  bool _isSecret = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Pre-select board from state if available, or initialize if needed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(boardProvider);
      if (state.selectedBoard != null) {
        setState(() {
          _selectedBoard = state.selectedBoard;
          if (state.selectedBoard!.type == BoardType.anonymous) {
            _isAnonymous = true;
          }
        });
      }
      // If boards are empty and not loading, trigger initialization
      if (state.boards.isEmpty && !state.isLoading && state.error == null) {
        ref.read(boardProvider.notifier).initialize();
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _createPost() async {
    final l10n = AppLocalizations.of(context)!;

    if (!_formKey.currentState!.validate()) return;
    if (_selectedBoard == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.pleaseSelectBoard)));
      return;
    }

    setState(() => _isLoading = true);

    final repo = ref.read(boardRepositoryProvider);
    final isAnonymous = _isAnonymous || (_selectedBoard?.type == BoardType.anonymous);
    final result = await repo.createPost(
      _selectedBoard!.id,
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      isAnonymous: isAnonymous,
      isSecret: _isSecret,
    );

    result.fold(
      (error) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error)));
      },
      (post) {
        // Refresh board posts
        ref.read(boardProvider.notifier).refreshPosts();
        context.go('/board');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final boardState = ref.watch(boardProvider);
    final boards = boardState.boards;
    final l10n = AppLocalizations.of(context);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AppScaffold(
      title: l10n.createPost,
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      padding: EdgeInsets.zero,
      body: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    AppColors.backgroundDark,
                    AppColors.primary.withValues(alpha: 0.08),
                    AppColors.backgroundDark,
                  ]
                : [
                    AppColors.background,
                    AppColors.primary.withValues(alpha: 0.05),
                    AppColors.secondary.withValues(alpha: 0.1),
                  ],
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  children: [
                    // Board Selection
                    _buildBoardSelector(context, boards),

                    const SizedBox(height: AppSpacing.lg),

                    // Title Field
                    GlassContainer(
                      borderColor: Colors.transparent,
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: AppTextField(
                        controller: _titleController,
                        labelText: l10n.title,
                        hintText: l10n.writeClearTitle,
                        maxLines: 2,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.pleaseEnterTitle;
                          }
                          if (value.trim().length < 2) {
                            return l10n.titleTooShort;
                          }
                          return null;
                        },
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Content Field
                    GlassContainer(
                      borderColor: Colors.transparent,
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: AppTextField(
                        controller: _contentController,
                        labelText: l10n.content,
                        hintText: l10n.shareYourThoughts,
                        maxLines: 8,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.pleaseEnterContent;
                          }
                          return null;
                        },
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Toggles
                    _buildToggles(context),

                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),

              // Bottom Actions
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: GlassContainer(
                  borderColor: Colors.transparent,
                  blur: 15,
                  opacity: 0.8,
                  child: Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          text: l10n.cancel,
                          onPressed: () => context.pop(),
                          variant: ButtonVariant.secondary,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: AppButton(
                          text: l10n.post,
                          onPressed: _isLoading ? null : _createPost,
                          isLoading: _isLoading,
                          variant: ButtonVariant.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBoardSelector(BuildContext context, List<Board> boards) {
    final l10n = AppLocalizations.of(context)!;
    final boardState = ref.watch(boardProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GlassContainer(
      borderColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.board,
            style: AppTypography.body2.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          if (boardState.isLoading)
            Row(
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  l10n.loading,
                  style: AppTypography.body2.copyWith(
                    color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondary,
                  ),
                ),
              ],
            )
          else if (boardState.error != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.errorOccurred,
                  style: AppTypography.body2.copyWith(color: AppColors.error),
                ),
                const SizedBox(height: AppSpacing.sm),
                TextButton.icon(
                  onPressed: () => ref.read(boardProvider.notifier).initialize(),
                  icon: const Icon(Icons.refresh, size: 18),
                  label: Text(l10n.retry),
                ),
              ],
            )
          else if (boards.isEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.noBoardsAvailable,
                  style: AppTypography.body2.copyWith(
                    color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                TextButton.icon(
                  onPressed: () => ref.read(boardProvider.notifier).initialize(),
                  icon: const Icon(Icons.refresh, size: 18),
                  label: Text(l10n.retry),
                ),
              ],
            )
          else
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: boards.map((board) {
                final isSelected = board.id == _selectedBoard?.id;
                return FilterChip(
                  label: Text(board.name),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedBoard = board;
                        if (board.type == BoardType.anonymous) {
                          _isAnonymous = true;
                        }
                      });
                    }
                  },
                  backgroundColor: (isDarkMode ? AppColors.surfaceDark : AppColors.surface).withValues(alpha: 0.5),
                  selectedColor: AppColors.primary.withValues(alpha: 0.15),
                  checkmarkColor: AppColors.primary,
                  labelStyle: AppTypography.body2.copyWith(
                    color: isSelected
                        ? AppColors.primary
                        : (isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondary),
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    side: BorderSide(
                      color: isSelected ? AppColors.primary : (isDarkMode ? AppColors.borderDark : AppColors.border),
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildToggles(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        _buildToggleItem(
          icon: Icons.visibility_off_outlined,
          title: l10n.postAnonymously,
          subtitle: _selectedBoard?.type == BoardType.anonymous
              ? l10n.hideIdentity
              : l10n.hideIdentity,
          value: _isAnonymous,
          onChanged: _selectedBoard?.type == BoardType.anonymous
              ? null
              : (val) => setState(() => _isAnonymous = val),
        ),
        const SizedBox(height: AppSpacing.md),
        _buildToggleItem(
          icon: Icons.lock_outline,
          title: l10n.secretPost,
          subtitle: l10n.onlyVisibleToAuthorized,
          value: _isSecret,
          onChanged: (val) => setState(() => _isSecret = val),
        ),
      ],
    );
  }

  Widget _buildToggleItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    ValueChanged<bool>? onChanged,
  }) {
    return GlassContainer(
      borderColor: Colors.transparent,
      child: Row(
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 24),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.body2.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
