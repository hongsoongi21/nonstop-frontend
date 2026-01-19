// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserInfoDto _$UserInfoDtoFromJson(Map<String, dynamic> json) {
  return _UserInfoDto.fromJson(json);
}

/// @nodoc
mixin _$UserInfoDto {
  @JsonKey(readValue: _readUserId)
  dynamic get userId => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  String? get profileImageUrl => throw _privateConstructorUsedError;

  /// Serializes this UserInfoDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserInfoDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserInfoDtoCopyWith<UserInfoDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInfoDtoCopyWith<$Res> {
  factory $UserInfoDtoCopyWith(
    UserInfoDto value,
    $Res Function(UserInfoDto) then,
  ) = _$UserInfoDtoCopyWithImpl<$Res, UserInfoDto>;
  @useResult
  $Res call({
    @JsonKey(readValue: _readUserId) dynamic userId,
    String nickname,
    String? profileImageUrl,
  });
}

/// @nodoc
class _$UserInfoDtoCopyWithImpl<$Res, $Val extends UserInfoDto>
    implements $UserInfoDtoCopyWith<$Res> {
  _$UserInfoDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserInfoDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? nickname = null,
    Object? profileImageUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            userId: freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            nickname: null == nickname
                ? _value.nickname
                : nickname // ignore: cast_nullable_to_non_nullable
                      as String,
            profileImageUrl: freezed == profileImageUrl
                ? _value.profileImageUrl
                : profileImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserInfoDtoImplCopyWith<$Res>
    implements $UserInfoDtoCopyWith<$Res> {
  factory _$$UserInfoDtoImplCopyWith(
    _$UserInfoDtoImpl value,
    $Res Function(_$UserInfoDtoImpl) then,
  ) = __$$UserInfoDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(readValue: _readUserId) dynamic userId,
    String nickname,
    String? profileImageUrl,
  });
}

