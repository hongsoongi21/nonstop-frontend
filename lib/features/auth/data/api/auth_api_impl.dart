import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

import '../../../../core/errors/exceptions.dart';
import '../../../../core/supabase/supabase_provider.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/user.dart';
import '../dto/auth_response_dto.dart';
import '../dto/policy_response_dto.dart';
import 'auth_api.dart';

final authApiProvider = Provider<AuthApi>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return AuthApiImpl(supabaseClient);
});

class AuthApiImpl implements AuthApi {
  final supa.SupabaseClient _supabase;
  final _authStateController = StreamController<User?>.broadcast();
  // Store the last email for verification resend
  String? _lastVerificationEmail;
  final _googleSignIn = GoogleSignIn.instance;

  AuthApiImpl(this._supabase);

  // ---------------------------------------------------------------------------
  // Sign In
  // ---------------------------------------------------------------------------

  @override
  Future<User> signIn({required String email, required String password}) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw const ServerException(
          message: '로그인에 실패했습니다.',
          statusCode: 401,
        );
      }

      if (!kReleaseMode) {
        AppLogger.d('[NONSTOP] Supabase sign-in successful for ${response.user!.email}');
      }

      return await _fetchCurrentUser();
    } on supa.AuthException catch (e) {
      throw ServerException(message: e.message, statusCode: 401);
    }
  }

  // ---------------------------------------------------------------------------
  // Sign Up
  // ---------------------------------------------------------------------------

  @override
  Future<User> signUp({
    required String email,
    required String password,
    required String nickname,
    required DateTime birthDate,
    int? universityId,
    int? majorId,
    List<int>? agreedPolicyIds,
  }) async {
    try {
      final birthDateStr =
          '${birthDate.year.toString().padLeft(4, '0')}-'
          '${birthDate.month.toString().padLeft(2, '0')}-'
          '${birthDate.day.toString().padLeft(2, '0')}';

      // Normal flow: Create a new auth user (trigger will create public.users row)
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'nickname': nickname},
      );

      if (response.user == null) {
        throw const ServerException(
          message: '회원가입에 실패했습니다.',
          statusCode: 500,
        );
      }

      if (!kReleaseMode) {
        AppLogger.d('[NONSTOP] Supabase sign-up successful for ${response.user!.email}');
      }

      // Update the public.users row with additional info
      await _supabase.from('users').update({
        'nickname': nickname,
        'birth_date': birthDateStr,
        if (universityId != null) 'university_id': universityId,
        if (majorId != null) 'major_id': majorId,
      }).eq('auth_id', response.user!.id);

      // Save policy agreements
      if (agreedPolicyIds != null && agreedPolicyIds.isNotEmpty) {
        final userId = await _getUserId(response.user!.id);
        await _supabase.from('user_policy_agreements').insert(
          agreedPolicyIds
              .map((policyId) => {
                    'user_id': userId,
                    'policy_id': policyId,
                  })
              .toList(),
        );
      }

      return await _fetchCurrentUser();
    } on supa.AuthException catch (e) {
      throw ServerException(message: e.message, statusCode: 400);
    }
  }

  // ---------------------------------------------------------------------------
  // OAuth - Google
  // ---------------------------------------------------------------------------

  @override
  Future<OAuthLoginResult> signInWithGoogle({required String idToken, String? accessToken}) async {
    try {
      final response = await _supabase.auth.signInWithIdToken(
        provider: supa.OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (response.user == null) {
        throw const ServerException(
          message: '구글 로그인에 실패했습니다.',
          statusCode: 401,
        );
      }

      if (!kReleaseMode) {
        AppLogger.d('[NONSTOP] Google sign-in via Supabase successful');
      }

      return await _resolveOAuthResult(
        authUser: response.user!,
        session: response.session,
        provider: 'google',
      );
    } on supa.AuthException catch (e) {
      throw ServerException(message: e.message, statusCode: 401);
    }
  }

  // ---------------------------------------------------------------------------
  // OAuth - Apple
  // ---------------------------------------------------------------------------

  @override
  Future<OAuthLoginResult> signInWithApple({
    required String idToken,
    String? nonce,
    String? authorizationCode,
    String? firstName,
    String? lastName,
  }) async {
    try {
      final response = await _supabase.auth.signInWithIdToken(
        provider: supa.OAuthProvider.apple,
        idToken: idToken,
        nonce: nonce,
      );

      if (response.user == null) {
        throw const ServerException(
          message: '애플 로그인에 실패했습니다.',
          statusCode: 401,
        );
      }

      if (!kReleaseMode) {
        AppLogger.d('[NONSTOP] Apple sign-in via Supabase successful');
      }

      // Apple only provides name on first sign-in; override displayName if available
      String? displayName;
      if (firstName != null || lastName != null) {
        displayName = [firstName, lastName].where((e) => e != null).join(' ');
      }

      return await _resolveOAuthResult(
        authUser: response.user!,
        session: response.session,
        provider: 'apple',
        displayNameOverride: displayName,
      );
    } on supa.AuthException catch (e) {
      throw ServerException(message: e.message, statusCode: 401);
    }
  }

  // ---------------------------------------------------------------------------
  // OAuth - Complete signup (profile completion for new/incomplete users)
  // ---------------------------------------------------------------------------

  @override
  Future<User> completeOAuthSignup({
    required String nickname,
    required DateTime birthDate,
    int? universityId,
    int? majorId,
    List<int>? agreedPolicyIds,
  }) async {
    try {
      final authUser = _supabase.auth.currentUser;
      if (authUser == null) {
        throw const ServerException(
          message: '인증되지 않은 사용자입니다.',
          statusCode: 401,
        );
      }

      final birthDateStr =
          '${birthDate.year.toString().padLeft(4, '0')}-'
          '${birthDate.month.toString().padLeft(2, '0')}-'
          '${birthDate.day.toString().padLeft(2, '0')}';

      // Update public.users row with profile info
      await _supabase.from('users').update({
        'nickname': nickname,
        'birth_date': birthDateStr,
        if (universityId != null) 'university_id': universityId,
        if (majorId != null) 'major_id': majorId,
      }).eq('auth_id', authUser.id);

      // Save policy agreements
      if (agreedPolicyIds != null && agreedPolicyIds.isNotEmpty) {
        final userId = await _getUserId(authUser.id);
        await _supabase.from('user_policy_agreements').upsert(
          agreedPolicyIds
              .map((policyId) => {
                    'user_id': userId,
                    'policy_id': policyId,
                  })
              .toList(),
          onConflict: 'user_id,policy_id',
        );
      }

      return await _fetchCurrentUser();
    } on supa.AuthException catch (e) {
      throw ServerException(message: e.message, statusCode: 400);
    }
  }

  // ---------------------------------------------------------------------------
  // Sign Out
  // ---------------------------------------------------------------------------

  @override
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      AppLogger.e('Supabase sign-out error: $e');
    } finally {
      _authStateController.add(null);
    }
  }

  @override
  Future<void> signOutFull() async {
    await signOut();
    await _googleSignIn.signOut();
  }

  // ---------------------------------------------------------------------------
  // Current User
  // ---------------------------------------------------------------------------

  @override
  Future<User?> getCurrentUser() async {
    try {
      final authUser = _supabase.auth.currentUser;
      final session = _supabase.auth.currentSession;

      if (authUser == null || session == null) {
        AppLogger.d('No Supabase session found');
        return null;
      }

      AppLogger.d('Supabase session found, fetching user profile...');
      return await _fetchCurrentUser();
    } catch (e) {
      AppLogger.e('Failed to get current user: $e');
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // Password Reset
  // ---------------------------------------------------------------------------

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } on supa.AuthException catch (e) {
      throw ServerException(message: e.message, statusCode: 400);
    }
  }

  @override
  Future<void> verifyPasswordResetCode(String email, String code) async {
    try {
      await _supabase.auth.verifyOTP(
        email: email,
        token: code,
        type: supa.OtpType.recovery,
      );
    } on supa.AuthException catch (e) {
      throw ServerException(message: e.message, statusCode: 400);
    }
  }

  @override
  Future<void> confirmPasswordReset(
    String email,
    String code,
    String newPassword,
  ) async {
    try {
      await _supabase.auth.updateUser(
        supa.UserAttributes(password: newPassword),
      );
    } on supa.AuthException catch (e) {
      throw ServerException(message: e.message, statusCode: 400);
    }
  }

  // ---------------------------------------------------------------------------
  // Email Verification
  // ---------------------------------------------------------------------------

  @override
  Future<void> sendVerificationEmail(String email) async {
    _lastVerificationEmail = email;
    try {
      final response = await _supabase.functions.invoke(
        'send-verification-email',
        body: {'email': email},
      );

      if (response.status != 200) {
        final data = response.data as Map<String, dynamic>?;
        throw ServerException(
          message: data?['error'] as String? ?? '인증 이메일 발송에 실패했습니다.',
          statusCode: response.status,
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(
        message: '인증 이메일 발송 실패: $e',
        statusCode: 500,
      );
    }
  }

  @override
  Future<void> verifyEmail(String code) async {
    if (_lastVerificationEmail == null) {
      throw const ServerException(
        message: '인증할 이메일 정보가 없습니다. 먼저 이메일을 발송해주세요.',
        statusCode: 400,
      );
    }
    try {
      final response = await _supabase.functions.invoke(
        'verify-email-code',
        body: {
          'email': _lastVerificationEmail!,
          'code': code,
        },
      );

      if (response.status != 200) {
        final data = response.data as Map<String, dynamic>?;
        throw ServerException(
          message: data?['error'] as String? ?? '유효하지 않거나 만료된 인증 코드입니다.',
          statusCode: response.status,
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(
        message: '이메일 인증 실패: $e',
        statusCode: 500,
      );
    }
  }

  @override
  Future<void> resendEmailVerification() async {
    if (_lastVerificationEmail == null) {
      throw const ServerException(
        message: '재발송할 이메일 정보가 없습니다.',
        statusCode: 400,
      );
    }
    await sendVerificationEmail(_lastVerificationEmail!);
  }

  // ---------------------------------------------------------------------------
  // Duplicate Checks
  // ---------------------------------------------------------------------------

  @override
  Future<void> checkEmailDuplicate(String email) async {
    try {
      final result = await _supabase
          .from('users')
          .select('id')
          .eq('email', email)
          .maybeSingle();

      if (result != null) {
        throw const ServerException(
          message: '이미 존재하는 이메일입니다',
          statusCode: 409,
        );
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        message: '이메일 확인 중 오류가 발생했습니다: $e',
        statusCode: 500,
      );
    }
  }

  @override
  Future<void> checkNicknameDuplicate(String nickname) async {
    try {
      final result = await _supabase
          .from('users')
          .select('id')
          .eq('nickname', nickname)
          .isFilter('deleted_at', null)
          .maybeSingle();

      if (result != null) {
        throw const ServerException(
          message: '이미 존재하는 닉네임입니다',
          statusCode: 409,
        );
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        message: '닉네임 확인 중 오류가 발생했습니다: $e',
        statusCode: 500,
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Profile Update
  // ---------------------------------------------------------------------------

  @override
  Future<User> updateProfile({
    String? nickname,
    int? universityId,
    int? majorId,
    String? bio,
    String? avatarUrl,
  }) async {
    final authUser = _supabase.auth.currentUser;
    if (authUser == null) {
      throw const ServerException(
        message: '인증되지 않은 사용자입니다.',
        statusCode: 401,
      );
    }

    try {
      final updateData = <String, dynamic>{};
      if (nickname != null) updateData['nickname'] = nickname;
      if (universityId != null) updateData['university_id'] = universityId;
      if (majorId != null) updateData['major_id'] = majorId;
      if (bio != null) updateData['introduction'] = bio;
      if (avatarUrl != null) updateData['profile_image_url'] = avatarUrl;

      if (updateData.isNotEmpty) {
        await _supabase
            .from('users')
            .update(updateData)
            .eq('auth_id', authUser.id);
      }

      return await _fetchCurrentUser();
    } catch (e) {
      throw ServerException(
        message: '프로필 업데이트 실패: $e',
        statusCode: 500,
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Account Deletion (soft delete)
  // ---------------------------------------------------------------------------

  @override
  Future<void> deleteAccount() async {
    final session = _supabase.auth.currentSession;
    if (session == null) {
      throw const ServerException(
        message: '인증되지 않은 사용자입니다.',
        statusCode: 401,
      );
    }

    try {
      // Call Edge Function for full account deletion (soft delete + auth.users delete)
      final response = await _supabase.functions.invoke(
        'delete-account',
        headers: {'Authorization': 'Bearer ${session.accessToken}'},
      );

      if (response.status != 200) {
        throw ServerException(
          message: '계정 삭제 실패',
          statusCode: response.status,
        );
      }

      await _supabase.auth.signOut();
      _authStateController.add(null);
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(
        message: '계정 삭제 실패: $e',
        statusCode: 500,
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Policies
  // ---------------------------------------------------------------------------

  @override
  Future<List<PolicyResponseDto>> getPolicies() async {
    try {
      final data = await _supabase
          .from('policies')
          .select()
          .eq('is_active', true)
          .order('id');

      return (data as List)
          .map((e) => PolicyResponseDto.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ServerException(
        message: '정책 목록 조회 실패: $e',
        statusCode: 500,
      );
    }
  }

  @override
  Future<void> agreePolicies(List<int> policyIds) async {
    final authUser = _supabase.auth.currentUser;
    if (authUser == null) {
      throw const ServerException(message: '인증 필요', statusCode: 401);
    }

    try {
      final userId = await _getUserId(authUser.id);
      await _supabase.from('user_policy_agreements').upsert(
        policyIds
            .map((id) => {
                  'user_id': userId,
                  'policy_id': id,
                })
            .toList(),
        onConflict: 'user_id,policy_id',
      );
    } catch (e) {
      throw ServerException(
        message: '정책 동의 저장 실패: $e',
        statusCode: 500,
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Access Token & Auth State Stream
  // ---------------------------------------------------------------------------

  @override
  Future<String?> getAccessToken() async {
    return _supabase.auth.currentSession?.accessToken;
  }

  @override
  Stream<User?> get authStateChanges => _authStateController.stream;

  // ---------------------------------------------------------------------------
  // Private Helpers
  // ---------------------------------------------------------------------------

  /// Fetch the current user's profile from the `users` table,
  /// joining `universities` and `majors` for display names.
  Future<User> _fetchCurrentUser() async {
    final authUser = _supabase.auth.currentUser;
    if (authUser == null) {
      throw const ServerException(
        message: '인증되지 않은 사용자입니다.',
        statusCode: 401,
      );
    }

    final data = await _supabase
        .from('users')
        .select('*, universities(name), majors(name)')
        .eq('auth_id', authUser.id)
        .single();

    final user = _mapToUser(data);
    _authStateController.add(user);
    return user;
  }

  /// Map a Supabase row from `users` (with joined university/major) to
  /// the domain [User] entity.
  User _mapToUser(Map<String, dynamic> data) {
    return User(
      id: data['id'].toString(),
      email: data['email'] ?? '',
      nickname: data['nickname'] ?? '',
      fullName: data['full_name'] as String?,
      avatarUrl: data['profile_image_url'] as String?,
      university: data['universities'] != null
          ? (data['universities'] as Map<String, dynamic>)['name'] as String?
          : null,
      universityId: data['university_id'] as int?,
      major: data['majors'] != null
          ? (data['majors'] as Map<String, dynamic>)['name'] as String?
          : null,
      majorId: data['major_id'] as int?,
      bio: data['introduction'] as String?,
      role: data['user_role'] as String?,
      isEmailVerified: data['is_email_verified'] as bool? ?? false,
      preferredLanguage: data['preferred_language'] as String?,
      isUniversityVerified: data['is_verified'] as bool? ?? false,
      createdAt: data['created_at'] != null
          ? parseUtcDateTime(data['created_at'] as String)
          : null,
      updatedAt: data['updated_at'] != null
          ? parseUtcDateTime(data['updated_at'] as String)
          : null,
    );
  }

  /// Get the public.users.id (BIGSERIAL) for a given auth UID.
  Future<int> _getUserId(String authUid) async {
    final data = await _supabase
        .from('users')
        .select('id')
        .eq('auth_id', authUid)
        .single();
    return data['id'] as int;
  }

  /// Shared logic for Google and Apple OAuth sign-in result resolution.
  /// Determines whether the user is new, has an incomplete profile, or is
  /// an existing user with a complete profile.
  Future<OAuthLoginResult> _resolveOAuthResult({
    required supa.User authUser,
    required supa.Session? session,
    required String provider,
    String? displayNameOverride,
  }) async {
    final email = authUser.email ?? '';
    final displayName = displayNameOverride ??
        authUser.userMetadata?['full_name'] as String?;
    final accessToken = session?.accessToken ?? '';
    final refreshToken = session?.refreshToken ?? '';
    final authId = authUser.id;

    // Check if user profile exists in public.users
    var userData = await _supabase
        .from('users')
        .select()
        .eq('auth_id', authId)
        .maybeSingle();

    if (userData == null) {
      // New user - the trigger should have created the row, but may not have completed yet
      await Future.delayed(const Duration(milliseconds: 500));
      userData = await _supabase
          .from('users')
          .select()
          .eq('auth_id', authId)
          .maybeSingle();

      if (userData == null) {
        // Still no row - treat as new user
        return OAuthNewUser(OAuthSignupData(
          email: email,
          displayName: displayName,
          provider: provider,
          accessToken: accessToken,
          refreshToken: refreshToken,
        ));
      }
    }

    // Check if profile is complete (has nickname and birth_date)
    final hasNickname = userData['nickname'] != null &&
        (userData['nickname'] as String).isNotEmpty;
    final hasBirthDate = userData['birth_date'] != null;

    // Check mandatory policy agreements
    final userId = userData['id'] as int;
    bool hasAgreedAllMandatory = true;

    final mandatoryPolicies = await _supabase
        .from('policies')
        .select('id')
        .eq('is_active', true)
        .eq('is_mandatory', true);

    if ((mandatoryPolicies as List).isNotEmpty) {
      final agreements = await _supabase
          .from('user_policy_agreements')
          .select('policy_id')
          .eq('user_id', userId);

      final agreedIds =
          (agreements as List).map((a) => a['policy_id']).toSet();
      hasAgreedAllMandatory =
          mandatoryPolicies.every((p) => agreedIds.contains(p['id']));
    }

    if (!hasNickname || !hasBirthDate || !hasAgreedAllMandatory) {
      final isNew = !hasNickname;
      final signupData = OAuthSignupData(
        email: email,
        displayName: displayName,
        provider: provider,
        accessToken: accessToken,
        refreshToken: refreshToken,
      );

      if (isNew) {
        return OAuthNewUser(signupData);
      } else {
        return OAuthIncompleteUser(
          signupData: signupData,
          hasBirthDate: hasBirthDate,
          hasAgreedAllMandatory: hasAgreedAllMandatory,
        );
      }
    }

    // Complete profile - return existing user
    final user = _mapToUser(userData);
    _authStateController.add(user);
    return OAuthExistingUser(user);
  }
}
