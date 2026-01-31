// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ReportRequestDto _$ReportRequestDtoFromJson(Map<String, dynamic> json) {
  return _ReportRequestDto.fromJson(json);
}

/// @nodoc
mixin _$ReportRequestDto {
  ReportReasonType get reason => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this ReportRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReportRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReportRequestDtoCopyWith<ReportRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportRequestDtoCopyWith<$Res> {
  factory $ReportRequestDtoCopyWith(
    ReportRequestDto value,
    $Res Function(ReportRequestDto) then,
  ) = _$ReportRequestDtoCopyWithImpl<$Res, ReportRequestDto>;
  @useResult
  $Res call({ReportReasonType reason, String? description});
}

/// @nodoc
class _$ReportRequestDtoCopyWithImpl<$Res, $Val extends ReportRequestDto>
    implements $ReportRequestDtoCopyWith<$Res> {
  _$ReportRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReportRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? reason = null, Object? description = freezed}) {
    return _then(
      _value.copyWith(
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as ReportReasonType,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReportRequestDtoImplCopyWith<$Res>
    implements $ReportRequestDtoCopyWith<$Res> {
  factory _$$ReportRequestDtoImplCopyWith(
    _$ReportRequestDtoImpl value,
    $Res Function(_$ReportRequestDtoImpl) then,
  ) = __$$ReportRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ReportReasonType reason, String? description});
}

/// @nodoc
class __$$ReportRequestDtoImplCopyWithImpl<$Res>
    extends _$ReportRequestDtoCopyWithImpl<$Res, _$ReportRequestDtoImpl>
    implements _$$ReportRequestDtoImplCopyWith<$Res> {
  __$$ReportRequestDtoImplCopyWithImpl(
    _$ReportRequestDtoImpl _value,
    $Res Function(_$ReportRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReportRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? reason = null, Object? description = freezed}) {
    return _then(
      _$ReportRequestDtoImpl(
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as ReportReasonType,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportRequestDtoImpl implements _ReportRequestDto {
  const _$ReportRequestDtoImpl({required this.reason, this.description});

  factory _$ReportRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportRequestDtoImplFromJson(json);

  @override
  final ReportReasonType reason;
  @override
  final String? description;

  @override
  String toString() {
    return 'ReportRequestDto(reason: $reason, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportRequestDtoImpl &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, reason, description);

  /// Create a copy of ReportRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportRequestDtoImplCopyWith<_$ReportRequestDtoImpl> get copyWith =>
      __$$ReportRequestDtoImplCopyWithImpl<_$ReportRequestDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportRequestDtoImplToJson(this);
  }
}

abstract class _ReportRequestDto implements ReportRequestDto {
  const factory _ReportRequestDto({
    required final ReportReasonType reason,
    final String? description,
  }) = _$ReportRequestDtoImpl;

  factory _ReportRequestDto.fromJson(Map<String, dynamic> json) =
      _$ReportRequestDtoImpl.fromJson;

  @override
  ReportReasonType get reason;
  @override
  String? get description;

  /// Create a copy of ReportRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportRequestDtoImplCopyWith<_$ReportRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
