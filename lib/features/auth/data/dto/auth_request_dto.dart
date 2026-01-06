import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_request_dto.freezed.dart';
part 'auth_request_dto.g.dart';

@freezed
class LoginRequestDto with _$LoginRequestDto {
  const factory LoginRequestDto({
    required String email,
    required String password,
  }) = _LoginRequestDto;

  factory LoginRequestDto.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestDtoFromJson(json);
}

@freezed
class SignUpRequestDto with _$SignUpRequestDto {
  const factory SignUpRequestDto({
    required String email,
    required String password,
    required String nickname,
  }) = _SignUpRequestDto;

  factory SignUpRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestDtoFromJson(json);
}

@freezed
class ProfileUpdateRequestDto with _$ProfileUpdateRequestDto {
  const factory ProfileUpdateRequestDto({
    String? nickname,
    int? universityId,
    int? majorId,
    String? introduction,
    String? preferredLanguage,
  }) = _ProfileUpdateRequestDto;

  factory ProfileUpdateRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileUpdateRequestDtoFromJson(json);
}

@freezed
class RefreshRequestDto with _$RefreshRequestDto {
  const factory RefreshRequestDto({
    required String refreshToken,
  }) = _RefreshRequestDto;

  factory RefreshRequestDto.fromJson(Map<String, dynamic> json) =>
      _$RefreshRequestDtoFromJson(json);
}
