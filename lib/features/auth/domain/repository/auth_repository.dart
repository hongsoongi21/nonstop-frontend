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
    required String fullName,
    String? university,
    String? major,
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

  /// Update user profile
  Future<Either<Failure, User>> updateProfile({
    String? fullName,
    String? university,
    String? major,
    String? bio,
    String? avatarUrl,
  });

  /// Delete user account
  Future<Either<Failure, Unit>> deleteAccount();

  /// Stream of authentication state changes
  Stream<User?> get authStateChanges;
}
