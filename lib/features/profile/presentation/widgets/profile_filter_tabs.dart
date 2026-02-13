import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

/// Filter tabs for profile content - Bold segmented control design
class ProfileFilterTabs extends StatefulWidget {
  final Function(int)? onTabChanged;

  const ProfileFilterTabs({super.key, this.onTabChanged});

  @override
  State<ProfileFilterTabs> createState() => _ProfileFilterTabsState();
}

class _ProfileFilterTabsState extends State<ProfileFilterTabs>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTabPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _animationController.forward(from: 0);
    widget.onTabChanged?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppSpacing.md),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.surfaceVariantColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.borderColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _FilterTab(
              icon: Icons.grid_on_outlined,
              label: AppLocalizations.of(context)!.posts,
              isSelected: _selectedIndex == 0,
              onPressed: () => _onTabPressed(0),
            ),
          ),
          Expanded(
            child: _FilterTab(
              icon: Icons.chat_bubble_outline,
              label: AppLocalizations.of(context)!.comments,
              isSelected: _selectedIndex == 1,
              onPressed: () => _onTabPressed(1),
            ),
          ),
        ],
      ),
    );
  }
}

/// Individual filter tab with icon and label
class _FilterTab extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const _FilterTab({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(
          vertical: AppSpacing.md,
          horizontal: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? context.surfaceColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 0,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedScale(
              scale: isSelected ? 1.0 : 0.9,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                icon,
                color: isSelected ? AppColors.primary : context.textSecondaryColor,
                size: 20,
              ),
            ),
            SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: AppTypography.labelMedium.copyWith(
                color: isSelected ? AppColors.primary : context.textSecondaryColor,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
