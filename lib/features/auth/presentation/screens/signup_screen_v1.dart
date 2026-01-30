import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/policy.dart';
import '../../domain/entities/university.dart';
import '../providers/auth_provider.dart';
import '../providers/policy_provider.dart';
import '../providers/university_provider.dart';
import '../widgets/custom_auth_text_field.dart';
import '../widgets/gradient_button.dart';
import '../widgets/language_selector.dart';

class SignupScreenV1 extends ConsumerStatefulWidget {
  const SignupScreenV1({super.key});

  @override
  ConsumerState<SignupScreenV1> createState() => _SignupScreenV1State();
}

class _SignupScreenV1State extends ConsumerState<SignupScreenV1> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  final _verificationCodeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  int? _selectedUniversityId;
  DateTime? _selectedBirthDate;

  // 동의한 정책 ID들을 저장하는 Set
  final Set<int> _agreedPolicyIds = {};

  // 타이머 관련 변수
  Timer? _verificationTimer;
  int _remainingSeconds = 300; // 5분

  @override
  void dispose() {
    _nicknameController.dispose();
    _emailController.dispose();
    _verificationCodeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _verificationTimer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _verificationTimer?.cancel();
    setState(() {
      _remainingSeconds = 300;
    });
    _verificationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _verificationTimer?.cancel();
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _handleAllAgreedChanged(bool? value, List<Policy> policies) {
    setState(() {
      if (value == true) {
        _agreedPolicyIds.addAll(policies.map((p) => p.id));
      } else {
        _agreedPolicyIds.clear();
      }
    });
  }

  void _handlePolicyToggle(int policyId, bool value) {
    setState(() {
      if (value) {
        _agreedPolicyIds.add(policyId);
      } else {
        _agreedPolicyIds.remove(policyId);
      }
    });
  }

  Future<void> _handleViewPolicy(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Could not launch $urlString'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error launching URL: $e'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<void> _handleSignup() async {
    // 1. 클라이언트 측 유효성 검사 (입력 형식 등)
    if (!_formKey.currentState!.validate()) return;

    // 2. 정책 로드 상태 확인 및 필수 약관 동의 검사
    final policiesAsync = ref.read(policiesProvider);
    
    // 데이터가 아직 로드되지 않았거나 에러인 경우 처리
    if (!policiesAsync.hasValue) {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please wait for policies to load'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final policies = policiesAsync.value!;
    final mandatoryPolicies = policies.where((p) => p.isMandatory);
    final isAllMandatoryAgreed = mandatoryPolicies.every((p) => _agreedPolicyIds.contains(p.id));

    if (!isAllMandatoryAgreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Majburiy shartlarni qabul qiling'),
          backgroundColor: AppColors.error,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // 3. 대학교 선택 여부 확인
    if (_selectedUniversityId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Universitetni tanlang'),
          backgroundColor: AppColors.error,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // 4. 생년월일 검증
    if (_selectedBirthDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('생년월일을 선택해주세요'),
          backgroundColor: AppColors.error,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // 5. 이메일 인증 여부 확인
    final authState = ref.read(authProvider);
    if (!authState.isEmailVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Iltimos, avval pochtangizni tasdiqlang'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // 5. 회원가입 프로세스 실행
    await ref.read(authProvider.notifier).signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          nickname: _nicknameController.text.trim(),
          birthDate: _selectedBirthDate!,
          universityId: _selectedUniversityId,
          agreedPolicyIds: _agreedPolicyIds.toList(),
        );

    // 위젯이 마운트된 상태인지 확인
    if (!mounted) return;

    // 6. 실행 결과에 따른 처리
    if (authState.hasError) {
      // 실패 시 에러 메시지 노출
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authState.failure?.message ?? '회원가입 실패'),
          backgroundColor: AppColors.error,
        ),
      );
    } else if (authState.isAuthenticated) {
      // 가입 시 정책 동의가 함께 처리되므로 즉시 홈 화면으로 이동
      if (mounted) {
        context.go(Routes.home);
      }
    }
  }

  Future<void> _handleSendVerification() async {
    final email = _emailController.text.trim();
    if (email.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    await ref.read(authProvider.notifier).sendVerificationEmail(email);
    
    if (mounted) {
      final authState = ref.read(authProvider);
      if (authState.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authState.failure?.message ?? 'Failed to send code'),
            backgroundColor: AppColors.error,
          ),
        );
      } else {
        _startTimer(); // 타이머 시작
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Verification code sent!'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    }
  }

  Future<void> _handleVerifyCode() async {
    final code = _verificationCodeController.text.trim();
    if (code.isEmpty) return;
    
    await ref.read(authProvider.notifier).verifyEmail(code);
    
    if (mounted) {
      final authState = ref.read(authProvider);
      if (authState.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authState.failure?.message ?? 'Invalid code'),
            backgroundColor: AppColors.error,
          ),
        );
      } else if (authState.isEmailVerified) {
        _verificationTimer?.cancel(); // 인증 성공 시 타이머 정지
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email verified successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    }
  }

  void _handleLogin() {
    context.go(Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    // 로딩 상태 및 대학 목록 데이터를 Watch 합니다.
    final authState = ref.watch(authProvider);
    final isLoading = authState.isLoading;
    final universitiesAsync = ref.watch(universitiesProvider);
    // 정책 목록 데이터를 Watch 합니다.
    final policiesAsync = ref.watch(policiesProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.backgroundGradient,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.md.w,
                    vertical: AppSpacing.xl.h,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // 언어 선택기
                        const LanguageSelector(),

                        SizedBox(height: AppSpacing.md.h),

                        // 메인 회원가입 폼 컨테이너
                        Container(
                          width: 343.w,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(AppSpacing.radiusXxl.r),
                            border: Border.all(
                              color: AppColors.border,
                              width: AppSpacing.borderWidth.w,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadowMedium,
                                offset: Offset(0, 4.h),
                                blurRadius: 20.r,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(AppSpacing.lg.w),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(height: AppSpacing.sm.h),

                                  // 헤더 타이틀
                                  _buildHeader(),

                                  SizedBox(height: AppSpacing.lg.h),

                                  // 닉네임 입력 필드
                                  CustomAuthTextField(
                                    controller: _nicknameController,
                                    hintText: 'Nickname',
                                    prefixIcon: Icons.person_outline,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your nickname';
                                      }
                                      if (value.length < 2 || value.length > 20) {
                                        return 'Nickname must be 2-20 characters';
                                      }
                                      return null;
                                    },
                                  ),

                                  SizedBox(height: AppSpacing.md.h),

                                  // 대학교 선택 드롭다운
                                  _buildUniversityDropdown(universitiesAsync),

                                  SizedBox(height: AppSpacing.md.h),

                                  // 생년월일 선택
                                  _buildBirthDatePicker(),

                                  SizedBox(height: AppSpacing.md.h),

                                  // 이메일 입력 필드 및 인증 버튼
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: CustomAuthTextField(
                                          controller: _emailController,
                                          hintText: 'Email',
                                          prefixIcon: Icons.email_outlined,
                                          keyboardType: TextInputType.emailAddress,
                                          readOnly: authState.isEmailVerified,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter your email';
                                            }
                                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                                .hasMatch(value)) {
                                              return 'Please enter a valid email';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      if (!authState.isEmailVerified) ...[
                                        SizedBox(width: AppSpacing.sm.w),
                                        SizedBox(
                                          height: 55.h,
                                          child: ElevatedButton(
                                            onPressed: isLoading ? null : _handleSendVerification,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColors.primaryLight,
                                              foregroundColor: AppColors.textOnPrimary,
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(AppSpacing.radiusMd.r),
                                              ),
                                              padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
                                            ),
                                            child: Text(
                                              authState.isEmailVerificationSent ? 'Resend' : 'Send',
                                              style: AppTypography.buttonSmall.copyWith(
                                                color: AppColors.textOnPrimary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),

                                  if (authState.isEmailVerificationSent && !authState.isEmailVerified) ...[
                                    SizedBox(height: AppSpacing.md.h),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: CustomAuthTextField(
                                            controller: _verificationCodeController,
                                            hintText: '6-digit code',
                                            prefixIcon: Icons.lock_clock_outlined,
                                            keyboardType: TextInputType.number,
                                            suffix: Text(
                                              _formatTime(_remainingSeconds),
                                              style: AppTypography.caption.copyWith(
                                                color: AppColors.error,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: AppSpacing.sm.w),
                                        SizedBox(
                                          height: 55.h,
                                          child: ElevatedButton(
                                            onPressed: isLoading ? null : _handleVerifyCode,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColors.success,
                                              foregroundColor: AppColors.textOnPrimary,
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(AppSpacing.radiusMd.r),
                                              ),
                                              padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
                                            ),
                                            child: Text(
                                              'Verify',
                                              style: AppTypography.buttonSmall.copyWith(
                                                color: AppColors.textOnPrimary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],

                                  if (authState.isEmailVerified)
                                    Padding(
                                      padding: EdgeInsets.only(top: AppSpacing.sm.h),
                                      child: Row(
                                        children: [
                                          Icon(Icons.check_circle, color: AppColors.success, size: AppSpacing.iconSm.sp),
                                          SizedBox(width: AppSpacing.xs.w),
                                          Text(
                                            'Email verified',
                                            style: AppTypography.caption.copyWith(
                                              color: AppColors.success,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  SizedBox(height: AppSpacing.md.h),

                                  // 비밀번호 입력 필드
                                  CustomAuthTextField(
                                    controller: _passwordController,
                                    hintText: 'Password',
                                    prefixIcon: Icons.lock_outline,
                                    obscureText: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      if (value.length < 8) {
                                        return 'Password must be at least 8 characters';
                                      }
                                      return null;
                                    },
                                  ),

                                  SizedBox(height: AppSpacing.md.h),

                                  // 비밀번호 확인 필드
                                  CustomAuthTextField(
                                    controller: _confirmPasswordController,
                                    hintText: 'Confirm Password',
                                    prefixIcon: Icons.lock_outline,
                                    obscureText: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please confirm your password';
                                      }
                                      if (value != _passwordController.text) {
                                        return 'Passwords do not match';
                                      }
                                      return null;
                                    },
                                  ),

                                  SizedBox(height: AppSpacing.lg.h),

                                  // 약관 동의 섹션 (API 데이터 기반)
                                  _buildPolicyAgreementSection(policiesAsync),

                                  SizedBox(height: AppSpacing.lg.h),

                                  // 가입하기 버튼
                                  GradientButton(
                                    text: "Ro'yxatdan o'tish",
                                    onPressed: isLoading ? null : _handleSignup,
                                  ),

                                  SizedBox(height: AppSpacing.lg.h),

                                  // 로그인 링크
                                  _buildLoginLink(),
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
              // API 통신 중 로딩 인디케이터 표시
              if (isLoading)
                Container(
                  color: Colors.black26,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          "Ro'yxatdan o'tish",
          textAlign: TextAlign.center,
          style: AppTypography.headline2.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppSpacing.xs.h),
        Text(
          "Ma'lumotlaringizni kiriting",
          textAlign: TextAlign.center,
          style: AppTypography.body2.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildUniversityDropdown(AsyncValue<List<University>> universitiesAsync) {
    return Container(
      width: 275.w,
      height: 55.h,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd.r),
        border: Border.all(
          color: AppColors.border,
          width: AppSpacing.borderWidth.w,
        ),
      ),
      child: universitiesAsync.when(
        data: (universities) => DropdownButtonFormField<int>(
          initialValue: _selectedUniversityId,
          decoration: InputDecoration(
            hintText: 'Select University',
            hintStyle: AppTypography.body2.copyWith(
              color: AppColors.textHint,
            ),
            prefixIcon: Icon(
              Icons.school_outlined,
              color: AppColors.primary,
              size: AppSpacing.iconMd.sp,
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md.w,
              vertical: AppSpacing.md.h,
            ),
          ),
          icon: Padding(
            padding: EdgeInsets.only(right: AppSpacing.sm.w),
            child: Icon(
              Icons.arrow_drop_down,
              color: AppColors.primary,
              size: AppSpacing.iconLg.sp,
            ),
          ),
          style: AppTypography.body2.copyWith(
            color: AppColors.textPrimary,
          ),
          dropdownColor: AppColors.surface,
          isExpanded: true,
          items: universities.map((University university) {
            return DropdownMenuItem<int>(
              value: university.id,
              child: Text(
                university.name,
                style: AppTypography.body2.copyWith(
                  color: AppColors.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: (int? value) {
            setState(() {
              _selectedUniversityId = value;
            });
          },
        ),
        loading: () => Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.primary,
            )),
        error: (err, stack) =>
            Center(child: Icon(Icons.error_outline, color: AppColors.error)),
      ),
    );
  }

  Widget _buildBirthDatePicker() {
    final formattedDate = _selectedBirthDate != null
        ? '${_selectedBirthDate!.year}-${_selectedBirthDate!.month.toString().padLeft(2, '0')}-${_selectedBirthDate!.day.toString().padLeft(2, '0')}'
        : null;

    return GestureDetector(
      onTap: _selectBirthDate,
      child: Container(
        width: 275.w,
        height: 55.h,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd.r),
          border: Border.all(
            color: AppColors.border,
            width: AppSpacing.borderWidth.w,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
        child: Row(
          children: [
            Icon(
              Icons.cake_outlined,
              size: AppSpacing.iconLg.sp,
              color: AppColors.primary,
            ),
            SizedBox(width: AppSpacing.sm.w),
            Expanded(
              child: Text(
                formattedDate ?? 'Select Birth Date',
                style: AppTypography.body2.copyWith(
                  color: formattedDate != null
                      ? AppColors.textPrimary
                      : AppColors.textHint,
                ),
              ),
            ),
            Icon(
              Icons.calendar_today,
              size: AppSpacing.iconMd.sp,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectBirthDate() async {
    final now = DateTime.now();
    final initialDate = _selectedBirthDate ?? DateTime(now.year - 20, 1, 1);
    final firstDate = DateTime(1900);
    final lastDate = DateTime(now.year - 14, 12, 31);

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      helpText: 'Select your birth date',
      fieldLabelText: 'Birth Date',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: AppColors.primary,
                ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedBirthDate = picked;
      });
    }
  }

  Widget _buildPolicyAgreementSection(AsyncValue<List<Policy>> policiesAsync) {
    return Container(
      width: 275.w,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd.r),
        border: Border.all(
          color: AppColors.border,
          width: AppSpacing.borderWidth.w,
        ),
      ),
      padding: EdgeInsets.all(AppSpacing.md.w),
      child: policiesAsync.when(
        data: (policies) {
          if (policies.isEmpty) {
            return const Text('No policies available');
          }
          
          final isAllAgreed = policies.every((p) => _agreedPolicyIds.contains(p.id));

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // All agree checkbox
              InkWell(
                onTap: () => _handleAllAgreedChanged(!isAllAgreed, policies),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: Checkbox(
                        value: isAllAgreed,
                        onChanged: (value) => _handleAllAgreedChanged(value, policies),
                        activeColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSpacing.radiusSm.r),
                        ),
                      ),
                    ),
                    SizedBox(width: AppSpacing.sm.w),
                    Text(
                      'Hammaga roziman',
                      style: AppTypography.body2.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppSpacing.sm.h),

              // Divider
              Divider(
                color: AppColors.divider,
                thickness: AppSpacing.borderWidth.h,
                height: AppSpacing.borderWidth.h,
              ),

              SizedBox(height: AppSpacing.md.h),

              // Individual Policies
              ...policies.map((policy) {
                return Padding(
                  padding: EdgeInsets.only(bottom: AppSpacing.md.h),
                  child: _buildPolicyCheckbox(
                    value: _agreedPolicyIds.contains(policy.id),
                    onChanged: (value) => _handlePolicyToggle(policy.id, value ?? false),
                    label: policy.title,
                    isRequired: policy.isMandatory,
                    onViewPolicy: () => _handleViewPolicy(policy.url),
                  ),
                );
              }),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildPolicyCheckbox({
    required bool value,
    required ValueChanged<bool?> onChanged,
    required String label,
    required bool isRequired,
    required VoidCallback onViewPolicy,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 20.w,
          height: 20.h,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm.r),
            ),
          ),
        ),
        SizedBox(width: AppSpacing.sm.w),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: isRequired ? '[Majburiy] ' : '[Ixtiyoriy] ',
                  style: AppTypography.caption.copyWith(
                    color: isRequired ? AppColors.error : AppColors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: label,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: onViewPolicy,
          child: Padding(
            padding: EdgeInsets.only(left: AppSpacing.sm.w),
            child: Text(
              "[View]",
              style: AppTypography.captionSmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginLink() {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: AppTypography.body2.copyWith(
            color: AppColors.textSecondary,
          ),
          children: [
            const TextSpan(text: 'Profiling bormi? '),
            TextSpan(
              text: 'Kirish',
              style: AppTypography.body2.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primary,
              ),
              recognizer: TapGestureRecognizer()..onTap = _handleLogin,
            ),
          ],
        ),
      ),
    );
  }
}
