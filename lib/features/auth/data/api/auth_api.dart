import '../../domain/entities/user.dart';
import '../dto/auth_response_dto.dart';
import '../dto/policy_response_dto.dart';

/// Result of OAuth login - existing user, new user, or incomplete profile
sealed class OAuthLoginResult {}

/// Existing user with complete profile
class OAuthExistingUser extends OAuthLoginResult {
  final User user;
  OAuthExistingUser(this.user);
}

/// New user who needs to complete signup
class OAuthNewUser extends OAuthLoginResult {
  final OAuthSignupData signupData;
  OAuthNewUser(this.signupData);
}

/// Existing user with incomplete profile (missing birthDate or policy agreements)
class OAuthIncompleteUser extends OAuthLoginResult {
  final OAuthSignupData signupData;
  final bool hasBirthDate;
  final bool hasAgreedAllMandatory;

  OAuthIncompleteUser({
    required this.signupData,
    required this.hasBirthDate,
    required this.hasAgreedAllMandatory,
  });
}

/// API interface for authentication operations
abstract class AuthApi {
  /// Sign in with email and password
  Future<User> signIn({required String email, required String password});

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

  /// Sign out current user and Google
  Future<void> signOutFull();

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
  /// Returns OAuthExistingUser for existing users, OAuthNewUser for new users
  Future<OAuthLoginResult> signInWithGoogle({required String idToken});

  /// Sign in with Apple
  /// Returns OAuthExistingUser for existing users, OAuthNewUser for new users
  Future<OAuthLoginResult> signInWithApple({
    required String idToken,
    String? authorizationCode,
    String? firstName,
    String? lastName,
  });

  /// Complete OAuth signup for new users
  Future<User> completeOAuthSignup({
    required String nickname,
    required DateTime birthDate,
    int? universityId,
    int? majorId,
    List<int>? agreedPolicyIds,
  });

  /// Get policy list
  Future<List<PolicyResponseDto>> getPolicies();

  /// Submit policy agreements
  Future<void> agreePolicies(List<int> policyIds);

  /// Stream of authentication state changes
  Stream<User?> get authStateChanges;
}
