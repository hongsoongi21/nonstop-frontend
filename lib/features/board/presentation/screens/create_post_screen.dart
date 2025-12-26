import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/mock/mock_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../shared/components/main_scaffold.dart';
import '../providers/board_provider.dart';

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

  PostCategory _selectedCategory = PostCategory.free;
  bool _isAnonymous = false;
  bool _isLoading = false;
  final List<String> _tags = [];
  final TextEditingController _tagController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  Future<void> _createPost() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // Create new post (in real app, this would be sent to backend)
    final newPost = Post(
      id: 'post_${DateTime.now().millisecondsSinceEpoch}',
      category: _selectedCategory,
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      author: _isAnonymous ? 'Anonymous' : 'Current User', // Would be from auth
      authorId: _isAnonymous ? 'anon_${DateTime.now().millisecondsSinceEpoch}' : 'current_user',
      authorAvatar: _isAnonymous ? null : 'https://via.placeholder.com/40x40/2563EB/FFFFFF?text=YU',
      likes: 0,
      comments: 0,
      timestamp: DateTime.now(),
      isAnonymous: _isAnonymous,
      tags: List.from(_tags),
    );

    // Add to board state and mock data
    ref.read(boardProvider.notifier).addPost(newPost);
    MockData.posts.insert(0, newPost);

    if (mounted) {
      // Navigate back to board
      context.go('/board');
    }
  }

  void _addTag(String tag) {
    final trimmedTag = tag.trim().toLowerCase();
    if (trimmedTag.isNotEmpty && !_tags.contains(trimmedTag)) {
      setState(() {
        _tags.add(trimmedTag);
      });
    }
    _tagController.clear();
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Create Post',
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Selection
                    _buildCategorySelector(),

                    const SizedBox(height: AppSpacing.lg),

                    // Title Field
                    AppTextField(
                      controller: _titleController,
                      labelText: 'Title',
                      hintText: 'Write a clear, engaging title...',
                      maxLines: 2,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a title';
                        }
                        if (value.trim().length < 5) {
                          return 'Title must be at least 5 characters';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Content Field
                    AppTextField(
                      controller: _contentController,
                      labelText: 'Content',
                      hintText: 'Share your thoughts, ask questions, or describe what you\'re selling...',
                      maxLines: 8,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter some content';
                        }
                        if (value.trim().length < 10) {
                          return 'Content must be at least 10 characters';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Tags Section
                    _buildTagsSection(),

                    const SizedBox(height: AppSpacing.lg),

                    // Anonymous Toggle
                    _buildAnonymousToggle(),

                    const SizedBox(height: AppSpacing.lg),

                    // Category Info
                    _buildCategoryInfo(),
                  ],
                ),
              ),
            ),

            // Bottom Actions
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  ),
                ),
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: 'Cancel',
                        onPressed: () => context.pop(),
                        variant: ButtonVariant.secondary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: AppButton(
                        text: 'Post',
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
    );
  }

  Widget _buildCategorySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: AppTypography.body2.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: PostCategory.values.map((category) {
            final isSelected = category == _selectedCategory;
            return FilterChip(
              label: Text(_getCategoryDisplayName(category)),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedCategory = category;
                  });
                }
              },
              backgroundColor: Theme.of(context).colorScheme.surface,
              selectedColor: Color(_getCategoryColor(category)).withValues(alpha: 0.1),
              checkmarkColor: Color(_getCategoryColor(category)),
              labelStyle: AppTypography.body2.copyWith(
                color: isSelected
                    ? Color(_getCategoryColor(category))
                    : Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                side: BorderSide(
                  color: isSelected
                      ? Color(_getCategoryColor(category))
                      : Theme.of(context).colorScheme.outline,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTagsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Tags',
              style: AppTypography.body2.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              '(Optional)',
              style: AppTypography.caption.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _tagController,
                decoration: InputDecoration(
                  hintText: 'Add a tag...',
                  hintStyle: AppTypography.body2.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.sm,
                  ),
                ),
                style: AppTypography.body2,
                onSubmitted: _addTag,
              ),
            ),
            IconButton(
              onPressed: () => _addTag(_tagController.text),
              icon: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        if (_tags.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: _tags.map((tag) => Chip(
              label: Text('#$tag'),
              deleteIcon: const Icon(Icons.close, size: 16),
              onDeleted: () => _removeTag(tag),
              backgroundColor: Theme.of(context).colorScheme.surface,
              labelStyle: AppTypography.caption.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            )).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildAnonymousToggle() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.visibility_off_outlined,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Post Anonymously',
                  style: AppTypography.body2.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  'Hide your identity from other users',
                  style: AppTypography.caption.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: _isAnonymous,
            onChanged: (value) {
              setState(() {
                _isAnonymous = value;
              });
            },
            activeColor: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryInfo() {
    final categoryInfo = _getCategoryInfo(_selectedCategory);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Color(_getCategoryColor(_selectedCategory)).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
          color: Color(_getCategoryColor(_selectedCategory)).withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            categoryInfo['icon'] as IconData,
            color: Color(_getCategoryColor(_selectedCategory)),
            size: 24,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  categoryInfo['title'] as String,
                  style: AppTypography.body2.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  categoryInfo['description'] as String,
                  style: AppTypography.caption.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getCategoryDisplayName(PostCategory category) {
    switch (category) {
      case PostCategory.free:
        return 'Erkin';
      case PostCategory.secret:
        return 'Sirli';
      case PostCategory.question:
        return 'Savol';
      case PostCategory.market:
        return 'Bozor';
    }
  }

  int _getCategoryColor(PostCategory category) {
    switch (category) {
      case PostCategory.free:
        return AppColors.boardFree.toARGB32();
      case PostCategory.secret:
        return AppColors.boardSecret.toARGB32();
      case PostCategory.question:
        return AppColors.boardQuestion.toARGB32();
      case PostCategory.market:
        return AppColors.boardMarket.toARGB32();
    }
  }

  Map<String, dynamic> _getCategoryInfo(PostCategory category) {
    switch (category) {
      case PostCategory.free:
        return {
          'title': 'Free Discussion',
          'description': 'Share your thoughts and connect with fellow students',
          'icon': Icons.forum,
        };
      case PostCategory.secret:
        return {
          'title': 'Anonymous Posts',
          'description': 'Post anonymously and share what\'s on your mind',
          'icon': Icons.visibility_off,
        };
      case PostCategory.question:
        return {
          'title': 'Questions & Help',
          'description': 'Ask questions and get help from the community',
          'icon': Icons.help_outline,
        };
      case PostCategory.market:
        return {
          'title': 'Marketplace',
          'description': 'Buy, sell, or trade items with other students',
          'icon': Icons.shopping_cart,
        };
    }
  }
}
