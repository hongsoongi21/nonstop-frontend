import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';

/// University verification screen with student ID and email verification tabs
class VerificationScreen extends ConsumerStatefulWidget {
  const VerificationScreen({super.key});

  @override
  ConsumerState<VerificationScreen> createState() =>
      _VerificationScreenState();
}

class _VerificationScreenState extends ConsumerState<VerificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  final _imagePicker = ImagePicker();

  // Student ID verification state
  XFile? _selectedImage;
  VerificationStatus _studentIdStatus = VerificationStatus.notVerified;

  // Email verification state
  bool _codeSent = false;
  Timer? _countdownTimer;
  int _remainingSeconds = 300; // 5 minutes
  VerificationStatus _emailStatus = VerificationStatus.notVerified;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _codeController.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }

  // Student ID verification methods
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = image;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick image: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _showImageSourceDialog() {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(l10n.takePhoto),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(l10n.chooseFromGallery),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitStudentId() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.selectImage),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    setState(() {
      _studentIdStatus = VerificationStatus.pending;
    });

    // TODO: Implement API call to submit student ID
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.verificationPending),
          backgroundColor: AppColors.info,
        ),
      );
    }
  }

  // Email verification methods
  Future<void> _sendVerificationCode() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your school email'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    // TODO: Implement API call to send verification code
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _codeSent = true;
      _remainingSeconds = 300;
    });

    _startCountdown();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.codeSent),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
        setState(() {
          _codeSent = false;
        });
      }
    });
  }

  Future<void> _verifyCode() async {
    final code = _codeController.text.trim();
    if (code.isEmpty || code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid 6-digit code'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    // TODO: Implement API call to verify code
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _emailStatus = VerificationStatus.approved;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.verificationSuccess),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.universityVerification,
          style: AppTypography.headline5.copyWith(
            fontWeight: FontWeight.w600,
            color: context.textPrimaryColor,
          ),
        ),
        backgroundColor: context.surfaceColor,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: context.textSecondaryColor,
          labelStyle: AppTypography.subtitle1,
          unselectedLabelStyle: AppTypography.subtitle2,
          indicatorColor: AppColors.primary,
          tabs: [
            Tab(text: l10n.studentIdVerification),
            Tab(text: l10n.emailVerification),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildStatusBanner(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildStudentIdTab(l10n),
                _buildEmailTab(l10n),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBanner() {
    final isVerified = _studentIdStatus == VerificationStatus.approved ||
        _emailStatus == VerificationStatus.approved;

    if (!isVerified) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.warning.withValues(alpha: 0.1),
          border: Border(
            bottom: BorderSide(
              color: AppColors.warning.withValues(alpha: 0.3),
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: AppColors.warning,
              size: 20,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                AppLocalizations.of(context)!.universityVerificationRequired,
                style: AppTypography.body2.copyWith(
                  color: context.textPrimaryColor,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.1),
        border: Border(
          bottom: BorderSide(
            color: AppColors.success.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            color: AppColors.success,
            size: 20,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.verificationApproved,
              style: AppTypography.body2.copyWith(
                color: AppColors.success,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentIdTab(AppLocalizations l10n) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.uploadStudentId,
            style: AppTypography.headline5.copyWith(
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Take a photo or upload your student ID card for verification',
            style: AppTypography.body2.copyWith(
              color: context.textSecondaryColor,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Image preview or placeholder
          GestureDetector(
            onTap: _showImageSourceDialog,
            child: Container(
              height: 240,
              decoration: BoxDecoration(
                color: context.surfaceVariantColor,
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                border: Border.all(
                  color: context.borderColor,
                  width: 2,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
              ),
              child: _selectedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                      child: Image.file(
                        File(_selectedImage!.path),
                        fit: BoxFit.cover,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 64,
                          color: context.textTertiaryColor,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          l10n.selectImage,
                          style: AppTypography.body1.copyWith(
                            color: context.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Select image button
          OutlinedButton.icon(
            onPressed: _showImageSourceDialog,
            icon: const Icon(Icons.image),
            label: Text(l10n.selectImage),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Submit button
          AppButton(
            text: l10n.submitVerification,
            onPressed: _submitStudentId,
            isLoading: _studentIdStatus == VerificationStatus.pending,
            size: ButtonSize.large,
          ),

          const SizedBox(height: AppSpacing.lg),

          // Status message
          if (_studentIdStatus == VerificationStatus.pending)
            _buildStatusCard(
              icon: Icons.hourglass_empty,
              color: AppColors.info,
              message: l10n.verificationPending,
            ),
          if (_studentIdStatus == VerificationStatus.approved)
            _buildStatusCard(
              icon: Icons.check_circle,
              color: AppColors.success,
              message: l10n.verificationApproved,
            ),
        ],
      ),
    );
  }

  Widget _buildEmailTab(AppLocalizations l10n) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.emailVerification,
            style: AppTypography.headline5.copyWith(
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Enter your university email address to receive a verification code',
            style: AppTypography.body2.copyWith(
              color: context.textSecondaryColor,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Email input
          AppTextField(
            controller: _emailController,
            labelText: l10n.schoolEmail,
            hintText: '@university.ac.kr',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.email_outlined),
            enabled: !_codeSent,
          ),

          const SizedBox(height: AppSpacing.lg),

          // Send code button
          AppButton(
            text: l10n.sendVerificationCode,
            onPressed: _codeSent ? null : _sendVerificationCode,
            size: ButtonSize.large,
            variant: ButtonVariant.outline,
          ),

          if (_codeSent) ...[
            const SizedBox(height: AppSpacing.xl),

            // Verification code input
            AppTextField(
              controller: _codeController,
              labelText: l10n.enterVerificationCode,
              hintText: '000000',
              keyboardType: TextInputType.number,
              prefixIcon: const Icon(Icons.pin_outlined),
              maxLength: 6,
            ),

            const SizedBox(height: AppSpacing.md),

            // Timer
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.timer_outlined,
                  size: 16,
                  color: context.textSecondaryColor,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '${l10n.timeRemaining}: ${_formatTime(_remainingSeconds)}',
                  style: AppTypography.body2.copyWith(
                    color: context.textSecondaryColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.lg),

            // Verify button
            AppButton(
              text: l10n.verifyCode,
              onPressed: _verifyCode,
              size: ButtonSize.large,
            ),
          ],

          const SizedBox(height: AppSpacing.lg),

          // Status message
          if (_emailStatus == VerificationStatus.approved)
            _buildStatusCard(
              icon: Icons.check_circle,
              color: AppColors.success,
              message: l10n.verificationSuccess,
            ),
        ],
      ),
    );
  }

  Widget _buildStatusCard({
    required IconData icon,
    required Color color,
    required String message,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              message,
              style: AppTypography.body2.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum VerificationStatus {
  notVerified,
  pending,
  approved,
}