/// @nodoc
class __$$UserInfoDtoImplCopyWithImpl<$Res>
    extends _$UserInfoDtoCopyWithImpl<$Res, _$UserInfoDtoImpl>
    implements _$$UserInfoDtoImplCopyWith<$Res> {
  __$$UserInfoDtoImplCopyWithImpl(
    _$UserInfoDtoImpl _value,
    $Res Function(_$UserInfoDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserInfoDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? nickname = null,
    Object? profileImageUrl = freezed,
  }) {
    return _then(
      _$UserInfoDtoImpl(
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        nickname: null == nickname
            ? _value.nickname
            : nickname // ignore: cast_nullable_to_non_nullable
                  as String,
        profileImageUrl: freezed == profileImageUrl
            ? _value.profileImageUrl
            : profileImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserInfoDtoImpl implements _UserInfoDto {
  const _$UserInfoDtoImpl({
    @JsonKey(readValue: _readUserId) required this.userId,
    required this.nickname,
    this.profileImageUrl,
  });

  factory _$UserInfoDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserInfoDtoImplFromJson(json);

  @override
  @JsonKey(readValue: _readUserId)
  final dynamic userId;
  @override
  final String nickname;
  @override
  final String? profileImageUrl;

  @override
  String toString() {
    return 'UserInfoDto(userId: $userId, nickname: $nickname, profileImageUrl: $profileImageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserInfoDtoImpl &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(userId),
    nickname,
    profileImageUrl,
  );

  /// Create a copy of UserInfoDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserInfoDtoImplCopyWith<_$UserInfoDtoImpl> get copyWith =>
      __$$UserInfoDtoImplCopyWithImpl<_$UserInfoDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserInfoDtoImplToJson(this);
  }
}

abstract class _UserInfoDto implements UserInfoDto {
  const factory _UserInfoDto({
    @JsonKey(readValue: _readUserId) required final dynamic userId,
    required final String nickname,
    final String? profileImageUrl,
  }) = _$UserInfoDtoImpl;

  factory _UserInfoDto.fromJson(Map<String, dynamic> json) =
      _$UserInfoDtoImpl.fromJson;

  @override
  @JsonKey(readValue: _readUserId)
  dynamic get userId;
  @override
  String get nickname;
  @override
  String? get profileImageUrl;

  /// Create a copy of UserInfoDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserInfoDtoImplCopyWith<_$UserInfoDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FriendDto _$FriendDtoFromJson(Map<String, dynamic> json) {
  return _FriendDto.fromJson(json);
}

/// @nodoc
mixin _$FriendDto {
  dynamic get friendshipId => throw _privateConstructorUsedError;
  UserInfoDto get friend => throw _privateConstructorUsedError;
  String? get becameFriendAt => throw _privateConstructorUsedError;

  /// Serializes this FriendDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FriendDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendDtoCopyWith<FriendDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendDtoCopyWith<$Res> {
  factory $FriendDtoCopyWith(FriendDto value, $Res Function(FriendDto) then) =
      _$FriendDtoCopyWithImpl<$Res, FriendDto>;
  @useResult
  $Res call({dynamic friendshipId, UserInfoDto friend, String? becameFriendAt});

  $UserInfoDtoCopyWith<$Res> get friend;
}

/// @nodoc
class _$FriendDtoCopyWithImpl<$Res, $Val extends FriendDto>
    implements $FriendDtoCopyWith<$Res> {
  _$FriendDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? friendshipId = freezed,
    Object? friend = null,
    Object? becameFriendAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            friendshipId: freezed == friendshipId
                ? _value.friendshipId
                : friendshipId // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            friend: null == friend
                ? _value.friend
                : friend // ignore: cast_nullable_to_non_nullable
                      as UserInfoDto,
            becameFriendAt: freezed == becameFriendAt
                ? _value.becameFriendAt
                : becameFriendAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of FriendDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserInfoDtoCopyWith<$Res> get friend {
    return $UserInfoDtoCopyWith<$Res>(_value.friend, (value) {
      return _then(_value.copyWith(friend: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FriendDtoImplCopyWith<$Res>
    implements $FriendDtoCopyWith<$Res> {
  factory _$$FriendDtoImplCopyWith(
    _$FriendDtoImpl value,
    $Res Function(_$FriendDtoImpl) then,
  ) = __$$FriendDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({dynamic friendshipId, UserInfoDto friend, String? becameFriendAt});

  @override
  $UserInfoDtoCopyWith<$Res> get friend;
}

/// @nodoc
class __$$FriendDtoImplCopyWithImpl<$Res>
    extends _$FriendDtoCopyWithImpl<$Res, _$FriendDtoImpl>
    implements _$$FriendDtoImplCopyWith<$Res> {
  __$$FriendDtoImplCopyWithImpl(
    _$FriendDtoImpl _value,
    $Res Function(_$FriendDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FriendDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? friendshipId = freezed,
    Object? friend = null,
    Object? becameFriendAt = freezed,
  }) {
    return _then(
      _$FriendDtoImpl(
        friendshipId: freezed == friendshipId
            ? _value.friendshipId
            : friendshipId // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        friend: null == friend
            ? _value.friend
            : friend // ignore: cast_nullable_to_non_nullable
                  as UserInfoDto,
        becameFriendAt: freezed == becameFriendAt
            ? _value.becameFriendAt
            : becameFriendAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FriendDtoImpl implements _FriendDto {
  const _$FriendDtoImpl({
    required this.friendshipId,
    required this.friend,
    this.becameFriendAt,
  });

  factory _$FriendDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendDtoImplFromJson(json);

  @override
  final dynamic friendshipId;
  @override
  final UserInfoDto friend;
  @override
  final String? becameFriendAt;

  @override
  String toString() {
    return 'FriendDto(friendshipId: $friendshipId, friend: $friend, becameFriendAt: $becameFriendAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendDtoImpl &&
            const DeepCollectionEquality().equals(
              other.friendshipId,
              friendshipId,
            ) &&
            (identical(other.friend, friend) || other.friend == friend) &&
            (identical(other.becameFriendAt, becameFriendAt) ||
                other.becameFriendAt == becameFriendAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(friendshipId),
    friend,
    becameFriendAt,
  );

  /// Create a copy of FriendDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendDtoImplCopyWith<_$FriendDtoImpl> get copyWith =>
      __$$FriendDtoImplCopyWithImpl<_$FriendDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendDtoImplToJson(this);
  }
}

abstract class _FriendDto implements FriendDto {
  const factory _FriendDto({
    required final dynamic friendshipId,
    required final UserInfoDto friend,
    final String? becameFriendAt,
  }) = _$FriendDtoImpl;

  factory _FriendDto.fromJson(Map<String, dynamic> json) =
      _$FriendDtoImpl.fromJson;

  @override
  dynamic get friendshipId;
  @override
  UserInfoDto get friend;
  @override
  String? get becameFriendAt;

  /// Create a copy of FriendDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendDtoImplCopyWith<_$FriendDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FriendRequestDto _$FriendRequestDtoFromJson(Map<String, dynamic> json) {
  return _FriendRequestDto.fromJson(json);
}

/// @nodoc
mixin _$FriendRequestDto {
  dynamic get requestId => throw _privateConstructorUsedError;
  UserInfoDto get requester => throw _privateConstructorUsedError;
  String? get requestedAt => throw _privateConstructorUsedError;

  /// Serializes this FriendRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FriendRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendRequestDtoCopyWith<FriendRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendRequestDtoCopyWith<$Res> {
  factory $FriendRequestDtoCopyWith(
    FriendRequestDto value,
    $Res Function(FriendRequestDto) then,
  ) = _$FriendRequestDtoCopyWithImpl<$Res, FriendRequestDto>;
  @useResult
  $Res call({dynamic requestId, UserInfoDto requester, String? requestedAt});

  $UserInfoDtoCopyWith<$Res> get requester;
}

/// @nodoc
class _$FriendRequestDtoCopyWithImpl<$Res, $Val extends FriendRequestDto>
    implements $FriendRequestDtoCopyWith<$Res> {
  _$FriendRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requestId = freezed,
    Object? requester = null,
    Object? requestedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            requestId: freezed == requestId
                ? _value.requestId
                : requestId // ignore: cast_nullable_to_non_nullable
                      as dynamic,
            requester: null == requester
                ? _value.requester
                : requester // ignore: cast_nullable_to_non_nullable
                      as UserInfoDto,
            requestedAt: freezed == requestedAt
                ? _value.requestedAt
                : requestedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of FriendRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserInfoDtoCopyWith<$Res> get requester {
    return $UserInfoDtoCopyWith<$Res>(_value.requester, (value) {
      return _then(_value.copyWith(requester: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FriendRequestDtoImplCopyWith<$Res>
    implements $FriendRequestDtoCopyWith<$Res> {
  factory _$$FriendRequestDtoImplCopyWith(
    _$FriendRequestDtoImpl value,
    $Res Function(_$FriendRequestDtoImpl) then,
  ) = __$$FriendRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({dynamic requestId, UserInfoDto requester, String? requestedAt});

  @override
  $UserInfoDtoCopyWith<$Res> get requester;
}

/// @nodoc
class __$$FriendRequestDtoImplCopyWithImpl<$Res>
    extends _$FriendRequestDtoCopyWithImpl<$Res, _$FriendRequestDtoImpl>
    implements _$$FriendRequestDtoImplCopyWith<$Res> {
  __$$FriendRequestDtoImplCopyWithImpl(
    _$FriendRequestDtoImpl _value,
    $Res Function(_$FriendRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FriendRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requestId = freezed,
    Object? requester = null,
    Object? requestedAt = freezed,
  }) {
    return _then(
      _$FriendRequestDtoImpl(
        requestId: freezed == requestId
            ? _value.requestId
            : requestId // ignore: cast_nullable_to_non_nullable
                  as dynamic,
        requester: null == requester
            ? _value.requester
            : requester // ignore: cast_nullable_to_non_nullable
                  as UserInfoDto,
        requestedAt: freezed == requestedAt
            ? _value.requestedAt
            : requestedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FriendRequestDtoImpl implements _FriendRequestDto {
  const _$FriendRequestDtoImpl({
    required this.requestId,
    required this.requester,
    this.requestedAt,
  });

  factory _$FriendRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendRequestDtoImplFromJson(json);

  @override
  final dynamic requestId;
  @override
  final UserInfoDto requester;
  @override
  final String? requestedAt;

  @override
  String toString() {
    return 'FriendRequestDto(requestId: $requestId, requester: $requester, requestedAt: $requestedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendRequestDtoImpl &&
            const DeepCollectionEquality().equals(other.requestId, requestId) &&
            (identical(other.requester, requester) ||
                other.requester == requester) &&
            (identical(other.requestedAt, requestedAt) ||
                other.requestedAt == requestedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(requestId),
    requester,
    requestedAt,
  );

  /// Create a copy of FriendRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendRequestDtoImplCopyWith<_$FriendRequestDtoImpl> get copyWith =>
      __$$FriendRequestDtoImplCopyWithImpl<_$FriendRequestDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendRequestDtoImplToJson(this);
  }
}

abstract class _FriendRequestDto implements FriendRequestDto {
  const factory _FriendRequestDto({
    required final dynamic requestId,
    required final UserInfoDto requester,
    final String? requestedAt,
  }) = _$FriendRequestDtoImpl;

  factory _FriendRequestDto.fromJson(Map<String, dynamic> json) =
      _$FriendRequestDtoImpl.fromJson;

  @override
  dynamic get requestId;
  @override
  UserInfoDto get requester;
  @override
  String? get requestedAt;

  /// Create a copy of FriendRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendRequestDtoImplCopyWith<_$FriendRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
