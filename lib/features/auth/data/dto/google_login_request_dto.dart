import 'package:freezed_annotation/freezed_annotation.dart';

part 'google_login_request_dto.freezed.dart';
part 'google_login_request_dto.g.dart';

@freezed
class GoogleLoginRequestDto with _$GoogleLoginRequestDto {
  const factory GoogleLoginRequestDto({
    required String idToken,
  }) = _GoogleLoginRequestDto;

  factory GoogleLoginRequestDto.fromJson(Map<String, dynamic> json) =>
      _$GoogleLoginRequestDtoFromJson(json);
}