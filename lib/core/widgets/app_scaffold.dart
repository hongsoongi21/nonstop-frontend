import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../extensions/context_extensions.dart';

/// App scaffold with consistent layout and common features
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawer,
    this.endDrawer,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.primary = true,
    this.restorationId,
    this.safeArea = const SafeAreaConfig(),
    this.systemUiOverlay = const SystemUiOverlayConfig(),
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? bottomSheet;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final bool primary;
  final String? restorationId;
  final SafeAreaConfig safeArea;
  final SystemUiOverlayConfig systemUiOverlay;

  @override
  Widget build(BuildContext context) {
    Widget scaffold = Scaffold(
      appBar: appBar,
      body: _buildBody(context),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      drawer: drawer,
      endDrawer: endDrawer,
      bottomSheet: bottomSheet,
      backgroundColor: backgroundColor ?? AppColors.background,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      primary: primary,
      restorationId: restorationId,
    );

    // Apply system UI overlay
    scaffold = AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiOverlay.getSystemUiOverlayStyle(context),
      child: scaffold,
    );

    return scaffold;
  }

  Widget _buildBody(BuildContext context) {
    Widget content = body;

    // Apply safe area
    if (safeArea.enabled) {
      content = SafeArea(
        top: safeArea.top,
        bottom: safeArea.bottom,
        left: safeArea.left,
        right: safeArea.right,
        minimum: safeArea.minimum,
        maintainBottomViewPadding: safeArea.maintainBottomViewPadding,
        child: content,
      );
    }

    return content;
  }
}

/// Safe area configuration
class SafeAreaConfig {
  const SafeAreaConfig({
    this.enabled = true,
    this.top = true,
    this.bottom = true,
    this.left = true,
    this.right = true,
    this.minimum = EdgeInsets.zero,
    this.maintainBottomViewPadding = false,
  });

  final bool enabled;
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;
  final EdgeInsets minimum;
  final bool maintainBottomViewPadding;
}

/// System UI overlay configuration
class SystemUiOverlayConfig {
  const SystemUiOverlayConfig({
    this.statusBarColor,
    this.statusBarBrightness,
    this.statusBarIconBrightness,
    this.systemNavigationBarColor,
    this.systemNavigationBarDividerColor,
    this.systemNavigationBarIconBrightness,
    this.systemNavigationBarContrastEnforced,
  });

  final Color? statusBarColor;
  final Brightness? statusBarBrightness;
  final Brightness? statusBarIconBrightness;
  final Color? systemNavigationBarColor;
  final Color? systemNavigationBarDividerColor;
  final Brightness? systemNavigationBarIconBrightness;
  final bool? systemNavigationBarContrastEnforced;

  SystemUiOverlayStyle getSystemUiOverlayStyle(BuildContext context) {
    final isDarkMode = context.isDarkMode;

    return SystemUiOverlayStyle(
      statusBarColor: statusBarColor ?? Colors.transparent,
      statusBarBrightness:
          statusBarBrightness ??
          (isDarkMode ? Brightness.dark : Brightness.light),
      statusBarIconBrightness:
          statusBarIconBrightness ??
          (isDarkMode ? Brightness.light : Brightness.dark),
      systemNavigationBarColor:
          systemNavigationBarColor ??
          (isDarkMode ? AppColors.surface : AppColors.background),
      systemNavigationBarDividerColor: systemNavigationBarDividerColor,
      systemNavigationBarIconBrightness:
          systemNavigationBarIconBrightness ??
          (isDarkMode ? Brightness.light : Brightness.dark),
      systemNavigationBarContrastEnforced: systemNavigationBarContrastEnforced,
    );
  }
}

