// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostEntityImpl _$$PostEntityImplFromJson(Map<String, dynamic> json) =>
    _$PostEntityImpl(
      id: (json['id'] as num).toInt(),
      boardId: (json['boardId'] as num).toInt(),
      writerNickname: json['writerNickname'] as String,
      isWriterAnonymous: json['isWriterAnonymous'] as bool? ?? false,
      title: json['title'] as String,
      content: json['content'] as String,
      category: json['category'] as String?,
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      commentCount: (json['commentCount'] as num?)?.toInt() ?? 0,
      isSecret: json['isSecret'] as bool? ?? false,
      isLiked: json['isLiked'] as bool? ?? false,
      isMine: json['isMine'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      imageUrls: (json['imageUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$PostEntityImplToJson(_$PostEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'boardId': instance.boardId,
      'writerNickname': instance.writerNickname,
      'isWriterAnonymous': instance.isWriterAnonymous,
      'title': instance.title,
      'content': instance.content,
      'category': instance.category,
      'viewCount': instance.viewCount,
      'likeCount': instance.likeCount,
      'commentCount': instance.commentCount,
      'isSecret': instance.isSecret,
      'isLiked': instance.isLiked,
      'isMine': instance.isMine,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'imageUrls': instance.imageUrls,
    };
