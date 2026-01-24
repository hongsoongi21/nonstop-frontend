import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/config/env_config.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_auth_text_field.dart';
import '../widgets/gradient_button.dart';
import '../widgets/language_selector.dart';

class LoginScreenV1 extends ConsumerStatefulWidget {
  const LoginScreenV1({super.key});

  @override
  ConsumerState<LoginScreenV1> createState() => _LoginScreenV1State();
}

class _LoginScreenV1State extends ConsumerState<LoginScreenV1>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: EnvConfig.googleServerClientId,
    scopes: ['email', 'profile'],
  );
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
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    await ref.read(authProvider.notifier).signIn(email, password);

    // Check if widget is still mounted before accessing ref
    if (!mounted) return;

    final authState = ref.read(authProvider);
    if (authState.isAuthenticated && !authState.hasError) {
      if (mounted) {
        context.go(Routes.home);
      }
    }
  }

  Future<void> _handleGoogleLogin() async {
    try {
      // Google Sign-In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final googleIdToken = googleAuth.idToken;
      final googleAccessToken = googleAuth.accessToken;

      if (googleIdToken == null) return;

      // Exchange Google token for a Firebase ID token.
      final credential = GoogleAuthProvider.credential(
        idToken: googleIdToken,
        accessToken: googleAccessToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      final firebaseIdToken = await userCredential.user?.getIdToken(true);

      if (firebaseIdToken == null) return;

      await ref.read(authProvider.notifier).signInWithGoogle(firebaseIdToken);

      if (mounted) {
        final authState = ref.read(authProvider);
        if (authState.isAuthenticated && !authState.hasError) {
          context.go(Routes.home);
        }
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google Sign-In failed: $error')),
        );
      }
    }
  }

  void _handleForgotPassword() {
    // TODO: 비밀번호 찾기 화면으로 이동 필요
  }

  void _handleSignup() {
    context.go(Routes.register);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFE0DBF8), // #E0DBF8
              Color(0xFFDEF4EB), // #DEF4EB
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
                      // Language selector
                      const LanguageSelector(),

                      SizedBox(height: 16.h),

                      // Login form container
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
                              color: const Color(
                                0xFF7C3BEE,
                              ).withValues(alpha: 0.059), // #7C3BEE0F
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
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(height: 15.h),

                                // Title
                                Container(
                                  width: 275.w,
                                  height: 38.h,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Xush Kelibsiz!',
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
                                ),

                                Container(
                                  width: 275.w,
                                  height: 39.h,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Davom etish uchun tizimga kiring',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Noto Sans',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      height: 1.0,
                                      letterSpacing: -0.03 * 14.sp,
                                      color: const Color(0xFF6B7280),
                                    ),
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
                                      return 'Please enter your email';
                                    }
                                    if (!RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                    ).hasMatch(value)) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                ),

                                SizedBox(height: 20.h),

                                // Password Input
                                CustomAuthTextField(
                                  controller: _passwordController,
                                  hintText: 'Password',
                                  prefixIcon: Icons.lock_outline,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    if (value.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }
                                    return null;
                                  },
                                ),

                                SizedBox(height: 12.h),

                                // Forgot Password
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: _handleForgotPassword,
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      'Forgot Password?',
                                      style: AppTypography.body2.copyWith(
                                        color: const Color(
                                          0xFF7C3BEE,
                                        ), // #7C3BEE
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 20.h),

                                // Login Button
                                GradientButton(
                                  text: 'Login',
                                  onPressed: _handleLogin,
                                  isLoading: authState.isLoading,
                                ),

                                SizedBox(height: 24.h),

                                // Divider with text
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // Divider line
                                    Divider(
                                      color: Colors.grey.shade300,
                                      thickness: 1,
                                    ),
                                    // White background container with text
                                    Container(
                                      width: 200.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFFFFF),
                                        borderRadius: BorderRadius.circular(
                                          15.r,
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Yoki ijtimoly tarmoqlar orqali',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Noto Sans',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp,
                                          height: 1.0,
                                          letterSpacing: -0.03 * 12.sp,
                                          color: const Color(0xFF6B7280),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 24.h),

                                // Google Login Button
                                OutlinedButton.icon(
                                  onPressed: _handleGoogleLogin,
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 16.h,
                                      horizontal: 24.w,
                                    ),
                                    side: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 1.w,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.g_mobiledata,
                                    size: 24.sp,
                                    color: Colors.black87,
                                  ),
                                  label: Text(
                                    'Continue with Google',
                                    style: AppTypography.body1.copyWith(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),

                                SizedBox(height: 32.h),

                                // Signup Text
                                Container(
                                  width: 275.w,
                                  alignment: Alignment.center,
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontFamily: 'Noto Sans',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        height: 1.0,
                                        letterSpacing: -0.02 * 14.sp,
                                        color: Colors.black87,
                                      ),
                                      children: [
                                        const TextSpan(
                                          text: "Profiling yo'qmi? ",
                                        ),
                                        WidgetSpan(
                                          child: GestureDetector(
                                            onTap: _handleSignup,
                                            child: Text(
                                              "Ro'yxatdan o'tish",
                                              style: TextStyle(
                                                fontFamily: 'Noto Sans',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.sp,
                                                height: 1.0,
                                                letterSpacing: -0.02 * 14.sp,
                                                color: const Color(0xFF7C3BEE),
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: const Color(
                                                  0xFF7C3BEE,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                SizedBox(height: 2.h),

                                // Error Message
                                if (authState.hasError)
                                  Container(
                                    padding: EdgeInsets.all(12.w),
                                    decoration: BoxDecoration(
                                      color: AppColors.error.withValues(
                                        alpha: 0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(8.r),
                                      border: Border.all(
                                        color: AppColors.error.withValues(
                                          alpha: 0.3,
                                        ),
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
                                            authState.failure?.message ??
                                                'An error occurred',
                                            style: AppTypography.body2.copyWith(
                                              color: AppColors.error,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
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
}
