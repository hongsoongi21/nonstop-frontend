// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'google_login_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GoogleLoginRequestDto _$GoogleLoginRequestDtoFromJson(
  Map<String, dynamic> json,
) {
  return _GoogleLoginRequestDto.fromJson(json);
}

/// @nodoc
mixin _$GoogleLoginRequestDto {
  String get idToken => throw _privateConstructorUsedError;

  /// Serializes this GoogleLoginRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GoogleLoginRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GoogleLoginRequestDtoCopyWith<GoogleLoginRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoogleLoginRequestDtoCopyWith<$Res> {
  factory $GoogleLoginRequestDtoCopyWith(
    GoogleLoginRequestDto value,
    $Res Function(GoogleLoginRequestDto) then,
  ) = _$GoogleLoginRequestDtoCopyWithImpl<$Res, GoogleLoginRequestDto>;
  @useResult
  $Res call({String idToken});
}

/// @nodoc
class _$GoogleLoginRequestDtoCopyWithImpl<
  $Res,
  $Val extends GoogleLoginRequestDto
>
    implements $GoogleLoginRequestDtoCopyWith<$Res> {
  _$GoogleLoginRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GoogleLoginRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? idToken = null}) {
    return _then(
      _value.copyWith(
            idToken: null == idToken
                ? _value.idToken
                : idToken // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GoogleLoginRequestDtoImplCopyWith<$Res>
    implements $GoogleLoginRequestDtoCopyWith<$Res> {
  factory _$$GoogleLoginRequestDtoImplCopyWith(
    _$GoogleLoginRequestDtoImpl value,
    $Res Function(_$GoogleLoginRequestDtoImpl) then,
  ) = __$$GoogleLoginRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String idToken});
}

/// @nodoc
class __$$GoogleLoginRequestDtoImplCopyWithImpl<$Res>
    extends
        _$GoogleLoginRequestDtoCopyWithImpl<$Res, _$GoogleLoginRequestDtoImpl>
    implements _$$GoogleLoginRequestDtoImplCopyWith<$Res> {
  __$$GoogleLoginRequestDtoImplCopyWithImpl(
    _$GoogleLoginRequestDtoImpl _value,
    $Res Function(_$GoogleLoginRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GoogleLoginRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? idToken = null}) {
    return _then(
      _$GoogleLoginRequestDtoImpl(
        idToken: null == idToken
            ? _value.idToken
            : idToken // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GoogleLoginRequestDtoImpl implements _GoogleLoginRequestDto {
  const _$GoogleLoginRequestDtoImpl({required this.idToken});

  factory _$GoogleLoginRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoogleLoginRequestDtoImplFromJson(json);

  @override
  final String idToken;

  @override
  String toString() {
    return 'GoogleLoginRequestDto(idToken: $idToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoogleLoginRequestDtoImpl &&
            (identical(other.idToken, idToken) || other.idToken == idToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, idToken);

  /// Create a copy of GoogleLoginRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoogleLoginRequestDtoImplCopyWith<_$GoogleLoginRequestDtoImpl>
  get copyWith =>
      __$$GoogleLoginRequestDtoImplCopyWithImpl<_$GoogleLoginRequestDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GoogleLoginRequestDtoImplToJson(this);
  }
}

abstract class _GoogleLoginRequestDto implements GoogleLoginRequestDto {
  const factory _GoogleLoginRequestDto({required final String idToken}) =
      _$GoogleLoginRequestDtoImpl;

  factory _GoogleLoginRequestDto.fromJson(Map<String, dynamic> json) =
      _$GoogleLoginRequestDtoImpl.fromJson;

  @override
  String get idToken;

  /// Create a copy of GoogleLoginRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoogleLoginRequestDtoImplCopyWith<_$GoogleLoginRequestDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}
