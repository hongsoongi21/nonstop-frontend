// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apple_login_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppleLoginRequestDto _$AppleLoginRequestDtoFromJson(Map<String, dynamic> json) {
  return _AppleLoginRequestDto.fromJson(json);
}

/// @nodoc
mixin _$AppleLoginRequestDto {
  String get idToken => throw _privateConstructorUsedError;
  String? get authorizationCode => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;

  /// Serializes this AppleLoginRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppleLoginRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppleLoginRequestDtoCopyWith<AppleLoginRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppleLoginRequestDtoCopyWith<$Res> {
  factory $AppleLoginRequestDtoCopyWith(
    AppleLoginRequestDto value,
    $Res Function(AppleLoginRequestDto) then,
  ) = _$AppleLoginRequestDtoCopyWithImpl<$Res, AppleLoginRequestDto>;
  @useResult
  $Res call({
    String idToken,
    String? authorizationCode,
    String? firstName,
    String? lastName,
  });
}

/// @nodoc
class _$AppleLoginRequestDtoCopyWithImpl<
  $Res,
  $Val extends AppleLoginRequestDto
>
    implements $AppleLoginRequestDtoCopyWith<$Res> {
  _$AppleLoginRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppleLoginRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idToken = null,
    Object? authorizationCode = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
  }) {
    return _then(
      _value.copyWith(
            idToken: null == idToken
                ? _value.idToken
                : idToken // ignore: cast_nullable_to_non_nullable
                      as String,
            authorizationCode: freezed == authorizationCode
                ? _value.authorizationCode
                : authorizationCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            firstName: freezed == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastName: freezed == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppleLoginRequestDtoImplCopyWith<$Res>
    implements $AppleLoginRequestDtoCopyWith<$Res> {
  factory _$$AppleLoginRequestDtoImplCopyWith(
    _$AppleLoginRequestDtoImpl value,
    $Res Function(_$AppleLoginRequestDtoImpl) then,
  ) = __$$AppleLoginRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String idToken,
    String? authorizationCode,
    String? firstName,
    String? lastName,
  });
}

/// @nodoc
class __$$AppleLoginRequestDtoImplCopyWithImpl<$Res>
    extends _$AppleLoginRequestDtoCopyWithImpl<$Res, _$AppleLoginRequestDtoImpl>
    implements _$$AppleLoginRequestDtoImplCopyWith<$Res> {
  __$$AppleLoginRequestDtoImplCopyWithImpl(
    _$AppleLoginRequestDtoImpl _value,
    $Res Function(_$AppleLoginRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppleLoginRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idToken = null,
    Object? authorizationCode = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
  }) {
    return _then(
      _$AppleLoginRequestDtoImpl(
        idToken: null == idToken
            ? _value.idToken
            : idToken // ignore: cast_nullable_to_non_nullable
                  as String,
        authorizationCode: freezed == authorizationCode
            ? _value.authorizationCode
            : authorizationCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        firstName: freezed == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastName: freezed == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AppleLoginRequestDtoImpl implements _AppleLoginRequestDto {
  const _$AppleLoginRequestDtoImpl({
    required this.idToken,
    this.authorizationCode,
    this.firstName,
    this.lastName,
  });

  factory _$AppleLoginRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppleLoginRequestDtoImplFromJson(json);

  @override
  final String idToken;
  @override
  final String? authorizationCode;
  @override
  final String? firstName;
  @override
  final String? lastName;

  @override
  String toString() {
    return 'AppleLoginRequestDto(idToken: $idToken, authorizationCode: $authorizationCode, firstName: $firstName, lastName: $lastName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppleLoginRequestDtoImpl &&
            (identical(other.idToken, idToken) || other.idToken == idToken) &&
            (identical(other.authorizationCode, authorizationCode) ||
                other.authorizationCode == authorizationCode) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, idToken, authorizationCode, firstName, lastName);

  /// Create a copy of AppleLoginRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppleLoginRequestDtoImplCopyWith<_$AppleLoginRequestDtoImpl>
  get copyWith =>
      __$$AppleLoginRequestDtoImplCopyWithImpl<_$AppleLoginRequestDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AppleLoginRequestDtoImplToJson(this);
  }
}

abstract class _AppleLoginRequestDto implements AppleLoginRequestDto {
  const factory _AppleLoginRequestDto({
    required final String idToken,
    final String? authorizationCode,
    final String? firstName,
    final String? lastName,
  }) = _$AppleLoginRequestDtoImpl;

  factory _AppleLoginRequestDto.fromJson(Map<String, dynamic> json) =
      _$AppleLoginRequestDtoImpl.fromJson;

  @override
  String get idToken;
  @override
  String? get authorizationCode;
  @override
  String? get firstName;
  @override
  String? get lastName;

  /// Create a copy of AppleLoginRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppleLoginRequestDtoImplCopyWith<_$AppleLoginRequestDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}
