// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) {
  return _AppNotification.fromJson(json);
}

/// @nodoc
mixin _$AppNotification {
  int get id => throw _privateConstructorUsedError;
  int? get actorId => throw _privateConstructorUsedError;
  String? get actorNickname => throw _privateConstructorUsedError;
  NotificationType get type => throw _privateConstructorUsedError;
  int? get postId => throw _privateConstructorUsedError;
  int? get commentId => throw _privateConstructorUsedError;
  int? get chatRoomId => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this AppNotification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppNotificationCopyWith<AppNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppNotificationCopyWith<$Res> {
  factory $AppNotificationCopyWith(
    AppNotification value,
    $Res Function(AppNotification) then,
  ) = _$AppNotificationCopyWithImpl<$Res, AppNotification>;
  @useResult
  $Res call({
    int id,
    int? actorId,
    String? actorNickname,
    NotificationType type,
    int? postId,
    int? commentId,
    int? chatRoomId,
    String message,
    bool isRead,
    DateTime createdAt,
  });
}

/// @nodoc
class _$AppNotificationCopyWithImpl<$Res, $Val extends AppNotification>
    implements $AppNotificationCopyWith<$Res> {
  _$AppNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? actorId = freezed,
    Object? actorNickname = freezed,
    Object? type = null,
    Object? postId = freezed,
    Object? commentId = freezed,
    Object? chatRoomId = freezed,
    Object? message = null,
    Object? isRead = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            actorId: freezed == actorId
                ? _value.actorId
                : actorId // ignore: cast_nullable_to_non_nullable
                      as int?,
            actorNickname: freezed == actorNickname
                ? _value.actorNickname
                : actorNickname // ignore: cast_nullable_to_non_nullable
                      as String?,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as NotificationType,
            postId: freezed == postId
                ? _value.postId
                : postId // ignore: cast_nullable_to_non_nullable
                      as int?,
            commentId: freezed == commentId
                ? _value.commentId
                : commentId // ignore: cast_nullable_to_non_nullable
                      as int?,
            chatRoomId: freezed == chatRoomId
                ? _value.chatRoomId
                : chatRoomId // ignore: cast_nullable_to_non_nullable
                      as int?,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            isRead: null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppNotificationImplCopyWith<$Res>
    implements $AppNotificationCopyWith<$Res> {
  factory _$$AppNotificationImplCopyWith(
    _$AppNotificationImpl value,
    $Res Function(_$AppNotificationImpl) then,
  ) = __$$AppNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int? actorId,
    String? actorNickname,
    NotificationType type,
    int? postId,
    int? commentId,
    int? chatRoomId,
    String message,
    bool isRead,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$AppNotificationImplCopyWithImpl<$Res>
    extends _$AppNotificationCopyWithImpl<$Res, _$AppNotificationImpl>
    implements _$$AppNotificationImplCopyWith<$Res> {
  __$$AppNotificationImplCopyWithImpl(
    _$AppNotificationImpl _value,
    $Res Function(_$AppNotificationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? actorId = freezed,
    Object? actorNickname = freezed,
    Object? type = null,
    Object? postId = freezed,
    Object? commentId = freezed,
    Object? chatRoomId = freezed,
    Object? message = null,
    Object? isRead = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$AppNotificationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        actorId: freezed == actorId
            ? _value.actorId
            : actorId // ignore: cast_nullable_to_non_nullable
                  as int?,
        actorNickname: freezed == actorNickname
            ? _value.actorNickname
            : actorNickname // ignore: cast_nullable_to_non_nullable
                  as String?,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as NotificationType,
        postId: freezed == postId
            ? _value.postId
            : postId // ignore: cast_nullable_to_non_nullable
                  as int?,
        commentId: freezed == commentId
            ? _value.commentId
            : commentId // ignore: cast_nullable_to_non_nullable
                  as int?,
        chatRoomId: freezed == chatRoomId
            ? _value.chatRoomId
            : chatRoomId // ignore: cast_nullable_to_non_nullable
                  as int?,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        isRead: null == isRead
            ? _value.isRead
            : isRead // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AppNotificationImpl implements _AppNotification {
  const _$AppNotificationImpl({
    required this.id,
    this.actorId,
    this.actorNickname,
    required this.type,
    this.postId,
    this.commentId,
    this.chatRoomId,
    required this.message,
    this.isRead = false,
    required this.createdAt,
  });

  factory _$AppNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppNotificationImplFromJson(json);

  @override
  final int id;
  @override
  final int? actorId;
  @override
  final String? actorNickname;
  @override
  final NotificationType type;
  @override
  final int? postId;
  @override
  final int? commentId;
  @override
  final int? chatRoomId;
  @override
  final String message;
  @override
  @JsonKey()
  final bool isRead;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'AppNotification(id: $id, actorId: $actorId, actorNickname: $actorNickname, type: $type, postId: $postId, commentId: $commentId, chatRoomId: $chatRoomId, message: $message, isRead: $isRead, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppNotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.actorId, actorId) || other.actorId == actorId) &&
            (identical(other.actorNickname, actorNickname) ||
                other.actorNickname == actorNickname) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.commentId, commentId) ||
                other.commentId == commentId) &&
            (identical(other.chatRoomId, chatRoomId) ||
                other.chatRoomId == chatRoomId) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    actorId,
    actorNickname,
    type,
    postId,
    commentId,
    chatRoomId,
    message,
    isRead,
    createdAt,
  );

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppNotificationImplCopyWith<_$AppNotificationImpl> get copyWith =>
      __$$AppNotificationImplCopyWithImpl<_$AppNotificationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AppNotificationImplToJson(this);
  }
}

abstract class _AppNotification implements AppNotification {
  const factory _AppNotification({
    required final int id,
    final int? actorId,
    final String? actorNickname,
    required final NotificationType type,
    final int? postId,
    final int? commentId,
    final int? chatRoomId,
    required final String message,
    final bool isRead,
    required final DateTime createdAt,
  }) = _$AppNotificationImpl;

  factory _AppNotification.fromJson(Map<String, dynamic> json) =
      _$AppNotificationImpl.fromJson;

  @override
  int get id;
  @override
  int? get actorId;
  @override
  String? get actorNickname;
  @override
  NotificationType get type;
  @override
  int? get postId;
  @override
  int? get commentId;
  @override
  int? get chatRoomId;
  @override
  String get message;
  @override
  bool get isRead;
  @override
  DateTime get createdAt;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppNotificationImplCopyWith<_$AppNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
