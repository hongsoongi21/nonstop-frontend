import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/theme/app_colors.dart';
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

  String? _selectedUniversity;
  bool _allAgreed = false;
  bool _termsAgreed = false;
  bool _privacyAgreed = false;
  bool _marketingAgreed = false;

  // TODO: 실제 대학교 목록 API로 교체 필요
  final List<String> _universities = [
    'Tashkent State University of Economics',
    'National University of Uzbekistan',
    'Westminster International University in Tashkent',
    'Inha University in Tashkent',
    'Turin Polytechnic University in Tashkent',
    'Management Development Institute of Singapore in Tashkent',
    'Tashkent University of Information Technologies',
    'Tashkent State Technical University',
  ];

  @override
  void dispose() {
    _nicknameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleAllAgreedChanged(bool? value) {
    setState(() {
      _allAgreed = value ?? false;
      _termsAgreed = _allAgreed;
      _privacyAgreed = _allAgreed;
      _marketingAgreed = _allAgreed;
    });
  }

  void _handleIndividualPolicyChanged() {
    setState(() {
      _allAgreed = _termsAgreed && _privacyAgreed && _marketingAgreed;
    });
  }

  void _handleViewPolicy(String policyType) {
    // TODO: 정책 상세 화면으로 이동 필요
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$policyType 정책 보기 - 구현 예정'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;

    // Check required policies
    if (!_termsAgreed || !_privacyAgreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Majburiy shartlarni qabul qiling'),
          backgroundColor: AppColors.error,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    // Check university selection
    if (_selectedUniversity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Universitetni tanlang'),
          backgroundColor: AppColors.error,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    // TODO: 회원가입 API 호출 필요
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('회원가입 기능 - 구현 예정'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _handleLogin() {
    context.go(Routes.login);
  }

  @override
  Widget build(BuildContext context) {
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
          child: SingleChildScrollView(
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
                    // Language selector
                    const LanguageSelector(),

                    SizedBox(height: 16.h),

                    // Main signup form container
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
                            ).withValues(alpha: 0.059),
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
                              _buildHeader(),

                              SizedBox(height: 30.h),

                              // Nickname Input
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

                              // University Dropdown
                              _buildUniversityDropdown(),

                              SizedBox(height: 20.h),

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

                              SizedBox(height: 20.h),

                              // Confirm Password Input
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

                              // Policy Agreement Section
                              _buildPolicyAgreementSection(),

                              SizedBox(height: 24.h),

                              // Signup Button
                              GradientButton(
                                text: "Ro'yxatdan o'tish",
                                onPressed: _handleSignup,
                              ),

                              SizedBox(height: 24.h),

                              // Login Link
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

  Widget _buildUniversityDropdown() {
    return Container(
      width: 275.w,
      height: 55.h,
      decoration: BoxDecoration(
        color: const Color(0xFFE9F0FE),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: const Color(0xFFFFFFFF), width: 1.w),
      ),
      child: DropdownButtonFormField<String>(
        initialValue: _selectedUniversity,
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
        style: TextStyle(fontSize: 14.sp, color: Colors.black87),
        dropdownColor: const Color(0xFFE9F0FE),
        isExpanded: true,
        items: _universities.map((String university) {
          return DropdownMenuItem<String>(
            value: university,
            child: Text(
              university,
              style: TextStyle(fontSize: 14.sp, color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            _selectedUniversity = value;
          });
        },
      ),
    );
  }

  Widget _buildPolicyAgreementSection() {
    return Container(
      width: 275.w,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.w),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // All agree checkbox
          InkWell(
            onTap: () => _handleAllAgreedChanged(!_allAgreed),
            child: Row(
              children: [
                SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: Checkbox(
                    value: _allAgreed,
                    onChanged: _handleAllAgreedChanged,
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

          // Terms of service (required)
          _buildPolicyCheckbox(
            value: _termsAgreed,
            onChanged: (value) {
              setState(() {
                _termsAgreed = value ?? false;
                _handleIndividualPolicyChanged();
              });
            },
            label: 'Foydalanish shartlari',
            isRequired: true,
            onViewPolicy: () => _handleViewPolicy('Terms of Service'),
          ),

          SizedBox(height: 12.h),

          // Privacy policy (required)
          _buildPolicyCheckbox(
            value: _privacyAgreed,
            onChanged: (value) {
              setState(() {
                _privacyAgreed = value ?? false;
                _handleIndividualPolicyChanged();
              });
            },
            label: 'Maxfiylik siyosati',
            isRequired: true,
            onViewPolicy: () => _handleViewPolicy('Privacy Policy'),
          ),

          SizedBox(height: 12.h),

          // Marketing (optional)
          _buildPolicyCheckbox(
            value: _marketingAgreed,
            onChanged: (value) {
              setState(() {
                _marketingAgreed = value ?? false;
                _handleIndividualPolicyChanged();
              });
            },
            label: 'Marketing xabarlari',
            isRequired: false,
            onViewPolicy: () => _handleViewPolicy('Marketing'),
          ),
        ],
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
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF6B7280),
              ),
              children: [
                TextSpan(
                  text: isRequired ? '[Majburiy] ' : '[Ixtiyoriy] ',
                  style: TextStyle(
                    color: isRequired
                        ? const Color(0xFFEF4444)
                        : const Color(0xFF10B981),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: label,
                  style: const TextStyle(
                    color: Color(0xFF7C3BEE),
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onViewPolicy,
                ),
              ],
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
