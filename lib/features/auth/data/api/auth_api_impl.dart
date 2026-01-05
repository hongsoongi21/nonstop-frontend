import 'dart:async';
import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/user.dart';
import '../dto/auth_request_dto.dart';
import '../dto/auth_response_dto.dart';
import '../dto/user_dto.dart';
import 'auth_api.dart';

class AuthApiImpl implements AuthApi {
  final DioClient _dioClient;
  final _authStateController = StreamController<User?>.broadcast();

  AuthApiImpl(this._dioClient);

  @override
  Future<User> signIn({required String email, required String password}) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/auth/login',
        data: LoginRequestDto(email: email, password: password).toJson(),
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] == true) {
        final tokenData = TokenResponseDto.fromJson(apiResponse['data']);
        
        // 로그인 성공 시 획득한 Access Token을 DioClient 헤더에 설정합니다.
        // 이후 모든 API 요청에 Authorization: Bearer <token>이 자동으로 포함됩니다.
        _dioClient.updateAuthToken(tokenData.accessToken);
        
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
  Future<User> signUp({
    required String email,
    required String password,
    required String nickname,
  }) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/auth/signup',
        data: SignUpRequestDto(
          email: email,
          password: password,
          nickname: nickname,
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
      // We might need to send a request to the server to invalidate the refresh token
      // For now, just clear local auth
      _dioClient.clearAuth();
      _authStateController.add(null);
    } catch (e) {
      // Even if server call fails, we should clear local state
      _dioClient.clearAuth();
      _authStateController.add(null);
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      return await _fetchAndEmitUserInfo();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    // Implement based on backend API when available
  }

  @override
  Future<void> verifyEmail(String code) async {
    // Implement based on backend API when available
  }

  @override
  Future<void> resendEmailVerification() async {
    // Implement based on backend API when available
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
          message: apiResponse['message'] ?? 'Email already exists',
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
          message: apiResponse['message'] ?? 'Nickname already exists',
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
      final response = await _dioClient.patch(
        '/api/v1/users/me',
        data: ProfileUpdateRequestDto(
          nickname: nickname,
          universityId: universityId,
          majorId: majorId,
          introduction: bio,
        ).toJson(),
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] == true) {
        return await _fetchAndEmitUserInfo();
      } else {
        throw ServerException(
          message: apiResponse['message'] ?? 'Update profile failed',
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
        _dioClient.clearAuth();
        _authStateController.add(null);
      } else {
        throw ServerException(
          message: apiResponse['message'] ?? 'Delete account failed',
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
          message: apiResponse['message'] ?? 'Failed to fetch user info',
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
          message: data['message'] ?? 'Server error',
          statusCode: e.response?.statusCode ?? 500,
        );
      }
      return ServerException(
        message: e.message ?? 'Server error',
        statusCode: e.response?.statusCode ?? 500,
      );
    }
    return NetworkException('인터넷 연결을 확인해주세요.');
  }
}
