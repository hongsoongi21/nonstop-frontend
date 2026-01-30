import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/forgot_password_provider.dart';
import '../widgets/custom_auth_text_field.dart';
import '../widgets/gradient_button.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleSendEmail() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(forgotPasswordProvider.notifier).sendResetEmail(
          _emailController.text.trim(),
        );
    if (!mounted) return;
    final state = ref.read(forgotPasswordProvider);
    if (state.hasError) {
      _showErrorSnackBar(state.failure?.message ?? 'Xatolik yuz berdi');
    } else if (state.step == ForgotPasswordStep.verification) {
      _showSuccessSnackBar('Tasdiqlash kodi yuborildi!');
    }
  }

  Future<void> _handleVerifyCode() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(forgotPasswordProvider.notifier).verifyCode(
          _codeController.text.trim(),
        );
    if (!mounted) return;
    final state = ref.read(forgotPasswordProvider);
    if (state.hasError) {
      _showErrorSnackBar(state.failure?.message ?? 'Kod noto\'g\'ri');
    } else if (state.step == ForgotPasswordStep.newPassword) {
      _showSuccessSnackBar('Kod tasdiqlandi!');
    }
  }

  Future<void> _handleResetPassword() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(forgotPasswordProvider.notifier).confirmPasswordReset(
          _passwordController.text,
        );
    if (!mounted) return;
    final state = ref.read(forgotPasswordProvider);
    if (state.hasError) {
      _showErrorSnackBar(state.failure?.message ?? 'Xatolik yuz berdi');
    }
  }

  Future<void> _handleResendCode() async {
    await ref.read(forgotPasswordProvider.notifier).resendCode();
    if (!mounted) return;
    final state = ref.read(forgotPasswordProvider);
    if (state.hasError) {
      _showErrorSnackBar(state.failure?.message ?? 'Xatolik yuz berdi');
    } else {
      _showSuccessSnackBar('Kod qayta yuborildi!');
    }
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _handleBack() {
    final state = ref.read(forgotPasswordProvider);
    if (state.step == ForgotPasswordStep.email) {
      context.pop();
    } else {
      ref.read(forgotPasswordProvider.notifier).goBack();
    }
  }

  void _handleComplete() {
    ref.read(forgotPasswordProvider.notifier).reset();
    context.go(Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(forgotPasswordProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFE0DBF8),
              Color(0xFFDEF4EB),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: 40.h,
              left: 16.w,
              right: 16.w,
              bottom: 40.h,
            ),
            child: SingleChildScrollView(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Back button
                      if (state.step != ForgotPasswordStep.complete)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: _handleBack,
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 24.sp,
                              color: const Color(0xFF111827),
                            ),
                          ),
                        ),

                      SizedBox(height: 16.h),

                      // Form container
                      Container(
                        width: 343.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(40.r),
                          border: Border.all(
                            color: const Color(0xFFFFFFFF),
                            width: 1.w,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  const Color(0xFF7C3BEE).withValues(alpha: 0.059),
                              offset: Offset(0, 8.h),
                              blurRadius: 15.r,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 25.h,
                            bottom: 40.h,
                            left: 24.w,
                            right: 24.w,
                          ),
                          child: Form(
                            key: _formKey,
                            child: _buildStepContent(state),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent(ForgotPasswordState state) {
    switch (state.step) {
      case ForgotPasswordStep.email:
        return _buildEmailStep(state);
      case ForgotPasswordStep.verification:
        return _buildVerificationStep(state);
      case ForgotPasswordStep.newPassword:
        return _buildNewPasswordStep(state);
      case ForgotPasswordStep.complete:
        return _buildCompleteStep();
    }
  }

  Widget _buildEmailStep(ForgotPasswordState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 15.h),

        // Icon
        Icon(
          Icons.lock_reset,
          size: 64.sp,
          color: const Color(0xFF7C3BEE),
        ),

        SizedBox(height: 20.h),

        // Title
        Text(
          'Parolni tiklash',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Noto Sans',
            fontWeight: FontWeight.w800,
            fontSize: 24.sp,
            height: 1.0,
            letterSpacing: -0.03 * 24.sp,
            color: const Color(0xFF111827),
          ),
        ),

        SizedBox(height: 12.h),

        // Description
        Text(
          "Ro'yxatdan o'tgan email manzilingizni kiriting",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Noto Sans',
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            height: 1.4,
            letterSpacing: -0.03 * 14.sp,
            color: const Color(0xFF6B7280),
          ),
        ),

        SizedBox(height: 30.h),

        // Email Input
        CustomAuthTextField(
          controller: _emailController,
          hintText: 'Email',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email kiriting';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return "To'g'ri email kiriting";
            }
            return null;
          },
        ),

        SizedBox(height: 24.h),

        // Submit Button
        GradientButton(
          text: "Kod yuborish",
          onPressed: _handleSendEmail,
          isLoading: state.isLoading,
        ),

        // Error Message
        if (state.hasError) ...[
          SizedBox(height: 16.h),
          _buildErrorMessage(state.failure?.message ?? 'Xatolik yuz berdi'),
        ],
      ],
    );
  }

  Widget _buildVerificationStep(ForgotPasswordState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 15.h),

        // Icon
        Icon(
          Icons.mark_email_read_outlined,
          size: 64.sp,
          color: const Color(0xFF7C3BEE),
        ),

        SizedBox(height: 20.h),

        // Title
        Text(
          'Kodni tasdiqlash',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Noto Sans',
            fontWeight: FontWeight.w800,
            fontSize: 24.sp,
            height: 1.0,
            letterSpacing: -0.03 * 24.sp,
            color: const Color(0xFF111827),
          ),
        ),

        SizedBox(height: 12.h),

        // Description
        Text(
          '${state.email} manziliga yuborilgan kodni kiriting',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Noto Sans',
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            height: 1.4,
            letterSpacing: -0.03 * 14.sp,
            color: const Color(0xFF6B7280),
          ),
        ),

        SizedBox(height: 30.h),

        // Code Input
        CustomAuthTextField(
          controller: _codeController,
          hintText: 'Tasdiqlash kodi',
          prefixIcon: Icons.pin_outlined,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Kodni kiriting';
            }
            if (value.length < 4) {
              return "Kod kamida 4 ta raqamdan iborat bo'lishi kerak";
            }
            return null;
          },
        ),

        SizedBox(height: 24.h),

        // Submit Button
        GradientButton(
          text: 'Tasdiqlash',
          onPressed: _handleVerifyCode,
          isLoading: state.isLoading,
        ),

        SizedBox(height: 16.h),

        // Resend Code
        Center(
          child: TextButton(
            onPressed: state.isLoading ? null : _handleResendCode,
            child: Text(
              'Kodni qayta yuborish',
              style: AppTypography.body2.copyWith(
                color: const Color(0xFF7C3BEE),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        // Error Message
        if (state.hasError) ...[
          SizedBox(height: 16.h),
          _buildErrorMessage(state.failure?.message ?? 'Xatolik yuz berdi'),
        ],
      ],
    );
  }

  Widget _buildNewPasswordStep(ForgotPasswordState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 15.h),

        // Icon
        Icon(
          Icons.lock_outline,
          size: 64.sp,
          color: const Color(0xFF7C3BEE),
        ),

        SizedBox(height: 20.h),

        // Title
        Text(
          'Yangi parol',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Noto Sans',
            fontWeight: FontWeight.w800,
            fontSize: 24.sp,
            height: 1.0,
            letterSpacing: -0.03 * 24.sp,
            color: const Color(0xFF111827),
          ),
        ),

        SizedBox(height: 12.h),

        // Description
        Text(
          'Yangi parolingizni kiriting',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Noto Sans',
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            height: 1.4,
            letterSpacing: -0.03 * 14.sp,
            color: const Color(0xFF6B7280),
          ),
        ),

        SizedBox(height: 30.h),

        // New Password Input
        CustomAuthTextField(
          controller: _passwordController,
          hintText: 'Yangi parol',
          prefixIcon: Icons.lock_outline,
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Parol kiriting';
            }
            if (value.length < 8) {
              return "Parol kamida 8 ta belgidan iborat bo'lishi kerak";
            }
            return null;
          },
        ),

        SizedBox(height: 20.h),

        // Confirm Password Input
        CustomAuthTextField(
          controller: _confirmPasswordController,
          hintText: 'Parolni tasdiqlang',
          prefixIcon: Icons.lock_outline,
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Parolni tasdiqlang';
            }
            if (value != _passwordController.text) {
              return 'Parollar mos kelmaydi';
            }
            return null;
          },
        ),

        SizedBox(height: 24.h),

        // Submit Button
        GradientButton(
          text: 'Parolni yangilash',
          onPressed: _handleResetPassword,
          isLoading: state.isLoading,
        ),

        // Error Message
        if (state.hasError) ...[
          SizedBox(height: 16.h),
          _buildErrorMessage(state.failure?.message ?? 'Xatolik yuz berdi'),
        ],
      ],
    );
  }

  Widget _buildCompleteStep() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 15.h),

        // Success Icon
        Icon(
          Icons.check_circle_outline,
          size: 80.sp,
          color: const Color(0xFF10B981),
        ),

        SizedBox(height: 20.h),

        // Title
        Text(
          'Muvaffaqiyatli!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Noto Sans',
            fontWeight: FontWeight.w800,
            fontSize: 24.sp,
            height: 1.0,
            letterSpacing: -0.03 * 24.sp,
            color: const Color(0xFF111827),
          ),
        ),

        SizedBox(height: 12.h),

        // Description
        Text(
          "Parolingiz muvaffaqiyatli o'zgartirildi. Endi yangi parol bilan tizimga kirishingiz mumkin.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Noto Sans',
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            height: 1.4,
            letterSpacing: -0.03 * 14.sp,
            color: const Color(0xFF6B7280),
          ),
        ),

        SizedBox(height: 30.h),

        // Login Button
        GradientButton(
          text: 'Kirish',
          onPressed: _handleComplete,
          isLoading: false,
        ),
      ],
    );
  }

  Widget _buildErrorMessage(String message) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColors.error.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: AppColors.error,
            size: 20.sp,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              message,
              style: AppTypography.body2.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
