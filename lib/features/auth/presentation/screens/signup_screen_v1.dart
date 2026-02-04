import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../data/dto/auth_response_dto.dart';
import '../../domain/entities/policy.dart';
import '../../domain/entities/university.dart';
import '../providers/auth_provider.dart';
import '../providers/policy_provider.dart';
import '../providers/university_provider.dart';
import '../widgets/custom_auth_text_field.dart';
import '../widgets/gradient_button.dart';
import '../widgets/language_selector.dart';

class SignupScreenV1 extends ConsumerStatefulWidget {
  /// OAuth 회원가입 데이터 (Google/Apple 로그인 시 전달됨)
  final dynamic oauthSignupData;

  const SignupScreenV1({super.key, this.oauthSignupData});

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

  /// OAuth 회원가입 데이터 (타입 캐스팅된 버전)
  OAuthSignupData? get _oauthData {
    final data = widget.oauthSignupData;
    if (data is OAuthSignupData) {
      return data;
    }
    return null;
  }

  /// OAuth 회원가입 모드인지 확인
  bool get _isOAuthSignup => _oauthData != null;

  @override
  void initState() {
    super.initState();
    // OAuth 데이터가 있으면 이메일 필드 초기화
    if (_oauthData != null) {
      _emailController.text = _oauthData!.email;
      // 닉네임 힌트로 displayName 사용 가능
      if (_oauthData!.displayName != null && _oauthData!.displayName!.isNotEmpty) {
        _nicknameController.text = _oauthData!.displayName!;
      }
    }
  }

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
    final l10n = AppLocalizations.of(context);
    final authState = ref.read(authProvider);

    // 미완성 프로필 상태 확인
    final isIncompleteProfile = authState.isIncompleteProfile && _isOAuthSignup;
    final needsBirthDate = !authState.existingUserHasBirthDate;
    final needsPolicyAgreement = !authState.existingUserHasAgreedPolicies;

    // 1. 클라이언트 측 유효성 검사 (입력 형식 등)
    if (!_formKey.currentState!.validate()) return;

