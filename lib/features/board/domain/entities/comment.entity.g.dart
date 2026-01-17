// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentEntityImpl _$$CommentEntityImplFromJson(Map<String, dynamic> json) =>
    _$CommentEntityImpl(
      id: (json['id'] as num).toInt(),
      postId: (json['postId'] as num).toInt(),
      upperCommentId: (json['upperCommentId'] as num?)?.toInt(),
      writerNickname: json['writerNickname'] as String,
      isWriterAnonymous: json['isWriterAnonymous'] as bool? ?? false,
      content: json['content'] as String,
      type: $enumDecode(_$CommentTypeEnumMap, json['type']),
      depth: (json['depth'] as num?)?.toInt() ?? 0,
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      isLiked: json['isLiked'] as bool? ?? false,
      isDeleted: json['isDeleted'] as bool? ?? false,
      isMine: json['isMine'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      imageUrls: (json['imageUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      replies:
          (json['replies'] as List<dynamic>?)
              ?.map((e) => CommentEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CommentEntityImplToJson(_$CommentEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'upperCommentId': instance.upperCommentId,
      'writerNickname': instance.writerNickname,
      'isWriterAnonymous': instance.isWriterAnonymous,
      'content': instance.content,
      'type': _$CommentTypeEnumMap[instance.type]!,
      'depth': instance.depth,
      'likeCount': instance.likeCount,
      'isLiked': instance.isLiked,
      'isDeleted': instance.isDeleted,
      'isMine': instance.isMine,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'imageUrls': instance.imageUrls,
      'replies': instance.replies,
    };

const _$CommentTypeEnumMap = {
  CommentType.general: 'GENERAL',
  CommentType.anonymous: 'ANONYMOUS',
};
