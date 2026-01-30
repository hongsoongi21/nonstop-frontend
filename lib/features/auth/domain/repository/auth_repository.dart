import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/policy.dart';
import '../entities/user.dart';

/// Repository interface for authentication operations
abstract class AuthRepository {
  /// Sign in with email and password
  Future<Either<Failure, User>> signIn({
    required String email,
    required String password,
  });

  /// Sign in with Google
  Future<Either<Failure, User>> signInWithGoogle({required String idToken});

  /// Signs up a new user with email, password, nickname, and birthDate.
  Future<Either<Failure, User>> signUp({
    required String email,
    required String password,
    required String nickname,
    required DateTime birthDate,
    int? universityId,
    int? majorId,
    List<int>? agreedPolicyIds,
  });

  /// Sign out current user
  Future<Either<Failure, Unit>> signOut();

  /// Sign out current user and Google
  Future<Either<Failure, Unit>> signOutFull();

  /// Get current authenticated user
  Future<Either<Failure, User?>> getCurrentUser();

  /// Send password reset email
  Future<Either<Failure, Unit>> sendPasswordResetEmail(String email);

  /// Verify password reset code
  Future<Either<Failure, Unit>> verifyPasswordResetCode(String email, String code);

  /// Confirm password reset with new password
  Future<Either<Failure, Unit>> confirmPasswordReset(String email, String code, String newPassword);

  /// Send verification code to email
  Future<Either<Failure, Unit>> sendVerificationEmail(String email);

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

  /// Get current access token
  Future<Either<Failure, String?>> getAccessToken();

  /// Get policy list
  Future<Either<Failure, List<Policy>>> getPolicies();

  /// Submit policy agreements
  Future<Either<Failure, Unit>> agreePolicies(List<int> policyIds);

  /// Stream of authentication state changes
  Stream<User?> get authStateChanges;
}
