// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'semester_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SemesterDto _$SemesterDtoFromJson(Map<String, dynamic> json) {
  return _SemesterDto.fromJson(json);
}

/// @nodoc
mixin _$SemesterDto {
  int get id => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  SemesterType get type => throw _privateConstructorUsedError;
  bool get isCurrent => throw _privateConstructorUsedError;

  /// Serializes this SemesterDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SemesterDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SemesterDtoCopyWith<SemesterDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SemesterDtoCopyWith<$Res> {
  factory $SemesterDtoCopyWith(
    SemesterDto value,
    $Res Function(SemesterDto) then,
  ) = _$SemesterDtoCopyWithImpl<$Res, SemesterDto>;
  @useResult
  $Res call({int id, int year, SemesterType type, bool isCurrent});
}

/// @nodoc
class _$SemesterDtoCopyWithImpl<$Res, $Val extends SemesterDto>
    implements $SemesterDtoCopyWith<$Res> {
  _$SemesterDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SemesterDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? year = null,
    Object? type = null,
    Object? isCurrent = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as SemesterType,
            isCurrent: null == isCurrent
                ? _value.isCurrent
                : isCurrent // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SemesterDtoImplCopyWith<$Res>
    implements $SemesterDtoCopyWith<$Res> {
  factory _$$SemesterDtoImplCopyWith(
    _$SemesterDtoImpl value,
    $Res Function(_$SemesterDtoImpl) then,
  ) = __$$SemesterDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int year, SemesterType type, bool isCurrent});
}

/// @nodoc
class __$$SemesterDtoImplCopyWithImpl<$Res>
    extends _$SemesterDtoCopyWithImpl<$Res, _$SemesterDtoImpl>
    implements _$$SemesterDtoImplCopyWith<$Res> {
  __$$SemesterDtoImplCopyWithImpl(
    _$SemesterDtoImpl _value,
    $Res Function(_$SemesterDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SemesterDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? year = null,
    Object? type = null,
    Object? isCurrent = null,
  }) {
    return _then(
      _$SemesterDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as SemesterType,
        isCurrent: null == isCurrent
            ? _value.isCurrent
            : isCurrent // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SemesterDtoImpl implements _SemesterDto {
  const _$SemesterDtoImpl({
    required this.id,
    required this.year,
    required this.type,
    this.isCurrent = false,
  });

  factory _$SemesterDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SemesterDtoImplFromJson(json);

  @override
  final int id;
  @override
  final int year;
  @override
  final SemesterType type;
  @override
  @JsonKey()
  final bool isCurrent;

  @override
  String toString() {
    return 'SemesterDto(id: $id, year: $year, type: $type, isCurrent: $isCurrent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SemesterDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isCurrent, isCurrent) ||
                other.isCurrent == isCurrent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, year, type, isCurrent);

  /// Create a copy of SemesterDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SemesterDtoImplCopyWith<_$SemesterDtoImpl> get copyWith =>
      __$$SemesterDtoImplCopyWithImpl<_$SemesterDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SemesterDtoImplToJson(this);
  }
}

abstract class _SemesterDto implements SemesterDto {
  const factory _SemesterDto({
    required final int id,
    required final int year,
    required final SemesterType type,
    final bool isCurrent,
  }) = _$SemesterDtoImpl;

  factory _SemesterDto.fromJson(Map<String, dynamic> json) =
      _$SemesterDtoImpl.fromJson;

  @override
  int get id;
  @override
  int get year;
  @override
  SemesterType get type;
  @override
  bool get isCurrent;

  /// Create a copy of SemesterDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SemesterDtoImplCopyWith<_$SemesterDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
