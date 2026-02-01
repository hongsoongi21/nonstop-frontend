import 'package:flutter/material.dart';
import 'package:nonstop/core/l10n/app_localizations.dart';
import 'package:nonstop/core/theme/app_colors.dart';
import 'package:nonstop/core/theme/app_typography.dart';

/// Message input bar with text field, image attachment button, and send button
///
/// Features:
/// - Multiline text field (expands up to 4 lines)
/// - Camera attachment button
/// - Send button (enabled only when text is present)
/// - SafeArea for bottom insets
/// - Auto-clear after sending
class ChatInputBar extends StatefulWidget {
  final Function(String) onSend;
  final VoidCallback? onAttachmentTap;
  final bool enabled;
  final String? hintText;

  const ChatInputBar({
    super.key,
    required this.onSend,
    this.onAttachmentTap,
    this.enabled = true,
    this.hintText,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final hasText = _controller.text.trim().isNotEmpty;
      if (hasText != _hasText) {
        setState(() => _hasText = hasText);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onSend(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    // Theme-aware colors
    final surfaceColor = colorScheme.surface;
    final surfaceVariantColor = isDarkMode
        ? AppColors.surfaceVariantDark
        : AppColors.surfaceVariant;
    final borderColor = isDarkMode
        ? AppColors.borderDark
        : AppColors.border;
    final iconColor = isDarkMode
        ? AppColors.textSecondaryDark
        : AppColors.textSecondary;
    final hintColor = isDarkMode
        ? AppColors.textTertiaryDark
        : AppColors.textHint;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: surfaceColor,
        border: Border(
          top: BorderSide(
            color: borderColor.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black26 : AppColors.shadowMedium,
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Attachment button (camera icon)
            Container(
              margin: const EdgeInsets.only(bottom: 2),
              decoration: BoxDecoration(
                color: surfaceVariantColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: widget.enabled ? widget.onAttachmentTap : null,
                icon: const Icon(Icons.camera_alt_rounded, size: 22),
                color: iconColor,
                splashRadius: 20,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                ),
              ),
            ),

            const SizedBox(width: 10),

            // Text field
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: surfaceVariantColor,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: borderColor.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: _controller,
                  enabled: widget.enabled,
                  maxLines: 5,
                  minLines: 1,
                  textCapitalization: TextCapitalization.sentences,
                  style: AppTypography.body2.copyWith(
                    fontSize: 15,
                    height: 1.4,
                    letterSpacing: 0.1,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hintText ?? AppLocalizations.of(context).messageHint,
                    hintStyle: AppTypography.body2.copyWith(
                      color: hintColor,
                      fontSize: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                  ),
                  onSubmitted: (_) => _handleSend(),
                ),
              ),
            ),

            const SizedBox(width: 10),

            // Send button with animation
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              tween: Tween(begin: 0.0, end: _hasText ? 1.0 : 0.0),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: 0.85 + (value * 0.15),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 2),
                    decoration: BoxDecoration(
                      gradient: _hasText
                          ? const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: AppColors.primaryGradient,
                            )
                          : null,
                      color: _hasText ? null : surfaceVariantColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: _hasText
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.3 * value),
                                blurRadius: 8 * value,
                                offset: Offset(0, 2 * value),
                              ),
                            ]
                          : null,
                    ),
                    child: IconButton(
                      onPressed: _hasText && widget.enabled ? _handleSend : null,
                      icon: Icon(
                        _hasText ? Icons.send_rounded : Icons.send_outlined,
                        size: 22,
                      ),
                      color: _hasText ? AppColors.textOnPrimary : hintColor,
                      splashRadius: 20,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 44,
                        minHeight: 44,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
