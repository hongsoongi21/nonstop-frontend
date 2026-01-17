// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'university_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UniversityResponseDto _$UniversityResponseDtoFromJson(
  Map<String, dynamic> json,
) {
  return _UniversityResponseDto.fromJson(json);
}

/// @nodoc
mixin _$UniversityResponseDto {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get region => throw _privateConstructorUsedError;
  String? get logoImageUrl => throw _privateConstructorUsedError;

  /// Serializes this UniversityResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UniversityResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UniversityResponseDtoCopyWith<UniversityResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UniversityResponseDtoCopyWith<$Res> {
  factory $UniversityResponseDtoCopyWith(
    UniversityResponseDto value,
    $Res Function(UniversityResponseDto) then,
  ) = _$UniversityResponseDtoCopyWithImpl<$Res, UniversityResponseDto>;
  @useResult
  $Res call({int id, String name, String? region, String? logoImageUrl});
}

/// @nodoc
class _$UniversityResponseDtoCopyWithImpl<
  $Res,
  $Val extends UniversityResponseDto
>
    implements $UniversityResponseDtoCopyWith<$Res> {
  _$UniversityResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UniversityResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? region = freezed,
    Object? logoImageUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            region: freezed == region
                ? _value.region
                : region // ignore: cast_nullable_to_non_nullable
                      as String?,
            logoImageUrl: freezed == logoImageUrl
                ? _value.logoImageUrl
                : logoImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UniversityResponseDtoImplCopyWith<$Res>
    implements $UniversityResponseDtoCopyWith<$Res> {
  factory _$$UniversityResponseDtoImplCopyWith(
    _$UniversityResponseDtoImpl value,
    $Res Function(_$UniversityResponseDtoImpl) then,
  ) = __$$UniversityResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String? region, String? logoImageUrl});
}

/// @nodoc
class __$$UniversityResponseDtoImplCopyWithImpl<$Res>
    extends
        _$UniversityResponseDtoCopyWithImpl<$Res, _$UniversityResponseDtoImpl>
    implements _$$UniversityResponseDtoImplCopyWith<$Res> {
  __$$UniversityResponseDtoImplCopyWithImpl(
    _$UniversityResponseDtoImpl _value,
    $Res Function(_$UniversityResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UniversityResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? region = freezed,
    Object? logoImageUrl = freezed,
  }) {
    return _then(
      _$UniversityResponseDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        region: freezed == region
            ? _value.region
            : region // ignore: cast_nullable_to_non_nullable
                  as String?,
        logoImageUrl: freezed == logoImageUrl
            ? _value.logoImageUrl
            : logoImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UniversityResponseDtoImpl extends _UniversityResponseDto {
  const _$UniversityResponseDtoImpl({
    required this.id,
    required this.name,
    this.region,
    this.logoImageUrl,
  }) : super._();

  factory _$UniversityResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$UniversityResponseDtoImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? region;
  @override
  final String? logoImageUrl;

  @override
  String toString() {
    return 'UniversityResponseDto(id: $id, name: $name, region: $region, logoImageUrl: $logoImageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UniversityResponseDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.logoImageUrl, logoImageUrl) ||
                other.logoImageUrl == logoImageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, region, logoImageUrl);

  /// Create a copy of UniversityResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UniversityResponseDtoImplCopyWith<_$UniversityResponseDtoImpl>
  get copyWith =>
      __$$UniversityResponseDtoImplCopyWithImpl<_$UniversityResponseDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UniversityResponseDtoImplToJson(this);
  }
}

abstract class _UniversityResponseDto extends UniversityResponseDto {
  const factory _UniversityResponseDto({
    required final int id,
    required final String name,
    final String? region,
    final String? logoImageUrl,
  }) = _$UniversityResponseDtoImpl;
  const _UniversityResponseDto._() : super._();

  factory _UniversityResponseDto.fromJson(Map<String, dynamic> json) =
      _$UniversityResponseDtoImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get region;
  @override
  String? get logoImageUrl;

  /// Create a copy of UniversityResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UniversityResponseDtoImplCopyWith<_$UniversityResponseDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

UniversityListResponseDto _$UniversityListResponseDtoFromJson(
  Map<String, dynamic> json,
) {
  return _UniversityListResponseDto.fromJson(json);
}

/// @nodoc
mixin _$UniversityListResponseDto {
  List<UniversityResponseDto> get items => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  int? get limit => throw _privateConstructorUsedError;
  int? get offset => throw _privateConstructorUsedError;

  /// Serializes this UniversityListResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UniversityListResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UniversityListResponseDtoCopyWith<UniversityListResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UniversityListResponseDtoCopyWith<$Res> {
  factory $UniversityListResponseDtoCopyWith(
    UniversityListResponseDto value,
    $Res Function(UniversityListResponseDto) then,
  ) = _$UniversityListResponseDtoCopyWithImpl<$Res, UniversityListResponseDto>;
  @useResult
  $Res call({
    List<UniversityResponseDto> items,
    int totalCount,
    bool hasMore,
    int? limit,
    int? offset,
  });
}

/// @nodoc
class _$UniversityListResponseDtoCopyWithImpl<
  $Res,
  $Val extends UniversityListResponseDto
>
    implements $UniversityListResponseDtoCopyWith<$Res> {
  _$UniversityListResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UniversityListResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? totalCount = null,
    Object? hasMore = null,
    Object? limit = freezed,
    Object? offset = freezed,
  }) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<UniversityResponseDto>,
            totalCount: null == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            limit: freezed == limit
                ? _value.limit
                : limit // ignore: cast_nullable_to_non_nullable
                      as int?,
            offset: freezed == offset
                ? _value.offset
                : offset // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UniversityListResponseDtoImplCopyWith<$Res>
    implements $UniversityListResponseDtoCopyWith<$Res> {
  factory _$$UniversityListResponseDtoImplCopyWith(
    _$UniversityListResponseDtoImpl value,
    $Res Function(_$UniversityListResponseDtoImpl) then,
  ) = __$$UniversityListResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<UniversityResponseDto> items,
    int totalCount,
    bool hasMore,
    int? limit,
    int? offset,
  });
}

