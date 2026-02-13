import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/supabase/supabase_provider.dart';
import '../../domain/entities/board.entity.dart';
import '../../domain/entities/community.entity.dart';
import '../../domain/entities/post.entity.dart';
import '../../domain/entities/comment.entity.dart';

final boardRemoteDataSourceProvider = Provider<BoardRemoteDataSource>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return BoardRemoteDataSource(supabaseClient);
});

class BoardRemoteDataSource {
  final SupabaseClient _supabase;

  BoardRemoteDataSource(this._supabase);

  // ---------------------------------------------------------------------------
  // Helper: get current user's BIGSERIAL id from auth UUID
  // ---------------------------------------------------------------------------
  Future<int> _getCurrentUserId() async {
    final authUser = _supabase.auth.currentUser;
    if (authUser == null) throw Exception('Not authenticated');
    final data = await _supabase
        .from('users')
        .select('id')
        .eq('auth_id', authUser.id)
        .single();
    return data['id'] as int;
  }

  // ---------------------------------------------------------------------------
  // Communities
  // ---------------------------------------------------------------------------
  Future<List<Community>> getCommunities() async {
    final data = await _supabase
        .from('communities')
        .select()
        .order('sort_order', ascending: true);

    return (data as List)
        .map((json) => Community(
              id: json['id'] as int,
              name: json['name'] as String,
              description: json['description'] as String?,
              icon: json['icon'] as String?,
              universityRequired: json['university_id'] != null,
              isAnonymous: json['is_anonymous'] as bool? ?? false,
              isGlobal: json['is_global'] as bool? ?? false,
              universityId: json['university_id'] as int?,
            ))
        .toList();
  }

  // ---------------------------------------------------------------------------
  // Boards
  // ---------------------------------------------------------------------------
  Future<List<Board>> getBoards(int communityId) async {
    final data = await _supabase
        .from('boards')
        .select()
        .eq('community_id', communityId);

    return (data as List)
        .map((json) => Board(
              id: json['id'] as int,
              name: json['name'] as String,
              description: json['description'] as String?,
              type: _parseBoardType(json['type'] as String),
              isSecret: json['is_secret'] as bool? ?? false,
              createdAt: DateTime.parse(json['created_at'] as String),
            ))
        .toList();
  }

  Future<Board> createBoard(int communityId, {
    required String name,
    String? description,
    String type = 'GENERAL',
  }) async {
    final result = await _supabase
        .from('boards')
        .insert({
          'community_id': communityId,
          'name': name,
          'description': description,
          'type': type,
        })
        .select()
        .single();

    return Board(
      id: result['id'] as int,
      name: result['name'] as String,
      description: result['description'] as String?,
      type: _parseBoardType(result['type'] as String),
      isSecret: result['is_secret'] as bool? ?? false,
      createdAt: DateTime.parse(result['created_at'] as String),
    );
  }

  // ---------------------------------------------------------------------------
  // Posts
  // ---------------------------------------------------------------------------
  Future<List<PostEntity>> getPosts(
    int boardId, {
    int page = 1,
    int size = 20,
  }) async {
    final from = (page - 1) * size;
    final to = from + size - 1;

    final posts = await _supabase
        .from('posts')
        .select('*, users(nickname)')
        .eq('board_id', boardId)
        .isFilter('deleted_at', null)
        .order('created_at', ascending: false)
        .range(from, to);

    if (posts.isEmpty) return [];
    return _enrichPosts(posts);
  }

  Future<PostEntity> getPostDetail(int postId) async {
    final post = await _supabase
        .from('posts')
        .select('*, users(nickname)')
        .eq('id', postId)
        .single();

    // Atomic view count increment via RPC
    await _supabase.rpc('increment_view_count', params: {'target_post_id': postId});

    final enriched = await _enrichPosts([post]);
    return enriched.first;
  }

