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
  }) = _TokenResponseDto;

  factory TokenResponseDto.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseDtoFromJson(json);
}