    // 2. 정책 동의 검사 (필요한 경우에만)
    if (!isIncompleteProfile || needsPolicyAgreement) {
      final policiesAsync = ref.read(policiesProvider);

      // 데이터가 아직 로드되지 않았거나 에러인 경우 처리
      if (!policiesAsync.hasValue) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.pleaseWaitPoliciesLoad),
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
          SnackBar(
            content: Text(l10n.agreeMandatoryPolicies),
            backgroundColor: AppColors.error,
            duration: const Duration(seconds: 2),
          ),
        );
        return;
      }
    }

    // 3. 대학교 선택 여부 확인
    if (_selectedUniversityId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.pleaseSelectUniversity),
          backgroundColor: AppColors.error,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    // 4. 생년월일 검증 (필요한 경우에만)
    if ((!isIncompleteProfile || needsBirthDate) && _selectedBirthDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.pleaseSelectBirthDate),
          backgroundColor: AppColors.error,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    // 5. OAuth vs 일반 회원가입 분기
    if (_isOAuthSignup) {
      // OAuth 회원가입: 이메일 인증 불필요, 비밀번호 불필요
      // 미완성 프로필의 경우 birthDate가 null일 수 있음 (이미 있는 경우)
      await ref.read(authProvider.notifier).completeOAuthSignup(
            nickname: _nicknameController.text.trim(),
            birthDate: _selectedBirthDate ?? DateTime(2000, 1, 1), // 기존 값이 있으면 서버에서 무시됨
            universityId: _selectedUniversityId,
            agreedPolicyIds: _agreedPolicyIds.toList(),
          );
    } else {
      // 일반 회원가입: 이메일 인증 필요
      final authState = ref.read(authProvider);
      if (!authState.isEmailVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).pleaseVerifyEmail),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }

      // 회원가입 프로세스 실행
      await ref.read(authProvider.notifier).signUp(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            nickname: _nicknameController.text.trim(),
            birthDate: _selectedBirthDate!,
            universityId: _selectedUniversityId,
            agreedPolicyIds: _agreedPolicyIds.toList(),
          );
    }

    // 위젯이 마운트된 상태인지 확인
    if (!mounted) return;

    // 6. 실행 결과에 따른 처리
    final resultAuthState = ref.read(authProvider);
    if (resultAuthState.hasError) {
      // 실패 시 에러 메시지 노출
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resultAuthState.failure?.message ?? AppLocalizations.of(context).signupFailed),
          backgroundColor: AppColors.error,
        ),
      );
    } else if (resultAuthState.isAuthenticated) {
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
        SnackBar(
          content: Text(AppLocalizations.of(context).validationEmailInvalid),
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
            content: Text(authState.failure?.message ?? AppLocalizations.of(context).failedToSendCode),
            backgroundColor: AppColors.error,
          ),
        );
      } else {
        _startTimer(); // 타이머 시작
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).verificationCodeSent),
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
            content: Text(authState.failure?.message ?? AppLocalizations.of(context).invalidCode),
            backgroundColor: AppColors.error,
          ),
        );
      } else if (authState.isEmailVerified) {
        _verificationTimer?.cancel(); // 인증 성공 시 타이머 정지
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).emailVerifiedSuccess),
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

    // 미완성 프로필 상태 확인 (기존 OAuth 사용자)
    final isIncompleteProfile = authState.isIncompleteProfile && _isOAuthSignup;
    final needsBirthDate = !authState.existingUserHasBirthDate;
    final needsPolicyAgreement = !authState.existingUserHasAgreedPolicies;

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
                                  _buildHeader(isIncompleteProfile: isIncompleteProfile),

                                  SizedBox(height: AppSpacing.lg.h),

                                  // 닉네임 입력 필드
                                  CustomAuthTextField(
                                    controller: _nicknameController,
                                    hintText: AppLocalizations.of(context).nickname,
                                    prefixIcon: Icons.person_outline,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppLocalizations.of(context).validationNicknameRequired;
                                      }
                                      if (value.length < 2 || value.length > 20) {
                                        return AppLocalizations.of(context).validationNickname2to20;
                                      }
                                      return null;
                                    },
                                  ),

                                  SizedBox(height: AppSpacing.md.h),

                                  // 대학교 선택 드롭다운
                                  _buildUniversityDropdown(universitiesAsync),

                                  // 생년월일 선택 (미완성 프로필에서 이미 있으면 숨김)
                                  if (!isIncompleteProfile || needsBirthDate) ...[
                                    SizedBox(height: AppSpacing.md.h),
                                    _buildBirthDatePicker(),
                                  ],

                                  SizedBox(height: AppSpacing.md.h),

                                  // 이메일 입력 필드 및 인증 버튼
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: CustomAuthTextField(
                                          controller: _emailController,
                                          hintText: AppLocalizations.of(context).email,
                                          prefixIcon: Icons.email_outlined,
                                          keyboardType: TextInputType.emailAddress,
                                          // OAuth는 항상 readOnly, 일반 가입은 인증 완료 시 readOnly
                                          readOnly: _isOAuthSignup || authState.isEmailVerified,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return AppLocalizations.of(context).validationEmailRequired;
                                            }
                                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                                .hasMatch(value)) {
                                              return AppLocalizations.of(context).validationEmailInvalid;
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      // 일반 회원가입에서만 인증 버튼 표시
                                      if (!_isOAuthSignup && !authState.isEmailVerified) ...[
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
                                              authState.isEmailVerificationSent ? AppLocalizations.of(context).resend : AppLocalizations.of(context).send,
                                              style: AppTypography.buttonSmall.copyWith(
                                                color: AppColors.textOnPrimary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),

                                  // OAuth의 경우 이메일 인증 대신 안내 메시지 표시
                                  if (_isOAuthSignup)
                                    Padding(
                                      padding: EdgeInsets.only(top: AppSpacing.sm.h),
                                      child: Row(
                                        children: [
                                          Icon(Icons.check_circle, color: AppColors.success, size: AppSpacing.iconSm.sp),
                                          SizedBox(width: AppSpacing.xs.w),
                                          Expanded(
                                            child: Text(
                                              AppLocalizations.of(context).oauthEmailVerified,
                                              style: AppTypography.caption.copyWith(
                                                color: AppColors.success,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  // 일반 회원가입의 경우에만 이메일 인증 코드 입력 표시
                                  if (!_isOAuthSignup && authState.isEmailVerificationSent && !authState.isEmailVerified) ...[
                                    SizedBox(height: AppSpacing.md.h),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: CustomAuthTextField(
                                            controller: _verificationCodeController,
                                            hintText: AppLocalizations.of(context).sixDigitCode,
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
                                              AppLocalizations.of(context).verify,
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
                                            AppLocalizations.of(context).emailVerified,
                                            style: AppTypography.caption.copyWith(
                                              color: AppColors.success,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  // 일반 회원가입에서만 비밀번호 필드 표시 (OAuth는 비밀번호 불필요)
                                  if (!_isOAuthSignup) ...[
                                    SizedBox(height: AppSpacing.md.h),

                                    // 비밀번호 입력 필드
                                    CustomAuthTextField(
                                      controller: _passwordController,
                                      hintText: AppLocalizations.of(context).password,
                                      prefixIcon: Icons.lock_outline,
                                      obscureText: true,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return AppLocalizations.of(context).validationPasswordRequired;
                                        }
                                        if (value.length < 8) {
                                          return AppLocalizations.of(context).validationPasswordMin8;
                                        }
                                        return null;
                                      },
                                    ),

                                    SizedBox(height: AppSpacing.md.h),

                                    // 비밀번호 확인 필드
                                    CustomAuthTextField(
                                      controller: _confirmPasswordController,
                                      hintText: AppLocalizations.of(context).confirmPassword,
                                      prefixIcon: Icons.lock_outline,
                                      obscureText: true,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return AppLocalizations.of(context).validationConfirmPassword;
                                        }
                                        if (value != _passwordController.text) {
                                          return AppLocalizations.of(context).validationPasswordsNoMatch;
                                        }
                                        return null;
                                      },
                                    ),
                                  ],

                                  // 약관 동의 섹션 (미완성 프로필에서 이미 동의했으면 숨김)
                                  if (!isIncompleteProfile || needsPolicyAgreement) ...[
                                    SizedBox(height: AppSpacing.lg.h),
                                    _buildPolicyAgreementSection(policiesAsync),
                                  ],

                                  SizedBox(height: AppSpacing.lg.h),

                                  // 가입하기/완료 버튼
                                  GradientButton(
                                    text: isIncompleteProfile
                                        ? AppLocalizations.of(context).save
                                        : AppLocalizations.of(context).createAccount,
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

  Widget _buildHeader({bool isIncompleteProfile = false}) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        Text(
          isIncompleteProfile
              ? l10n.completeProfile
              : l10n.createAccount,
          textAlign: TextAlign.center,
          style: AppTypography.headline2.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppSpacing.xs.h),
        Text(
          isIncompleteProfile
              ? l10n.completeProfileSubtitle
              : l10n.enterYourInfo,
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
            hintText: AppLocalizations.of(context).selectUniversity,
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
                formattedDate ?? AppLocalizations.of(context).selectBirthDate,
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
      helpText: AppLocalizations.of(context).selectYourBirthDate,
      fieldLabelText: AppLocalizations.of(context).birthDate,
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
            return Text(AppLocalizations.of(context).noPoliciesAvailable);
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
                      AppLocalizations.of(context).agreeToAll,
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
                  text: isRequired ? '${AppLocalizations.of(context).required} ' : '${AppLocalizations.of(context).optional} ',
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
              AppLocalizations.of(context).view,
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
            TextSpan(text: AppLocalizations.of(context).haveAccount),
            TextSpan(
              text: AppLocalizations.of(context).loginLink,
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
