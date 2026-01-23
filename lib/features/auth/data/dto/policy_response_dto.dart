import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/policy.dart';

part 'policy_response_dto.freezed.dart';
part 'policy_response_dto.g.dart';

@freezed
class PolicyResponseDto with _$PolicyResponseDto {
  const factory PolicyResponseDto({
    required int id,
    required String type,
    required String title,
    required String url,
    required bool isMandatory,
  }) = _PolicyResponseDto;

  factory PolicyResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PolicyResponseDtoFromJson(json);

  const PolicyResponseDto._();

  Policy toDomain() {
    return Policy(
      id: id,
      type: type,
      title: title,
      url: url,
      isMandatory: isMandatory,
    );
  }
}
