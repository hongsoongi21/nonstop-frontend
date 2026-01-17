import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.entity.freezed.dart';
part 'comment.entity.g.dart';

enum CommentType {
  @JsonValue('GENERAL')
  general,
  @JsonValue('ANONYMOUS')
  anonymous,
}

@freezed
class CommentEntity with _$CommentEntity {
  const factory CommentEntity({
    required int id,
    required int postId,
    int? upperCommentId,
    required String writerNickname,
    @Default(false) bool isWriterAnonymous,
    required String content,
    required CommentType type,
    @Default(0) int depth,
    @Default(0) int likeCount,
    @Default(false) bool isLiked,
    @Default(false) bool isDeleted,
    @Default(false) bool isMine,
    required DateTime createdAt,
    DateTime? updatedAt,
    List<String>? imageUrls,
    @Default([]) List<CommentEntity> replies,
  }) = _CommentEntity;

  factory CommentEntity.fromJson(Map<String, dynamic> json) =>
      _$CommentEntityFromJson(json);
}
