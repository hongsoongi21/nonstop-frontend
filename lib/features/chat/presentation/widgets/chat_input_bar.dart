import 'package:flutter/material.dart';
import 'package:nonstop/core/l10n/app_localizations.dart';
import 'package:nonstop/core/theme/app_colors.dart';
import 'package:nonstop/core/theme/app_spacing.dart';
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
    return Container(
      padding: EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Attachment button (camera icon)
            IconButton(
              onPressed: widget.enabled ? widget.onAttachmentTap : null,
              icon: const Icon(Icons.camera_alt_outlined),
              color: AppColors.textSecondary,
              splashRadius: 20,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 40,
              ),
            ),

            SizedBox(width: AppSpacing.xs),

            // Text field
            Expanded(
              child: TextField(
                controller: _controller,
                enabled: widget.enabled,
                maxLines: 4,
                minLines: 1,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: widget.hintText ?? AppLocalizations.of(context).messageHint,
                  hintStyle: AppTypography.body2.copyWith(
                    color: AppColors.textHint,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
                onSubmitted: (_) => _handleSend(),
              ),
            ),

            SizedBox(width: AppSpacing.xs),

            // Send button
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: IconButton(
                onPressed: _hasText && widget.enabled ? _handleSend : null,
                icon: const Icon(Icons.send),
                color: _hasText ? AppColors.primary : AppColors.textHint,
                splashRadius: 20,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 40,
                  minHeight: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
