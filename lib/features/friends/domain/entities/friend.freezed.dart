// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Friend {
  String get id => throw _privateConstructorUsedError; // This is User ID
  String get nickname => throw _privateConstructorUsedError;
  String? get relationshipId =>
      throw _privateConstructorUsedError; // This is requestId or friendshipId
  String? get profileImageUrl => throw _privateConstructorUsedError;
  String? get universityName => throw _privateConstructorUsedError;
  String? get majorName => throw _privateConstructorUsedError;
  FriendStatus get status => throw _privateConstructorUsedError;

  /// Create a copy of Friend
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendCopyWith<Friend> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendCopyWith<$Res> {
  factory $FriendCopyWith(Friend value, $Res Function(Friend) then) =
      _$FriendCopyWithImpl<$Res, Friend>;
  @useResult
  $Res call({
    String id,
    String nickname,
    String? relationshipId,
    String? profileImageUrl,
    String? universityName,
    String? majorName,
    FriendStatus status,
  });
}

/// @nodoc
class _$FriendCopyWithImpl<$Res, $Val extends Friend>
    implements $FriendCopyWith<$Res> {
  _$FriendCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Friend
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nickname = null,
    Object? relationshipId = freezed,
    Object? profileImageUrl = freezed,
    Object? universityName = freezed,
    Object? majorName = freezed,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            nickname: null == nickname
                ? _value.nickname
                : nickname // ignore: cast_nullable_to_non_nullable
                      as String,
            relationshipId: freezed == relationshipId
                ? _value.relationshipId
                : relationshipId // ignore: cast_nullable_to_non_nullable
                      as String?,
            profileImageUrl: freezed == profileImageUrl
                ? _value.profileImageUrl
                : profileImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            universityName: freezed == universityName
                ? _value.universityName
                : universityName // ignore: cast_nullable_to_non_nullable
                      as String?,
            majorName: freezed == majorName
                ? _value.majorName
                : majorName // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as FriendStatus,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FriendImplCopyWith<$Res> implements $FriendCopyWith<$Res> {
  factory _$$FriendImplCopyWith(
    _$FriendImpl value,
    $Res Function(_$FriendImpl) then,
  ) = __$$FriendImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String nickname,
    String? relationshipId,
    String? profileImageUrl,
    String? universityName,
    String? majorName,
    FriendStatus status,
  });
}

/// @nodoc
class __$$FriendImplCopyWithImpl<$Res>
    extends _$FriendCopyWithImpl<$Res, _$FriendImpl>
    implements _$$FriendImplCopyWith<$Res> {
  __$$FriendImplCopyWithImpl(
    _$FriendImpl _value,
    $Res Function(_$FriendImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Friend
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nickname = null,
    Object? relationshipId = freezed,
    Object? profileImageUrl = freezed,
    Object? universityName = freezed,
    Object? majorName = freezed,
    Object? status = null,
  }) {
    return _then(
      _$FriendImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        nickname: null == nickname
            ? _value.nickname
            : nickname // ignore: cast_nullable_to_non_nullable
                  as String,
        relationshipId: freezed == relationshipId
            ? _value.relationshipId
            : relationshipId // ignore: cast_nullable_to_non_nullable
                  as String?,
        profileImageUrl: freezed == profileImageUrl
            ? _value.profileImageUrl
            : profileImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        universityName: freezed == universityName
            ? _value.universityName
            : universityName // ignore: cast_nullable_to_non_nullable
                  as String?,
        majorName: freezed == majorName
            ? _value.majorName
            : majorName // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as FriendStatus,
      ),
    );
  }
}

/// @nodoc

class _$FriendImpl implements _Friend {
  const _$FriendImpl({
    required this.id,
    required this.nickname,
    this.relationshipId,
    this.profileImageUrl,
    this.universityName,
    this.majorName,
    this.status = FriendStatus.none,
  });

  @override
  final String id;
  // This is User ID
  @override
  final String nickname;
  @override
  final String? relationshipId;
  // This is requestId or friendshipId
  @override
  final String? profileImageUrl;
  @override
  final String? universityName;
  @override
  final String? majorName;
  @override
  @JsonKey()
  final FriendStatus status;

  @override
  String toString() {
    return 'Friend(id: $id, nickname: $nickname, relationshipId: $relationshipId, profileImageUrl: $profileImageUrl, universityName: $universityName, majorName: $majorName, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.relationshipId, relationshipId) ||
                other.relationshipId == relationshipId) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.universityName, universityName) ||
                other.universityName == universityName) &&
            (identical(other.majorName, majorName) ||
                other.majorName == majorName) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    nickname,
    relationshipId,
    profileImageUrl,
    universityName,
    majorName,
    status,
  );

  /// Create a copy of Friend
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendImplCopyWith<_$FriendImpl> get copyWith =>
      __$$FriendImplCopyWithImpl<_$FriendImpl>(this, _$identity);
}

abstract class _Friend implements Friend {
  const factory _Friend({
    required final String id,
    required final String nickname,
    final String? relationshipId,
    final String? profileImageUrl,
    final String? universityName,
    final String? majorName,
    final FriendStatus status,
  }) = _$FriendImpl;

  @override
  String get id; // This is User ID
  @override
  String get nickname;
  @override
  String? get relationshipId; // This is requestId or friendshipId
  @override
  String? get profileImageUrl;
  @override
  String? get universityName;
  @override
  String? get majorName;
  @override
  FriendStatus get status;

  /// Create a copy of Friend
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendImplCopyWith<_$FriendImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
