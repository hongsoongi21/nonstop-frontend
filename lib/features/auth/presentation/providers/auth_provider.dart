import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../../data/api/auth_api.dart';
import '../../data/api/auth_api_impl.dart';
import '../../data/repository_impl/auth_repository_impl.dart';
import '../../domain/entities/user.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/usecases/google_sign_in_usecase.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';

/// DioClient 제공자
final dioClientProvider = Provider<DioClient>((ref) {
  final secureStorage = ref.watch(secureStorageServiceProvider);
  return DioClient(secureStorage);
});

/// AuthApi 제공자
final authApiProvider = Provider<AuthApi>((ref) {
  // 제공자로부터 DioClient 사용
  final dioClient = ref.watch(dioClientProvider);
  final secureStorage = ref.watch(secureStorageServiceProvider);
  return AuthApiImpl(dioClient, secureStorage);
});

/// AuthRepository 제공자
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final api = ref.watch(authApiProvider);
  return AuthRepositoryImpl(api);
});

/// SignInUseCase 제공자
final signInUseCaseProvider = Provider<SignInUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignInUseCase(repository);
});

/// SignUpUseCase 제공자
final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignUpUseCase(repository);
});

/// GoogleSignInUseCase 제공자
final googleSignInUseCaseProvider = Provider<GoogleSignInUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return GoogleSignInUseCase(repository);
});

/// 현재 인증 상태를 나타내는 클래스
class AuthState {
  final bool isLoading;
  final User? user;
  final Failure? failure;
  final bool isEmailVerificationSent;
  final bool isEmailVerified;

  const AuthState({
    this.isLoading = false,
    this.user,
    this.failure,
    this.isEmailVerificationSent = false,
    this.isEmailVerified = false,
  });

  AuthState copyWith({
    bool? isLoading,
    User? user,
    Failure? failure,
    bool? isEmailVerificationSent,
    bool? isEmailVerified,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      failure: failure ?? this.failure,
      isEmailVerificationSent:
          isEmailVerificationSent ?? this.isEmailVerificationSent,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }

  /// 사용자가 인증되었는지 확인
  bool get isAuthenticated => user != null;

  /// 에러 발생 여부 확인
  bool get hasError => failure != null;
}

/// 인증 상태를 관리하는 Notifier입니다.
/// 로그인, 회원가입, 로그아웃 등 모든 인증 관련 상태 변화를 담당합니다.
class AuthNotifier extends StateNotifier<AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final GoogleSignInUseCase _googleSignInUseCase;
  final AuthRepository _authRepository;

  AuthNotifier({
    required SignInUseCase signInUseCase,
    required SignUpUseCase signUpUseCase,
    required GoogleSignInUseCase googleSignInUseCase,
    required AuthRepository authRepository,
  }) : _signInUseCase = signInUseCase,
       _signUpUseCase = signUpUseCase,
       _googleSignInUseCase = googleSignInUseCase,
       _authRepository = authRepository,
       super(const AuthState()) {
    // 앱 시작 시 현재 로그인된 사용자가 있는지 초기화합니다.
    _initializeAuth();
  }

  /// 앱 구동 시 로컬 저장소의 토큰을 확인하여 자동 로그인 정보를 가져옵니다.
  Future<void> _initializeAuth() async {
    state = state.copyWith(isLoading: true);
    final result = await _authRepository.getCurrentUser();
    result.fold((failure) => state = state.copyWith(isLoading: false), (user) {
      state = state.copyWith(isLoading: false, user: user);
    });
  }

  /// 이메일과 비밀번호로 로그인을 수행합니다.
  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, failure: null);
    final result = await _signInUseCase(
      SignInParams(email: email, password: password),
    );
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (user) => state = state.copyWith(isLoading: false, user: user),
    );
  }

  /// 새로운 사용자를 등록합니다.
  /// 회원가입 성공 시 자동으로 로그인이 진행되어 user 상태가 업데이트됩니다.
  Future<void> signUp({
    required String email,
    required String password,
    required String nickname,
    required DateTime birthDate,
    int? universityId,
    int? majorId,
    List<int>? agreedPolicyIds,
  }) async {
    state = state.copyWith(isLoading: true, failure: null);
    final result = await _signUpUseCase(
      SignUpParams(
        email: email,
        password: password,
        nickname: nickname,
        birthDate: birthDate,
        universityId: universityId,
        majorId: majorId,
        agreedPolicyIds: agreedPolicyIds,
      ),
    );
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (user) => state = state.copyWith(isLoading: false, user: user),
    );
  }

  /// 이메일 인증 코드를 발송합니다.
  Future<void> sendVerificationEmail(String email) async {
    state = state.copyWith(isLoading: true, failure: null);
    final result = await _authRepository.sendVerificationEmail(email);
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (_) => state = state.copyWith(
        isLoading: false,
        isEmailVerificationSent: true,
      ),
    );
  }

  /// 이메일 인증 코드를 확인합니다.
  Future<void> verifyEmail(String code) async {
    state = state.copyWith(isLoading: true, failure: null);
    final result = await _authRepository.verifyEmail(code);
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (_) => state = state.copyWith(isLoading: false, isEmailVerified: true),
    );
  }

  /// Google로 로그인을 수행합니다.
  Future<void> signInWithGoogle(String idToken) async {
    state = state.copyWith(isLoading: true, failure: null);
    final result = await _googleSignInUseCase(
      GoogleSignInParams(idToken: idToken),
    );
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (user) => state = state.copyWith(isLoading: false, user: user),
    );
  }

  /// 로그아웃을 수행하고 모든 인증 상태를 초기화합니다.
  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);
    await _authRepository.signOut();
    state = const AuthState();
  }

  /// 정책 동의를 백엔드에 저장합니다.
  Future<void> agreePolicies(List<int> policyIds) async {
    await _authRepository.agreePolicies(policyIds);
  }

  /// 발생한 에러 상태를 초기화합니다.
  void clearError() {
    state = state.copyWith(failure: null);
  }
}

/// Auth 제공자
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    signInUseCase: ref.watch(signInUseCaseProvider),
    signUpUseCase: ref.watch(signUpUseCaseProvider),
    googleSignInUseCase: ref.watch(googleSignInUseCaseProvider),
    authRepository: ref.watch(authRepositoryProvider),
  );
});

/// 편의성 제공자들
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
