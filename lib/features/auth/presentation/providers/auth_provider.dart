import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/user.dart';

/// Auth state that represents the current authentication status
class AuthState {
  final bool isLoading;
  final User? user;
  final Failure? failure;

  const AuthState({
    this.isLoading = false,
    this.user,
    this.failure,
  });

  AuthState copyWith({
    bool? isLoading,
    User? user,
    Failure? failure,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      failure: failure ?? this.failure,
    );
  }

  /// Check if user is authenticated
  bool get isAuthenticated => user != null;

  /// Check if there's an error
  bool get hasError => failure != null;
}

/// Auth notifier that manages authentication state
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState()) {
    // Initialize auth state
    _initializeAuth();
  }

  /// Create a mock implementation for development
  factory AuthNotifier._createMock() {
    return AuthNotifier();
  }

  /// Initialize authentication state on app start
  Future<void> _initializeAuth() async {
    state = state.copyWith(isLoading: true);

    // TODO: Implement get current user logic
    // For now, we'll just set loading to false
    state = state.copyWith(isLoading: false);
  }

  /// Sign in with email and password
  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, failure: null);

    // Mock implementation for development
    await Future.delayed(const Duration(seconds: 1));

    if (email.isEmpty || password.isEmpty) {
      state = state.copyWith(
        isLoading: false,
        failure: const ValidationFailure(message: 'Email and password are required'),
      );
      return;
    }

    if (password.length < 6) {
      state = state.copyWith(
        isLoading: false,
        failure: const ValidationFailure(message: 'Password must be at least 6 characters'),
      );
      return;
    }

    // Create mock user
    final user = User(
      id: 'mock_user_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      fullName: 'Mock User',
      university: 'Mock University',
      major: 'Computer Science',
      isEmailVerified: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    state = state.copyWith(isLoading: false, user: user, failure: null);
  }

  /// Sign up with user details
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    String? university,
    String? major,
  }) async {
    state = state.copyWith(isLoading: true, failure: null);

    // Mock implementation for development
    await Future.delayed(const Duration(seconds: 1));

    if (email.isEmpty || password.isEmpty || fullName.isEmpty) {
      state = state.copyWith(
        isLoading: false,
        failure: const ValidationFailure(message: 'Email, password, and full name are required'),
      );
      return;
    }

    if (password.length < 6) {
      state = state.copyWith(
        isLoading: false,
        failure: const ValidationFailure(message: 'Password must be at least 6 characters'),
      );
      return;
    }

    // Create mock user
    final user = User(
      id: 'mock_user_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      fullName: fullName,
      university: university ?? 'Not specified',
      major: major ?? 'Not specified',
      isEmailVerified: false, // New users need email verification
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    state = state.copyWith(isLoading: false, user: user, failure: null);
  }

  /// Sign out current user
  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, failure: null);

    // Mock implementation for development
    await Future.delayed(const Duration(milliseconds: 500));

    state = const AuthState(); // Reset to initial state
  }

  /// Clear any current error
  void clearError() {
    state = state.copyWith(failure: null);
  }

  /// Reset auth state (useful for testing or manual state management)
  void reset() {
    state = const AuthState();
  }
}

/// Auth provider - temporary implementation for development
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  // TODO: Replace with proper dependency injection
  // For now, create a basic implementation
  return AuthNotifier._createMock();
});

/// Auth state stream provider (alternative approach using streams)
/// TODO: Implement when repository is properly set up
// final authStateProvider = StreamProvider<User?>((ref) {
//   final repository = ref.watch(authRepositoryProvider);
//   return repository.authStateChanges;
// });

/// Convenience providers for common auth state checks
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isAuthenticated;
});

final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authProvider).user;
});

final isLoadingProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isLoading;
});

final authErrorProvider = Provider<Failure?>((ref) {
  return ref.watch(authProvider).failure;
});
