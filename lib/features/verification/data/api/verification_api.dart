import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../dto/verification_dto.dart';

/// Abstract interface for verification API
abstract interface class VerificationApi {
  /// Upload student ID photo for manual verification
  ///
  /// [filePath] - Local file path to the student ID image
  Future<Either<ApiException, void>> uploadStudentId({
    required String filePath,
  });

  /// Request email verification code
  ///
  /// [request] - Email verification request containing university email
  Future<Either<ApiException, void>> requestEmailVerification({
    required EmailVerificationRequestDto request,
  });

  /// Confirm email verification with code
  ///
  /// [request] - Email verification confirmation containing email and code
  Future<Either<ApiException, void>> confirmEmailVerification({
    required EmailVerificationConfirmDto request,
  });

  /// Get current user's verification status
  Future<Either<ApiException, VerificationStatusDto>> getVerificationStatus();
}
