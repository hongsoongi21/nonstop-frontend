// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_notice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HomeNotice {
  int get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  int get boardId => throw _privateConstructorUsedError;
  String get boardName => throw _privateConstructorUsedError;
  String? get boardSlug => throw _privateConstructorUsedError;

  /// Create a copy of HomeNotice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeNoticeCopyWith<HomeNotice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeNoticeCopyWith<$Res> {
  factory $HomeNoticeCopyWith(
    HomeNotice value,
    $Res Function(HomeNotice) then,
  ) = _$HomeNoticeCopyWithImpl<$Res, HomeNotice>;
  @useResult
  $Res call({
    int id,
    String? title,
    DateTime createdAt,
    int boardId,
    String boardName,
    String? boardSlug,
  });
}

/// @nodoc
class _$HomeNoticeCopyWithImpl<$Res, $Val extends HomeNotice>
    implements $HomeNoticeCopyWith<$Res> {
  _$HomeNoticeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeNotice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? createdAt = null,
    Object? boardId = null,
    Object? boardName = null,
    Object? boardSlug = freezed,
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
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HomeNoticeImplCopyWith<$Res>
    implements $HomeNoticeCopyWith<$Res> {
  factory _$$HomeNoticeImplCopyWith(
    _$HomeNoticeImpl value,
    $Res Function(_$HomeNoticeImpl) then,
  ) = __$$HomeNoticeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String? title,
    DateTime createdAt,
    int boardId,
    String boardName,
    String? boardSlug,
  });
}

/// @nodoc
class __$$HomeNoticeImplCopyWithImpl<$Res>
    extends _$HomeNoticeCopyWithImpl<$Res, _$HomeNoticeImpl>
    implements _$$HomeNoticeImplCopyWith<$Res> {
  __$$HomeNoticeImplCopyWithImpl(
    _$HomeNoticeImpl _value,
    $Res Function(_$HomeNoticeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeNotice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? createdAt = null,
    Object? boardId = null,
    Object? boardName = null,
    Object? boardSlug = freezed,
  }) {
    return _then(
      _$HomeNoticeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
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
      ),
    );
  }
}

/// @nodoc

class _$HomeNoticeImpl implements _HomeNotice {
  const _$HomeNoticeImpl({
    required this.id,
    this.title,
    required this.createdAt,
    required this.boardId,
    required this.boardName,
    this.boardSlug,
  });

  @override
  final int id;
  @override
  final String? title;
  @override
  final DateTime createdAt;
  @override
  final int boardId;
  @override
  final String boardName;
  @override
  final String? boardSlug;

  @override
  String toString() {
    return 'HomeNotice(id: $id, title: $title, createdAt: $createdAt, boardId: $boardId, boardName: $boardName, boardSlug: $boardSlug)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeNoticeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.boardId, boardId) || other.boardId == boardId) &&
            (identical(other.boardName, boardName) ||
                other.boardName == boardName) &&
            (identical(other.boardSlug, boardSlug) ||
                other.boardSlug == boardSlug));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    createdAt,
    boardId,
    boardName,
    boardSlug,
  );

  /// Create a copy of HomeNotice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeNoticeImplCopyWith<_$HomeNoticeImpl> get copyWith =>
      __$$HomeNoticeImplCopyWithImpl<_$HomeNoticeImpl>(this, _$identity);
}

abstract class _HomeNotice implements HomeNotice {
  const factory _HomeNotice({
    required final int id,
    final String? title,
    required final DateTime createdAt,
    required final int boardId,
    required final String boardName,
    final String? boardSlug,
  }) = _$HomeNoticeImpl;

  @override
  int get id;
  @override
  String? get title;
  @override
  DateTime get createdAt;
  @override
  int get boardId;
  @override
  String get boardName;
  @override
  String? get boardSlug;

  /// Create a copy of HomeNotice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeNoticeImplCopyWith<_$HomeNoticeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
