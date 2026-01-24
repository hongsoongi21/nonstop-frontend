import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/theme/app_colors.dart';
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
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  int? _selectedUniversityId;
  
  // 동의한 정책 ID들을 저장하는 Set
  final Set<int> _agreedPolicyIds = {};

  @override
  void dispose() {
    _nicknameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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

    // 4. 회원가입 프로세스 실행
    await ref.read(authProvider.notifier).signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          nickname: _nicknameController.text.trim(),
          universityId: _selectedUniversityId,
        );

    // 위젯이 마운트된 상태인지 확인
    if (!mounted) return;

    // 5. 실행 결과에 따른 처리
    final authState = ref.read(authProvider);
    if (authState.hasError) {
      // 실패 시 에러 메시지 노출
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authState.failure?.message ?? '회원가입 실패'),
          backgroundColor: AppColors.error,
        ),
      );
    } else if (authState.isAuthenticated) {
      // 성공 시 홈 화면으로 이동
      context.go(Routes.home);
    }
  }

  void _handleLogin() {
    context.go(Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    // 로딩 상태 및 대학 목록 데이터를 Watch 합니다.
    final isLoading = ref.watch(isLoadingProvider);
    final universitiesAsync = ref.watch(universitiesProvider);
    // 정책 목록 데이터를 Watch 합니다.
    final policiesAsync = ref.watch(policiesProvider);

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
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 40.h,
                    left: 16.w,
                    right: 16.w,
                    bottom: 40.h,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // 언어 선택기
                        const LanguageSelector(),

                        SizedBox(height: 16.h),

                        // 메인 회원가입 폼 컨테이너
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
                                color: const Color(0xFF7C3BEE).withValues(alpha: 0.059),
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

                                  // 헤더 타이틀
                                  _buildHeader(),

                                  SizedBox(height: 30.h),

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

                                  SizedBox(height: 20.h),

                                  // 대학교 선택 드롭다운
                                  _buildUniversityDropdown(universitiesAsync),

                                  SizedBox(height: 20.h),

                                  // 이메일 입력 필드
                                  CustomAuthTextField(
                                    controller: _emailController,
                                    hintText: 'Email',
                                    prefixIcon: Icons.email_outlined,
                                    keyboardType: TextInputType.emailAddress,
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

                                  SizedBox(height: 20.h),

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

                                  SizedBox(height: 20.h),

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

                                  SizedBox(height: 24.h),

                                  // 약관 동의 섹션 (API 데이터 기반)
                                  _buildPolicyAgreementSection(policiesAsync),

                                  SizedBox(height: 24.h),

                                  // 가입하기 버튼
                                  GradientButton(
                                    text: "Ro'yxatdan o'tish",
                                    onPressed: isLoading ? null : _handleSignup,
                                  ),

                                  SizedBox(height: 24.h),

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
        Container(
          width: 275.w,
          height: 38.h,
          alignment: Alignment.center,
          child: Text(
            "Ro'yxatdan o'tish",
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
            "Ma'lumotlaringizni kiriting",
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
      ],
    );
  }

  Widget _buildUniversityDropdown(AsyncValue<List<University>> universitiesAsync) {
    return Container(
      width: 275.w,
      height: 55.h,
      decoration: BoxDecoration(
        color: const Color(0xFFE9F0FE),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: const Color(0xFFFFFFFF), width: 1.w),
      ),
      child: universitiesAsync.when(
        data: (universities) => DropdownButtonFormField<int>(
          initialValue: _selectedUniversityId,
          decoration: InputDecoration(
            hintText: 'Select University',
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: Colors.black.withValues(alpha: 0.5),
            ),
            prefixIcon: Icon(
              Icons.school_outlined,
              color: const Color(0xFF7C3BEE),
              size: 20.sp,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
          ),
          icon: Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Icon(
              Icons.arrow_drop_down,
              color: const Color(0xFF7C3BEE),
              size: 24.sp,
            ),
          ),
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black87,
          ),
          dropdownColor: const Color(0xFFE9F0FE),
          isExpanded: true,
          items: universities.map((University university) {
            return DropdownMenuItem<int>(
              value: university.id,
              child: Text(
                university.name,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black87,
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
        loading: () => const Center(
            child: CircularProgressIndicator(strokeWidth: 2)),
        error: (err, stack) =>
            const Center(child: Icon(Icons.error_outline, color: Colors.red)),
      ),
    );
  }

  Widget _buildPolicyAgreementSection(AsyncValue<List<Policy>> policiesAsync) {
    return Container(
      width: 275.w,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.w),
      ),
      padding: EdgeInsets.all(16.w),
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
                        activeColor: const Color(0xFF7C3BEE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Hammaga roziman',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111827),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 8.h),

              // Divider
              Divider(color: const Color(0xFFE5E7EB), thickness: 1.h, height: 1.h),

              SizedBox(height: 12.h),

              // Individual Policies
              ...policies.map((policy) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
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
            activeColor: const Color(0xFF7C3BEE),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: isRequired ? '[Majburiy] ' : '[Ixtiyoriy] ',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: isRequired
                        ? const Color(0xFFEF4444)
                        : const Color(0xFF10B981),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: onViewPolicy,
          child: Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Text(
              "[View]",
              style: TextStyle(
                fontSize: 11.sp,
                color: const Color(0xFF7C3BEE),
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginLink() {
    return Container(
      width: 275.w,
      height: 41.h,
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
            const TextSpan(text: 'Profiling bormi? '),
            TextSpan(
              text: 'Kirish',
              style: TextStyle(
                fontFamily: 'Noto Sans',
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                height: 1.0,
                letterSpacing: -0.02 * 14.sp,
                color: const Color(0xFF7C3BEE),
                decoration: TextDecoration.underline,
                decorationColor: const Color(0xFF7C3BEE),
              ),
              recognizer: TapGestureRecognizer()..onTap = _handleLogin,
            ),
          ],
        ),
      ),
    );
  }
}
