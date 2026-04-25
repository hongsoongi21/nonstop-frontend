import 'package:freezed_annotation/freezed_annotation.dart';

part 'popular_board_item.freezed.dart';

@freezed
class PopularTopPost with _$PopularTopPost {
  const factory PopularTopPost({
    required int id,
    String? title,
    required int viewCount,
    required DateTime createdAt,
    required int likeCount,
    required int commentCount,
  }) = _PopularTopPost;
}

@freezed
class PopularBoardItem with _$PopularBoardItem {
  const factory PopularBoardItem({
    required int boardId,
    required String boardName,
    String? boardSlug,
    required String boardType,
    required int postCount,
    PopularTopPost? topPost,
  }) = _PopularBoardItem;
}