  Future<PostEntity> createPost(
    int boardId, {
    required String title,
    required String content,
    bool isAnonymous = false,
    bool isSecret = false,
    List<String>? imageUrls,
  }) async {
    final currentUserId = await _getCurrentUserId();

    final result = await _supabase
        .from('posts')
        .insert({
          'board_id': boardId,
          'user_id': currentUserId,
          'title': title,
          'content': content,
          'is_anonymous': isAnonymous,
          'is_secret': isSecret,
          // TODO: imageUrls - add image_urls column and Supabase Storage integration
        })
        .select('*, users(nickname)')
        .single();

    return _mapToPost(
      result,
      likeCount: 0,
      commentCount: 0,
      isLiked: false,
      isMine: true,
    );
  }

  Future<PostEntity> updatePost(
    int postId, {
    required String title,
    required String content,
    bool isAnonymous = false,
    bool isSecret = false,
    List<String>? imageUrls,
  }) async {
    final result = await _supabase
        .from('posts')
        .update({
          'title': title,
          'content': content,
          'is_anonymous': isAnonymous,
          'is_secret': isSecret,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', postId)
        .select('*, users(nickname)')
        .single();

    final enriched = await _enrichPosts([result]);
    return enriched.first;
  }

  Future<void> deletePost(int postId) async {
    await _supabase
        .from('posts')
        .update({'deleted_at': DateTime.now().toIso8601String()})
        .eq('id', postId);
  }

  Future<void> togglePostLike(int postId) async {
    final currentUserId = await _getCurrentUserId();

    final existing = await _supabase
        .from('user_post_likes')
        .select()
        .eq('user_id', currentUserId)
        .eq('post_id', postId)
        .maybeSingle();

    if (existing == null) {
      await _supabase.from('user_post_likes').insert({
        'user_id': currentUserId,
        'post_id': postId,
      });
    } else if (existing['deleted_at'] != null) {
      await _supabase
          .from('user_post_likes')
          .update({'deleted_at': null})
          .eq('user_id', currentUserId)
          .eq('post_id', postId);
    } else {
      await _supabase
          .from('user_post_likes')
          .update({'deleted_at': DateTime.now().toIso8601String()})
          .eq('user_id', currentUserId)
          .eq('post_id', postId);
    }
  }

  // ---------------------------------------------------------------------------
  // Comments
  // ---------------------------------------------------------------------------
  Future<List<CommentEntity>> getComments(int postId) async {
    final currentUserId = await _getCurrentUserId();

    final comments = await _supabase
        .from('comments')
        .select('*, users(nickname)')
        .eq('post_id', postId)
        .isFilter('deleted_at', null)
        .order('created_at', ascending: true);

    if (comments.isEmpty) return [];

    final commentIds = comments.map((c) => c['id'] as int).toList();

    // Batch: like counts
    final likes = await _supabase
        .from('user_comment_likes')
        .select('comment_id')
        .inFilter('comment_id', commentIds)
        .isFilter('deleted_at', null);

    final likeCountMap = <int, int>{};
    for (final like in likes) {
      final cid = like['comment_id'] as int;
      likeCountMap[cid] = (likeCountMap[cid] ?? 0) + 1;
    }

    // Batch: current user's likes
    final myLikes = await _supabase
        .from('user_comment_likes')
        .select('comment_id')
        .inFilter('comment_id', commentIds)
        .eq('user_id', currentUserId)
        .isFilter('deleted_at', null);

    final myLikeSet = myLikes.map((l) => l['comment_id'] as int).toSet();

    // Map all comments (flat list)
    final allComments = comments
        .map((c) {
          final cid = c['id'] as int;
          return _mapToComment(
            c,
            likeCount: likeCountMap[cid] ?? 0,
            isLiked: myLikeSet.contains(cid),
            isMine: c['user_id'] == currentUserId,
          );
        })
        .toList();

    // Build tree: top-level comments with nested replies
    final topLevel = <CommentEntity>[];
    final repliesMap = <int, List<CommentEntity>>{};

    for (final comment in allComments) {
      if (comment.upperCommentId == null) {
        topLevel.add(comment);
      } else {
        repliesMap.putIfAbsent(comment.upperCommentId!, () => []).add(comment);
      }
    }

    return topLevel
        .map((c) => c.copyWith(replies: repliesMap[c.id] ?? []))
        .toList();
  }

  Future<CommentEntity> createComment(
    int postId, {
    required String content,
    int? upperCommentId,
    bool isAnonymous = false,
    List<String>? imageUrls,
  }) async {
    final currentUserId = await _getCurrentUserId();

    final result = await _supabase
        .from('comments')
        .insert({
          'post_id': postId,
          'user_id': currentUserId,
          'content': content,
          'type': isAnonymous ? 'ANONYMOUS' : 'GENERAL',
          'is_anonymous': isAnonymous,
          if (upperCommentId != null) 'upper_comment_id': upperCommentId,
          'depth': upperCommentId != null ? 1 : 0,
        })
        .select('*, users(nickname)')
        .single();

    return _mapToComment(result, likeCount: 0, isLiked: false, isMine: true);
  }

  Future<CommentEntity> updateComment(
    int commentId, {
    required String content,
    bool isAnonymous = false,
    List<String>? imageUrls,
  }) async {
    final currentUserId = await _getCurrentUserId();

    final result = await _supabase
        .from('comments')
        .update({
          'content': content,
          'is_anonymous': isAnonymous,
          'type': isAnonymous ? 'ANONYMOUS' : 'GENERAL',
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', commentId)
        .select('*, users(nickname)')
        .single();

    final likes = await _supabase
        .from('user_comment_likes')
        .select()
        .eq('comment_id', commentId)
        .isFilter('deleted_at', null);

    final myLike = await _supabase
        .from('user_comment_likes')
        .select()
        .eq('comment_id', commentId)
        .eq('user_id', currentUserId)
        .isFilter('deleted_at', null)
        .maybeSingle();

    return _mapToComment(
      result,
      likeCount: likes.length,
      isLiked: myLike != null,
      isMine: true,
    );
  }

  Future<void> deleteComment(int commentId) async {
    await _supabase
        .from('comments')
        .update({'deleted_at': DateTime.now().toIso8601String()})
        .eq('id', commentId);
  }

  Future<void> toggleCommentLike(int commentId) async {
    final currentUserId = await _getCurrentUserId();

    final existing = await _supabase
        .from('user_comment_likes')
        .select()
        .eq('user_id', currentUserId)
        .eq('comment_id', commentId)
        .maybeSingle();

    if (existing == null) {
      await _supabase.from('user_comment_likes').insert({
        'user_id': currentUserId,
        'comment_id': commentId,
      });
    } else if (existing['deleted_at'] != null) {
      await _supabase
          .from('user_comment_likes')
          .update({'deleted_at': null})
          .eq('user_id', currentUserId)
          .eq('comment_id', commentId);
    } else {
      await _supabase
          .from('user_comment_likes')
          .update({'deleted_at': DateTime.now().toIso8601String()})
          .eq('user_id', currentUserId)
          .eq('comment_id', commentId);
    }
  }

  // ---------------------------------------------------------------------------
  // My Posts
  // ---------------------------------------------------------------------------
  Future<List<PostEntity>> getMyPosts({
    int page = 1,
    int size = 20,
  }) async {
    final currentUserId = await _getCurrentUserId();
    final from = (page - 1) * size;
    final to = from + size - 1;

    final posts = await _supabase
        .from('posts')
        .select('*, users(nickname)')
        .eq('user_id', currentUserId)
        .isFilter('deleted_at', null)
        .order('created_at', ascending: false)
        .range(from, to);

    if (posts.isEmpty) return [];
    return _enrichPosts(posts);
  }

  // ---------------------------------------------------------------------------
  // Private Helpers
  // ---------------------------------------------------------------------------

  /// Enrich a list of raw post maps with computed fields
  /// (likeCount, commentCount, isLiked, isMine)
  Future<List<PostEntity>> _enrichPosts(
      List<Map<String, dynamic>> posts) async {
    final postIds = posts.map((p) => p['id'] as int).toList();
    final currentUserId = await _getCurrentUserId();

    // Batch: like counts
    final likes = await _supabase
        .from('user_post_likes')
        .select('post_id')
        .inFilter('post_id', postIds)
        .isFilter('deleted_at', null);

    final likeCountMap = <int, int>{};
    for (final like in likes) {
      final pid = like['post_id'] as int;
      likeCountMap[pid] = (likeCountMap[pid] ?? 0) + 1;
    }

    // Batch: comment counts
    final commentRows = await _supabase
        .from('comments')
        .select('post_id')
        .inFilter('post_id', postIds)
        .isFilter('deleted_at', null);

    final commentCountMap = <int, int>{};
    for (final comment in commentRows) {
      final pid = comment['post_id'] as int;
      commentCountMap[pid] = (commentCountMap[pid] ?? 0) + 1;
    }

    // Batch: current user's likes
    final myLikes = await _supabase
        .from('user_post_likes')
        .select('post_id')
        .inFilter('post_id', postIds)
        .eq('user_id', currentUserId)
        .isFilter('deleted_at', null);

    final myLikeSet = myLikes.map((l) => l['post_id'] as int).toSet();

    return posts.map((post) {
      final postId = post['id'] as int;
      return _mapToPost(
        post,
        likeCount: likeCountMap[postId] ?? 0,
        commentCount: commentCountMap[postId] ?? 0,
        isLiked: myLikeSet.contains(postId),
        isMine: post['user_id'] == currentUserId,
      );
    }).toList();
  }

  BoardType _parseBoardType(String type) {
    switch (type) {
      case 'GENERAL':
        return BoardType.general;
      case 'NOTICE':
        return BoardType.notice;
      case 'QNA':
        return BoardType.qna;
      case 'ANONYMOUS':
        return BoardType.anonymous;
      default:
        return BoardType.general;
    }
  }

  PostEntity _mapToPost(
    Map<String, dynamic> data, {
    required int likeCount,
    required int commentCount,
    required bool isLiked,
    required bool isMine,
  }) {
    final isAnonymous = data['is_anonymous'] as bool? ?? false;
    final userMap = data['users'] as Map<String, dynamic>?;

    return PostEntity(
      id: data['id'] as int,
      boardId: data['board_id'] as int,
      writerNickname:
          isAnonymous ? '익명' : (userMap?['nickname'] as String? ?? ''),
      isWriterAnonymous: isAnonymous,
      title: data['title'] as String? ?? '',
      content: data['content'] as String? ?? '',
      viewCount: data['view_count'] as int? ?? 0,
      likeCount: likeCount,
      commentCount: commentCount,
      isSecret: data['is_secret'] as bool? ?? false,
      isLiked: isLiked,
      isMine: isMine,
      createdAt: DateTime.parse(data['created_at'] as String),
      updatedAt: data['updated_at'] != null
          ? DateTime.parse(data['updated_at'] as String)
          : null,
    );
  }

  CommentEntity _mapToComment(
    Map<String, dynamic> data, {
    required int likeCount,
    required bool isLiked,
    required bool isMine,
  }) {
    final isAnonymous = data['is_anonymous'] as bool? ?? false;
    final userMap = data['users'] as Map<String, dynamic>?;
    final typeStr = data['type'] as String? ?? 'GENERAL';

    return CommentEntity(
      id: data['id'] as int,
      postId: data['post_id'] as int,
      upperCommentId: data['upper_comment_id'] as int?,
      writerNickname:
          isAnonymous ? '익명' : (userMap?['nickname'] as String? ?? ''),
      isWriterAnonymous: isAnonymous,
      content: data['content'] as String? ?? '',
      type:
          typeStr == 'ANONYMOUS' ? CommentType.anonymous : CommentType.general,
      depth: data['depth'] as int? ?? 0,
      likeCount: likeCount,
      isLiked: isLiked,
      isMine: isMine,
      createdAt: DateTime.parse(data['created_at'] as String),
      updatedAt: data['updated_at'] != null
          ? DateTime.parse(data['updated_at'] as String)
          : null,
    );
  }
}
