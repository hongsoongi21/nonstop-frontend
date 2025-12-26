import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/mock/mock_data.dart';

/// State for board interactions
class BoardState {
  final bool isLoading;
  final String? error;
  final List<Post> posts;
  final PostCategory selectedCategory;
  final Set<String> likedPosts;
  final Map<String, int> postLikes;

  const BoardState({
    this.isLoading = false,
    this.error,
    required this.posts,
    this.selectedCategory = PostCategory.free,
    this.likedPosts = const {},
    this.postLikes = const {},
  });

  BoardState copyWith({
    bool? isLoading,
    String? error,
    List<Post>? posts,
    PostCategory? selectedCategory,
    Set<String>? likedPosts,
    Map<String, int>? postLikes,
  }) {
    return BoardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      posts: posts ?? this.posts,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      likedPosts: likedPosts ?? this.likedPosts,
      postLikes: postLikes ?? this.postLikes,
    );
  }

  List<Post> get filteredPosts {
    return posts.where((post) => post.category == selectedCategory).toList();
  }

  bool isPostLiked(String postId) => likedPosts.contains(postId);

  int getPostLikes(String postId) => postLikes[postId] ?? 0;
}

/// Board provider for managing board state and interactions
class BoardNotifier extends StateNotifier<BoardState> {
  BoardNotifier()
      : super(BoardState(
          posts: List.from(MockData.posts),
          postLikes: {
            for (var post in MockData.posts) post.id: post.likes
          },
        ));

  void changeCategory(PostCategory category) {
    state = state.copyWith(selectedCategory: category);
  }

  Future<void> refreshPosts() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // In real app, this would fetch fresh data from backend
      // For now, just reset to mock data
      state = state.copyWith(
        isLoading: false,
        posts: List.from(MockData.posts),
        postLikes: {
          for (var post in MockData.posts) post.id: post.likes
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to refresh posts',
      );
    }
  }

  void toggleLike(String postId) {
    final isLiked = state.isPostLiked(postId);
    final currentLikes = state.getPostLikes(postId);

    final newLikedPosts = Set<String>.from(state.likedPosts);
    final newPostLikes = Map<String, int>.from(state.postLikes);

    if (isLiked) {
      newLikedPosts.remove(postId);
      newPostLikes[postId] = currentLikes - 1;
    } else {
      newLikedPosts.add(postId);
      newPostLikes[postId] = currentLikes + 1;
    }

    state = state.copyWith(
      likedPosts: newLikedPosts,
      postLikes: newPostLikes,
    );

    // Update the actual post data (in real app, this would update backend)
    final postIndex = state.posts.indexWhere((p) => p.id == postId);
    if (postIndex != -1) {
      final updatedPost = state.posts[postIndex].copyWith(
        likes: newPostLikes[postId]!,
      );
      final updatedPosts = List<Post>.from(state.posts);
      updatedPosts[postIndex] = updatedPost;

      state = state.copyWith(posts: updatedPosts);

      // Also update mock data for consistency
      final mockPostIndex = MockData.posts.indexWhere((p) => p.id == postId);
      if (mockPostIndex != -1) {
        MockData.posts[mockPostIndex] = updatedPost;
      }
    }
  }

  void addComment(String postId, String comment) {
    // In a real app, this would add a comment to the post
    // For now, just increment comment count
    final postIndex = state.posts.indexWhere((p) => p.id == postId);
    if (postIndex != -1) {
      final updatedPost = state.posts[postIndex].copyWith(
        comments: state.posts[postIndex].comments + 1,
      );
      final updatedPosts = List<Post>.from(state.posts);
      updatedPosts[postIndex] = updatedPost;

      state = state.copyWith(posts: updatedPosts);

      // Update mock data
      final mockPostIndex = MockData.posts.indexWhere((p) => p.id == postId);
      if (mockPostIndex != -1) {
        MockData.posts[mockPostIndex] = updatedPost;
      }
    }
  }

  void addPost(Post newPost) {
    final updatedPosts = [newPost, ...state.posts];
    final updatedPostLikes = Map<String, int>.from(state.postLikes);
    updatedPostLikes[newPost.id] = newPost.likes;

    state = state.copyWith(
      posts: updatedPosts,
      postLikes: updatedPostLikes,
    );
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Board provider
final boardProvider = StateNotifierProvider<BoardNotifier, BoardState>((ref) {
  return BoardNotifier();
});

/// Convenience providers
final boardPostsProvider = Provider<List<Post>>((ref) {
  return ref.watch(boardProvider).filteredPosts;
});

final selectedCategoryProvider = Provider<PostCategory>((ref) {
  return ref.watch(boardProvider).selectedCategory;
});

final boardLoadingProvider = Provider<bool>((ref) {
  return ref.watch(boardProvider).isLoading;
});

final boardErrorProvider = Provider<String?>((ref) {
  return ref.watch(boardProvider).error;
});
