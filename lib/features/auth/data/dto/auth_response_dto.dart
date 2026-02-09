import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_response_dto.freezed.dart';
part 'auth_response_dto.g.dart';

@freezed
class TokenResponseDto with _$TokenResponseDto {
  const factory TokenResponseDto({
    required String accessToken,
    required String refreshToken,
    int? userId,
    @Default(false) bool emailVerified,
    @Default(false) bool hasAgreedAllMandatory,
    @Default(false) bool hasBirthDate,
    @Default(false) bool isNewUser,
  }) = _TokenResponseDto;

  factory TokenResponseDto.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseDtoFromJson(json);
}

/// OAuth signup data to pass to signup screen
class OAuthSignupData {
  final String email;
  final String? displayName;
  final String provider; // 'google' or 'apple'
  final String accessToken;
  final String refreshToken;

  const OAuthSignupData({
    required this.email,
    this.displayName,
    required this.provider,
    required this.accessToken,
    required this.refreshToken,
  });
}
