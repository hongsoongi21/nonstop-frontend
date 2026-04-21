// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'popular_board_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PopularTopPost {
  int get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  int get viewCount => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  int get likeCount => throw _privateConstructorUsedError;
  int get commentCount => throw _privateConstructorUsedError;

  /// Create a copy of PopularTopPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PopularTopPostCopyWith<PopularTopPost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PopularTopPostCopyWith<$Res> {
  factory $PopularTopPostCopyWith(
    PopularTopPost value,
    $Res Function(PopularTopPost) then,
  ) = _$PopularTopPostCopyWithImpl<$Res, PopularTopPost>;
  @useResult
  $Res call({
    int id,
    String? title,
    int viewCount,
    DateTime createdAt,
    int likeCount,
    int commentCount,
  });
}

/// @nodoc
class _$PopularTopPostCopyWithImpl<$Res, $Val extends PopularTopPost>
    implements $PopularTopPostCopyWith<$Res> {
  _$PopularTopPostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PopularTopPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? viewCount = null,
    Object? createdAt = null,
    Object? likeCount = null,
    Object? commentCount = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            viewCount: null == viewCount
                ? _value.viewCount
                : viewCount // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            likeCount: null == likeCount
                ? _value.likeCount
                : likeCount // ignore: cast_nullable_to_non_nullable
                      as int,
            commentCount: null == commentCount
                ? _value.commentCount
                : commentCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PopularTopPostImplCopyWith<$Res>
    implements $PopularTopPostCopyWith<$Res> {
  factory _$$PopularTopPostImplCopyWith(
    _$PopularTopPostImpl value,
    $Res Function(_$PopularTopPostImpl) then,
  ) = __$$PopularTopPostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String? title,
    int viewCount,
    DateTime createdAt,
    int likeCount,
    int commentCount,
  });
}

