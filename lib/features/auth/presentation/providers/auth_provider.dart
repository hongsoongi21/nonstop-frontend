import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repository/auth_repository.dart';
import '../../data/repository_impl/auth_repository_impl.dart';
import '../../data/api/auth_api_impl.dart';

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
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(const AuthState()) {
    // Initialize auth state
    _initializeAuth();
  }

  /// Initialize authentication state on app start
  Future<void> _initializeAuth() async {
    state = state.copyWith(isLoading: true);
    
    final result = await _repository.getCurrentUser();
    
    result.fold(
      (failure) {
         // If generic failure (e.g. no token), just set not authenticated
         state = state.copyWith(isLoading: false, user: null, failure: null);
      },
      (user) {
        state = state.copyWith(isLoading: false, user: user, failure: null);
      },
    );
  }

  /// Sign in with email and password
  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, failure: null);

    final result = await _repository.signIn(email: email, password: password);
    
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (user) => state = state.copyWith(isLoading: false, user: user, failure: null),
    );
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

    final result = await _repository.signUp(
      email: email,
      password: password,
      fullName: fullName,
      university: university,
      major: major,
    );
    
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (user) => state = state.copyWith(isLoading: false, user: user, failure: null),
    );
  }

  /// Sign out current user
  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, failure: null);
    
    await _repository.signOut();
    
    state = const AuthState(); // Reset to initial state
  }

  /// Clear any current error
  void clearError() {
    state = state.copyWith(failure: null);
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authApi = ref.watch(authApiProvider);
  return AuthRepositoryImpl(authApi);
});

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});

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