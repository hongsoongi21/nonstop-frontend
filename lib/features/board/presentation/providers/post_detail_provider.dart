import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/post.entity.dart';
import '../../domain/entities/comment.entity.dart';
import '../../domain/repository/board_repository.dart';
import '../../data/repositories/board_repository_impl.dart';
import 'board_provider.dart';

class PostDetailState {
  final bool isLoading;
  final String? error;
  final PostEntity? post;
  final List<CommentEntity> comments;

  const PostDetailState({
    this.isLoading = false,
    this.error,
    this.post,
    this.comments = const [],
  });

  PostDetailState copyWith({
    bool? isLoading,
    String? error,
    PostEntity? post,
    List<CommentEntity>? comments,
  }) {
    return PostDetailState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      post: post ?? this.post,
      comments: comments ?? this.comments,
    );
  }
}

class PostDetailNotifier extends StateNotifier<PostDetailState> {
  final BoardRepository _repository;
  final int _postId;
  final Ref _ref;

  PostDetailNotifier(this._repository, this._postId, this._ref)
    : super(const PostDetailState()) {
    fetchPostDetail();
  }

  Future<void> fetchPostDetail() async {
    state = state.copyWith(isLoading: true, error: null);

    final postResult = await _repository.getPostDetail(_postId);
    final commentsResult = await _repository.getComments(_postId);

    postResult.fold(
      (error) => state = state.copyWith(isLoading: false, error: error),
      (post) {
        commentsResult.fold(
          (error) => state = state.copyWith(
            isLoading: false,
            post: post,
            error: error,
          ),
          (comments) {
            state = state.copyWith(
              isLoading: false,
              post: post,
              comments: comments,
            );
            _ref.read(boardProvider.notifier).updateLocalPost(post);
          },
        );
      },
    );
  }

  Future<void> addComment(
    String content, {
    int? upperCommentId,
    bool isAnonymous = false,
  }) async {
    final result = await _repository.createComment(
      _postId,
      content: content,
      upperCommentId: upperCommentId,
      isAnonymous: isAnonymous,
    );

    if (result.isLeft()) {
      result.fold(
        (error) => state = state.copyWith(error: error),
        (_) {},
      );
    } else {
      // Refresh comments and update board list
      await fetchPostDetail();
      // Also mark board list for refresh in case user navigates back quickly
      _ref.read(boardProvider.notifier).markNeedsRefresh();
    }
  }

  Future<void> toggleLike() async {
    if (state.post == null) return;

    final result = await _repository.togglePostLike(_postId);
    result.fold((error) => state = state.copyWith(error: error), (_) {
      final currentPost = state.post!;
      final isLiked = !currentPost.isLiked;
      final updatedPost = currentPost.copyWith(
        isLiked: isLiked,
        likeCount: isLiked
            ? currentPost.likeCount + 1
            : currentPost.likeCount - 1,
      );
      state = state.copyWith(post: updatedPost);
      _ref.read(boardProvider.notifier).updateLocalPost(updatedPost);
    });
  }

  Future<void> deletePost() async {
    final result = await _repository.deletePost(_postId);
    result.fold((error) => state = state.copyWith(error: error), (_) {
      // Handle success, e.g., navigate back (UI handles this via listener or callback, or provider state)
      // For now, we can just clear post or set a flag. But usually navigation happens in UI.
      _ref.read(boardProvider.notifier).removeLocalPost(_postId);
    });
  }

  Future<void> updatePost({
    required String title,
    required String content,
    bool isAnonymous = false,
    bool isSecret = false,
  }) async {
    final result = await _repository.updatePost(
      _postId,
      title: title,
      content: content,
      isAnonymous: isAnonymous,
      isSecret: isSecret,
    );
    result.fold((error) => state = state.copyWith(error: error), (updatedPost) {
      state = state.copyWith(post: updatedPost);
      _ref.read(boardProvider.notifier).updateLocalPost(updatedPost);
    });
  }

  Future<void> toggleCommentLike(int commentId) async {
    final result = await _repository.toggleCommentLike(commentId);
    result.fold((error) => state = state.copyWith(error: error), (_) {
      // Optimistic update for comment like
      final updatedComments = state.comments.map((c) {
        if (c.id == commentId) {
          final isLiked = !c.isLiked;
          return c.copyWith(
            isLiked: isLiked,
            likeCount: isLiked ? c.likeCount + 1 : c.likeCount - 1,
          );
        }
        // Check replies
        if (c.replies.isNotEmpty) {
          final updatedReplies = c.replies.map((r) {
            if (r.id == commentId) {
              final isLiked = !r.isLiked;
              return r.copyWith(
                isLiked: isLiked,
                likeCount: isLiked ? r.likeCount + 1 : r.likeCount - 1,
              );
            }
            return r;
          }).toList();
          return c.copyWith(replies: updatedReplies);
        }
        return c;
      }).toList();
      state = state.copyWith(comments: updatedComments);
    });
  }

  Future<void> deleteComment(int commentId) async {
    final result = await _repository.deleteComment(commentId);
    if (result.isLeft()) {
      result.fold(
        (error) => state = state.copyWith(error: error),
        (_) {},
      );
    } else {
      // Refresh comments and update board list
      await fetchPostDetail();
      // Also mark board list for refresh
      _ref.read(boardProvider.notifier).markNeedsRefresh();
    }
  }

  Future<void> updateComment(int commentId, String content) async {
    final result = await _repository.updateComment(commentId, content: content);
    if (result.isLeft()) {
      result.fold(
        (error) => state = state.copyWith(error: error),
        (_) {},
      );
    } else {
      // Refresh comments and update board list
      await fetchPostDetail();
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

final postDetailProvider =
    StateNotifierProvider.family<PostDetailNotifier, PostDetailState, int>((
      ref,
      postId,
    ) {
      final repository = ref.watch(boardRepositoryProvider);
      return PostDetailNotifier(repository, postId, ref);
    });
