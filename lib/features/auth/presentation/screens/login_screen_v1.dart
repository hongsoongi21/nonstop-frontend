import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/dto/auth_response_dto.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_auth_text_field.dart';

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
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _staggeredAnimation2;
  late Animation<double> _staggeredAnimation3;
  bool _googleSignInInitialized = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Fade animation for the entire form
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    // Slide animation for the form container
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
      ),
    );

    // Staggered animations for form elements
    _staggeredAnimation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 0.9, curve: Curves.easeOut),
      ),
    );

    _staggeredAnimation3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _animationController.forward();
    _initGoogleSignIn();
  }

  Future<void> _initGoogleSignIn() async {
    if (_googleSignInInitialized) return;
    await _googleSignIn.initialize(
      // Firebase project: nonstop-c2aa4 (127473148279)
      serverClientId:
          '127473148279-sa5hnb576mfoceltmfg0d5ih76tegi95.apps.googleusercontent.com',
    );
    _googleSignInInitialized = true;
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
      _showWelcomeSnackbar(authState.user?.nickname);
      // 라우터가 자동으로 board로 리다이렉트합니다
    }
  }

  void _showWelcomeSnackbar(String? nickname) {
    if (!mounted) return;
    final displayName = nickname ?? 'User';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.loginSuccessWelcome(displayName)),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _handleGoogleLogin() async {
    // Store notifier reference before async gap to avoid "ref after dispose" error
    final authNotifier = ref.read(authProvider.notifier);

    try {
      debugPrint('[GOOGLE_LOGIN] Step 1: Initializing Google Sign-In...');
      await _initGoogleSignIn();

      debugPrint('[GOOGLE_LOGIN] Step 2: Calling authenticate()...');
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
      debugPrint('[GOOGLE_LOGIN] Step 3: Got Google user: ${googleUser.email}');

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final googleIdToken = googleAuth.idToken;
      debugPrint('[GOOGLE_LOGIN] Step 4: Google ID Token: ${googleIdToken != null ? "EXISTS (${googleIdToken.length} chars)" : "NULL"}');

      if (googleIdToken == null) {
        debugPrint('[GOOGLE_LOGIN] ERROR: Google ID Token is null! serverClientId may be misconfigured.');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.googleSignInFailed('ID Token is null')),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      // On iOS, Google ID token includes a nonce that Supabase can't verify
      // without an access token. In google_sign_in v7.x, auth and authz are
      // separate - we must use authorizationClient to obtain an access token.
      String? accessToken;
      if (Platform.isIOS) {
        try {
          final authClient = googleUser.authorizationClient;
          // Silent check first
          final clientAuth = await authClient.authorizationForScopes(
            <String>['openid', 'email', 'profile'],
          );
          accessToken = clientAuth?.accessToken;

          if (accessToken == null) {
            // Explicit authorization request (may show prompt)
            final auth = await authClient.authorizeScopes(
              <String>['openid', 'email', 'profile'],
            );
            accessToken = auth.accessToken;
          }
          debugPrint('[GOOGLE_LOGIN] Step 4b: Got accessToken from authorizationClient');
        } catch (e) {
          debugPrint('[GOOGLE_LOGIN] WARNING: authorizationClient failed: $e');
          // On iOS without accessToken, Supabase cannot verify the nonce.
          // Show error and abort.
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context)!.googleSignInFailed('Access token 획득 실패')),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        }
      } else if (Platform.isAndroid) {
        // On Android, get accessToken from authorizationClient as well
        try {
          final authClient = googleUser.authorizationClient;
          final clientAuth = await authClient.authorizationForScopes(
            <String>['openid', 'email', 'profile'],
          );
          accessToken = clientAuth?.accessToken;
        } catch (e) {
          debugPrint('[GOOGLE_LOGIN] Android accessToken not available: $e');
        }
      }

      debugPrint('[GOOGLE_LOGIN] Step 5: Calling Supabase signInWithGoogle... (accessToken: ${accessToken != null ? "YES" : "NO"})');
      await authNotifier.signInWithGoogle(googleIdToken, accessToken: accessToken);

      if (mounted) {
        final authState = ref.read(authProvider);
        debugPrint('[GOOGLE_LOGIN] Step 6: Auth state - isAuthenticated: ${authState.isAuthenticated}, hasError: ${authState.hasError}, hasPendingOAuthSignup: ${authState.hasPendingOAuthSignup}');

        if (authState.hasPendingOAuthSignup) {
          debugPrint('[GOOGLE_LOGIN] New user, redirecting to signup...');
          GoRouter.of(context).go(Routes.register, extra: authState.pendingOAuthSignup);
        } else if (authState.isAuthenticated && !authState.hasError) {
          debugPrint('[GOOGLE_LOGIN] Login successful!');
          _showWelcomeSnackbar(authState.user?.nickname);
        } else if (authState.hasError) {
          debugPrint('[GOOGLE_LOGIN] ERROR from Supabase: ${authState.failure?.message}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(authState.failure?.message ?? AppLocalizations.of(context)!.googleSignInFailed('')),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 5),
            ),
          );
        }
      }
    } on GoogleSignInException catch (e) {
      debugPrint('[GOOGLE_LOGIN] GoogleSignInException: ${e.code} - ${e.description}');
      if (e.code == GoogleSignInExceptionCode.canceled) return;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.googleSignInFailed(e.description ?? '')),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error, stackTrace) {
      debugPrint('[GOOGLE_LOGIN] Exception: $error');
      debugPrint('[GOOGLE_LOGIN] StackTrace: $stackTrace');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.googleSignInFailed(error.toString())),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  /// Generate a random nonce for Apple Sign In
  String _generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  /// Hash the nonce using SHA256
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> _handleAppleLogin() async {
    // Apple Sign In is only available on iOS
    if (!Platform.isIOS) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.appleSignInNotAvailable)),
        );
      }
      return;
    }

    // Store notifier reference before async gap to avoid "ref after dispose" error
    final authNotifier = ref.read(authProvider.notifier);

    try {
      debugPrint('[APPLE_LOGIN] Step 1: Generating nonce...');
      // Generate nonce for security
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      debugPrint('[APPLE_LOGIN] Step 2: Requesting Apple credential...');
      // Request Apple Sign In
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );
      debugPrint('[APPLE_LOGIN] Step 3: Got Apple credential, identityToken: ${appleCredential.identityToken != null ? "EXISTS" : "NULL"}');

      final appleIdToken = appleCredential.identityToken;
      if (appleIdToken == null) {
        debugPrint('[APPLE_LOGIN] ERROR: Apple Identity Token is null!');
        return;
      }

      // Get user name from Apple (only provided on first sign in)
      final firstName = appleCredential.givenName;
      final lastName = appleCredential.familyName;
      debugPrint('[APPLE_LOGIN] Step 4: Name: $firstName $lastName');

      debugPrint('[APPLE_LOGIN] Step 5: Calling Supabase signInWithApple...');
      // Pass Apple Identity Token + rawNonce to Supabase for nonce verification
      await authNotifier.signInWithApple(
        idToken: appleIdToken,
        nonce: rawNonce,
        authorizationCode: appleCredential.authorizationCode,
        firstName: firstName,
        lastName: lastName,
      );

      if (mounted) {
        final authState = ref.read(authProvider);
        debugPrint('[APPLE_LOGIN] Step 9: Auth state - isAuthenticated: ${authState.isAuthenticated}, hasError: ${authState.hasError}, hasPendingOAuthSignup: ${authState.hasPendingOAuthSignup}');

        if (authState.hasPendingOAuthSignup) {
          // 신규 사용자: 회원가입 화면으로 이동
          debugPrint('[APPLE_LOGIN] Step 10: New user, redirecting to signup...');
          GoRouter.of(context).go(Routes.register, extra: authState.pendingOAuthSignup);
        } else if (authState.isAuthenticated && !authState.hasError) {
          debugPrint('[APPLE_LOGIN] Step 10: Login successful, router will redirect...');
          _showWelcomeSnackbar(authState.user?.nickname);
          // 라우터가 자동으로 board로 리다이렉트합니다
        }
      }
    } on SignInWithAppleAuthorizationException catch (e) {
      debugPrint('[APPLE_LOGIN] SignInWithAppleAuthorizationException: ${e.code} - ${e.message}');
      // User cancelled the sign-in
      if (e.code == AuthorizationErrorCode.canceled) return;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.appleSignInFailed(e.message))),
        );
      }
    } catch (error, stackTrace) {
      debugPrint('[APPLE_LOGIN] Exception: $error');
      debugPrint('[APPLE_LOGIN] StackTrace: $stackTrace');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.appleSignInFailed(error.toString()))),
        );
      }
    }
  }

  void _handleForgotPassword() {
    GoRouter.of(context).push(Routes.forgotPassword);
  }

  void _handleSignup() {
    GoRouter.of(context).go(Routes.register);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.hasError && !(previous?.hasError ?? false)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              next.failure?.message ?? AppLocalizations.of(context)!.errorOccurred,
            ),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.primaryGradient,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: 24.h,
              left: 16.w,
              right: 16.w,
              bottom: 24.h,
            ),
            child: SingleChildScrollView(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 40.h),

                        // Login form container
                        FadeTransition(
                          opacity: _staggeredAnimation2,
                          child: Container(
                            width: 343.w,
                            decoration: BoxDecoration(
                              color: context.surfaceColor,
                              borderRadius: BorderRadius.circular(32.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.shadowStrong,
                                  offset: Offset(0, 12.h),
                                  blurRadius: 32.r,
                                  spreadRadius: -4.r,
                                ),
                                BoxShadow(
                                  color: AppColors.primaryDark
                                      .withValues(alpha: 0.1),
                                  offset: Offset(0, 4.h),
                                  blurRadius: 16.r,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 28.w,
                                vertical: 40.h,
                              ),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    // Title
                                    Text(
                                      'Nonstop',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Noto Sans',
                                        fontWeight: FontWeight.w800,
                                        fontSize: 28.sp,
                                        height: 1.2,
                                        letterSpacing: -0.02 * 28.sp,
                                        color: context.textPrimaryColor,
                                      ),
                                    ),

                                    SizedBox(height: 8.h),

                                    Text(
                                      AppLocalizations.of(context)!.loginToContinue,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Noto Sans',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.sp,
                                        height: 1.4,
                                        letterSpacing: -0.01 * 15.sp,
                                        color: context.textSecondaryColor,
                                      ),
                                    ),

                                    SizedBox(height: 32.h),

                                    // Email Input
                                    CustomAuthTextField(
                                      controller: _emailController,
                                      hintText: AppLocalizations.of(context)!.email,
                                      prefixIcon: Icons.email_outlined,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return AppLocalizations.of(context)!.validationEmailRequired;
                                        }
                                        if (!RegExp(
                                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                        ).hasMatch(value)) {
                                          return AppLocalizations.of(context)!.validationEmailInvalid;
                                        }
                                        return null;
                                      },
                                    ),

                                    SizedBox(height: 16.h),

                                    // Password Input
                                    CustomAuthTextField(
                                      controller: _passwordController,
                                      hintText: AppLocalizations.of(context)!.password,
                                      prefixIcon: Icons.lock_outline,
                                      obscureText: true,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return AppLocalizations.of(context)!.validationPasswordRequired;
                                        }
                                        if (value.length < 6) {
                                          return AppLocalizations.of(context)!.validationPasswordMin6;
                                        }
                                        return null;
                                      },
                                    ),

                                    SizedBox(height: 16.h),

                                    // Forgot Password
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: _handleForgotPassword,
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 4.w,
                                            vertical: 4.h,
                                          ),
                                          minimumSize: Size.zero,
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          foregroundColor: AppColors.primary,
                                          overlayColor: AppColors.primary
                                              .withValues(alpha: 0.1),
                                        ),
                                        child: Text(
                                          AppLocalizations.of(context)!.forgotPassword,
                                          style: TextStyle(
                                            fontFamily: 'Noto Sans',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.sp,
                                            height: 1.4,
                                            letterSpacing: -0.01 * 14.sp,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 24.h),

                                    // Login Button
                                    Container(
                                      height: 56.h,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: AppColors.primaryGradient,
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.primary
                                                .withValues(alpha: 0.3),
                                            offset: Offset(0, 4.h),
                                            blurRadius: 12.r,
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                      child: ElevatedButton(
                                        onPressed: authState.isLoading
                                            ? null
                                            : _handleLogin,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Colors.white,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.r),
                                          ),
                                          padding: EdgeInsets.zero,
                                        ),
                                        child: authState.isLoading
                                            ? SizedBox(
                                                width: 24.w,
                                                height: 24.h,
                                                child:
                                                    const CircularProgressIndicator(
                                                  strokeWidth: 2.5,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(Colors.white),
                                                ),
                                              )
                                            : Text(
                                                AppLocalizations.of(context)!.login,
                                                style: TextStyle(
                                                  fontFamily: 'Noto Sans',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.sp,
                                                  height: 1.4,
                                                  letterSpacing: 0.01 * 16.sp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                      ),
                                    ),

                                    SizedBox(height: 24.h),

                                    // Divider with text
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 1.h,
                                            color: context.borderColor,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 16.w,
                                          ),
                                          child: Text(
                                            AppLocalizations.of(context)!.orSocialMedia,
                                            style: TextStyle(
                                              fontFamily: 'Noto Sans',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13.sp,
                                              height: 1.4,
                                              letterSpacing: -0.01 * 13.sp,
                                              color: context.textTertiaryColor,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 1.h,
                                            color: context.borderColor,
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 24.h),

                                    // Google Login Button
                                    Container(
                                      height: 56.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                        border: Border.all(
                                          color: context.borderColor,
                                          width: 1.5.w,
                                        ),
                                      ),
                                      child: OutlinedButton(
                                        onPressed: _handleGoogleLogin,
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: context.surfaceColor,
                                          foregroundColor:
                                              context.textPrimaryColor,
                                          side: BorderSide.none,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.r),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 24.w,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // Google Icon (using custom SVG or icon)
                                            Container(
                                              width: 24.w,
                                              height: 24.h,
                                              decoration: BoxDecoration(
                                                color: context.surfaceColor,
                                                borderRadius:
                                                    BorderRadius.circular(4.r),
                                              ),
                                              child: Icon(
                                                Icons.g_mobiledata,
                                                size: 28.sp,
                                                color: AppColors.google,
                                              ),
                                            ),
                                            SizedBox(width: 12.w),
                                            Text(
                                              AppLocalizations.of(context)!.continueWithGoogle,
                                              style: TextStyle(
                                                fontFamily: 'Noto Sans',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15.sp,
                                                height: 1.4,
                                                letterSpacing: -0.01 * 15.sp,
                                                color: context.textPrimaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Apple Login Button (iOS only)
                                    if (Platform.isIOS) ...[
                                      SizedBox(height: 12.h),
                                      Container(
                                        height: 56.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                          color: Colors.black,
                                        ),
                                        child: ElevatedButton(
                                          onPressed: _handleAppleLogin,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 24.w,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // Apple Icon
                                              Icon(
                                                Icons.apple,
                                                size: 24.sp,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 12.w),
                                              Text(
                                                AppLocalizations.of(context)!.continueWithApple,
                                                style: TextStyle(
                                                  fontFamily: 'Noto Sans',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15.sp,
                                                  height: 1.4,
                                                  letterSpacing: -0.01 * 15.sp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],

                                    SizedBox(height: 28.h),

                                    // Signup Text
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.noAccount,
                                          style: TextStyle(
                                            fontFamily: 'Noto Sans',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp,
                                            height: 1.4,
                                            letterSpacing: -0.01 * 14.sp,
                                            color: context.textSecondaryColor,
                                          ),
                                        ),
                                        SizedBox(width: 4.w),
                                        TextButton(
                                          onPressed: _handleSignup,
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8.w,
                                              vertical: 4.h,
                                            ),
                                            minimumSize: Size.zero,
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                            foregroundColor: AppColors.primary,
                                            overlayColor: AppColors.primary
                                                .withValues(alpha: 0.1),
                                          ),
                                          child: Text(
                                            AppLocalizations.of(context)!.signUpLink,
                                            style: TextStyle(
                                              fontFamily: 'Noto Sans',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14.sp,
                                              height: 1.4,
                                              letterSpacing: -0.01 * 14.sp,
                                              color: AppColors.primary,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor:
                                                  AppColors.primary,
                                              decorationThickness: 2.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
      ),
    );
  }
}
