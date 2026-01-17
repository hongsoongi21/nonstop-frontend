// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CommentEntity _$CommentEntityFromJson(Map<String, dynamic> json) {
  return _CommentEntity.fromJson(json);
}

/// @nodoc
mixin _$CommentEntity {
  int get id => throw _privateConstructorUsedError;
  int get postId => throw _privateConstructorUsedError;
  int? get upperCommentId => throw _privateConstructorUsedError;
  String get writerNickname => throw _privateConstructorUsedError;
  bool get isWriterAnonymous => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  CommentType get type => throw _privateConstructorUsedError;
  int get depth => throw _privateConstructorUsedError;
  int get likeCount => throw _privateConstructorUsedError;
  bool get isLiked => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;
  bool get isMine => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  List<String>? get imageUrls => throw _privateConstructorUsedError;
  List<CommentEntity> get replies => throw _privateConstructorUsedError;

  /// Serializes this CommentEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommentEntityCopyWith<CommentEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentEntityCopyWith<$Res> {
  factory $CommentEntityCopyWith(
    CommentEntity value,
    $Res Function(CommentEntity) then,
  ) = _$CommentEntityCopyWithImpl<$Res, CommentEntity>;
  @useResult
  $Res call({
    int id,
    int postId,
    int? upperCommentId,
    String writerNickname,
    bool isWriterAnonymous,
    String content,
    CommentType type,
    int depth,
    int likeCount,
    bool isLiked,
    bool isDeleted,
    bool isMine,
    DateTime createdAt,
    DateTime? updatedAt,
    List<String>? imageUrls,
    List<CommentEntity> replies,
  });
}

/// @nodoc
class _$CommentEntityCopyWithImpl<$Res, $Val extends CommentEntity>
    implements $CommentEntityCopyWith<$Res> {
  _$CommentEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommentEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? upperCommentId = freezed,
    Object? writerNickname = null,
    Object? isWriterAnonymous = null,
    Object? content = null,
    Object? type = null,
    Object? depth = null,
    Object? likeCount = null,
    Object? isLiked = null,
    Object? isDeleted = null,
    Object? isMine = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? imageUrls = freezed,
    Object? replies = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            postId: null == postId
                ? _value.postId
                : postId // ignore: cast_nullable_to_non_nullable
                      as int,
            upperCommentId: freezed == upperCommentId
                ? _value.upperCommentId
                : upperCommentId // ignore: cast_nullable_to_non_nullable
                      as int?,
            writerNickname: null == writerNickname
                ? _value.writerNickname
                : writerNickname // ignore: cast_nullable_to_non_nullable
                      as String,
            isWriterAnonymous: null == isWriterAnonymous
                ? _value.isWriterAnonymous
                : isWriterAnonymous // ignore: cast_nullable_to_non_nullable
                      as bool,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as CommentType,
            depth: null == depth
                ? _value.depth
                : depth // ignore: cast_nullable_to_non_nullable
                      as int,
            likeCount: null == likeCount
                ? _value.likeCount
                : likeCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isLiked: null == isLiked
                ? _value.isLiked
                : isLiked // ignore: cast_nullable_to_non_nullable
                      as bool,
            isDeleted: null == isDeleted
                ? _value.isDeleted
                : isDeleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            isMine: null == isMine
                ? _value.isMine
                : isMine // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            imageUrls: freezed == imageUrls
                ? _value.imageUrls
                : imageUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            replies: null == replies
                ? _value.replies
                : replies // ignore: cast_nullable_to_non_nullable
                      as List<CommentEntity>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CommentEntityImplCopyWith<$Res>
    implements $CommentEntityCopyWith<$Res> {
  factory _$$CommentEntityImplCopyWith(
    _$CommentEntityImpl value,
    $Res Function(_$CommentEntityImpl) then,
  ) = __$$CommentEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int postId,
    int? upperCommentId,
    String writerNickname,
    bool isWriterAnonymous,
    String content,
    CommentType type,
    int depth,
    int likeCount,
    bool isLiked,
    bool isDeleted,
    bool isMine,
    DateTime createdAt,
    DateTime? updatedAt,
    List<String>? imageUrls,
    List<CommentEntity> replies,
  });
}

