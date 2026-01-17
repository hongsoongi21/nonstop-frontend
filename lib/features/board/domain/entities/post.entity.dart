import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.entity.freezed.dart';
part 'post.entity.g.dart';

@freezed
class PostEntity with _$PostEntity {
  const factory PostEntity({
    required int id,
    required int boardId,
    required String writerNickname,
    @Default(false) bool isWriterAnonymous,
    required String title,
    required String content,
    required String category, // Added category field
    @Default(0) int viewCount,
    @Default(0) int likeCount,
    @Default(0) int commentCount,
    @Default(false) bool isSecret,
    @Default(false) bool isLiked,
    @Default(false) bool isMine,
    required DateTime createdAt,
    DateTime? updatedAt,
    @Default([]) List<String> imageUrls,
  }) = _PostEntity;

  factory PostEntity.fromJson(Map<String, dynamic> json) =>
      _$PostEntityFromJson(json);
}
