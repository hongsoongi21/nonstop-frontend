import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user.dart';

/// Repository interface for authentication operations
abstract class AuthRepository {
  /// Sign in with email and password
  Future<Either<Failure, User>> signIn({
    required String email,
    required String password,
  });

  /// Sign up with email, password, and user details
  Future<Either<Failure, User>> signUp({
    required String email,
    required String password,
    required String nickname,
  });

  /// Sign out current user
  Future<Either<Failure, Unit>> signOut();

  /// Get current authenticated user
  Future<Either<Failure, User?>> getCurrentUser();

  /// Send password reset email
  Future<Either<Failure, Unit>> sendPasswordResetEmail(String email);

  /// Verify email with confirmation code
  Future<Either<Failure, Unit>> verifyEmail(String code);

  /// Resend email verification
  Future<Either<Failure, Unit>> resendEmailVerification();

  /// Check if email is available
  Future<Either<Failure, Unit>> checkEmailDuplicate(String email);

  /// Check if nickname is available
  Future<Either<Failure, Unit>> checkNicknameDuplicate(String nickname);

  /// Update user profile
  Future<Either<Failure, User>> updateProfile({
    String? nickname,
    int? universityId,
    int? majorId,
    String? bio,
    String? avatarUrl,
  });

  /// Delete user account
  Future<Either<Failure, Unit>> deleteAccount();

  /// Stream of authentication state changes
  Stream<User?> get authStateChanges;
}