/// @nodoc
class __$$CommentEntityImplCopyWithImpl<$Res>
    extends _$CommentEntityCopyWithImpl<$Res, _$CommentEntityImpl>
    implements _$$CommentEntityImplCopyWith<$Res> {
  __$$CommentEntityImplCopyWithImpl(
    _$CommentEntityImpl _value,
    $Res Function(_$CommentEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CommentEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? upperCommentId = freezed,
    Object? writerNickname = null,
    Object? isWriterAnonymous = null,
    Object? content = null,
    Object? type = null,
    Object? depth = null,
    Object? likeCount = null,
    Object? isLiked = null,
    Object? isDeleted = null,
    Object? isMine = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? imageUrls = freezed,
    Object? replies = null,
  }) {
    return _then(
      _$CommentEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        postId: null == postId
            ? _value.postId
            : postId // ignore: cast_nullable_to_non_nullable
                  as int,
        upperCommentId: freezed == upperCommentId
            ? _value.upperCommentId
            : upperCommentId // ignore: cast_nullable_to_non_nullable
                  as int?,
        writerNickname: null == writerNickname
            ? _value.writerNickname
            : writerNickname // ignore: cast_nullable_to_non_nullable
                  as String,
        isWriterAnonymous: null == isWriterAnonymous
            ? _value.isWriterAnonymous
            : isWriterAnonymous // ignore: cast_nullable_to_non_nullable
                  as bool,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as CommentType,
        depth: null == depth
            ? _value.depth
            : depth // ignore: cast_nullable_to_non_nullable
                  as int,
        likeCount: null == likeCount
            ? _value.likeCount
            : likeCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isLiked: null == isLiked
            ? _value.isLiked
            : isLiked // ignore: cast_nullable_to_non_nullable
                  as bool,
        isDeleted: null == isDeleted
            ? _value.isDeleted
            : isDeleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        isMine: null == isMine
            ? _value.isMine
            : isMine // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        imageUrls: freezed == imageUrls
            ? _value._imageUrls
            : imageUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        replies: null == replies
            ? _value._replies
            : replies // ignore: cast_nullable_to_non_nullable
                  as List<CommentEntity>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CommentEntityImpl implements _CommentEntity {
  const _$CommentEntityImpl({
    required this.id,
    required this.postId,
    this.upperCommentId,
    required this.writerNickname,
    this.isWriterAnonymous = false,
    required this.content,
    required this.type,
    this.depth = 0,
    this.likeCount = 0,
    this.isLiked = false,
    this.isDeleted = false,
    this.isMine = false,
    required this.createdAt,
    this.updatedAt,
    final List<String>? imageUrls,
    final List<CommentEntity> replies = const [],
  }) : _imageUrls = imageUrls,
       _replies = replies;

  factory _$CommentEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentEntityImplFromJson(json);

  @override
  final int id;
  @override
  final int postId;
  @override
  final int? upperCommentId;
  @override
  final String writerNickname;
  @override
  @JsonKey()
  final bool isWriterAnonymous;
  @override
  final String content;
  @override
  final CommentType type;
  @override
  @JsonKey()
  final int depth;
  @override
  @JsonKey()
  final int likeCount;
  @override
  @JsonKey()
  final bool isLiked;
  @override
  @JsonKey()
  final bool isDeleted;
  @override
  @JsonKey()
  final bool isMine;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  final List<String>? _imageUrls;
  @override
  List<String>? get imageUrls {
    final value = _imageUrls;
    if (value == null) return null;
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<CommentEntity> _replies;
  @override
  @JsonKey()
  List<CommentEntity> get replies {
    if (_replies is EqualUnmodifiableListView) return _replies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_replies);
  }

  @override
  String toString() {
    return 'CommentEntity(id: $id, postId: $postId, upperCommentId: $upperCommentId, writerNickname: $writerNickname, isWriterAnonymous: $isWriterAnonymous, content: $content, type: $type, depth: $depth, likeCount: $likeCount, isLiked: $isLiked, isDeleted: $isDeleted, isMine: $isMine, createdAt: $createdAt, updatedAt: $updatedAt, imageUrls: $imageUrls, replies: $replies)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.upperCommentId, upperCommentId) ||
                other.upperCommentId == upperCommentId) &&
            (identical(other.writerNickname, writerNickname) ||
                other.writerNickname == writerNickname) &&
            (identical(other.isWriterAnonymous, isWriterAnonymous) ||
                other.isWriterAnonymous == isWriterAnonymous) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.depth, depth) || other.depth == depth) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.isMine, isMine) || other.isMine == isMine) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(
              other._imageUrls,
              _imageUrls,
            ) &&
            const DeepCollectionEquality().equals(other._replies, _replies));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    postId,
    upperCommentId,
    writerNickname,
    isWriterAnonymous,
    content,
    type,
    depth,
    likeCount,
    isLiked,
    isDeleted,
    isMine,
    createdAt,
    updatedAt,
    const DeepCollectionEquality().hash(_imageUrls),
    const DeepCollectionEquality().hash(_replies),
  );

  /// Create a copy of CommentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentEntityImplCopyWith<_$CommentEntityImpl> get copyWith =>
      __$$CommentEntityImplCopyWithImpl<_$CommentEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentEntityImplToJson(this);
  }
}

abstract class _CommentEntity implements CommentEntity {
  const factory _CommentEntity({
    required final int id,
    required final int postId,
    final int? upperCommentId,
    required final String writerNickname,
    final bool isWriterAnonymous,
    required final String content,
    required final CommentType type,
    final int depth,
    final int likeCount,
    final bool isLiked,
    final bool isDeleted,
    final bool isMine,
    required final DateTime createdAt,
    final DateTime? updatedAt,
    final List<String>? imageUrls,
    final List<CommentEntity> replies,
  }) = _$CommentEntityImpl;

  factory _CommentEntity.fromJson(Map<String, dynamic> json) =
      _$CommentEntityImpl.fromJson;

  @override
  int get id;
  @override
  int get postId;
  @override
  int? get upperCommentId;
  @override
  String get writerNickname;
  @override
  bool get isWriterAnonymous;
  @override
  String get content;
  @override
  CommentType get type;
  @override
  int get depth;
  @override
  int get likeCount;
  @override
  bool get isLiked;
  @override
  bool get isDeleted;
  @override
  bool get isMine;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  List<String>? get imageUrls;
  @override
  List<CommentEntity> get replies;

  /// Create a copy of CommentEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommentEntityImplCopyWith<_$CommentEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
