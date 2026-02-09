import 'package:freezed_annotation/freezed_annotation.dart';

part 'apple_login_request_dto.freezed.dart';
part 'apple_login_request_dto.g.dart';

@freezed
class AppleLoginRequestDto with _$AppleLoginRequestDto {
  const factory AppleLoginRequestDto({
    required String idToken,
    String? authorizationCode,
    String? firstName,
    String? lastName,
  }) = _AppleLoginRequestDto;

  factory AppleLoginRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AppleLoginRequestDtoFromJson(json);
}
