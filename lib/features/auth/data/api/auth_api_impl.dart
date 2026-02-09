import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../../domain/entities/user.dart';
import '../dto/auth_request_dto.dart';
import '../dto/auth_response_dto.dart'; // Ensure TokenResponseDto is imported via this
import '../dto/apple_login_request_dto.dart';
import '../dto/google_login_request_dto.dart';
import '../dto/policy_request_dto.dart';
import '../dto/policy_response_dto.dart';
import '../dto/user_dto.dart';
import 'auth_api.dart';
import '../../../../core/utils/logger.dart'; // Added for AppLogger

final authApiProvider = Provider<AuthApi>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  final secureStorageService = ref.watch(secureStorageServiceProvider);
  return AuthApiImpl(dioClient, secureStorageService);
});

class AuthApiImpl implements AuthApi {
  final DioClient _dioClient;
  final SecureStorageService _secureStorageService;
  final _authStateController = StreamController<User?>.broadcast();
  // 인증 확인을 위해 마지막으로 인증번호를 보낸 이메일을 저장합니다.
  String? _lastVerificationEmail;
  // OAuth 가입 시 사용할 이메일 (signInWithGoogle/Apple에서 설정됨)
  String? _oauthEmail;
  String? _oauthProvider;
  final _googleSignIn = GoogleSignIn.instance;

  AuthApiImpl(this._dioClient, this._secureStorageService);

