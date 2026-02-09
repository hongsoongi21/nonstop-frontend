import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_dto.freezed.dart';
part 'report_dto.g.dart';

/// Report reason types matching backend enum
enum ReportReasonType {
  @JsonValue('SPAM')
  spam,
  @JsonValue('ABUSE')
  abuse,
  @JsonValue('SEXUAL')
  sexual,
  @JsonValue('HATE')
  hate,
  @JsonValue('ILLEGAL')
  illegal,
  @JsonValue('PRIVACY')
  privacy,
  @JsonValue('IMPERSONATION')
  impersonation,
  @JsonValue('ETC')
  etc,
}

/// Request DTO for reporting content
@freezed
class ReportRequestDto with _$ReportRequestDto {
  const factory ReportRequestDto({
    required ReportReasonType reason,
    String? description,
  }) = _ReportRequestDto;

  factory ReportRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ReportRequestDtoFromJson(json);
}