/// @nodoc
class __$$UniversityListResponseDtoImplCopyWithImpl<$Res>
    extends
        _$UniversityListResponseDtoCopyWithImpl<
          $Res,
          _$UniversityListResponseDtoImpl
        >
    implements _$$UniversityListResponseDtoImplCopyWith<$Res> {
  __$$UniversityListResponseDtoImplCopyWithImpl(
    _$UniversityListResponseDtoImpl _value,
    $Res Function(_$UniversityListResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UniversityListResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? totalCount = null,
    Object? hasMore = null,
    Object? limit = freezed,
    Object? offset = freezed,
  }) {
    return _then(
      _$UniversityListResponseDtoImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<UniversityResponseDto>,
        totalCount: null == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        limit: freezed == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int?,
        offset: freezed == offset
            ? _value.offset
            : offset // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UniversityListResponseDtoImpl implements _UniversityListResponseDto {
  const _$UniversityListResponseDtoImpl({
    required final List<UniversityResponseDto> items,
    required this.totalCount,
    required this.hasMore,
    this.limit,
    this.offset,
  }) : _items = items;

  factory _$UniversityListResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$UniversityListResponseDtoImplFromJson(json);

  final List<UniversityResponseDto> _items;
  @override
  List<UniversityResponseDto> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final int totalCount;
  @override
  final bool hasMore;
  @override
  final int? limit;
  @override
  final int? offset;

  @override
  String toString() {
    return 'UniversityListResponseDto(items: $items, totalCount: $totalCount, hasMore: $hasMore, limit: $limit, offset: $offset)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UniversityListResponseDtoImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.offset, offset) || other.offset == offset));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    totalCount,
    hasMore,
    limit,
    offset,
  );

  /// Create a copy of UniversityListResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UniversityListResponseDtoImplCopyWith<_$UniversityListResponseDtoImpl>
  get copyWith =>
      __$$UniversityListResponseDtoImplCopyWithImpl<
        _$UniversityListResponseDtoImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UniversityListResponseDtoImplToJson(this);
  }
}

abstract class _UniversityListResponseDto implements UniversityListResponseDto {
  const factory _UniversityListResponseDto({
    required final List<UniversityResponseDto> items,
    required final int totalCount,
    required final bool hasMore,
    final int? limit,
    final int? offset,
  }) = _$UniversityListResponseDtoImpl;

  factory _UniversityListResponseDto.fromJson(Map<String, dynamic> json) =
      _$UniversityListResponseDtoImpl.fromJson;

  @override
  List<UniversityResponseDto> get items;
  @override
  int get totalCount;
  @override
  bool get hasMore;
  @override
  int? get limit;
  @override
  int? get offset;

  /// Create a copy of UniversityListResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UniversityListResponseDtoImplCopyWith<_$UniversityListResponseDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}
