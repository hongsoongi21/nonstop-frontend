import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import 'glass_container.dart';

/// Filter tabs for profile content (grid, comments, bookmarks, favorites)
class ProfileFilterTabs extends StatefulWidget {
  final Function(int)? onTabChanged;

  const ProfileFilterTabs({
    super.key,
    this.onTabChanged,
  });

  @override
  State<ProfileFilterTabs> createState() => _ProfileFilterTabsState();
}

class _ProfileFilterTabsState extends State<ProfileFilterTabs> {
  int _selectedIndex = 0;

  void _onTabPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onTabChanged?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      margin: EdgeInsets.all(AppSpacing.md),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      borderRadius: 16,
      blur: 15,
      opacity: 0.15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _FilterTab(
            icon: Icons.grid_on_outlined,
            isSelected: _selectedIndex == 0,
            onPressed: () => _onTabPressed(0),
          ),
          _FilterTab(
            icon: Icons.chat_bubble_outline,
            isSelected: _selectedIndex == 1,
            onPressed: () => _onTabPressed(1),
          ),
          _FilterTab(
            icon: Icons.bookmark_border,
            isSelected: _selectedIndex == 2,
            onPressed: () => _onTabPressed(2),
          ),
          _FilterTab(
            icon: Icons.favorite_border,
            isSelected: _selectedIndex == 3,
            onPressed: () => _onTabPressed(3),
          ),
        ],
      ),
    );
  }
}

/// Individual filter tab
class _FilterTab extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onPressed;

  const _FilterTab({
    required this.icon,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
          size: 26,
        ),
      ),
    );
  }
}
