// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PostEntity _$PostEntityFromJson(Map<String, dynamic> json) {
  return _PostEntity.fromJson(json);
}

/// @nodoc
mixin _$PostEntity {
  int get id => throw _privateConstructorUsedError;
  int get boardId => throw _privateConstructorUsedError;
  String get writerNickname => throw _privateConstructorUsedError;
  bool get isWriterAnonymous => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String? get category =>
      throw _privateConstructorUsedError; // Added category field
  int get viewCount => throw _privateConstructorUsedError;
  int get likeCount => throw _privateConstructorUsedError;
  int get commentCount => throw _privateConstructorUsedError;
  bool get isSecret => throw _privateConstructorUsedError;
  bool get isLiked => throw _privateConstructorUsedError;
  bool get isMine => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  List<String>? get imageUrls => throw _privateConstructorUsedError;

  /// Serializes this PostEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostEntityCopyWith<PostEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostEntityCopyWith<$Res> {
  factory $PostEntityCopyWith(
    PostEntity value,
    $Res Function(PostEntity) then,
  ) = _$PostEntityCopyWithImpl<$Res, PostEntity>;
  @useResult
  $Res call({
    int id,
    int boardId,
    String writerNickname,
    bool isWriterAnonymous,
    String title,
    String content,
    String? category,
    int viewCount,
    int likeCount,
    int commentCount,
    bool isSecret,
    bool isLiked,
    bool isMine,
    DateTime createdAt,
    DateTime? updatedAt,
    List<String>? imageUrls,
  });
}

/// @nodoc
class _$PostEntityCopyWithImpl<$Res, $Val extends PostEntity>
    implements $PostEntityCopyWith<$Res> {
  _$PostEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? boardId = null,
    Object? writerNickname = null,
    Object? isWriterAnonymous = null,
    Object? title = null,
    Object? content = null,
    Object? category = freezed,
    Object? viewCount = null,
    Object? likeCount = null,
    Object? commentCount = null,
    Object? isSecret = null,
    Object? isLiked = null,
    Object? isMine = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? imageUrls = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            boardId: null == boardId
                ? _value.boardId
                : boardId // ignore: cast_nullable_to_non_nullable
                      as int,
            writerNickname: null == writerNickname
                ? _value.writerNickname
                : writerNickname // ignore: cast_nullable_to_non_nullable
                      as String,
            isWriterAnonymous: null == isWriterAnonymous
                ? _value.isWriterAnonymous
                : isWriterAnonymous // ignore: cast_nullable_to_non_nullable
                      as bool,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String?,
            viewCount: null == viewCount
                ? _value.viewCount
                : viewCount // ignore: cast_nullable_to_non_nullable
                      as int,
            likeCount: null == likeCount
                ? _value.likeCount
                : likeCount // ignore: cast_nullable_to_non_nullable
                      as int,
            commentCount: null == commentCount
                ? _value.commentCount
                : commentCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isSecret: null == isSecret
                ? _value.isSecret
                : isSecret // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLiked: null == isLiked
                ? _value.isLiked
                : isLiked // ignore: cast_nullable_to_non_nullable
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PostEntityImplCopyWith<$Res>
    implements $PostEntityCopyWith<$Res> {
  factory _$$PostEntityImplCopyWith(
    _$PostEntityImpl value,
    $Res Function(_$PostEntityImpl) then,
  ) = __$$PostEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int boardId,
    String writerNickname,
    bool isWriterAnonymous,
    String title,
    String content,
    String? category,
    int viewCount,
    int likeCount,
    int commentCount,
    bool isSecret,
    bool isLiked,
    bool isMine,
    DateTime createdAt,
    DateTime? updatedAt,
    List<String>? imageUrls,
  });
}

