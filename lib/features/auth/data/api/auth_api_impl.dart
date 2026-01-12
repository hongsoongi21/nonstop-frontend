import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_client.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../domain/entities/user.dart';
import '../dto/auth_response_dto.dart';
import '../dto/user_dto.dart';
import 'auth_api.dart';

final authApiProvider = Provider<AuthApi>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AuthApiImpl(dioClient);
});

class AuthApiImpl implements AuthApi {
  final DioClient _dioClient;
  final SecureStorageService _storage = SecureStorageService();

  AuthApiImpl(this._dioClient);

  @override
  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    // 1. Login to get tokens
    final response = await _dioClient.post(
      '/api/v1/auth/login',
      data: {'email': email, 'password': password},
    );

    final authResponse = AuthResponseDto.fromJson(response.data['data']);
    
    // 2. Save tokens
    await _storage.saveAccessToken(authResponse.accessToken);
    await _storage.saveRefreshToken(authResponse.refreshToken);

    // 3. Get User Info
    return await _fetchCurrentUser();
  }

  @override
  Future<User> signUp({
    required String email,
    required String password,
    required String fullName,
    String? university,
    String? major,
  }) async {
    // 1. Sign up
    await _dioClient.post(
      '/api/v1/auth/signup',
      data: {
        'email': email,
        'password': password,
        'nickname': fullName, // Using fullName as nickname
        'universityId': int.tryParse(university ?? '') ?? 0, // Should be handled better
        'majorId': int.tryParse(major ?? '') ?? 0, // Should be handled better
      },
    );

    // 2. Login to get tokens and return User
    return signIn(email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await _storage.clearTokens();
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final token = await _storage.getAccessToken();
      if (token == null) return null;
      return await _fetchCurrentUser();
    } catch (e) {
      await _storage.clearTokens();
      return null;
    }
  }

  Future<User> _fetchCurrentUser() async {
    final response = await _dioClient.get('/api/v1/users/me');
    final userDto = UserDto.fromJson(response.data['data']);
    return userDto.toDomain();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    // Not implemented in backend yet or path unknown
    throw UnimplementedError();
  }

  @override
  Future<void> verifyEmail(String code) async {
    // Not implemented in backend yet or path unknown
    throw UnimplementedError();
  }

  @override
  Future<void> resendEmailVerification() async {
    // Not implemented in backend yet or path unknown
    throw UnimplementedError();
  }

  @override
  Future<User> updateProfile({String? fullName, String? university, String? major, String? bio, String? avatarUrl}) async {
     // Stub
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAccount() async {
      await _dioClient.delete('/api/v1/users/me');
      await _storage.clearTokens();
  }

  @override
  Future<String?> getAccessToken() async {
    return await _storage.getAccessToken();
  }

  @override
  Stream<User?> get authStateChanges => Stream.empty();
}
