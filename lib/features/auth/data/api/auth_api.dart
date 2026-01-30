import '../../domain/entities/user.dart';
import '../dto/policy_response_dto.dart';

/// API interface for authentication operations
abstract class AuthApi {
  /// Sign in with email and password
  Future<User> signIn({
    required String email,
    required String password,
  });

  /// Sign up with email, password, and user details
  Future<User> signUp({
    required String email,
    required String password,
    required String nickname,
    required DateTime birthDate,
    int? universityId,
    int? majorId,
    List<int>? agreedPolicyIds,
  });

  /// Sign out current user
  Future<void> signOut();

  /// Get current authenticated user
  Future<User?> getCurrentUser();

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email);

  /// Verify password reset code
  Future<void> verifyPasswordResetCode(String email, String code);

  /// Confirm password reset with new password
  Future<void> confirmPasswordReset(String email, String code, String newPassword);

  /// Send verification code to email
  Future<void> sendVerificationEmail(String email);

  /// Verify email with confirmation code
  Future<void> verifyEmail(String code);

  /// Resend email verification
  Future<void> resendEmailVerification();

  /// Check if email is available
  Future<void> checkEmailDuplicate(String email);

  /// Check if nickname is available
  Future<void> checkNicknameDuplicate(String nickname);

  /// Update user profile
  Future<User> updateProfile({
    String? nickname,
    int? universityId,
    int? majorId,
    String? bio,
    String? avatarUrl,
  });

  /// Delete user account
  Future<void> deleteAccount();

  /// Get current access token
  Future<String?> getAccessToken();

  /// Sign in with Google
  Future<User> signInWithGoogle({
    required String idToken,
  });

  /// Get policy list
  Future<List<PolicyResponseDto>> getPolicies();

  /// Submit policy agreements
  Future<void> agreePolicies(List<int> policyIds);

  /// Stream of authentication state changes
  Stream<User?> get authStateChanges;
}
