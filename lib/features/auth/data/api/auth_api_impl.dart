import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../../domain/entities/user.dart';
import '../dto/auth_request_dto.dart';
import '../dto/auth_response_dto.dart'; // Ensure TokenResponseDto is imported via this
import '../dto/google_login_request_dto.dart';
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

  AuthApiImpl(this._dioClient, this._secureStorageService);

  @override
  Future<User> signIn({required String email, required String password}) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/auth/login',
        data: LoginRequestDto(email: email, password: password).toJson(),
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
  Future<User> signInWithGoogle({required String idToken}) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/auth/google',
        data: GoogleLoginRequestDto(idToken: idToken).toJson(),
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] == true) {
        final tokenData = TokenResponseDto.fromJson(apiResponse['data']);

        if (!kReleaseMode) {
          AppLogger.d('[NONSTOP] 🔑 Google Login Tokens Received:');
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
          message: apiResponse['message'] ?? '구글 로그인에 실패했습니다.',
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
      final birthDateString = '${birthDate.year.toString().padLeft(4, '0')}-'
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
  Future<void> signOut() async {
    try {
      final refreshToken = await _secureStorageService.getRefreshToken();
      if (refreshToken != null) {
        // 서버에 로그아웃 요청 (Refresh Token 무효화)
        await _dioClient.post(
          '/api/v1/auth/logout',
          data: RefreshRequestDto(refreshToken: refreshToken).toJson(),
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
  Future<User?> getCurrentUser() async {
    try {
      // Avoid calling `/users/me` when we don't have a token yet.
      // This prevents noisy 401s during cold start.
      final accessToken = await _secureStorageService.getAccessToken();
      if (accessToken == null || accessToken.isEmpty) return null;

      return await _fetchAndEmitUserInfo();
    } catch (e) {
      AppLogger.e('현재 사용자 정보 조회 실패: $e'); // Using AppLogger
      return null;
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    // 백엔드 API 제공 시 구현
    throw UnimplementedError(
      'sendPasswordResetEmail not implemented',
    ); // Add explicit error
  }

  @override
  Future<void> verifyEmail(String code) async {
    // 백엔드 API 제공 시 구현
    throw UnimplementedError(
      'verifyEmail not implemented',
    ); // Add explicit error
  }

  @override
  Future<void> resendEmailVerification() async {
    // 백엔드 API 제공 시 구현
    throw UnimplementedError(
      'resendEmailVerification not implemented',
    ); // Add explicit error
  }

  @override
  Future<void> checkEmailDuplicate(String email) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/auth/email/check',
        data: {'email': email},
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
      return ServerException(
        message: e.message ?? '서버 오류가 발생했습니다',
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
