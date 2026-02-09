import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../features/report/data/api/report_api_impl.dart';
import '../../features/report/data/dto/report_dto.dart';
import '../../core/l10n/app_localizations.dart';

/// Report target type for the dialog
enum ReportTargetType {
  post,
  comment,
  user,
  chatMessage,
}

/// Provider for report submission
final reportSubmissionProvider = FutureProvider.family<void, _ReportSubmission>(
  (ref, submission) async {
    final reportApi = ref.read(reportApiProvider);

    final result = switch (submission.targetType) {
      ReportTargetType.post => await reportApi.reportPost(
          postId: submission.targetId,
          request: submission.request,
        ),
      ReportTargetType.comment => await reportApi.reportComment(
          commentId: submission.targetId,
          request: submission.request,
        ),
      ReportTargetType.user => await reportApi.reportUser(
          userId: submission.targetId,
          request: submission.request,
        ),
      ReportTargetType.chatMessage => await reportApi.reportChatMessage(
          messageId: submission.targetId,
          request: submission.request,
        ),
    };

    result.fold(
      (error) => throw error,
      (_) => null,
    );
  },
);

/// Internal class for report submission data
class _ReportSubmission {
  final ReportTargetType targetType;
  final int targetId;
  final ReportRequestDto request;

  const _ReportSubmission({
    required this.targetType,
    required this.targetId,
    required this.request,
  });
}

/// Shows a report dialog and returns true if submitted, false if cancelled
///
/// Example usage:
/// ```dart
/// // Report a post
/// final submitted = await showReportDialog(
///   context: context,
///   targetType: ReportTargetType.post,
///   targetId: postId,
/// );
///
/// // Report a comment
/// final submitted = await showReportDialog(
///   context: context,
///   targetType: ReportTargetType.comment,
///   targetId: commentId,
/// );
///
/// // Report a user
/// final submitted = await showReportDialog(
///   context: context,
///   targetType: ReportTargetType.user,
///   targetId: userId,
/// );
///
/// // Report a chat message
/// final submitted = await showReportDialog(
///   context: context,
///   targetType: ReportTargetType.chatMessage,
///   targetId: messageId,
/// );
/// ```
Future<bool> showReportDialog({
  required BuildContext context,
  required ReportTargetType targetType,
  required int targetId,
}) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => _ReportDialogContent(
      targetType: targetType,
      targetId: targetId,
    ),
  );

  return result ?? false;
}

/// Internal widget for report dialog content
class _ReportDialogContent extends ConsumerStatefulWidget {
  final ReportTargetType targetType;
  final int targetId;

  const _ReportDialogContent({
    required this.targetType,
    required this.targetId,
  });

  @override
  ConsumerState<_ReportDialogContent> createState() =>
      _ReportDialogContentState();
}

class _ReportDialogContentState extends ConsumerState<_ReportDialogContent> {
  ReportReasonType? _selectedReason;
  final _descriptionController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitReport() async {
    if (_selectedReason == null) return;

    setState(() => _isSubmitting = true);

    try {
      final submission = _ReportSubmission(
        targetType: widget.targetType,
        targetId: widget.targetId,
        request: ReportRequestDto(
          reason: _selectedReason!,
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
        ),
      );

      await ref.read(reportSubmissionProvider(submission).future);

      if (mounted) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).reportSuccess),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);

        // Check if it's an "already reported" error
        final errorMessage = e.toString().toLowerCase();
        final isAlreadyReported = errorMessage.contains('already') ||
                                   errorMessage.contains('duplicate');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isAlreadyReported
                  ? AppLocalizations.of(context).reportAlreadyReported
                  : AppLocalizations.of(context).errorOccurred,
            ),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSpacing.radiusXl),
          topRight: Radius.circular(AppSpacing.radiusXl),
        ),
      ),
      padding: EdgeInsets.only(bottom: keyboardHeight),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(l10n),
            _buildReasonList(l10n),
            if (_selectedReason == ReportReasonType.etc)
              _buildDescriptionField(l10n),
            _buildSubmitButton(l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.border,
            width: AppSpacing.borderWidth,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.report_outlined,
            color: AppColors.error,
            size: 24,
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              l10n.report,
              style: AppTypography.headline5.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: AppColors.textSecondary),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      ),
    );
  }

  Widget _buildReasonList(AppLocalizations l10n) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      children: [
        Text(
          l10n.reportReason,
          style: AppTypography.subtitle2.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: AppSpacing.md),
        _buildReasonTile(ReportReasonType.spam, l10n.reportReasonSpam),
        _buildReasonTile(ReportReasonType.abuse, l10n.reportReasonAbuse),
        _buildReasonTile(ReportReasonType.sexual, l10n.reportReasonSexual),
        _buildReasonTile(ReportReasonType.hate, l10n.reportReasonHate),
        _buildReasonTile(ReportReasonType.illegal, l10n.reportReasonIllegal),
        _buildReasonTile(ReportReasonType.privacy, l10n.reportReasonPrivacy),
        _buildReasonTile(
          ReportReasonType.impersonation,
          l10n.reportReasonImpersonation,
        ),
        _buildReasonTile(ReportReasonType.etc, l10n.reportReasonOther),
      ],
    );
  }

  Widget _buildReasonTile(ReportReasonType reason, String label) {
    final isSelected = _selectedReason == reason;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Material(
        color: isSelected ? AppColors.primary.withAlpha(20) : Colors.transparent,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: InkWell(
          onTap: () => setState(() => _selectedReason = reason),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.border,
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Row(
              children: [
                Icon(
                  isSelected
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: isSelected ? AppColors.primary : AppColors.textTertiary,
                  size: 20,
                ),
                SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    label,
                    style: AppTypography.body2.copyWith(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textPrimary,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionField(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: TextField(
        controller: _descriptionController,
        maxLines: 3,
        maxLength: 500,
        decoration: InputDecoration(
          hintText: l10n.reportDescription,
          hintStyle: AppTypography.body2.copyWith(
            color: AppColors.textTertiary,
          ),
          filled: true,
          fillColor: AppColors.surfaceVariant,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            borderSide: BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            borderSide: BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
        style: AppTypography.body2.copyWith(color: AppColors.textPrimary),
      ),
    );
  }

  Widget _buildSubmitButton(AppLocalizations l10n) {
    final isEnabled = _selectedReason != null && !_isSubmitting;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: isEnabled ? _submitReport : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.error,
            disabledBackgroundColor: AppColors.border,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            elevation: 0,
          ),
          child: _isSubmitting
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  l10n.reportSubmit,
                  style: AppTypography.button.copyWith(
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