/// @nodoc
class __$$PopularTopPostImplCopyWithImpl<$Res>
    extends _$PopularTopPostCopyWithImpl<$Res, _$PopularTopPostImpl>
    implements _$$PopularTopPostImplCopyWith<$Res> {
  __$$PopularTopPostImplCopyWithImpl(
    _$PopularTopPostImpl _value,
    $Res Function(_$PopularTopPostImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PopularTopPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? viewCount = null,
    Object? createdAt = null,
    Object? likeCount = null,
    Object? commentCount = null,
  }) {
    return _then(
      _$PopularTopPostImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        viewCount: null == viewCount
            ? _value.viewCount
            : viewCount // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        likeCount: null == likeCount
            ? _value.likeCount
            : likeCount // ignore: cast_nullable_to_non_nullable
                  as int,
        commentCount: null == commentCount
            ? _value.commentCount
            : commentCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$PopularTopPostImpl implements _PopularTopPost {
  const _$PopularTopPostImpl({
    required this.id,
    this.title,
    required this.viewCount,
    required this.createdAt,
    required this.likeCount,
    required this.commentCount,
  });

  @override
  final int id;
  @override
  final String? title;
  @override
  final int viewCount;
  @override
  final DateTime createdAt;
  @override
  final int likeCount;
  @override
  final int commentCount;

  @override
  String toString() {
    return 'PopularTopPost(id: $id, title: $title, viewCount: $viewCount, createdAt: $createdAt, likeCount: $likeCount, commentCount: $commentCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PopularTopPostImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    viewCount,
    createdAt,
    likeCount,
    commentCount,
  );

  /// Create a copy of PopularTopPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PopularTopPostImplCopyWith<_$PopularTopPostImpl> get copyWith =>
      __$$PopularTopPostImplCopyWithImpl<_$PopularTopPostImpl>(
        this,
        _$identity,
      );
}

abstract class _PopularTopPost implements PopularTopPost {
  const factory _PopularTopPost({
    required final int id,
    final String? title,
    required final int viewCount,
    required final DateTime createdAt,
    required final int likeCount,
    required final int commentCount,
  }) = _$PopularTopPostImpl;

  @override
  int get id;
  @override
  String? get title;
  @override
  int get viewCount;
  @override
  DateTime get createdAt;
  @override
  int get likeCount;
  @override
  int get commentCount;

  /// Create a copy of PopularTopPost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PopularTopPostImplCopyWith<_$PopularTopPostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PopularBoardItem {
  int get boardId => throw _privateConstructorUsedError;
  String get boardName => throw _privateConstructorUsedError;
  String? get boardSlug => throw _privateConstructorUsedError;
  String get boardType => throw _privateConstructorUsedError;
  int get postCount => throw _privateConstructorUsedError;
  PopularTopPost? get topPost => throw _privateConstructorUsedError;

  /// Create a copy of PopularBoardItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PopularBoardItemCopyWith<PopularBoardItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PopularBoardItemCopyWith<$Res> {
  factory $PopularBoardItemCopyWith(
    PopularBoardItem value,
    $Res Function(PopularBoardItem) then,
  ) = _$PopularBoardItemCopyWithImpl<$Res, PopularBoardItem>;
  @useResult
  $Res call({
    int boardId,
    String boardName,
    String? boardSlug,
    String boardType,
    int postCount,
    PopularTopPost? topPost,
  });

  $PopularTopPostCopyWith<$Res>? get topPost;
}

/// @nodoc
class _$PopularBoardItemCopyWithImpl<$Res, $Val extends PopularBoardItem>
    implements $PopularBoardItemCopyWith<$Res> {
  _$PopularBoardItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PopularBoardItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? boardId = null,
    Object? boardName = null,
    Object? boardSlug = freezed,
    Object? boardType = null,
    Object? postCount = null,
    Object? topPost = freezed,
  }) {
    return _then(
      _value.copyWith(
            boardId: null == boardId
                ? _value.boardId
                : boardId // ignore: cast_nullable_to_non_nullable
                      as int,
            boardName: null == boardName
                ? _value.boardName
                : boardName // ignore: cast_nullable_to_non_nullable
                      as String,
            boardSlug: freezed == boardSlug
                ? _value.boardSlug
                : boardSlug // ignore: cast_nullable_to_non_nullable
                      as String?,
            boardType: null == boardType
                ? _value.boardType
                : boardType // ignore: cast_nullable_to_non_nullable
                      as String,
            postCount: null == postCount
                ? _value.postCount
                : postCount // ignore: cast_nullable_to_non_nullable
                      as int,
            topPost: freezed == topPost
                ? _value.topPost
                : topPost // ignore: cast_nullable_to_non_nullable
                      as PopularTopPost?,
          )
          as $Val,
    );
  }

  /// Create a copy of PopularBoardItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PopularTopPostCopyWith<$Res>? get topPost {
    if (_value.topPost == null) {
      return null;
    }

    return $PopularTopPostCopyWith<$Res>(_value.topPost!, (value) {
      return _then(_value.copyWith(topPost: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PopularBoardItemImplCopyWith<$Res>
    implements $PopularBoardItemCopyWith<$Res> {
  factory _$$PopularBoardItemImplCopyWith(
    _$PopularBoardItemImpl value,
    $Res Function(_$PopularBoardItemImpl) then,
  ) = __$$PopularBoardItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int boardId,
    String boardName,
    String? boardSlug,
    String boardType,
    int postCount,
    PopularTopPost? topPost,
  });

  @override
  $PopularTopPostCopyWith<$Res>? get topPost;
}

/// @nodoc
class __$$PopularBoardItemImplCopyWithImpl<$Res>
    extends _$PopularBoardItemCopyWithImpl<$Res, _$PopularBoardItemImpl>
    implements _$$PopularBoardItemImplCopyWith<$Res> {
  __$$PopularBoardItemImplCopyWithImpl(
    _$PopularBoardItemImpl _value,
    $Res Function(_$PopularBoardItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PopularBoardItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? boardId = null,
    Object? boardName = null,
    Object? boardSlug = freezed,
    Object? boardType = null,
    Object? postCount = null,
    Object? topPost = freezed,
  }) {
    return _then(
      _$PopularBoardItemImpl(
        boardId: null == boardId
            ? _value.boardId
            : boardId // ignore: cast_nullable_to_non_nullable
                  as int,
        boardName: null == boardName
            ? _value.boardName
            : boardName // ignore: cast_nullable_to_non_nullable
                  as String,
        boardSlug: freezed == boardSlug
            ? _value.boardSlug
            : boardSlug // ignore: cast_nullable_to_non_nullable
                  as String?,
        boardType: null == boardType
            ? _value.boardType
            : boardType // ignore: cast_nullable_to_non_nullable
                  as String,
        postCount: null == postCount
            ? _value.postCount
            : postCount // ignore: cast_nullable_to_non_nullable
                  as int,
        topPost: freezed == topPost
            ? _value.topPost
            : topPost // ignore: cast_nullable_to_non_nullable
                  as PopularTopPost?,
      ),
    );
  }
}

/// @nodoc

class _$PopularBoardItemImpl implements _PopularBoardItem {
  const _$PopularBoardItemImpl({
    required this.boardId,
    required this.boardName,
    this.boardSlug,
    required this.boardType,
    required this.postCount,
    this.topPost,
  });

  @override
  final int boardId;
  @override
  final String boardName;
  @override
  final String? boardSlug;
  @override
  final String boardType;
  @override
  final int postCount;
  @override
  final PopularTopPost? topPost;

  @override
  String toString() {
    return 'PopularBoardItem(boardId: $boardId, boardName: $boardName, boardSlug: $boardSlug, boardType: $boardType, postCount: $postCount, topPost: $topPost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PopularBoardItemImpl &&
            (identical(other.boardId, boardId) || other.boardId == boardId) &&
            (identical(other.boardName, boardName) ||
                other.boardName == boardName) &&
            (identical(other.boardSlug, boardSlug) ||
                other.boardSlug == boardSlug) &&
            (identical(other.boardType, boardType) ||
                other.boardType == boardType) &&
            (identical(other.postCount, postCount) ||
                other.postCount == postCount) &&
            (identical(other.topPost, topPost) || other.topPost == topPost));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    boardId,
    boardName,
    boardSlug,
    boardType,
    postCount,
    topPost,
  );

  /// Create a copy of PopularBoardItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PopularBoardItemImplCopyWith<_$PopularBoardItemImpl> get copyWith =>
      __$$PopularBoardItemImplCopyWithImpl<_$PopularBoardItemImpl>(
        this,
        _$identity,
      );
}

abstract class _PopularBoardItem implements PopularBoardItem {
  const factory _PopularBoardItem({
    required final int boardId,
    required final String boardName,
    final String? boardSlug,
    required final String boardType,
    required final int postCount,
    final PopularTopPost? topPost,
  }) = _$PopularBoardItemImpl;

  @override
  int get boardId;
  @override
  String get boardName;
  @override
  String? get boardSlug;
  @override
  String get boardType;
  @override
  int get postCount;
  @override
  PopularTopPost? get topPost;

  /// Create a copy of PopularBoardItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PopularBoardItemImplCopyWith<_$PopularBoardItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
