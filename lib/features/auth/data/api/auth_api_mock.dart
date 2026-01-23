import 'dart:async';

import '../../domain/entities/user.dart';
import 'auth_api.dart';

/// Mock implementation of AuthApi for development
class AuthApiMock implements AuthApi {
  final _authStateController = StreamController<User?>.broadcast();
  User? _currentUser;

  @override
  Future<User> signInWithGoogle({required String idToken}) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Create mock user from Google
    _currentUser = User(
      id: 'google_user_${DateTime.now().millisecondsSinceEpoch}',
      email: 'google@example.com',
      nickname: 'GoogleUser',
      fullName: 'Google User',
      universityId: null,
      majorId: null,
      isEmailVerified: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    _authStateController.add(_currentUser);
    return _currentUser!;
  }

  @override
  Future<User> signIn({required String email, required String password}) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock validation
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password are required');
    }

    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }

    // Create mock user
    _currentUser = User(
      id: 'mock_user_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      nickname: email.split('@').first,
      fullName: 'Mock User',
      universityId: 1,
      majorId: 101,
      isEmailVerified: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    _authStateController.add(_currentUser);
    return _currentUser!;
  }

  @override
  Future<User> signUp({
    required String email,
    required String password,
    required String nickname,
    int? universityId,
    int? majorId,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // 네트워크 지연 시뮬레이션
    
    return User(
      id: 'mock_user_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      nickname: nickname,
      universityId: universityId,
      majorId: majorId,
    );
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
    _authStateController.add(null);
  }

  @override
  Future<User?> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _currentUser;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> verifyEmail(String code) async {
    await Future.delayed(const Duration(seconds: 1));
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(isEmailVerified: true);
      _authStateController.add(_currentUser);
    }
  }

  @override
  Future<void> resendEmailVerification() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> checkEmailDuplicate(String email) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (email == 'taken@example.com') {
      throw Exception('Email already exists');
    }
  }

  @override
  Future<void> checkNicknameDuplicate(String nickname) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (nickname == 'taken') {
      throw Exception('Nickname already exists');
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
    await Future.delayed(const Duration(seconds: 1));

    if (_currentUser == null) {
      throw Exception('User not authenticated');
    }

    _currentUser = _currentUser!.copyWith(
      nickname: nickname ?? _currentUser!.nickname,
      universityId: universityId ?? _currentUser!.universityId,
      majorId: majorId ?? _currentUser!.majorId,
      bio: bio ?? _currentUser!.bio,
      avatarUrl: avatarUrl ?? _currentUser!.avatarUrl,
      updatedAt: DateTime.now(),
    );

    _authStateController.add(_currentUser);
    return _currentUser!;
  }

  @override
  Future<void> deleteAccount() async {
    await Future.delayed(const Duration(seconds: 1));
    _currentUser = null;
    _authStateController.add(null);
  }

  @override
  Future<String?> getAccessToken() async {
    return 'mock_token';
  }

  @override
  Stream<User?> get authStateChanges => _authStateController.stream;

  void dispose() {
    _authStateController.close();
  }
}
