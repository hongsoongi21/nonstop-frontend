// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_room.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ChatRoom {
  int get id => throw _privateConstructorUsedError;
  ChatRoomType get type => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  int get unreadCount => throw _privateConstructorUsedError;
  ChatMessage? get lastMessage => throw _privateConstructorUsedError;
  List<int>? get memberIds => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  bool get isAnonymous => throw _privateConstructorUsedError;

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatRoomCopyWith<ChatRoom> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatRoomCopyWith<$Res> {
  factory $ChatRoomCopyWith(ChatRoom value, $Res Function(ChatRoom) then) =
      _$ChatRoomCopyWithImpl<$Res, ChatRoom>;
  @useResult
  $Res call({
    int id,
    ChatRoomType type,
    String? name,
    int unreadCount,
    ChatMessage? lastMessage,
    List<int>? memberIds,
    DateTime? updatedAt,
    String? imageUrl,
    bool isAnonymous,
  });
}

/// @nodoc
class _$ChatRoomCopyWithImpl<$Res, $Val extends ChatRoom>
    implements $ChatRoomCopyWith<$Res> {
  _$ChatRoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = freezed,
    Object? unreadCount = null,
    Object? lastMessage = freezed,
    Object? memberIds = freezed,
    Object? updatedAt = freezed,
    Object? imageUrl = freezed,
    Object? isAnonymous = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as ChatRoomType,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            unreadCount: null == unreadCount
                ? _value.unreadCount
                : unreadCount // ignore: cast_nullable_to_non_nullable
                      as int,
            lastMessage: freezed == lastMessage
                ? _value.lastMessage
                : lastMessage // ignore: cast_nullable_to_non_nullable
                      as ChatMessage?,
            memberIds: freezed == memberIds
                ? _value.memberIds
                : memberIds // ignore: cast_nullable_to_non_nullable
                      as List<int>?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            isAnonymous: null == isAnonymous
                ? _value.isAnonymous
                : isAnonymous // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatRoomImplCopyWith<$Res>
    implements $ChatRoomCopyWith<$Res> {
  factory _$$ChatRoomImplCopyWith(
    _$ChatRoomImpl value,
    $Res Function(_$ChatRoomImpl) then,
  ) = __$$ChatRoomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    ChatRoomType type,
    String? name,
    int unreadCount,
    ChatMessage? lastMessage,
    List<int>? memberIds,
    DateTime? updatedAt,
    String? imageUrl,
    bool isAnonymous,
  });
}

/// @nodoc
class __$$ChatRoomImplCopyWithImpl<$Res>
    extends _$ChatRoomCopyWithImpl<$Res, _$ChatRoomImpl>
    implements _$$ChatRoomImplCopyWith<$Res> {
  __$$ChatRoomImplCopyWithImpl(
    _$ChatRoomImpl _value,
    $Res Function(_$ChatRoomImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = freezed,
    Object? unreadCount = null,
    Object? lastMessage = freezed,
    Object? memberIds = freezed,
    Object? updatedAt = freezed,
    Object? imageUrl = freezed,
    Object? isAnonymous = null,
  }) {
    return _then(
      _$ChatRoomImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ChatRoomType,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        unreadCount: null == unreadCount
            ? _value.unreadCount
            : unreadCount // ignore: cast_nullable_to_non_nullable
                  as int,
        lastMessage: freezed == lastMessage
            ? _value.lastMessage
            : lastMessage // ignore: cast_nullable_to_non_nullable
                  as ChatMessage?,
        memberIds: freezed == memberIds
            ? _value._memberIds
            : memberIds // ignore: cast_nullable_to_non_nullable
                  as List<int>?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        isAnonymous: null == isAnonymous
            ? _value.isAnonymous
            : isAnonymous // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ChatRoomImpl implements _ChatRoom {
  const _$ChatRoomImpl({
    required this.id,
    required this.type,
    this.name,
    required this.unreadCount,
    this.lastMessage,
    final List<int>? memberIds,
    this.updatedAt,
    this.imageUrl,
    this.isAnonymous = false,
  }) : _memberIds = memberIds;

  @override
  final int id;
  @override
  final ChatRoomType type;
  @override
  final String? name;
  @override
  final int unreadCount;
  @override
  final ChatMessage? lastMessage;
  final List<int>? _memberIds;
  @override
  List<int>? get memberIds {
    final value = _memberIds;
    if (value == null) return null;
    if (_memberIds is EqualUnmodifiableListView) return _memberIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? updatedAt;
  @override
  final String? imageUrl;
  @override
  @JsonKey()
  final bool isAnonymous;

  @override
  String toString() {
    return 'ChatRoom(id: $id, type: $type, name: $name, unreadCount: $unreadCount, lastMessage: $lastMessage, memberIds: $memberIds, updatedAt: $updatedAt, imageUrl: $imageUrl, isAnonymous: $isAnonymous)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatRoomImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            const DeepCollectionEquality().equals(
              other._memberIds,
              _memberIds,
            ) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isAnonymous, isAnonymous) ||
                other.isAnonymous == isAnonymous));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    name,
    unreadCount,
    lastMessage,
    const DeepCollectionEquality().hash(_memberIds),
    updatedAt,
    imageUrl,
    isAnonymous,
  );

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatRoomImplCopyWith<_$ChatRoomImpl> get copyWith =>
      __$$ChatRoomImplCopyWithImpl<_$ChatRoomImpl>(this, _$identity);
}

abstract class _ChatRoom implements ChatRoom {
  const factory _ChatRoom({
    required final int id,
    required final ChatRoomType type,
    final String? name,
    required final int unreadCount,
    final ChatMessage? lastMessage,
    final List<int>? memberIds,
    final DateTime? updatedAt,
    final String? imageUrl,
    final bool isAnonymous,
  }) = _$ChatRoomImpl;

  @override
  int get id;
  @override
  ChatRoomType get type;
  @override
  String? get name;
  @override
  int get unreadCount;
  @override
  ChatMessage? get lastMessage;
  @override
  List<int>? get memberIds;
  @override
  DateTime? get updatedAt;
  @override
  String? get imageUrl;
  @override
  bool get isAnonymous;

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatRoomImplCopyWith<_$ChatRoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
