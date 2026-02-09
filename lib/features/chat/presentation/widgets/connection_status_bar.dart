import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nonstop/core/l10n/app_localizations.dart';
import 'package:nonstop/core/network/stomp_service.dart';
import 'package:nonstop/core/theme/app_colors.dart';
import 'package:nonstop/core/theme/app_spacing.dart';
import 'package:nonstop/core/theme/app_typography.dart';
import 'package:nonstop/features/auth/presentation/providers/auth_provider.dart';
import 'package:nonstop/features/chat/presentation/providers/chat_provider.dart';

/// A connection status bar that shows WebSocket connection state
/// - Connected: Green bar (auto-hides after 2s)
/// - Connecting: Yellow bar with animated dots
/// - Disconnected/Error: Red bar (tap to reconnect)
class ConnectionStatusBar extends ConsumerStatefulWidget {
  const ConnectionStatusBar({super.key});

  @override
  ConsumerState<ConnectionStatusBar> createState() => _ConnectionStatusBarState();
}

class _ConnectionStatusBarState extends ConsumerState<ConnectionStatusBar>
    with SingleTickerProviderStateMixin {
  bool _showConnected = true;
  late AnimationController _dotAnimationController;

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
    final stompService = ref.watch(stompServiceProvider);

    return StreamBuilder<StompConnectionState>(
      stream: stompService.stateStream,
      initialData: stompService.currentState,
      builder: (context, snapshot) {
        final state = snapshot.data ?? StompConnectionState.disconnected;

        // Auto-hide when connected after 2 seconds
        if (state == StompConnectionState.connected) {
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              setState(() => _showConnected = false);
            }
          });
        } else {
          if (!_showConnected) {
            setState(() => _showConnected = true);
          }
        }

        // Don't show bar when connected and timeout elapsed
        if (state == StompConnectionState.connected && !_showConnected) {
          return const SizedBox.shrink();
        }

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: 40,
          decoration: BoxDecoration(
            color: _getBackgroundColor(state),
            boxShadow: [
              BoxShadow(
                color: _getShadowColor(state),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: _buildContent(state, stompService),
        );
      },
    );
  }

  Color _getBackgroundColor(StompConnectionState state) {
    switch (state) {
      case StompConnectionState.connected:
        return AppColors.success;
      case StompConnectionState.connecting:
        return AppColors.warning;
      case StompConnectionState.disconnected:
      case StompConnectionState.error:
        return AppColors.error;
    }
  }

  Color _getShadowColor(StompConnectionState state) {
    switch (state) {
      case StompConnectionState.connected:
        return AppColors.success.withValues(alpha: 0.3);
      case StompConnectionState.connecting:
        return AppColors.warning.withValues(alpha: 0.3);
      case StompConnectionState.disconnected:
      case StompConnectionState.error:
        return AppColors.error.withValues(alpha: 0.3);
    }
  }

  Widget _buildContent(StompConnectionState state, StompService service) {
    final canTapToReconnect =
        state == StompConnectionState.disconnected || state == StompConnectionState.error;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: canTapToReconnect ? () => _handleReconnect(service) : null,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStatusIcon(state),
              const SizedBox(width: AppSpacing.sm),
              _buildStatusText(state),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon(StompConnectionState state) {
    final icon = _getStatusIcon(state);
    final color = Colors.white;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: Icon(
        icon,
        key: ValueKey(state),
        color: color,
        size: AppSpacing.iconMd,
      ),
    );
  }

  IconData _getStatusIcon(StompConnectionState state) {
    switch (state) {
      case StompConnectionState.connected:
        return Icons.check_circle;
      case StompConnectionState.connecting:
        return Icons.sync;
      case StompConnectionState.disconnected:
      case StompConnectionState.error:
        return Icons.error_outline;
    }
  }

  Widget _buildStatusText(StompConnectionState state) {
    final text = _getStatusText(context, state);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
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

  String _getStatusText(BuildContext context, StompConnectionState state) {
    final l10n = AppLocalizations.of(context);
    switch (state) {
      case StompConnectionState.connected:
        return l10n.connectionConnected;
      case StompConnectionState.connecting:
        return _buildConnectingText(l10n);
      case StompConnectionState.disconnected:
        return l10n.connectionDisconnected;
      case StompConnectionState.error:
        return l10n.connectionDisconnected;
    }
  }

  String _buildConnectingText(AppLocalizations l10n) {
    // Animated dots for connecting state
    final animation = _dotAnimationController.value;
    final dotCount = ((animation * 3) % 4).floor();
    final dots = '.' * dotCount;
    // Remove trailing "..." from connecting text and add animated dots
    final baseText = l10n.connectionConnecting.replaceAll('...', '');
    return '$baseText$dots';
  }

  Future<void> _handleReconnect(StompService service) async {
    // Get auth repository to fetch access token
    final authRepo = ref.read(authRepositoryProvider);
    final tokenResult = await authRepo.getAccessToken();

    tokenResult.fold(
      (failure) {
        // Show error if we can't get token
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('재연결 실패: 인증 토큰을 가져올 수 없습니다'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      (accessToken) {
        // Check if token is not null before reconnecting
        if (accessToken == null) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('재연결 실패: 인증 토큰이 없습니다'),
                backgroundColor: AppColors.error,
              ),
            );
          }
          return;
        }
        // Reconnect with token
        service.connect(accessToken: accessToken);
      },
    );
  }
}
