import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/board.entity.dart';
import '../../domain/entities/community.entity.dart';
import '../../domain/entities/post.entity.dart';
import '../../data/repositories/board_repository_impl.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

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
    final currentUser = _ref.read(currentUserProvider);

    communitiesResult.fold(
      (error) => state = state.copyWith(isLoading: false, error: error),
      (allCommunities) async {
        // 드롭다운에 표시할 커뮤니티 필터링:
        // 1. 공용 커뮤니티 (is_global=true)
        // 2. 내 대학교 커뮤니티 (university_id = currentUser.universityId)
        final filteredCommunities = allCommunities.where((c) {
          if (c.isGlobal) return true;  // 공용 커뮤니티는 항상 표시
          if (currentUser?.universityId == null) return false;  // 대학교 미인증 유저는 대학교 커뮤니티 볼 수 없음
          return c.universityId == currentUser!.universityId;  // 내 대학교만 표시
        }).toList();

        if (filteredCommunities.isEmpty) {
          state = state.copyWith(isLoading: false, communities: []);
          return;
        }

        // 공용 커뮤니티를 기본 선택
        final selectedCommunity = filteredCommunities.firstWhere(
          (c) => c.isGlobal,
          orElse: () => filteredCommunities.first,
        );
        final boardsResult = await repo.getBoards(selectedCommunity.id);

        boardsResult.fold(
          (error) => state = state.copyWith(
            isLoading: false,
            error: error,
            communities: filteredCommunities,
            selectedCommunity: selectedCommunity,
          ),
          (boards) async {
            if (boards.isEmpty) {
              state = state.copyWith(
                isLoading: false,
                communities: filteredCommunities,
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
                communities: filteredCommunities,
                selectedCommunity: selectedCommunity,
                boards: boards,
                selectedBoard: selectedBoard,
              ),
              (posts) => state = state.copyWith(
                isLoading: false,
                communities: filteredCommunities,
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

  /// Create a new board in the selected community
  Future<Either<String, Board>> createBoard({required String name, String? description}) async {
    if (state.selectedCommunity == null) {
      return const Left('No community selected');
    }

    final repo = _ref.read(boardRepositoryProvider);
    final result = await repo.createBoard(
      state.selectedCommunity!.id,
      name: name,
      description: description,
    );

    result.fold(
      (error) => state = state.copyWith(error: error),
      (newBoard) async {
        // Refresh the boards list to include the newly created board
        final boardsResult = await repo.getBoards(state.selectedCommunity!.id);
        boardsResult.fold(
          (error) => state = state.copyWith(error: error),
          (boards) => state = state.copyWith(boards: boards),
        );
      },
    );

    return result;
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
