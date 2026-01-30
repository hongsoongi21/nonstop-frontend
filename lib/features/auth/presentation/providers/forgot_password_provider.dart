import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/repository/auth_repository.dart';
import 'auth_provider.dart';

/// Steps for the forgot password flow
enum ForgotPasswordStep {
  email,
  verification,
  newPassword,
  complete,
}

/// State for forgot password flow
class ForgotPasswordState {
  final ForgotPasswordStep step;
  final bool isLoading;
  final Failure? failure;
  final String email;
  final String verificationCode;
  final bool isSuccess;

  const ForgotPasswordState({
    this.step = ForgotPasswordStep.email,
    this.isLoading = false,
    this.failure,
    this.email = '',
    this.verificationCode = '',
    this.isSuccess = false,
  });

  ForgotPasswordState copyWith({
    ForgotPasswordStep? step,
    bool? isLoading,
    Failure? failure,
    String? email,
    String? verificationCode,
    bool? isSuccess,
  }) {
    return ForgotPasswordState(
      step: step ?? this.step,
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
      email: email ?? this.email,
      verificationCode: verificationCode ?? this.verificationCode,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  bool get hasError => failure != null;
}

/// Notifier for managing forgot password state
class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordState> {
  final AuthRepository _authRepository;

  ForgotPasswordNotifier(this._authRepository)
      : super(const ForgotPasswordState());

  /// Send password reset email
  Future<void> sendResetEmail(String email) async {
    state = state.copyWith(isLoading: true, failure: null, email: email);

    final result = await _authRepository.sendPasswordResetEmail(email);

    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (_) => state = state.copyWith(
        isLoading: false,
        step: ForgotPasswordStep.verification,
      ),
    );
  }

  /// Verify the reset code
  Future<void> verifyCode(String code) async {
    state = state.copyWith(isLoading: true, failure: null);

    final result = await _authRepository.verifyPasswordResetCode(
      state.email,
      code,
    );

    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (_) => state = state.copyWith(
        isLoading: false,
        verificationCode: code,
        step: ForgotPasswordStep.newPassword,
      ),
    );
  }

  /// Confirm password reset with new password
  Future<void> confirmPasswordReset(String newPassword) async {
    state = state.copyWith(isLoading: true, failure: null);

    final result = await _authRepository.confirmPasswordReset(
      state.email,
      state.verificationCode,
      newPassword,
    );

    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (_) => state = state.copyWith(
        isLoading: false,
        step: ForgotPasswordStep.complete,
        isSuccess: true,
      ),
    );
  }

  /// Resend verification code
  Future<void> resendCode() async {
    await sendResetEmail(state.email);
  }

  /// Go back to previous step
  void goBack() {
    switch (state.step) {
      case ForgotPasswordStep.verification:
        state = state.copyWith(step: ForgotPasswordStep.email, failure: null);
        break;
      case ForgotPasswordStep.newPassword:
        state = state.copyWith(
          step: ForgotPasswordStep.verification,
          failure: null,
        );
        break;
      default:
        break;
    }
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(failure: null);
  }

  /// Reset state
  void reset() {
    state = const ForgotPasswordState();
  }
}

/// Provider for forgot password
final forgotPasswordProvider =
    StateNotifierProvider<ForgotPasswordNotifier, ForgotPasswordState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return ForgotPasswordNotifier(authRepository);
});
