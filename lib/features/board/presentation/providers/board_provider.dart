import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/board.entity.dart';
import '../../domain/entities/community.entity.dart';
import '../../domain/entities/post.entity.dart';
import '../../data/repositories/board_repository_impl.dart';

/// State for board interactions
class BoardState {
  final bool isLoading;
  final String? error;
  final List<PostEntity> posts;
  final List<Community> communities;
  final List<Board> boards;
  final Community? selectedCommunity;
  final Board? selectedBoard;
  final bool needsRefresh;

  const BoardState({
    this.isLoading = false,
    this.error,
    this.posts = const [],
    this.communities = const [],
    this.boards = const [],
    this.selectedCommunity,
    this.selectedBoard,
    this.needsRefresh = false,
  });

  BoardState copyWith({
    bool? isLoading,
    String? error,
    List<PostEntity>? posts,
    List<Community>? communities,
    List<Board>? boards,
    Community? selectedCommunity,
    Board? selectedBoard,
    bool? needsRefresh,
  }) {
    return BoardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      posts: posts ?? this.posts,
      communities: communities ?? this.communities,
      boards: boards ?? this.boards,
      selectedCommunity: selectedCommunity ?? this.selectedCommunity,
      selectedBoard: selectedBoard ?? this.selectedBoard,
      needsRefresh: needsRefresh ?? this.needsRefresh,
    );
  }
}

/// Board provider for managing board state and interactions
class BoardNotifier extends StateNotifier<BoardState> {
  final Ref _ref;

  BoardNotifier(this._ref) : super(const BoardState()) {
    initialize();
  }

  Future<void> initialize() async {
    state = state.copyWith(isLoading: true, error: null);

    final repo = _ref.read(boardRepositoryProvider);
    final communitiesResult = await repo.getCommunities();

    communitiesResult.fold(
      (error) => state = state.copyWith(isLoading: false, error: error),
      (communities) async {
        if (communities.isEmpty) {
          state = state.copyWith(isLoading: false, communities: []);
          return;
        }

        // Auto-select first community if none selected
        final selectedCommunity = communities.first;
        final boardsResult = await repo.getBoards(selectedCommunity.id);

        boardsResult.fold(
          (error) => state = state.copyWith(
            isLoading: false,
            error: error,
            communities: communities,
            selectedCommunity: selectedCommunity,
          ),
          (boards) async {
            if (boards.isEmpty) {
              state = state.copyWith(
                isLoading: false,
                communities: communities,
                selectedCommunity: selectedCommunity,
                boards: [],
              );
              return;
            }

            // Auto-select first board
            final selectedBoard = boards.first;
            final postsResult = await repo.getPosts(selectedBoard.id);

            postsResult.fold(
              (error) => state = state.copyWith(
                isLoading: false,
                error: error,
                communities: communities,
                selectedCommunity: selectedCommunity,
                boards: boards,
                selectedBoard: selectedBoard,
              ),
              (posts) => state = state.copyWith(
                isLoading: false,
                communities: communities,
                selectedCommunity: selectedCommunity,
                boards: boards,
                selectedBoard: selectedBoard,
                posts: posts,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> selectCommunity(Community community) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
      selectedCommunity: community,
      boards: [],
      posts: [],
    );

    final repo = _ref.read(boardRepositoryProvider);
    final boardsResult = await repo.getBoards(community.id);

    boardsResult.fold(
      (error) => state = state.copyWith(isLoading: false, error: error),
      (boards) async {
        if (boards.isEmpty) {
          state = state.copyWith(isLoading: false, boards: []);
          return;
        }

        final selectedBoard = boards.first;
        final postsResult = await repo.getPosts(selectedBoard.id);

        postsResult.fold(
          (error) => state = state.copyWith(
            isLoading: false,
            error: error,
            boards: boards,
            selectedBoard: selectedBoard,
          ),
          (posts) => state = state.copyWith(
            isLoading: false,
            boards: boards,
            selectedBoard: selectedBoard,
            posts: posts,
          ),
        );
      },
    );
  }

  Future<void> selectBoard(Board board) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
      selectedBoard: board,
      posts: [],
    );

    final repo = _ref.read(boardRepositoryProvider);
    final postsResult = await repo.getPosts(board.id);

    postsResult.fold(
      (error) => state = state.copyWith(isLoading: false, error: error),
      (posts) => state = state.copyWith(isLoading: false, posts: posts),
    );
  }

  Future<void> refreshPosts() async {
    if (state.selectedBoard == null) return;

    state = state.copyWith(isLoading: true, error: null);

    final repo = _ref.read(boardRepositoryProvider);
    final postsResult = await repo.getPosts(state.selectedBoard!.id);

    postsResult.fold(
      (error) => state = state.copyWith(isLoading: false, error: error),
      (posts) => state = state.copyWith(isLoading: false, posts: posts),
    );
  }

  Future<void> toggleLike(int postId) async {
    final repo = _ref.read(boardRepositoryProvider);
    final result = await repo.togglePostLike(postId);

    result.fold((error) => state = state.copyWith(error: error), (_) {
      // Optimistic update or state refresh
      final updatedPosts = state.posts.map((post) {
        if (post.id == postId) {
          final isCurrentlyLiked = post.isLiked;
          return post.copyWith(
            isLiked: !isCurrentlyLiked,
            likeCount: isCurrentlyLiked
                ? post.likeCount - 1
                : post.likeCount + 1,
          );
        }
        return post;
      }).toList();
      state = state.copyWith(posts: updatedPosts);
    });
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void updateLocalPost(PostEntity updatedPost) {
    state = state.copyWith(
      posts: state.posts.map((post) {
        return post.id == updatedPost.id ? updatedPost : post;
      }).toList(),
    );
  }

  void removeLocalPost(int postId) {
    state = state.copyWith(
      posts: state.posts.where((post) => post.id != postId).toList(),
    );
  }

  /// Mark that the board list needs to be refreshed (e.g., after comment added)
  void markNeedsRefresh() {
    state = state.copyWith(needsRefresh: true);
  }

  /// Check if refresh is needed and perform it if so
  Future<void> refreshIfNeeded() async {
    if (state.needsRefresh) {
      state = state.copyWith(needsRefresh: false);
      await refreshPosts();
    }
  }
}

/// Board provider
final boardProvider = StateNotifierProvider<BoardNotifier, BoardState>((ref) {
  return BoardNotifier(ref);
});

/// Convenience providers
final boardPostsProvider = Provider<List<PostEntity>>((ref) {
  return ref.watch(boardProvider).posts;
});

final boardLoadingProvider = Provider<bool>((ref) {
  return ref.watch(boardProvider).isLoading;
});

final boardErrorProvider = Provider<String?>((ref) {
  return ref.watch(boardProvider).error;
});