  @override
  Future<User> signIn({required String email, required String password}) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/auth/login',
        data: LoginRequestDto(email: email, password: password).toJson(),
        options: Options(extra: {'no-auth': true}),
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] == true) {
        final tokenData = TokenResponseDto.fromJson(
          apiResponse['data'],
        ); // Changed to TokenResponseDto

        if (!kReleaseMode) {
          AppLogger.d('[NONSTOP] 🔑 Tokens Received:'); // Using AppLogger
          AppLogger.d('[NONSTOP]   Access: ${tokenData.accessToken}');
          AppLogger.d('[NONSTOP]   Refresh: ${tokenData.refreshToken}');
        }

        // 보안 저장소에 토큰 저장
        await _secureStorageService.saveAccessToken(tokenData.accessToken);
        await _secureStorageService.saveRefreshToken(tokenData.refreshToken);

        // 토큰 획득 후 내 정보를 조회하여 최종 User 엔티티를 반환합니다.
        return await _fetchAndEmitUserInfo();
      } else {
        throw ServerException(
          message: apiResponse['message'] ?? '로그인에 실패했습니다.',
          statusCode: response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<OAuthLoginResult> signInWithGoogle({required String idToken}) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/auth/google',
        data: GoogleLoginRequestDto(idToken: idToken).toJson(),
        options: Options(extra: {'no-auth': true}),
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] == true) {
        final tokenData = TokenResponseDto.fromJson(apiResponse['data']);

        if (!kReleaseMode) {
          AppLogger.d('[NONSTOP] 🔑 Google Login Tokens Received:');
          AppLogger.d('[NONSTOP]   Access: ${tokenData.accessToken}');
          AppLogger.d('[NONSTOP]   Refresh: ${tokenData.refreshToken}');
          AppLogger.d('[NONSTOP]   isNewUser: ${tokenData.isNewUser}');
        }

        // 보안 저장소에 토큰 저장
        await _secureStorageService.saveAccessToken(tokenData.accessToken);
        await _secureStorageService.saveRefreshToken(tokenData.refreshToken);

        // 토큰에서 이메일 추출
        final email = apiResponse['data']['email'] as String? ?? '';
        final displayName = apiResponse['data']['displayName'] as String?;

        // 신규 사용자인 경우 회원가입 화면으로 이동하도록 OAuthNewUser 반환
        if (tokenData.isNewUser) {
          _oauthEmail = email;
          _oauthProvider = 'google';

          return OAuthNewUser(OAuthSignupData(
            email: email,
            displayName: displayName,
            provider: 'google',
            accessToken: tokenData.accessToken,
            refreshToken: tokenData.refreshToken,
          ));
        }

        // 기존 사용자지만 필수 정보가 누락된 경우 (생년월일 또는 필수 약관 동의)
        if (!tokenData.hasBirthDate || !tokenData.hasAgreedAllMandatory) {
          _oauthEmail = email;
          _oauthProvider = 'google';

          return OAuthIncompleteUser(
            signupData: OAuthSignupData(
              email: email,
              displayName: displayName,
              provider: 'google',
              accessToken: tokenData.accessToken,
              refreshToken: tokenData.refreshToken,
            ),
            hasBirthDate: tokenData.hasBirthDate,
            hasAgreedAllMandatory: tokenData.hasAgreedAllMandatory,
          );
        }

        // 기존 사용자 (프로필 완성됨): 내 정보를 조회하여 반환
        final user = await _fetchAndEmitUserInfo();
        return OAuthExistingUser(user);
      } else {
        throw ServerException(
          message: apiResponse['message'] ?? '구글 로그인에 실패했습니다.',
          statusCode: response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<OAuthLoginResult> signInWithApple({
    required String idToken,
    String? authorizationCode,
    String? firstName,
    String? lastName,
  }) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/auth/apple',
        data: AppleLoginRequestDto(
          idToken: idToken,
          authorizationCode: authorizationCode,
          firstName: firstName,
          lastName: lastName,
        ).toJson(),
        options: Options(extra: {'no-auth': true}),
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] == true) {
        final tokenData = TokenResponseDto.fromJson(apiResponse['data']);

        if (!kReleaseMode) {
          AppLogger.d('[NONSTOP] 🍎 Apple Login Tokens Received:');
          AppLogger.d('[NONSTOP]   Access: ${tokenData.accessToken}');
          AppLogger.d('[NONSTOP]   Refresh: ${tokenData.refreshToken}');
          AppLogger.d('[NONSTOP]   isNewUser: ${tokenData.isNewUser}');
        }

        // 보안 저장소에 토큰 저장
        await _secureStorageService.saveAccessToken(tokenData.accessToken);
        await _secureStorageService.saveRefreshToken(tokenData.refreshToken);

        // 토큰에서 이메일 추출
        final email = apiResponse['data']['email'] as String? ?? '';
        // Apple은 최초 로그인 시에만 이름을 제공
        String? displayName;
        if (firstName != null || lastName != null) {
          displayName = [firstName, lastName].where((e) => e != null).join(' ');
        } else {
          displayName = apiResponse['data']['displayName'] as String?;
        }

        // 신규 사용자인 경우 회원가입 화면으로 이동하도록 OAuthNewUser 반환
        if (tokenData.isNewUser) {
          _oauthEmail = email;
          _oauthProvider = 'apple';

          return OAuthNewUser(OAuthSignupData(
            email: email,
            displayName: displayName,
            provider: 'apple',
            accessToken: tokenData.accessToken,
            refreshToken: tokenData.refreshToken,
          ));
        }

        // 기존 사용자지만 필수 정보가 누락된 경우 (생년월일 또는 필수 약관 동의)
        if (!tokenData.hasBirthDate || !tokenData.hasAgreedAllMandatory) {
          _oauthEmail = email;
          _oauthProvider = 'apple';

          return OAuthIncompleteUser(
            signupData: OAuthSignupData(
              email: email,
              displayName: displayName,
              provider: 'apple',
              accessToken: tokenData.accessToken,
              refreshToken: tokenData.refreshToken,
            ),
            hasBirthDate: tokenData.hasBirthDate,
            hasAgreedAllMandatory: tokenData.hasAgreedAllMandatory,
          );
        }

        // 기존 사용자 (프로필 완성됨): 내 정보를 조회하여 반환
        final user = await _fetchAndEmitUserInfo();
        return OAuthExistingUser(user);
      } else {
        throw ServerException(
          message: apiResponse['message'] ?? '애플 로그인에 실패했습니다.',
          statusCode: response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

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
      // Format birthDate as "YYYY-MM-DD"
      final birthDateString =
          '${birthDate.year.toString().padLeft(4, '0')}-'
          '${birthDate.month.toString().padLeft(2, '0')}-'
          '${birthDate.day.toString().padLeft(2, '0')}';

      final response = await _dioClient.post(
        '/api/v1/auth/signup',
        data: SignUpRequestDto(
          email: email,
          password: password,
          nickname: nickname,
          birthDate: birthDateString,
          universityId: universityId,
          majorId: majorId,
          agreedPolicyIds: agreedPolicyIds,
        ).toJson(),
        options: Options(extra: {'no-auth': true}),
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] == true) {
        // 회원가입 성공 직후, 사용자 편의를 위해 즉시 로그인을 시도합니다.
        return await signIn(email: email, password: password);
      } else {
        throw ServerException(
          message: apiResponse['message'] ?? '회원가입에 실패했습니다.',
          statusCode: response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<User> completeOAuthSignup({
    required String nickname,
    required DateTime birthDate,
    int? universityId,
    int? majorId,
    List<int>? agreedPolicyIds,
  }) async {
    try {
      // Format birthDate as "YYYY-MM-DD"
      final birthDateString =
          '${birthDate.year.toString().padLeft(4, '0')}-'
          '${birthDate.month.toString().padLeft(2, '0')}-'
          '${birthDate.day.toString().padLeft(2, '0')}';

      // OAuth 사용자는 이미 토큰이 저장되어 있으므로 프로필 완성 API 호출
      final response = await _dioClient.post(
        '/api/v1/auth/oauth/complete-signup',
        data: {
          'nickname': nickname,
          'birthDate': birthDateString,
          'universityId': universityId,
          'majorId': majorId,
          'agreedPolicyIds': agreedPolicyIds,
        },
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] == true) {
        // 프로필 완성 후 사용자 정보 조회
        return await _fetchAndEmitUserInfo();
      } else {
        throw ServerException(
          message: apiResponse['message'] ?? 'OAuth 회원가입 완료에 실패했습니다.',
          statusCode: response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      final refreshToken = await _secureStorageService.getRefreshToken();
      if (refreshToken != null) {
        // 서버에 로그아웃 요청 (Refresh Token 무효화)
        await _dioClient.post(
          '/api/v1/auth/logout',
          data: RefreshRequestDto(refreshToken: refreshToken).toJson(),
          // 로그아웃 시에는 기존 액세스 토큰을 함께 보내야 할 수 있으므로 no-auth를 쓰지 않거나 상황에 맞춰 결정
        );
      }
    } catch (e) {
      // 서버 호출 실패 로그 (필요 시)
      AppLogger.e('로그아웃 요청 실패: $e'); // Using AppLogger
    } finally {
      // 서버 성공 여부와 관계없이 로컬 인증 정보 삭제
      await _secureStorageService.deleteAllTokens();
      _authStateController.add(null);
    }
  }

  @override
  Future<void> signOutFull() async {
    await signOut();
    await _googleSignIn.signOut();
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      // 보안 저장소에서 토큰 확인
      final accessToken = await _secureStorageService.getAccessToken();
      final refreshToken = await _secureStorageService.getRefreshToken();

      // 토큰이 아예 없으면 null 반환
      if ((accessToken == null || accessToken.isEmpty) &&
          (refreshToken == null || refreshToken.isEmpty)) {
        AppLogger.d('📭 No tokens found in storage');
        return null;
      }

      AppLogger.d('🔐 Tokens found, validating...');

      // 사용자 정보 조회 시도 (인터셉터가 자동으로 토큰 갱신 처리)
      return await _fetchAndEmitUserInfo();
    } catch (e) {
      // 토큰 갱신 실패 또는 유효하지 않은 토큰
      AppLogger.e('❌ 현재 사용자 정보 조회 실패: $e');
      // 실패 시 토큰 삭제
      await _secureStorageService.deleteAllTokens();
      return null;
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/auth/password/reset/request',
        data: {'email': email},
        options: Options(extra: {'no-auth': true}),
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] != true) {
        throw ServerException(
          message: apiResponse['message'] ?? '비밀번호 재설정 이메일 발송에 실패했습니다.',
          statusCode: response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> verifyPasswordResetCode(String email, String code) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/auth/password/reset/verify',
        data: {'email': email, 'code': code},
        options: Options(extra: {'no-auth': true}),
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] != true) {
        throw ServerException(
          message: apiResponse['message'] ?? '인증 코드가 일치하지 않습니다.',
          statusCode: response.statusCode ?? 400,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> confirmPasswordReset(
    String email,
    String code,
    String newPassword,
  ) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/auth/password/reset/confirm',
        data: {'email': email, 'code': code, 'newPassword': newPassword},
        options: Options(extra: {'no-auth': true}),
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] != true) {
        throw ServerException(
          message: apiResponse['message'] ?? '비밀번호 변경에 실패했습니다.',
          statusCode: response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> sendVerificationEmail(String email) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/auth/email/send-verification',
        data: {'email': email},
        options: Options(extra: {'no-auth': true}),
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] == true) {
        _lastVerificationEmail = email;
      } else {
        throw ServerException(
          message: apiResponse['message'] ?? '인증 이메일 발송에 실패했습니다.',
          statusCode: response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
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
      final response = await _dioClient.post(
        '/api/v1/auth/email/verify',
        data: {'email': _lastVerificationEmail, 'code': code},
        options: Options(extra: {'no-auth': true}),
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] != true) {
        throw ServerException(
          message: apiResponse['message'] ?? '인증번호가 일치하지 않습니다.',
          statusCode: response.statusCode ?? 400,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
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

    // Use the same endpoint as sendVerificationEmail (signup/resend was deleted)
    await sendVerificationEmail(_lastVerificationEmail!);
  }

  @override
  Future<void> checkEmailDuplicate(String email) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/auth/email/check',
        data: {'email': email},
        options: Options(extra: {'no-auth': true}),
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] != true) {
        throw ServerException(
          message: apiResponse['message'] ?? '이미 존재하는 이메일입니다',
          statusCode: 409, // Conflict
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> checkNicknameDuplicate(String nickname) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/auth/nickname/check',
        data: {'nickname': nickname},
        options: Options(extra: {'no-auth': true}),
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] != true) {
        throw ServerException(
          message: apiResponse['message'] ?? '이미 존재하는 닉네임입니다',
          statusCode: 409,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<User> updateProfile({
    String? nickname,
    int? universityId,
    int? majorId,
    String? bio,
    String? avatarUrl,
  }) async {
    try {
      // Need to import ProfileUpdateRequestDto
      // Assuming ProfileUpdateRequestDto is in lib/features/profile/data/dto
      // If not, it needs to be created or imported from the correct location.
      // For now, I'll use a direct map.
      final response = await _dioClient.patch(
        '/api/v1/users/me',
        data: {
          'nickname': nickname,
          'universityId': universityId,
          'majorId': majorId,
          'introduction': bio,
          // 'avatarUrl': avatarUrl, // Not included in current DTO. If needed, ProfileUpdateRequestDto must handle it.
        },
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] == true) {
        return await _fetchAndEmitUserInfo();
      } else {
        throw ServerException(
          message: apiResponse['message'] ?? '프로필 업데이트 실패',
          statusCode: response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final response = await _dioClient.delete('/api/v1/users/me');

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] == true) {
        await _secureStorageService.deleteAllTokens();
        _authStateController.add(null);
      } else {
        throw ServerException(
          message: apiResponse['message'] ?? '계정 삭제 실패',
          statusCode: response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<List<PolicyResponseDto>> getPolicies() async {
    try {
      final response = await _dioClient.get('/api/v1/policies');

      // JSON Array 응답 처리
      final List<dynamic> list = response.data;
      return list.map((e) => PolicyResponseDto.fromJson(e)).toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> agreePolicies(List<int> policyIds) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/policies/agree',
        data: PolicyAgreeRequestDto(policyIds: policyIds).toJson(),
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] != true) {
        throw ServerException(
          message: apiResponse['message'] ?? '정책 동의 저장 실패',
          statusCode: response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Stream<User?> get authStateChanges => _authStateController.stream;
  Future<User> _fetchAndEmitUserInfo() async {
    try {
      final response = await _dioClient.get('/api/v1/users/me');
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true) {
        final userDto = UserDto.fromJson(apiResponse['data']);
        final user = userDto.toDomain();
        _authStateController.add(user);
        return user;
      } else {
        throw ServerException(
          message: apiResponse['message'] ?? '사용자 정보 조회 실패',
          statusCode: response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.response != null) {
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        return ServerException(
          message: data['message'] ?? '서버 오류가 발생했습니다',
          statusCode: e.response?.statusCode ?? 500,
        );
      }
      // 응답이 JSON이 아닌 경우 사용자 친화적 메시지 반환
      return ServerException(
        message: '서버 오류가 발생했습니다',
        statusCode: e.response?.statusCode ?? 500,
      );
    }
    return NetworkException('인터넷 연결을 확인해주세요.');
  }

  @override
  Future<String?> getAccessToken() async {
    return await _secureStorageService.getAccessToken();
  }
}
