import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nonstop/core/l10n/app_localizations.dart';
import 'package:nonstop/core/theme/app_colors.dart';
import 'package:nonstop/core/theme/app_spacing.dart';
import 'package:nonstop/core/theme/app_typography.dart';

/// Connection state for Supabase Realtime
enum RealtimeConnectionState { connected, connecting, disconnected, error }

/// A connection status bar that shows Supabase Realtime connection state
/// Supabase Realtime handles reconnection automatically, so this bar
/// is shown only briefly or when there's a detected issue.
class ConnectionStatusBar extends ConsumerStatefulWidget {
  const ConnectionStatusBar({super.key});

  @override
  ConsumerState<ConnectionStatusBar> createState() =>
      _ConnectionStatusBarState();
}

class _ConnectionStatusBarState extends ConsumerState<ConnectionStatusBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _dotAnimationController;

  // Supabase Realtime manages connections per-channel automatically.
  // We default to connected and only show disconnected state if detected.
  RealtimeConnectionState _state = RealtimeConnectionState.connected;
  bool _showBar = false;

  @override
  void initState() {
    super.initState();
    _dotAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _dotAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Supabase Realtime auto-reconnects, so we hide the bar by default
    if (!_showBar ||
        _state == RealtimeConnectionState.connected) {
      return const SizedBox.shrink();
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: 40,
      decoration: BoxDecoration(
        color: _getBackgroundColor(_state),
        boxShadow: [
          BoxShadow(
            color: _getShadowColor(_state),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: _buildContent(_state),
    );
  }

  Color _getBackgroundColor(RealtimeConnectionState state) {
    switch (state) {
      case RealtimeConnectionState.connected:
        return AppColors.success;
      case RealtimeConnectionState.connecting:
        return AppColors.warning;
      case RealtimeConnectionState.disconnected:
      case RealtimeConnectionState.error:
        return AppColors.error;
    }
  }

  Color _getShadowColor(RealtimeConnectionState state) {
    switch (state) {
      case RealtimeConnectionState.connected:
        return AppColors.success.withValues(alpha: 0.3);
      case RealtimeConnectionState.connecting:
        return AppColors.warning.withValues(alpha: 0.3);
      case RealtimeConnectionState.disconnected:
      case RealtimeConnectionState.error:
        return AppColors.error.withValues(alpha: 0.3);
    }
  }

  Widget _buildContent(RealtimeConnectionState state) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStatusIcon(state),
          const SizedBox(width: AppSpacing.sm),
          _buildStatusText(state),
        ],
      ),
    );
  }

  Widget _buildStatusIcon(RealtimeConnectionState state) {
    final icon = _getStatusIcon(state);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Icon(
        icon,
        key: ValueKey(state),
        color: Colors.white,
        size: AppSpacing.iconMd,
      ),
    );
  }

  IconData _getStatusIcon(RealtimeConnectionState state) {
    switch (state) {
      case RealtimeConnectionState.connected:
        return Icons.check_circle;
      case RealtimeConnectionState.connecting:
        return Icons.sync;
      case RealtimeConnectionState.disconnected:
      case RealtimeConnectionState.error:
        return Icons.error_outline;
    }
  }

  Widget _buildStatusText(RealtimeConnectionState state) {
    final text = _getStatusText(context, state);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Text(
        text,
        key: ValueKey(text),
        style: AppTypography.bodyMedium.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  String _getStatusText(
      BuildContext context, RealtimeConnectionState state) {
    final l10n = AppLocalizations.of(context);
    switch (state) {
      case RealtimeConnectionState.connected:
        return l10n.connectionConnected;
      case RealtimeConnectionState.connecting:
        return _buildConnectingText(l10n);
      case RealtimeConnectionState.disconnected:
        return l10n.connectionDisconnected;
      case RealtimeConnectionState.error:
        return l10n.connectionDisconnected;
    }
  }

  String _buildConnectingText(AppLocalizations l10n) {
    final animation = _dotAnimationController.value;
    final dotCount = ((animation * 3) % 4).floor();
    final dots = '.' * dotCount;
    final baseText =
        l10n.connectionConnecting.replaceAll('...', '');
    return '$baseText$dots';
  }
}
