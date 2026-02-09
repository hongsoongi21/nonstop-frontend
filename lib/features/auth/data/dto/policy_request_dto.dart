import 'package:freezed_annotation/freezed_annotation.dart';

part 'policy_request_dto.freezed.dart';
part 'policy_request_dto.g.dart';

@freezed
class PolicyAgreeRequestDto with _$PolicyAgreeRequestDto {
  const factory PolicyAgreeRequestDto({
    required List<int> policyIds,
  }) = _PolicyAgreeRequestDto;

  factory PolicyAgreeRequestDto.fromJson(Map<String, dynamic> json) =>
      _$PolicyAgreeRequestDtoFromJson(json);
}
