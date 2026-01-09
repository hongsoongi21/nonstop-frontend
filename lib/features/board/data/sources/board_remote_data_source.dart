import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/board.entity.dart';
import '../../domain/entities/community.entity.dart';
import '../../domain/entities/post.entity.dart';
import '../../domain/entities/comment.entity.dart';

final boardRemoteDataSourceProvider = Provider<BoardRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return BoardRemoteDataSource(dioClient);
});

class BoardRemoteDataSource {
  final DioClient _dioClient;

  BoardRemoteDataSource(this._dioClient);

  Future<List<Community>> getCommunities() async {
    final response = await _dioClient.get('/api/v1/communities');
    final List<dynamic> communitiesJson = response.data['data']['communities'];
    return communitiesJson.map((json) => Community.fromJson(json)).toList();
  }

  Future<List<Board>> getBoards(int communityId) async {
    final response = await _dioClient.get(
      '/api/v1/communities/$communityId/boards',
    );
    final List<dynamic> boardsJson = response.data['data'];
    return boardsJson.map((json) => Board.fromJson(json)).toList();
  }

  Future<List<PostEntity>> getPosts(
    int boardId, {
    int page = 1,
    int size = 20,
  }) async {
    final response = await _dioClient.get(
      '/api/v1/boards/$boardId/posts',
      queryParameters: {'page': page, 'size': size},
    );
    final List<dynamic> postsJson = response.data['data'];
    return postsJson.map((json) => PostEntity.fromJson(json)).toList();
  }

  Future<PostEntity> getPostDetail(int postId) async {
    final response = await _dioClient.get('/api/v1/posts/$postId');
    return PostEntity.fromJson(response.data['data']);
  }

  Future<PostEntity> createPost(
    int boardId, {
    required String title,
    required String content,
    bool isAnonymous = false,
    bool isSecret = false,
    List<String>? imageUrls,
  }) async {
    final response = await _dioClient.post(
      '/api/v1/boards/$boardId/posts',
      data: {
        'title': title,
        'content': content,
        'isAnonymous': isAnonymous,
        'isSecret': isSecret,
        'imageUrls': imageUrls,
      },
    );
    return PostEntity.fromJson(response.data['data']);
  }

  Future<void> togglePostLike(int postId) async {
    await _dioClient.post('/api/v1/posts/$postId/like');
  }

  Future<List<CommentEntity>> getComments(int postId) async {
    final response = await _dioClient.get('/api/v1/posts/$postId/comments');
    final List<dynamic> commentsJson = response.data['data'];
    return commentsJson.map((json) => CommentEntity.fromJson(json)).toList();
  }

  Future<CommentEntity> createComment(
    int postId, {
    required String content,
    int? upperCommentId,
    bool isAnonymous = false,
    List<String>? imageUrls,
  }) async {
    final response = await _dioClient.post(
      '/api/v1/posts/$postId/comments',
      data: {
        'content': content,
        'upperCommentId': upperCommentId,
        'isAnonymous': isAnonymous,
        'imageUrls': imageUrls,
      },
    );
    return CommentEntity.fromJson(response.data['data']);
  }
}
