import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/post.entity.dart';
import '../../domain/entities/comment.entity.dart';
import '../../domain/repository/board_repository.dart';
import '../../data/repositories/board_repository_impl.dart';

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

  PostDetailNotifier(this._repository, this._postId)
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
          (comments) => state = state.copyWith(
            isLoading: false,
            post: post,
            comments: comments,
          ),
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

    result.fold((error) => state = state.copyWith(error: error), (newComment) {
      // Refresh comments
      fetchPostDetail();
    });
  }

  Future<void> toggleLike() async {
    if (state.post == null) return;

    final result = await _repository.togglePostLike(_postId);
    result.fold((error) => state = state.copyWith(error: error), (_) {
      final currentPost = state.post!;
      final isLiked = !currentPost.isLiked;
      state = state.copyWith(
        post: currentPost.copyWith(
          isLiked: isLiked,
          likeCount: isLiked
              ? currentPost.likeCount + 1
              : currentPost.likeCount - 1,
        ),
      );
    });
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
      return PostDetailNotifier(repository, postId);
    });
