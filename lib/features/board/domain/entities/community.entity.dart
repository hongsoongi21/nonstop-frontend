import 'package:freezed_annotation/freezed_annotation.dart';

part 'community.entity.freezed.dart';
part 'community.entity.g.dart';

@freezed
class Community with _$Community {
  const factory Community({
    required int id,
    required String name,
    String? description,
    String? icon,
    @Default(false) bool isAnonymous,
  }) = _Community;

  factory Community.fromJson(Map<String, dynamic> json) =>
      _$CommunityFromJson(json);
}
