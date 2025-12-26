// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EventDto _$EventDtoFromJson(Map<String, dynamic> json) {
  return _EventDto.fromJson(json);
}

/// @nodoc
mixin _$EventDto {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  String get eventType => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  int? get color => throw _privateConstructorUsedError;
  bool? get isAllDay => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this EventDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EventDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventDtoCopyWith<EventDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventDtoCopyWith<$Res> {
  factory $EventDtoCopyWith(EventDto value, $Res Function(EventDto) then) =
      _$EventDtoCopyWithImpl<$Res, EventDto>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    DateTime startTime,
    DateTime endTime,
    String eventType,
    String userId,
    String? location,
    int? color,
    bool? isAllDay,
    List<String>? tags,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$EventDtoCopyWithImpl<$Res, $Val extends EventDto>
    implements $EventDtoCopyWith<$Res> {
  _$EventDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? eventType = null,
    Object? userId = null,
    Object? location = freezed,
    Object? color = freezed,
    Object? isAllDay = freezed,
    Object? tags = freezed,
    Object? metadata = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            eventType: null == eventType
                ? _value.eventType
                : eventType // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            color: freezed == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as int?,
            isAllDay: freezed == isAllDay
                ? _value.isAllDay
                : isAllDay // ignore: cast_nullable_to_non_nullable
                      as bool?,
            tags: freezed == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            metadata: freezed == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EventDtoImplCopyWith<$Res>
    implements $EventDtoCopyWith<$Res> {
  factory _$$EventDtoImplCopyWith(
    _$EventDtoImpl value,
    $Res Function(_$EventDtoImpl) then,
  ) = __$$EventDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    DateTime startTime,
    DateTime endTime,
    String eventType,
    String userId,
    String? location,
    int? color,
    bool? isAllDay,
    List<String>? tags,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$EventDtoImplCopyWithImpl<$Res>
    extends _$EventDtoCopyWithImpl<$Res, _$EventDtoImpl>
    implements _$$EventDtoImplCopyWith<$Res> {
  __$$EventDtoImplCopyWithImpl(
    _$EventDtoImpl _value,
    $Res Function(_$EventDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EventDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? eventType = null,
    Object? userId = null,
    Object? location = freezed,
    Object? color = freezed,
    Object? isAllDay = freezed,
    Object? tags = freezed,
    Object? metadata = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$EventDtoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        eventType: null == eventType
            ? _value.eventType
            : eventType // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        color: freezed == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as int?,
        isAllDay: freezed == isAllDay
            ? _value.isAllDay
            : isAllDay // ignore: cast_nullable_to_non_nullable
                  as bool?,
        tags: freezed == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        metadata: freezed == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EventDtoImpl extends _EventDto {
  const _$EventDtoImpl({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.eventType,
    required this.userId,
    this.location,
    this.color,
    this.isAllDay = false,
    final List<String>? tags = const [],
    final Map<String, dynamic>? metadata,
    this.createdAt,
    this.updatedAt,
  }) : _tags = tags,
       _metadata = metadata,
       super._();

  factory _$EventDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final String eventType;
  @override
  final String userId;
  @override
  final String? location;
  @override
  final int? color;
  @override
  @JsonKey()
  final bool? isAllDay;
  final List<String>? _tags;
  @override
  @JsonKey()
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'EventDto(id: $id, title: $title, description: $description, startTime: $startTime, endTime: $endTime, eventType: $eventType, userId: $userId, location: $location, color: $color, isAllDay: $isAllDay, tags: $tags, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.isAllDay, isAllDay) ||
                other.isAllDay == isAllDay) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    startTime,
    endTime,
    eventType,
    userId,
    location,
    color,
    isAllDay,
    const DeepCollectionEquality().hash(_tags),
    const DeepCollectionEquality().hash(_metadata),
    createdAt,
    updatedAt,
  );

  /// Create a copy of EventDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventDtoImplCopyWith<_$EventDtoImpl> get copyWith =>
      __$$EventDtoImplCopyWithImpl<_$EventDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventDtoImplToJson(this);
  }
}

abstract class _EventDto extends EventDto {
  const factory _EventDto({
    required final String id,
    required final String title,
    required final String description,
    required final DateTime startTime,
    required final DateTime endTime,
    required final String eventType,
    required final String userId,
    final String? location,
    final int? color,
    final bool? isAllDay,
    final List<String>? tags,
    final Map<String, dynamic>? metadata,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$EventDtoImpl;
  const _EventDto._() : super._();

  factory _EventDto.fromJson(Map<String, dynamic> json) =
      _$EventDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  String get eventType;
  @override
  String get userId;
  @override
  String? get location;
  @override
  int? get color;
  @override
  bool? get isAllDay;
  @override
  List<String>? get tags;
  @override
  Map<String, dynamic>? get metadata;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of EventDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventDtoImplCopyWith<_$EventDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateEventDto _$CreateEventDtoFromJson(Map<String, dynamic> json) {
  return _CreateEventDto.fromJson(json);
}

/// @nodoc
mixin _$CreateEventDto {
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  String get eventType => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  int? get color => throw _privateConstructorUsedError;
  bool? get isAllDay => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this CreateEventDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateEventDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateEventDtoCopyWith<CreateEventDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateEventDtoCopyWith<$Res> {
  factory $CreateEventDtoCopyWith(
    CreateEventDto value,
    $Res Function(CreateEventDto) then,
  ) = _$CreateEventDtoCopyWithImpl<$Res, CreateEventDto>;
  @useResult
  $Res call({
    String title,
    String description,
    DateTime startTime,
    DateTime endTime,
    String eventType,
    String userId,
    String? location,
    int? color,
    bool? isAllDay,
    List<String>? tags,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class _$CreateEventDtoCopyWithImpl<$Res, $Val extends CreateEventDto>
    implements $CreateEventDtoCopyWith<$Res> {
  _$CreateEventDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateEventDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? eventType = null,
    Object? userId = null,
    Object? location = freezed,
    Object? color = freezed,
    Object? isAllDay = freezed,
    Object? tags = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            eventType: null == eventType
                ? _value.eventType
                : eventType // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            color: freezed == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as int?,
            isAllDay: freezed == isAllDay
                ? _value.isAllDay
                : isAllDay // ignore: cast_nullable_to_non_nullable
                      as bool?,
            tags: freezed == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            metadata: freezed == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateEventDtoImplCopyWith<$Res>
    implements $CreateEventDtoCopyWith<$Res> {
  factory _$$CreateEventDtoImplCopyWith(
    _$CreateEventDtoImpl value,
    $Res Function(_$CreateEventDtoImpl) then,
  ) = __$$CreateEventDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    String description,
    DateTime startTime,
    DateTime endTime,
    String eventType,
    String userId,
    String? location,
    int? color,
    bool? isAllDay,
    List<String>? tags,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class __$$CreateEventDtoImplCopyWithImpl<$Res>
    extends _$CreateEventDtoCopyWithImpl<$Res, _$CreateEventDtoImpl>
    implements _$$CreateEventDtoImplCopyWith<$Res> {
  __$$CreateEventDtoImplCopyWithImpl(
    _$CreateEventDtoImpl _value,
    $Res Function(_$CreateEventDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateEventDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? eventType = null,
    Object? userId = null,
    Object? location = freezed,
    Object? color = freezed,
    Object? isAllDay = freezed,
    Object? tags = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _$CreateEventDtoImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        eventType: null == eventType
            ? _value.eventType
            : eventType // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        color: freezed == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as int?,
        isAllDay: freezed == isAllDay
            ? _value.isAllDay
            : isAllDay // ignore: cast_nullable_to_non_nullable
                  as bool?,
        tags: freezed == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        metadata: freezed == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateEventDtoImpl extends _CreateEventDto {
  const _$CreateEventDtoImpl({
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.eventType,
    required this.userId,
    this.location,
    this.color,
    this.isAllDay = false,
    final List<String>? tags = const [],
    final Map<String, dynamic>? metadata,
  }) : _tags = tags,
       _metadata = metadata,
       super._();

  factory _$CreateEventDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateEventDtoImplFromJson(json);

  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final String eventType;
  @override
  final String userId;
  @override
  final String? location;
  @override
  final int? color;
  @override
  @JsonKey()
  final bool? isAllDay;
  final List<String>? _tags;
  @override
  @JsonKey()
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'CreateEventDto(title: $title, description: $description, startTime: $startTime, endTime: $endTime, eventType: $eventType, userId: $userId, location: $location, color: $color, isAllDay: $isAllDay, tags: $tags, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateEventDtoImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.isAllDay, isAllDay) ||
                other.isAllDay == isAllDay) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    description,
    startTime,
    endTime,
    eventType,
    userId,
    location,
    color,
    isAllDay,
    const DeepCollectionEquality().hash(_tags),
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of CreateEventDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateEventDtoImplCopyWith<_$CreateEventDtoImpl> get copyWith =>
      __$$CreateEventDtoImplCopyWithImpl<_$CreateEventDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateEventDtoImplToJson(this);
  }
}

abstract class _CreateEventDto extends CreateEventDto {
  const factory _CreateEventDto({
    required final String title,
    required final String description,
    required final DateTime startTime,
    required final DateTime endTime,
    required final String eventType,
    required final String userId,
    final String? location,
    final int? color,
    final bool? isAllDay,
    final List<String>? tags,
    final Map<String, dynamic>? metadata,
  }) = _$CreateEventDtoImpl;
  const _CreateEventDto._() : super._();

  factory _CreateEventDto.fromJson(Map<String, dynamic> json) =
      _$CreateEventDtoImpl.fromJson;

  @override
  String get title;
  @override
  String get description;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  String get eventType;
  @override
  String get userId;
  @override
  String? get location;
  @override
  int? get color;
  @override
  bool? get isAllDay;
  @override
  List<String>? get tags;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of CreateEventDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateEventDtoImplCopyWith<_$CreateEventDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateEventDto _$UpdateEventDtoFromJson(Map<String, dynamic> json) {
  return _UpdateEventDto.fromJson(json);
}

/// @nodoc
mixin _$UpdateEventDto {
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  String get eventType => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  int? get color => throw _privateConstructorUsedError;
  bool? get isAllDay => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this UpdateEventDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateEventDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateEventDtoCopyWith<UpdateEventDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateEventDtoCopyWith<$Res> {
  factory $UpdateEventDtoCopyWith(
    UpdateEventDto value,
    $Res Function(UpdateEventDto) then,
  ) = _$UpdateEventDtoCopyWithImpl<$Res, UpdateEventDto>;
  @useResult
  $Res call({
    String title,
    String description,
    DateTime startTime,
    DateTime endTime,
    String eventType,
    String? location,
    int? color,
    bool? isAllDay,
    List<String>? tags,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class _$UpdateEventDtoCopyWithImpl<$Res, $Val extends UpdateEventDto>
    implements $UpdateEventDtoCopyWith<$Res> {
  _$UpdateEventDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateEventDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? eventType = null,
    Object? location = freezed,
    Object? color = freezed,
    Object? isAllDay = freezed,
    Object? tags = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            eventType: null == eventType
                ? _value.eventType
                : eventType // ignore: cast_nullable_to_non_nullable
                      as String,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            color: freezed == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as int?,
            isAllDay: freezed == isAllDay
                ? _value.isAllDay
                : isAllDay // ignore: cast_nullable_to_non_nullable
                      as bool?,
            tags: freezed == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            metadata: freezed == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpdateEventDtoImplCopyWith<$Res>
    implements $UpdateEventDtoCopyWith<$Res> {
  factory _$$UpdateEventDtoImplCopyWith(
    _$UpdateEventDtoImpl value,
    $Res Function(_$UpdateEventDtoImpl) then,
  ) = __$$UpdateEventDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    String description,
    DateTime startTime,
    DateTime endTime,
    String eventType,
    String? location,
    int? color,
    bool? isAllDay,
    List<String>? tags,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class __$$UpdateEventDtoImplCopyWithImpl<$Res>
    extends _$UpdateEventDtoCopyWithImpl<$Res, _$UpdateEventDtoImpl>
    implements _$$UpdateEventDtoImplCopyWith<$Res> {
  __$$UpdateEventDtoImplCopyWithImpl(
    _$UpdateEventDtoImpl _value,
    $Res Function(_$UpdateEventDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpdateEventDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? eventType = null,
    Object? location = freezed,
    Object? color = freezed,
    Object? isAllDay = freezed,
    Object? tags = freezed,
    Object? metadata = freezed,
  }) {
    return _then(
      _$UpdateEventDtoImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        eventType: null == eventType
            ? _value.eventType
            : eventType // ignore: cast_nullable_to_non_nullable
                  as String,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        color: freezed == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as int?,
        isAllDay: freezed == isAllDay
            ? _value.isAllDay
            : isAllDay // ignore: cast_nullable_to_non_nullable
                  as bool?,
        tags: freezed == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        metadata: freezed == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateEventDtoImpl extends _UpdateEventDto {
  const _$UpdateEventDtoImpl({
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.eventType,
    this.location,
    this.color,
    this.isAllDay,
    final List<String>? tags,
    final Map<String, dynamic>? metadata,
  }) : _tags = tags,
       _metadata = metadata,
       super._();

  factory _$UpdateEventDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateEventDtoImplFromJson(json);

  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final String eventType;
  @override
  final String? location;
  @override
  final int? color;
  @override
  final bool? isAllDay;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'UpdateEventDto(title: $title, description: $description, startTime: $startTime, endTime: $endTime, eventType: $eventType, location: $location, color: $color, isAllDay: $isAllDay, tags: $tags, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateEventDtoImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.isAllDay, isAllDay) ||
                other.isAllDay == isAllDay) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    description,
    startTime,
    endTime,
    eventType,
    location,
    color,
    isAllDay,
    const DeepCollectionEquality().hash(_tags),
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of UpdateEventDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateEventDtoImplCopyWith<_$UpdateEventDtoImpl> get copyWith =>
      __$$UpdateEventDtoImplCopyWithImpl<_$UpdateEventDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateEventDtoImplToJson(this);
  }
}

abstract class _UpdateEventDto extends UpdateEventDto {
  const factory _UpdateEventDto({
    required final String title,
    required final String description,
    required final DateTime startTime,
    required final DateTime endTime,
    required final String eventType,
    final String? location,
    final int? color,
    final bool? isAllDay,
    final List<String>? tags,
    final Map<String, dynamic>? metadata,
  }) = _$UpdateEventDtoImpl;
  const _UpdateEventDto._() : super._();

  factory _UpdateEventDto.fromJson(Map<String, dynamic> json) =
      _$UpdateEventDtoImpl.fromJson;

  @override
  String get title;
  @override
  String get description;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  String get eventType;
  @override
  String? get location;
  @override
  int? get color;
  @override
  bool? get isAllDay;
  @override
  List<String>? get tags;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of UpdateEventDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateEventDtoImplCopyWith<_$UpdateEventDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EventResponseDto _$EventResponseDtoFromJson(Map<String, dynamic> json) {
  return _EventResponseDto.fromJson(json);
}

/// @nodoc
mixin _$EventResponseDto {
  bool get success => throw _privateConstructorUsedError;
  EventDto get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  List<String>? get errors => throw _privateConstructorUsedError;

  /// Serializes this EventResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EventResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventResponseDtoCopyWith<EventResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventResponseDtoCopyWith<$Res> {
  factory $EventResponseDtoCopyWith(
    EventResponseDto value,
    $Res Function(EventResponseDto) then,
  ) = _$EventResponseDtoCopyWithImpl<$Res, EventResponseDto>;
  @useResult
  $Res call({
    bool success,
    EventDto data,
    String? message,
    List<String>? errors,
  });

  $EventDtoCopyWith<$Res> get data;
}

/// @nodoc
class _$EventResponseDtoCopyWithImpl<$Res, $Val extends EventResponseDto>
    implements $EventResponseDtoCopyWith<$Res> {
  _$EventResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = null,
    Object? message = freezed,
    Object? errors = freezed,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as EventDto,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            errors: freezed == errors
                ? _value.errors
                : errors // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
          )
          as $Val,
    );
  }

  /// Create a copy of EventResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EventDtoCopyWith<$Res> get data {
    return $EventDtoCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EventResponseDtoImplCopyWith<$Res>
    implements $EventResponseDtoCopyWith<$Res> {
  factory _$$EventResponseDtoImplCopyWith(
    _$EventResponseDtoImpl value,
    $Res Function(_$EventResponseDtoImpl) then,
  ) = __$$EventResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool success,
    EventDto data,
    String? message,
    List<String>? errors,
  });

  @override
  $EventDtoCopyWith<$Res> get data;
}

/// @nodoc
class __$$EventResponseDtoImplCopyWithImpl<$Res>
    extends _$EventResponseDtoCopyWithImpl<$Res, _$EventResponseDtoImpl>
    implements _$$EventResponseDtoImplCopyWith<$Res> {
  __$$EventResponseDtoImplCopyWithImpl(
    _$EventResponseDtoImpl _value,
    $Res Function(_$EventResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EventResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = null,
    Object? message = freezed,
    Object? errors = freezed,
  }) {
    return _then(
      _$EventResponseDtoImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        data: null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as EventDto,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        errors: freezed == errors
            ? _value._errors
            : errors // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EventResponseDtoImpl extends _EventResponseDto {
  const _$EventResponseDtoImpl({
    required this.success,
    required this.data,
    this.message,
    final List<String>? errors,
  }) : _errors = errors,
       super._();

  factory _$EventResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventResponseDtoImplFromJson(json);

  @override
  final bool success;
  @override
  final EventDto data;
  @override
  final String? message;
  final List<String>? _errors;
  @override
  List<String>? get errors {
    final value = _errors;
    if (value == null) return null;
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'EventResponseDto(success: $success, data: $data, message: $message, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventResponseDtoImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    data,
    message,
    const DeepCollectionEquality().hash(_errors),
  );

  /// Create a copy of EventResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventResponseDtoImplCopyWith<_$EventResponseDtoImpl> get copyWith =>
      __$$EventResponseDtoImplCopyWithImpl<_$EventResponseDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EventResponseDtoImplToJson(this);
  }
}

abstract class _EventResponseDto extends EventResponseDto {
  const factory _EventResponseDto({
    required final bool success,
    required final EventDto data,
    final String? message,
    final List<String>? errors,
  }) = _$EventResponseDtoImpl;
  const _EventResponseDto._() : super._();

  factory _EventResponseDto.fromJson(Map<String, dynamic> json) =
      _$EventResponseDtoImpl.fromJson;

  @override
  bool get success;
  @override
  EventDto get data;
  @override
  String? get message;
  @override
  List<String>? get errors;

  /// Create a copy of EventResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventResponseDtoImplCopyWith<_$EventResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EventListResponseDto _$EventListResponseDtoFromJson(Map<String, dynamic> json) {
  return _EventListResponseDto.fromJson(json);
}

/// @nodoc
mixin _$EventListResponseDto {
  bool get success => throw _privateConstructorUsedError;
  List<EventDto> get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  int? get totalCount => throw _privateConstructorUsedError;
  int? get page => throw _privateConstructorUsedError;
  int? get pageSize => throw _privateConstructorUsedError;

  /// Serializes this EventListResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EventListResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventListResponseDtoCopyWith<EventListResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventListResponseDtoCopyWith<$Res> {
  factory $EventListResponseDtoCopyWith(
    EventListResponseDto value,
    $Res Function(EventListResponseDto) then,
  ) = _$EventListResponseDtoCopyWithImpl<$Res, EventListResponseDto>;
  @useResult
  $Res call({
    bool success,
    List<EventDto> data,
    String? message,
    int? totalCount,
    int? page,
    int? pageSize,
  });
}

/// @nodoc
class _$EventListResponseDtoCopyWithImpl<
  $Res,
  $Val extends EventListResponseDto
>
    implements $EventListResponseDtoCopyWith<$Res> {
  _$EventListResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventListResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = null,
    Object? message = freezed,
    Object? totalCount = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as List<EventDto>,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            totalCount: freezed == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            page: freezed == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int?,
            pageSize: freezed == pageSize
                ? _value.pageSize
                : pageSize // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EventListResponseDtoImplCopyWith<$Res>
    implements $EventListResponseDtoCopyWith<$Res> {
  factory _$$EventListResponseDtoImplCopyWith(
    _$EventListResponseDtoImpl value,
    $Res Function(_$EventListResponseDtoImpl) then,
  ) = __$$EventListResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool success,
    List<EventDto> data,
    String? message,
    int? totalCount,
    int? page,
    int? pageSize,
  });
}

/// @nodoc
class __$$EventListResponseDtoImplCopyWithImpl<$Res>
    extends _$EventListResponseDtoCopyWithImpl<$Res, _$EventListResponseDtoImpl>
    implements _$$EventListResponseDtoImplCopyWith<$Res> {
  __$$EventListResponseDtoImplCopyWithImpl(
    _$EventListResponseDtoImpl _value,
    $Res Function(_$EventListResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EventListResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = null,
    Object? message = freezed,
    Object? totalCount = freezed,
    Object? page = freezed,
    Object? pageSize = freezed,
  }) {
    return _then(
      _$EventListResponseDtoImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<EventDto>,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        totalCount: freezed == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        page: freezed == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int?,
        pageSize: freezed == pageSize
            ? _value.pageSize
            : pageSize // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EventListResponseDtoImpl extends _EventListResponseDto {
  const _$EventListResponseDtoImpl({
    required this.success,
    required final List<EventDto> data,
    this.message,
    this.totalCount,
    this.page,
    this.pageSize,
  }) : _data = data,
       super._();

  factory _$EventListResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventListResponseDtoImplFromJson(json);

  @override
  final bool success;
  final List<EventDto> _data;
  @override
  List<EventDto> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final String? message;
  @override
  final int? totalCount;
  @override
  final int? page;
  @override
  final int? pageSize;

  @override
  String toString() {
    return 'EventListResponseDto(success: $success, data: $data, message: $message, totalCount: $totalCount, page: $page, pageSize: $pageSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventListResponseDtoImpl &&
            (identical(other.success, success) || other.success == success) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    const DeepCollectionEquality().hash(_data),
    message,
    totalCount,
    page,
    pageSize,
  );

  /// Create a copy of EventListResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventListResponseDtoImplCopyWith<_$EventListResponseDtoImpl>
  get copyWith =>
      __$$EventListResponseDtoImplCopyWithImpl<_$EventListResponseDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EventListResponseDtoImplToJson(this);
  }
}

abstract class _EventListResponseDto extends EventListResponseDto {
  const factory _EventListResponseDto({
    required final bool success,
    required final List<EventDto> data,
    final String? message,
    final int? totalCount,
    final int? page,
    final int? pageSize,
  }) = _$EventListResponseDtoImpl;
  const _EventListResponseDto._() : super._();

  factory _EventListResponseDto.fromJson(Map<String, dynamic> json) =
      _$EventListResponseDtoImpl.fromJson;

  @override
  bool get success;
  @override
  List<EventDto> get data;
  @override
  String? get message;
  @override
  int? get totalCount;
  @override
  int? get page;
  @override
  int? get pageSize;

  /// Create a copy of EventListResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventListResponseDtoImplCopyWith<_$EventListResponseDtoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

SimpleResponseDto _$SimpleResponseDtoFromJson(Map<String, dynamic> json) {
  return _SimpleResponseDto.fromJson(json);
}

/// @nodoc
mixin _$SimpleResponseDto {
  bool get success => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  List<String>? get errors => throw _privateConstructorUsedError;

  /// Serializes this SimpleResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SimpleResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SimpleResponseDtoCopyWith<SimpleResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimpleResponseDtoCopyWith<$Res> {
  factory $SimpleResponseDtoCopyWith(
    SimpleResponseDto value,
    $Res Function(SimpleResponseDto) then,
  ) = _$SimpleResponseDtoCopyWithImpl<$Res, SimpleResponseDto>;
  @useResult
  $Res call({bool success, String? message, List<String>? errors});
}

/// @nodoc
class _$SimpleResponseDtoCopyWithImpl<$Res, $Val extends SimpleResponseDto>
    implements $SimpleResponseDtoCopyWith<$Res> {
  _$SimpleResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SimpleResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? errors = freezed,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            errors: freezed == errors
                ? _value.errors
                : errors // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SimpleResponseDtoImplCopyWith<$Res>
    implements $SimpleResponseDtoCopyWith<$Res> {
  factory _$$SimpleResponseDtoImplCopyWith(
    _$SimpleResponseDtoImpl value,
    $Res Function(_$SimpleResponseDtoImpl) then,
  ) = __$$SimpleResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String? message, List<String>? errors});
}

/// @nodoc
class __$$SimpleResponseDtoImplCopyWithImpl<$Res>
    extends _$SimpleResponseDtoCopyWithImpl<$Res, _$SimpleResponseDtoImpl>
    implements _$$SimpleResponseDtoImplCopyWith<$Res> {
  __$$SimpleResponseDtoImplCopyWithImpl(
    _$SimpleResponseDtoImpl _value,
    $Res Function(_$SimpleResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SimpleResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? errors = freezed,
  }) {
    return _then(
      _$SimpleResponseDtoImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        errors: freezed == errors
            ? _value._errors
            : errors // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SimpleResponseDtoImpl extends _SimpleResponseDto {
  const _$SimpleResponseDtoImpl({
    required this.success,
    this.message,
    final List<String>? errors,
  }) : _errors = errors,
       super._();

  factory _$SimpleResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SimpleResponseDtoImplFromJson(json);

  @override
  final bool success;
  @override
  final String? message;
  final List<String>? _errors;
  @override
  List<String>? get errors {
    final value = _errors;
    if (value == null) return null;
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SimpleResponseDto(success: $success, message: $message, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimpleResponseDtoImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    message,
    const DeepCollectionEquality().hash(_errors),
  );

  /// Create a copy of SimpleResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SimpleResponseDtoImplCopyWith<_$SimpleResponseDtoImpl> get copyWith =>
      __$$SimpleResponseDtoImplCopyWithImpl<_$SimpleResponseDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SimpleResponseDtoImplToJson(this);
  }
}

abstract class _SimpleResponseDto extends SimpleResponseDto {
  const factory _SimpleResponseDto({
    required final bool success,
    final String? message,
    final List<String>? errors,
  }) = _$SimpleResponseDtoImpl;
  const _SimpleResponseDto._() : super._();

  factory _SimpleResponseDto.fromJson(Map<String, dynamic> json) =
      _$SimpleResponseDtoImpl.fromJson;

  @override
  bool get success;
  @override
  String? get message;
  @override
  List<String>? get errors;

  /// Create a copy of SimpleResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SimpleResponseDtoImplCopyWith<_$SimpleResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
