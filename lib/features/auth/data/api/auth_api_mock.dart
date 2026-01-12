import 'dart:async';

import '../../domain/entities/user.dart';
import 'auth_api.dart';

/// Mock implementation of AuthApi for development
class AuthApiMock implements AuthApi {
  final _authStateController = StreamController<User?>.broadcast();
  User? _currentUser;

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
      fullName: 'Mock User',
      university: 'Mock University',
      major: 'Computer Science',
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
    required String fullName,
    String? university,
    String? major,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock validation
    if (email.isEmpty || password.isEmpty || fullName.isEmpty) {
      throw Exception('Email, password, and full name are required');
    }

    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }

    // Create mock user
    _currentUser = User(
      id: 'mock_user_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      fullName: fullName,
      university: university ?? 'Not specified',
      major: major ?? 'Not specified',
      isEmailVerified: false, // New users need email verification
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    _authStateController.add(_currentUser);
    return _currentUser!;
  }

  @override
  Future<void> signOut() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    _currentUser = null;
    _authStateController.add(null);
  }

  @override
  Future<User?> getCurrentUser() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _currentUser;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    if (email.isEmpty) {
      throw Exception('Email is required');
    }

    // Mock success - in real implementation, this would send an email
    // Password reset email sent successfully
  }

  @override
  Future<void> verifyEmail(String code) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    if (code != '123456') {
      throw Exception('Invalid verification code');
    }

    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(isEmailVerified: true);
      _authStateController.add(_currentUser);
    }
  }

  @override
  Future<void> resendEmailVerification() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock success - in real implementation, this would resend verification email
    // Email verification resent successfully
  }

  @override
  Future<User> updateProfile({
    String? fullName,
    String? university,
    String? major,
    String? bio,
    String? avatarUrl,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    if (_currentUser == null) {
      throw Exception('User not authenticated');
    }

    _currentUser = _currentUser!.copyWith(
      fullName: fullName ?? _currentUser!.fullName,
      university: university ?? _currentUser!.university,
      major: major ?? _currentUser!.major,
      bio: bio ?? _currentUser!.bio,
      avatarUrl: avatarUrl ?? _currentUser!.avatarUrl,
      updatedAt: DateTime.now(),
    );

    _authStateController.add(_currentUser);
    return _currentUser!;
  }

  @override
  Future<void> deleteAccount() async {
    // Mock implementation
  }

  @override
  Future<String?> getAccessToken() async {
    return 'mock_token';
  }

  @override
  Stream<User?> get authStateChanges => Stream.empty();

  /// Clean up resources
  void dispose() {
    _authStateController.close();
  }
}