/// App bar with consistent styling
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    this.title,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.bottom,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.backgroundColor,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.centerTitle,
    this.excludeHeaderSemantics = false,
    this.titleSpacing,
    this.shape,
    this.toolbarHeight,
    this.leadingWidth,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.systemOverlayStyle,
  });

  final Widget? title;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final double? elevation;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final bool primary;
  final bool? centerTitle;
  final bool excludeHeaderSemantics;
  final double? titleSpacing;
  final ShapeBorder? shape;
  final double? toolbarHeight;
  final double? leadingWidth;
  final TextStyle? toolbarTextStyle;
  final TextStyle? titleTextStyle;
  final SystemUiOverlayStyle? systemOverlayStyle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      bottom: bottom,
      elevation: elevation ?? AppSpacing.elevationXs,
      shadowColor: shadowColor ?? AppColors.shadow,
      surfaceTintColor: surfaceTintColor ?? AppColors.surface,
      backgroundColor: backgroundColor ?? AppColors.surface,
      foregroundColor: foregroundColor ?? AppColors.textPrimary,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      primary: primary,
      centerTitle: centerTitle ?? true,
      excludeHeaderSemantics: excludeHeaderSemantics,
      titleSpacing: titleSpacing,
      shape: shape,
      toolbarHeight: toolbarHeight,
      leadingWidth: leadingWidth,
      toolbarTextStyle: toolbarTextStyle,
      titleTextStyle:
          titleTextStyle ??
          AppTypography.headline6.copyWith(color: AppColors.textPrimary),
      systemOverlayStyle: systemOverlayStyle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Screen wrapper with standard padding and background
class AppScreen extends StatelessWidget {
  const AppScreen({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.safeArea = const SafeAreaConfig(),
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final SafeAreaConfig safeArea;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: backgroundColor,
      safeArea: safeArea,
      body: Padding(
        padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
        child: child,
      ),
    );
  }
}

/// Scrollable screen wrapper
class AppScrollableScreen extends StatelessWidget {
  const AppScrollableScreen({
    super.key,
    required this.children,
    this.appBar,
    this.padding,
    this.backgroundColor,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.physics,
    this.safeArea = const SafeAreaConfig(),
  });

  final AppAppBar? appBar;
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final ScrollPhysics? physics;
  final SafeAreaConfig safeArea;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      safeArea: safeArea,
      body: SingleChildScrollView(
        physics: physics ?? const BouncingScrollPhysics(),
        padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          children: children,
        ),
      ),
    );
  }
}

/// List screen wrapper with refresh functionality
class AppListScreen extends StatefulWidget {
  const AppListScreen({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.appBar,
    this.padding,
    this.backgroundColor,
    this.onRefresh,
    this.scrollController,
    this.physics,
    this.separatorBuilder,
    this.emptyWidget,
    this.loadingWidget,
    this.safeArea = const SafeAreaConfig(),
  });

  final AppAppBar? appBar;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Future<void> Function()? onRefresh;
  final ScrollController? scrollController;
  final ScrollPhysics? physics;
  final IndexedWidgetBuilder? separatorBuilder;
  final Widget? emptyWidget;
  final Widget? loadingWidget;
  final SafeAreaConfig safeArea;

  @override
  State<AppListScreen> createState() => _AppListScreenState();
}

class _AppListScreenState extends State<AppListScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget listView = widget.separatorBuilder != null
        ? ListView.separated(
            controller: _scrollController,
            physics: widget.physics ?? const BouncingScrollPhysics(),
            padding: widget.padding ?? const EdgeInsets.all(AppSpacing.lg),
            itemBuilder: widget.itemBuilder,
            separatorBuilder: widget.separatorBuilder!,
            itemCount: widget.itemCount,
          )
        : ListView.builder(
            controller: _scrollController,
            physics: widget.physics ?? const BouncingScrollPhysics(),
            padding: widget.padding ?? const EdgeInsets.all(AppSpacing.lg),
            itemBuilder: widget.itemBuilder,
            itemCount: widget.itemCount,
          );

    if (widget.onRefresh != null) {
      listView = RefreshIndicator(
        onRefresh: widget.onRefresh!,
        child: listView,
      );
    }

    if (widget.itemCount == 0 && widget.emptyWidget != null) {
      listView = Center(child: widget.emptyWidget);
    }

    return AppScaffold(
      appBar: widget.appBar,
      backgroundColor: widget.backgroundColor,
      safeArea: widget.safeArea,
      body: listView,
    );
  }
}

/// Empty state widget
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.action,
    this.iconSize = 64.0,
  });

  final IconData icon;
  final String title;
  final String message;
  final Widget? action;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: iconSize, color: AppColors.textSecondary),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              style: AppTypography.headline6.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              style: AppTypography.body2.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[
              const SizedBox(height: AppSpacing.lg),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
