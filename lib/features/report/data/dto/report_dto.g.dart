// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReportRequestDtoImpl _$$ReportRequestDtoImplFromJson(
  Map<String, dynamic> json,
) => _$ReportRequestDtoImpl(
  reason: $enumDecode(_$ReportReasonTypeEnumMap, json['reason']),
  description: json['description'] as String?,
);

Map<String, dynamic> _$$ReportRequestDtoImplToJson(
  _$ReportRequestDtoImpl instance,
) => <String, dynamic>{
  'reason': _$ReportReasonTypeEnumMap[instance.reason]!,
  'description': instance.description,
};

const _$ReportReasonTypeEnumMap = {
  ReportReasonType.spam: 'SPAM',
  ReportReasonType.abuse: 'ABUSE',
  ReportReasonType.sexual: 'SEXUAL',
  ReportReasonType.hate: 'HATE',
  ReportReasonType.illegal: 'ILLEGAL',
  ReportReasonType.privacy: 'PRIVACY',
  ReportReasonType.impersonation: 'IMPERSONATION',
  ReportReasonType.etc: 'ETC',
};
