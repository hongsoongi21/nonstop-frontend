// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Community _$CommunityFromJson(Map<String, dynamic> json) {
  return _Community.fromJson(json);
}

/// @nodoc
mixin _$Community {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  bool get universityRequired => throw _privateConstructorUsedError;
  bool get isAnonymous => throw _privateConstructorUsedError;
  bool get isGlobal => throw _privateConstructorUsedError; // 공용 커뮤니티 여부
  int? get universityId => throw _privateConstructorUsedError;

  /// Serializes this Community to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Community
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommunityCopyWith<Community> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunityCopyWith<$Res> {
  factory $CommunityCopyWith(Community value, $Res Function(Community) then) =
      _$CommunityCopyWithImpl<$Res, Community>;
  @useResult
  $Res call({
    int id,
    String name,
    String? description,
    String? icon,
    bool universityRequired,
    bool isAnonymous,
    bool isGlobal,
    int? universityId,
  });
}

/// @nodoc
class _$CommunityCopyWithImpl<$Res, $Val extends Community>
    implements $CommunityCopyWith<$Res> {
  _$CommunityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Community
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? icon = freezed,
    Object? universityRequired = null,
    Object? isAnonymous = null,
    Object? isGlobal = null,
    Object? universityId = freezed,
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
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            icon: freezed == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String?,
            universityRequired: null == universityRequired
                ? _value.universityRequired
                : universityRequired // ignore: cast_nullable_to_non_nullable
                      as bool,
            isAnonymous: null == isAnonymous
                ? _value.isAnonymous
                : isAnonymous // ignore: cast_nullable_to_non_nullable
                      as bool,
            isGlobal: null == isGlobal
                ? _value.isGlobal
                : isGlobal // ignore: cast_nullable_to_non_nullable
                      as bool,
            universityId: freezed == universityId
                ? _value.universityId
                : universityId // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CommunityImplCopyWith<$Res>
    implements $CommunityCopyWith<$Res> {
  factory _$$CommunityImplCopyWith(
    _$CommunityImpl value,
    $Res Function(_$CommunityImpl) then,
  ) = __$$CommunityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String? description,
    String? icon,
    bool universityRequired,
    bool isAnonymous,
    bool isGlobal,
    int? universityId,
  });
}

/// @nodoc
class __$$CommunityImplCopyWithImpl<$Res>
    extends _$CommunityCopyWithImpl<$Res, _$CommunityImpl>
    implements _$$CommunityImplCopyWith<$Res> {
  __$$CommunityImplCopyWithImpl(
    _$CommunityImpl _value,
    $Res Function(_$CommunityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Community
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? icon = freezed,
    Object? universityRequired = null,
    Object? isAnonymous = null,
    Object? isGlobal = null,
    Object? universityId = freezed,
  }) {
    return _then(
      _$CommunityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        icon: freezed == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String?,
        universityRequired: null == universityRequired
            ? _value.universityRequired
            : universityRequired // ignore: cast_nullable_to_non_nullable
                  as bool,
        isAnonymous: null == isAnonymous
            ? _value.isAnonymous
            : isAnonymous // ignore: cast_nullable_to_non_nullable
                  as bool,
        isGlobal: null == isGlobal
            ? _value.isGlobal
            : isGlobal // ignore: cast_nullable_to_non_nullable
                  as bool,
        universityId: freezed == universityId
            ? _value.universityId
            : universityId // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CommunityImpl implements _Community {
  const _$CommunityImpl({
    required this.id,
    required this.name,
    this.description,
    this.icon,
    this.universityRequired = false,
    this.isAnonymous = false,
    this.isGlobal = false,
    this.universityId,
  });

  factory _$CommunityImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommunityImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? icon;
  @override
  @JsonKey()
  final bool universityRequired;
  @override
  @JsonKey()
  final bool isAnonymous;
  @override
  @JsonKey()
  final bool isGlobal;
  // 공용 커뮤니티 여부
  @override
  final int? universityId;

  @override
  String toString() {
    return 'Community(id: $id, name: $name, description: $description, icon: $icon, universityRequired: $universityRequired, isAnonymous: $isAnonymous, isGlobal: $isGlobal, universityId: $universityId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommunityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.universityRequired, universityRequired) ||
                other.universityRequired == universityRequired) &&
            (identical(other.isAnonymous, isAnonymous) ||
                other.isAnonymous == isAnonymous) &&
            (identical(other.isGlobal, isGlobal) ||
                other.isGlobal == isGlobal) &&
            (identical(other.universityId, universityId) ||
                other.universityId == universityId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    icon,
    universityRequired,
    isAnonymous,
    isGlobal,
    universityId,
  );

  /// Create a copy of Community
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommunityImplCopyWith<_$CommunityImpl> get copyWith =>
      __$$CommunityImplCopyWithImpl<_$CommunityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommunityImplToJson(this);
  }
}

abstract class _Community implements Community {
  const factory _Community({
    required final int id,
    required final String name,
    final String? description,
    final String? icon,
    final bool universityRequired,
    final bool isAnonymous,
    final bool isGlobal,
    final int? universityId,
  }) = _$CommunityImpl;

  factory _Community.fromJson(Map<String, dynamic> json) =
      _$CommunityImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String? get icon;
  @override
  bool get universityRequired;
  @override
  bool get isAnonymous;
  @override
  bool get isGlobal; // 공용 커뮤니티 여부
  @override
  int? get universityId;

  /// Create a copy of Community
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommunityImplCopyWith<_$CommunityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
