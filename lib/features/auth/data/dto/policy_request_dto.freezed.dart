// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'policy_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PolicyAgreeRequestDto _$PolicyAgreeRequestDtoFromJson(
  Map<String, dynamic> json,
) {
  return _PolicyAgreeRequestDto.fromJson(json);
}

/// @nodoc
mixin _$PolicyAgreeRequestDto {
  List<int> get policyIds => throw _privateConstructorUsedError;

  /// Serializes this PolicyAgreeRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PolicyAgreeRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PolicyAgreeRequestDtoCopyWith<PolicyAgreeRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PolicyAgreeRequestDtoCopyWith<$Res> {
  factory $PolicyAgreeRequestDtoCopyWith(
    PolicyAgreeRequestDto value,
    $Res Function(PolicyAgreeRequestDto) then,
  ) = _$PolicyAgreeRequestDtoCopyWithImpl<$Res, PolicyAgreeRequestDto>;
  @useResult
  $Res call({List<int> policyIds});
}

/// @nodoc
class _$PolicyAgreeRequestDtoCopyWithImpl<
  $Res,
  $Val extends PolicyAgreeRequestDto
>
    implements $PolicyAgreeRequestDtoCopyWith<$Res> {
  _$PolicyAgreeRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PolicyAgreeRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? policyIds = null}) {
    return _then(
      _value.copyWith(
            policyIds: null == policyIds
                ? _value.policyIds
                : policyIds // ignore: cast_nullable_to_non_nullable
                      as List<int>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PolicyAgreeRequestDtoImplCopyWith<$Res>
    implements $PolicyAgreeRequestDtoCopyWith<$Res> {
  factory _$$PolicyAgreeRequestDtoImplCopyWith(
    _$PolicyAgreeRequestDtoImpl value,
    $Res Function(_$PolicyAgreeRequestDtoImpl) then,
  ) = __$$PolicyAgreeRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<int> policyIds});
}

/// @nodoc
class __$$PolicyAgreeRequestDtoImplCopyWithImpl<$Res>
    extends
        _$PolicyAgreeRequestDtoCopyWithImpl<$Res, _$PolicyAgreeRequestDtoImpl>
    implements _$$PolicyAgreeRequestDtoImplCopyWith<$Res> {
  __$$PolicyAgreeRequestDtoImplCopyWithImpl(
    _$PolicyAgreeRequestDtoImpl _value,
    $Res Function(_$PolicyAgreeRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PolicyAgreeRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? policyIds = null}) {
    return _then(
      _$PolicyAgreeRequestDtoImpl(
        policyIds: null == policyIds
            ? _value._policyIds
            : policyIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PolicyAgreeRequestDtoImpl implements _PolicyAgreeRequestDto {
  const _$PolicyAgreeRequestDtoImpl({required final List<int> policyIds})
    : _policyIds = policyIds;

  factory _$PolicyAgreeRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PolicyAgreeRequestDtoImplFromJson(json);

  final List<int> _policyIds;
  @override
  List<int> get policyIds {
    if (_policyIds is EqualUnmodifiableListView) return _policyIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_policyIds);
  }

  @override
  String toString() {
    return 'PolicyAgreeRequestDto(policyIds: $policyIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PolicyAgreeRequestDtoImpl &&
            const DeepCollectionEquality().equals(
              other._policyIds,
              _policyIds,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_policyIds));

  /// Create a copy of PolicyAgreeRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PolicyAgreeRequestDtoImplCopyWith<_$PolicyAgreeRequestDtoImpl>
  get copyWith =>
      __$$PolicyAgreeRequestDtoImplCopyWithImpl<_$PolicyAgreeRequestDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PolicyAgreeRequestDtoImplToJson(this);
  }
}

abstract class _PolicyAgreeRequestDto implements PolicyAgreeRequestDto {
  const factory _PolicyAgreeRequestDto({required final List<int> policyIds}) =
      _$PolicyAgreeRequestDtoImpl;

  factory _PolicyAgreeRequestDto.fromJson(Map<String, dynamic> json) =
      _$PolicyAgreeRequestDtoImpl.fromJson;

  @override
  List<int> get policyIds;

  /// Create a copy of PolicyAgreeRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PolicyAgreeRequestDtoImplCopyWith<_$PolicyAgreeRequestDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}