/// @nodoc
class __$$PostEntityImplCopyWithImpl<$Res>
    extends _$PostEntityCopyWithImpl<$Res, _$PostEntityImpl>
    implements _$$PostEntityImplCopyWith<$Res> {
  __$$PostEntityImplCopyWithImpl(
    _$PostEntityImpl _value,
    $Res Function(_$PostEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? boardId = null,
    Object? writerNickname = null,
    Object? isWriterAnonymous = null,
    Object? title = null,
    Object? content = null,
    Object? category = freezed,
    Object? viewCount = null,
    Object? likeCount = null,
    Object? commentCount = null,
    Object? isSecret = null,
    Object? isLiked = null,
    Object? isMine = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? imageUrls = freezed,
  }) {
    return _then(
      _$PostEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        boardId: null == boardId
            ? _value.boardId
            : boardId // ignore: cast_nullable_to_non_nullable
                  as int,
        writerNickname: null == writerNickname
            ? _value.writerNickname
            : writerNickname // ignore: cast_nullable_to_non_nullable
                  as String,
        isWriterAnonymous: null == isWriterAnonymous
            ? _value.isWriterAnonymous
            : isWriterAnonymous // ignore: cast_nullable_to_non_nullable
                  as bool,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
        viewCount: null == viewCount
            ? _value.viewCount
            : viewCount // ignore: cast_nullable_to_non_nullable
                  as int,
        likeCount: null == likeCount
            ? _value.likeCount
            : likeCount // ignore: cast_nullable_to_non_nullable
                  as int,
        commentCount: null == commentCount
            ? _value.commentCount
            : commentCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isSecret: null == isSecret
            ? _value.isSecret
            : isSecret // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLiked: null == isLiked
            ? _value.isLiked
            : isLiked // ignore: cast_nullable_to_non_nullable
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PostEntityImpl implements _PostEntity {
  const _$PostEntityImpl({
    required this.id,
    required this.boardId,
    required this.writerNickname,
    this.isWriterAnonymous = false,
    required this.title,
    required this.content,
    this.category,
    this.viewCount = 0,
    this.likeCount = 0,
    this.commentCount = 0,
    this.isSecret = false,
    this.isLiked = false,
    this.isMine = false,
    required this.createdAt,
    this.updatedAt,
    final List<String>? imageUrls,
  }) : _imageUrls = imageUrls;

  factory _$PostEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostEntityImplFromJson(json);

  @override
  final int id;
  @override
  final int boardId;
  @override
  final String writerNickname;
  @override
  @JsonKey()
  final bool isWriterAnonymous;
  @override
  final String title;
  @override
  final String content;
  @override
  final String? category;
  // Added category field
  @override
  @JsonKey()
  final int viewCount;
  @override
  @JsonKey()
  final int likeCount;
  @override
  @JsonKey()
  final int commentCount;
  @override
  @JsonKey()
  final bool isSecret;
  @override
  @JsonKey()
  final bool isLiked;
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

  @override
  String toString() {
    return 'PostEntity(id: $id, boardId: $boardId, writerNickname: $writerNickname, isWriterAnonymous: $isWriterAnonymous, title: $title, content: $content, category: $category, viewCount: $viewCount, likeCount: $likeCount, commentCount: $commentCount, isSecret: $isSecret, isLiked: $isLiked, isMine: $isMine, createdAt: $createdAt, updatedAt: $updatedAt, imageUrls: $imageUrls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.boardId, boardId) || other.boardId == boardId) &&
            (identical(other.writerNickname, writerNickname) ||
                other.writerNickname == writerNickname) &&
            (identical(other.isWriterAnonymous, isWriterAnonymous) ||
                other.isWriterAnonymous == isWriterAnonymous) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount) &&
            (identical(other.isSecret, isSecret) ||
                other.isSecret == isSecret) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked) &&
            (identical(other.isMine, isMine) || other.isMine == isMine) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(
              other._imageUrls,
              _imageUrls,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    boardId,
    writerNickname,
    isWriterAnonymous,
    title,
    content,
    category,
    viewCount,
    likeCount,
    commentCount,
    isSecret,
    isLiked,
    isMine,
    createdAt,
    updatedAt,
    const DeepCollectionEquality().hash(_imageUrls),
  );

  /// Create a copy of PostEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostEntityImplCopyWith<_$PostEntityImpl> get copyWith =>
      __$$PostEntityImplCopyWithImpl<_$PostEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostEntityImplToJson(this);
  }
}

abstract class _PostEntity implements PostEntity {
  const factory _PostEntity({
    required final int id,
    required final int boardId,
    required final String writerNickname,
    final bool isWriterAnonymous,
    required final String title,
    required final String content,
    final String? category,
    final int viewCount,
    final int likeCount,
    final int commentCount,
    final bool isSecret,
    final bool isLiked,
    final bool isMine,
    required final DateTime createdAt,
    final DateTime? updatedAt,
    final List<String>? imageUrls,
  }) = _$PostEntityImpl;

  factory _PostEntity.fromJson(Map<String, dynamic> json) =
      _$PostEntityImpl.fromJson;

  @override
  int get id;
  @override
  int get boardId;
  @override
  String get writerNickname;
  @override
  bool get isWriterAnonymous;
  @override
  String get title;
  @override
  String get content;
  @override
  String? get category; // Added category field
  @override
  int get viewCount;
  @override
  int get likeCount;
  @override
  int get commentCount;
  @override
  bool get isSecret;
  @override
  bool get isLiked;
  @override
  bool get isMine;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  List<String>? get imageUrls;

  /// Create a copy of PostEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostEntityImplCopyWith<_$PostEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
