import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/supabase/supabase_provider.dart';
import '../dto/verification_dto.dart';
import 'verification_api.dart';

final verificationApiProvider = Provider<VerificationApi>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return VerificationApiImpl(supabaseClient);
});

class VerificationApiImpl implements VerificationApi {
  final SupabaseClient _supabase;

  VerificationApiImpl(this._supabase);

  Future<int> _getCurrentUserId() async {
    final authUser = _supabase.auth.currentUser;
    if (authUser == null) throw const ApiException('Not authenticated');
    final data = await _supabase
        .from('users')
        .select('id')
        .eq('auth_id', authUser.id)
        .single();
    return data['id'] as int;
  }

  @override
  Future<Either<ApiException, void>> uploadStudentId({
    required String filePath,
  }) async {
    try {
      final authUser = _supabase.auth.currentUser;
      if (authUser == null) {
        return left(const ApiException('Not authenticated'));
      }

      final file = File(filePath);
      final fileName =
          '${authUser.id}/${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';

      // Upload to Supabase Storage
      await _supabase.storage
          .from('verification-docs')
          .upload(fileName, file);

      // Update user verification info
      final currentUserId = await _getCurrentUserId();
      await _supabase.from('users').update({
        'verification_method': 'STUDENT_ID_PHOTO',
      }).eq('id', currentUserId);

      // Store verification record (using file_uploads if available, or just update user)
      // For MVP, we just mark the user as pending verification

      return right(null);
    } on StorageException catch (e) {
      return left(ApiException('학생증 업로드 실패: ${e.message}'));
    } catch (e) {
      return left(ApiException('학생증 업로드 실패: $e'));
    }
  }

  @override
  Future<Either<ApiException, void>> requestEmailVerification({
    required EmailVerificationRequestDto request,
  }) async {
    try {
      // Use Supabase Edge Function or direct email verification
      // For MVP, check if email domain matches university domains
      final currentUserId = await _getCurrentUserId();

      final user = await _supabase
          .from('users')
          .select('university_id')
          .eq('id', currentUserId)
          .single();

      final universityId = user['university_id'] as int?;
      if (universityId == null) {
        return left(const ApiException('대학교가 설정되지 않았습니다.'));
      }

      // Check if email domain matches university domains
      final emailDomain = request.email.split('@').last;
      final domainMatch = await _supabase
          .from('university_email_domains')
          .select('id')
          .eq('university_id', universityId)
          .eq('domain', emailDomain)
          .maybeSingle();

      if (domainMatch == null) {
        return left(const ApiException('해당 대학교의 이메일 도메인이 아닙니다.'));
      }

      // Send verification code via Resend edge function
      final response = await _supabase.functions.invoke(
        'send-verification-email',
        body: {'email': request.email},
      );
      if (response.status != 200) {
        final data = response.data as Map<String, dynamic>?;
        return left(ApiException(
          data?['error'] as String? ?? '인증 코드 발송에 실패했습니다.',
        ));
      }

      return right(null);
    } catch (e) {
      return left(ApiException('인증 코드 발송 실패: $e'));
    }
  }

  @override
  Future<Either<ApiException, void>> confirmEmailVerification({
    required EmailVerificationConfirmDto request,
  }) async {
    try {
      final currentUserId = await _getCurrentUserId();

      // Idempotency: if already verified, return success immediately
      final userData = await _supabase
          .from('users')
          .select('is_verified')
          .eq('id', currentUserId)
          .single();
      if (userData['is_verified'] == true) {
        return right(null);
      }

      // Verify the code via edge function
      final response = await _supabase.functions.invoke(
        'verify-email-code',
        body: {'email': request.email, 'code': request.code},
      );
      if (response.status != 200) {
        return left(const ApiException('유효하지 않거나 만료된 인증 코드입니다.'));
      }

      // Code verified — update user record
      await _supabase.from('users').update({
        'is_verified': true,
        'verification_method': 'EMAIL_DOMAIN',
      }).eq('id', currentUserId);

      return right(null);
    } catch (e) {
      return left(ApiException('이메일 인증 실패: $e'));
    }
  }

  @override
  Future<Either<ApiException, VerificationStatusDto>>
      getVerificationStatus() async {
    try {
      final currentUserId = await _getCurrentUserId();

      final data = await _supabase
          .from('users')
          .select('is_verified, verification_method')
          .eq('id', currentUserId)
          .single();

      final methodStr = data['verification_method'] as String?;
      VerificationMethod? method;
      if (methodStr != null) {
        switch (methodStr) {
          case 'EMAIL_DOMAIN':
            method = VerificationMethod.emailDomain;
            break;
          case 'MANUAL_REVIEW':
            method = VerificationMethod.manualReview;
            break;
          case 'STUDENT_ID_PHOTO':
            method = VerificationMethod.studentIdPhoto;
            break;
        }
      }

      return right(VerificationStatusDto(
        isUniversityVerified: data['is_verified'] as bool? ?? false,
        verificationMethod: method,
      ));
    } catch (e) {
      return left(ApiException('인증 상태 조회 실패: $e'));
    }
  }
}
