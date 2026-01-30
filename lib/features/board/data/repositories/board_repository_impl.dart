import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/board.entity.dart';
import '../../domain/entities/community.entity.dart';
import '../../domain/entities/post.entity.dart';
import '../../domain/entities/comment.entity.dart';
import '../../domain/repository/board_repository.dart';
import '../sources/board_remote_data_source.dart';

final boardRepositoryProvider = Provider<BoardRepository>((ref) {
  final dataSource = ref.watch(boardRemoteDataSourceProvider);
  return BoardRepositoryImpl(dataSource);
});

class BoardRepositoryImpl implements BoardRepository {
  final BoardRemoteDataSource _dataSource;

  BoardRepositoryImpl(this._dataSource);

  @override
  Future<Either<String, List<Community>>> getCommunities() async {
    try {
      final result = await _dataSource.getCommunities();
      return Right(result);
    } catch (e) {
      log('getCommunities error: $e', name: 'BoardRepository');
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<Board>>> getBoards(int communityId) async {
    try {
      final result = await _dataSource.getBoards(communityId);
      return Right(result);
    } catch (e) {
      log('getBoards error: $e', name: 'BoardRepository');
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<PostEntity>>> getPosts(
    int boardId, {
    int page = 1,
    int size = 20,
  }) async {
    try {
      final result = await _dataSource.getPosts(
        boardId,
        page: page,
        size: size,
      );
      return Right(result);
    } catch (e) {
      log('getPosts error: $e', name: 'BoardRepository');
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, PostEntity>> getPostDetail(int postId) async {
    try {
      final result = await _dataSource.getPostDetail(postId);
      return Right(result);
    } catch (e) {
      log('getPostDetail error: $e', name: 'BoardRepository');
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, PostEntity>> createPost(
    int boardId, {
    required String title,
    required String content,
    bool isAnonymous = false,
    bool isSecret = false,
    List<String>? imageUrls,
  }) async {
    try {
      final result = await _dataSource.createPost(
        boardId,
        title: title,
        content: content,
        isAnonymous: isAnonymous,
        isSecret: isSecret,
        imageUrls: imageUrls,
      );
      return Right(result);
    } catch (e) {
      log('createPost error: $e', name: 'BoardRepository');
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, PostEntity>> updatePost(
    int postId, {
    required String title,
    required String content,
    bool isAnonymous = false,
    bool isSecret = false,
    List<String>? imageUrls,
  }) async {
    try {
      final result = await _dataSource.updatePost(
        postId,
        title: title,
        content: content,
        isAnonymous: isAnonymous,
        isSecret: isSecret,
        imageUrls: imageUrls,
      );
      return Right(result);
    } catch (e) {
      log('updatePost error: $e', name: 'BoardRepository');
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> deletePost(int postId) async {
    try {
      await _dataSource.deletePost(postId);
      return const Right(null);
    } catch (e) {
      log('deletePost error: $e', name: 'BoardRepository');
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> togglePostLike(int postId) async {
    try {
      await _dataSource.togglePostLike(postId);
      return const Right(null);
    } catch (e) {
      log('togglePostLike error: $e', name: 'BoardRepository');
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<CommentEntity>>> getComments(int postId) async {
    try {
      final result = await _dataSource.getComments(postId);
      return Right(result);
    } catch (e) {
      log('getComments error: $e', name: 'BoardRepository');
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, CommentEntity>> createComment(
    int postId, {
    required String content,
    int? upperCommentId,
    bool isAnonymous = false,
    List<String>? imageUrls,
  }) async {
    try {
      final result = await _dataSource.createComment(
        postId,
        content: content,
        upperCommentId: upperCommentId,
        isAnonymous: isAnonymous,
        imageUrls: imageUrls,
      );
      return Right(result);
    } catch (e) {
      log('createComment error: $e', name: 'BoardRepository');
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, CommentEntity>> updateComment(
    int commentId, {
    required String content,
    bool isAnonymous = false,
    List<String>? imageUrls,
  }) async {
    try {
      final result = await _dataSource.updateComment(
        commentId,
        content: content,
        isAnonymous: isAnonymous,
        imageUrls: imageUrls,
      );
      return Right(result);
    } catch (e) {
      log('updateComment error: $e', name: 'BoardRepository');
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> deleteComment(int commentId) async {
    try {
      await _dataSource.deleteComment(commentId);
      return const Right(null);
    } catch (e) {
      log('deleteComment error: $e', name: 'BoardRepository');
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> toggleCommentLike(int commentId) async {
    try {
      await _dataSource.toggleCommentLike(commentId);
      return const Right(null);
    } catch (e) {
      log('toggleCommentLike error: $e', name: 'BoardRepository');
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<PostEntity>>> getMyPosts({
    int page = 1,
    int size = 20,
  }) async {
    try {
      final result = await _dataSource.getMyPosts(page: page, size: size);
      return Right(result);
    } catch (e) {
      log('getMyPosts error: $e', name: 'BoardRepository');
      return Left(e.toString());
    }
  }
}
