import 'package:freezed_annotation/freezed_annotation.dart';

part 'verification_dto.freezed.dart';
part 'verification_dto.g.dart';

/// Verification method types matching backend enum
enum VerificationMethod {
  @JsonValue('EMAIL_DOMAIN')
  emailDomain,
  @JsonValue('MANUAL_REVIEW')
  manualReview,
  @JsonValue('STUDENT_ID_PHOTO')
  studentIdPhoto,
}

/// Request DTO for email verification request
@freezed
class EmailVerificationRequestDto with _$EmailVerificationRequestDto {
  const factory EmailVerificationRequestDto({
    required String email,
  }) = _EmailVerificationRequestDto;

  factory EmailVerificationRequestDto.fromJson(Map<String, dynamic> json) =>
      _$EmailVerificationRequestDtoFromJson(json);
}

/// Request DTO for email verification confirmation
/// Note: Backend only requires 'code', not 'email'
@freezed
class EmailVerificationConfirmDto with _$EmailVerificationConfirmDto {
  const factory EmailVerificationConfirmDto({
    required String code,
  }) = _EmailVerificationConfirmDto;

  factory EmailVerificationConfirmDto.fromJson(Map<String, dynamic> json) =>
      _$EmailVerificationConfirmDtoFromJson(json);
}

/// Response DTO for verification status
@freezed
class VerificationStatusDto with _$VerificationStatusDto {
  const factory VerificationStatusDto({
    required bool isUniversityVerified,
    VerificationMethod? verificationMethod,
  }) = _VerificationStatusDto;

  factory VerificationStatusDto.fromJson(Map<String, dynamic> json) =>
      _$VerificationStatusDtoFromJson(json);
}
