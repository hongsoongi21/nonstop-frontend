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
    @Default(false) bool universityRequired,
    @Default(false) bool isAnonymous,
    @Default(false) bool isGlobal,  // 공용 커뮤니티 여부
    int? universityId,  // 대학교 ID (is_global=false일 때)
  }) = _Community;

  factory Community.fromJson(Map<String, dynamic> json) =>
      _$CommunityFromJson(json);
}
