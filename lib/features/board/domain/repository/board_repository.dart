import '../../domain/entities/board.entity.dart';
import '../../domain/entities/community.entity.dart';
import '../../domain/entities/post.entity.dart';
import '../../domain/entities/comment.entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class BoardRepository {
  Future<Either<String, List<Community>>> getCommunities();
  Future<Either<String, List<Board>>> getBoards(int communityId);
  Future<Either<String, List<PostEntity>>> getPosts(
    int boardId, {
    int page = 1,
    int size = 20,
  });
  Future<Either<String, PostEntity>> getPostDetail(int postId);
  Future<Either<String, PostEntity>> createPost(
    int boardId, {
    required String title,
    required String content,
    bool isAnonymous = false,
    bool isSecret = false,
    List<String>? imageUrls,
  });
  Future<Either<String, PostEntity>> updatePost(
    int postId, {
    required String title,
    required String content,
    bool isAnonymous = false,
    bool isSecret = false,
    List<String>? imageUrls,
  });
  Future<Either<String, void>> deletePost(int postId);
  Future<Either<String, void>> togglePostLike(int postId);
  Future<Either<String, List<CommentEntity>>> getComments(int postId);
  Future<Either<String, CommentEntity>> createComment(
    int postId, {
    required String content,
    int? upperCommentId,
    bool isAnonymous = false,
    List<String>? imageUrls,
  });
  Future<Either<String, CommentEntity>> updateComment(
    int commentId, {
    required String content,
    bool isAnonymous = false,
    List<String>? imageUrls,
  });
  Future<Either<String, void>> deleteComment(int commentId);
  Future<Either<String, void>> toggleCommentLike(int commentId);
}
