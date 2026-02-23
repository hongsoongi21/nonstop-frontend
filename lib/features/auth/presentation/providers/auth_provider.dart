import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/services/fcm_service.dart';
import '../../data/api/auth_api.dart';
import '../../data/api/auth_api_impl.dart';
import '../../data/dto/auth_response_dto.dart';
import '../../data/repository_impl/auth_repository_impl.dart';
import '../../domain/entities/user.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/usecases/apple_sign_in_usecase.dart';
import '../../domain/usecases/google_sign_in_usecase.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';

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

/// AppleSignInUseCase 제공자
final appleSignInUseCaseProvider = Provider<AppleSignInUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AppleSignInUseCase(repository);
});

/// 현재 인증 상태를 나타내는 클래스
class AuthState {
  final bool isLoading;
  final User? user;
  final Failure? failure;
  final bool isEmailVerificationSent;
  final bool isEmailVerified;
  final bool isInitialized; // 앱 시작 시 토큰 체크가 완료되었는지 여부
  final OAuthSignupData? pendingOAuthSignup; // OAuth 회원가입 대기 데이터
  final bool isIncompleteProfile; // 기존 OAuth 사용자의 미완성 프로필 여부
  final bool existingUserHasBirthDate; // 기존 사용자의 생년월일 보유 여부
  final bool existingUserHasAgreedPolicies; // 기존 사용자의 약관 동의 여부

  const AuthState({
    this.isLoading = false,
    this.user,
    this.failure,
    this.isEmailVerificationSent = false,
    this.isEmailVerified = false,
    this.isInitialized = false, // 초기에는 false
    this.pendingOAuthSignup,
    this.isIncompleteProfile = false,
    this.existingUserHasBirthDate = false,
    this.existingUserHasAgreedPolicies = false,
  });

  AuthState copyWith({
    bool? isLoading,
    User? user,
    Failure? failure,
    bool clearFailure = false,
    bool? isEmailVerificationSent,
    bool? isEmailVerified,
    bool? isInitialized,
    bool clearUser = false, // user를 null로 설정하기 위한 플래그
    OAuthSignupData? pendingOAuthSignup,
    bool clearPendingOAuthSignup = false,
    bool? isIncompleteProfile,
    bool? existingUserHasBirthDate,
    bool? existingUserHasAgreedPolicies,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: clearUser ? null : (user ?? this.user),
      failure: clearFailure ? null : (failure ?? this.failure),
      isEmailVerificationSent:
          isEmailVerificationSent ?? this.isEmailVerificationSent,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isInitialized: isInitialized ?? this.isInitialized,
      pendingOAuthSignup: clearPendingOAuthSignup
          ? null
          : (pendingOAuthSignup ?? this.pendingOAuthSignup),
      isIncompleteProfile: clearPendingOAuthSignup
          ? false
          : (isIncompleteProfile ?? this.isIncompleteProfile),
      existingUserHasBirthDate:
          existingUserHasBirthDate ?? this.existingUserHasBirthDate,
      existingUserHasAgreedPolicies:
          existingUserHasAgreedPolicies ?? this.existingUserHasAgreedPolicies,
    );
  }

  /// 사용자가 인증되었는지 확인
  bool get isAuthenticated => user != null;

  /// 에러 발생 여부 확인
  bool get hasError => failure != null;

  /// OAuth 회원가입 대기 중인지 확인 (신규 또는 미완성 프로필)
  bool get hasPendingOAuthSignup => pendingOAuthSignup != null;
}

/// 인증 상태를 관리하는 Notifier입니다.
/// 로그인, 회원가입, 로그아웃 등 모든 인증 관련 상태 변화를 담당합니다.
class AuthNotifier extends StateNotifier<AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final GoogleSignInUseCase _googleSignInUseCase;
  final AppleSignInUseCase _appleSignInUseCase;
  final AuthRepository _authRepository;
  final FcmService _fcmService;

  AuthNotifier({
    required SignInUseCase signInUseCase,
    required SignUpUseCase signUpUseCase,
    required GoogleSignInUseCase googleSignInUseCase,
    required AppleSignInUseCase appleSignInUseCase,
    required AuthRepository authRepository,
    required FcmService fcmService,
  }) : _signInUseCase = signInUseCase,
       _signUpUseCase = signUpUseCase,
       _googleSignInUseCase = googleSignInUseCase,
       _appleSignInUseCase = appleSignInUseCase,
       _authRepository = authRepository,
       _fcmService = fcmService,
       super(const AuthState()) {
    // 앱 시작 시 현재 로그인된 사용자가 있는지 초기화합니다.
    _initializeAuth();
  }

  /// 앱 구동 시 로컬 저장소의 토큰을 확인하여 자동 로그인 정보를 가져옵니다.
  Future<void> _initializeAuth() async {
    debugPrint('[AUTH] 🔄 Initializing authentication...');
    state = state.copyWith(isLoading: true);
    final result = await _authRepository.getCurrentUser();
    result.fold(
      (failure) {
        // 토큰이 없거나 만료된 경우
        debugPrint('[AUTH] ❌ Auth initialization failed: ${failure.message}');
        state = state.copyWith(
          isLoading: false,
          isInitialized: true,
          clearUser: true, // 명시적으로 user를 null로 설정
        );
      },
      (user) {
        if (user != null) {
          debugPrint('[AUTH] ✅ Auth initialized successfully for user: ${user.email}');
        } else {
          debugPrint('[AUTH] ℹ️ Auth initialized with no user (logged out)');
        }
        state = state.copyWith(
          isLoading: false,
          user: user,
          isInitialized: true,
        );
        if (user != null) {
          _initializeFcm();
        }
      }
    );
  }

  /// FCM 서비스를 초기화합니다.
  Future<void> _initializeFcm() async {
    try {
      await _fcmService.initialize();
      debugPrint('FCM initialized successfully');
    } catch (e) {
      debugPrint('FCM initialization failed: $e');
    }
  }

  /// 이메일과 비밀번호로 로그인을 수행합니다.
  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, clearFailure: true);
    final result = await _signInUseCase(
      SignInParams(email: email, password: password),
    );
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (user) {
        state = state.copyWith(isLoading: false, user: user);
        _initializeFcm();
      },
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
    state = state.copyWith(isLoading: true, clearFailure: true);
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
      (user) {
        state = state.copyWith(isLoading: false, user: user);
        _initializeFcm();
      },
    );
  }

  /// 이메일 인증 코드를 발송합니다.
  Future<void> sendVerificationEmail(String email) async {
    state = state.copyWith(isLoading: true, clearFailure: true);
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
    state = state.copyWith(isLoading: true, clearFailure: true);
    final result = await _authRepository.verifyEmail(code);
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (_) => state = state.copyWith(isLoading: false, isEmailVerified: true),
    );
  }

  /// Google로 로그인을 수행합니다.
  /// 신규 사용자인 경우 pendingOAuthSignup에 데이터가 설정됩니다.
  Future<void> signInWithGoogle(String idToken, {String? accessToken}) async {
    state = state.copyWith(isLoading: true, clearFailure: true);
    final result = await _googleSignInUseCase(
      GoogleSignInParams(idToken: idToken, accessToken: accessToken),
    );
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (loginResult) {
        switch (loginResult) {
          case OAuthExistingUser(user: final user):
            // 기존 사용자: 바로 로그인 완료
            state = state.copyWith(isLoading: false, user: user);
            _initializeFcm();
          case OAuthNewUser(signupData: final signupData):
            // 신규 사용자: 회원가입 화면으로 이동 필요
            state = state.copyWith(
              isLoading: false,
              pendingOAuthSignup: signupData,
              isIncompleteProfile: false,
            );
          case OAuthIncompleteUser(
              signupData: final signupData,
              hasBirthDate: final hasBirthDate,
              hasAgreedAllMandatory: final hasAgreed,
            ):
            // 기존 사용자지만 필수 정보 미완성: 프로필 완성 화면으로 이동
            state = state.copyWith(
              isLoading: false,
              pendingOAuthSignup: signupData,
              isIncompleteProfile: true,
              existingUserHasBirthDate: hasBirthDate,
              existingUserHasAgreedPolicies: hasAgreed,
            );
        }
      },
    );
  }

  /// Apple로 로그인을 수행합니다.
  /// 신규 사용자인 경우 pendingOAuthSignup에 데이터가 설정됩니다.
  Future<void> signInWithApple({
    required String idToken,
    String? nonce,
    String? authorizationCode,
    String? firstName,
    String? lastName,
  }) async {
    state = state.copyWith(isLoading: true, clearFailure: true);
    final result = await _appleSignInUseCase(
      AppleSignInParams(
        idToken: idToken,
        nonce: nonce,
        authorizationCode: authorizationCode,
        firstName: firstName,
        lastName: lastName,
      ),
    );
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (loginResult) {
        switch (loginResult) {
          case OAuthExistingUser(user: final user):
            // 기존 사용자: 바로 로그인 완료
            state = state.copyWith(isLoading: false, user: user);
            _initializeFcm();
          case OAuthNewUser(signupData: final signupData):
            // 신규 사용자: 회원가입 화면으로 이동 필요
            state = state.copyWith(
              isLoading: false,
              pendingOAuthSignup: signupData,
              isIncompleteProfile: false,
            );
          case OAuthIncompleteUser(
              signupData: final signupData,
              hasBirthDate: final hasBirthDate,
              hasAgreedAllMandatory: final hasAgreed,
            ):
            // 기존 사용자지만 필수 정보 미완성: 프로필 완성 화면으로 이동
            state = state.copyWith(
              isLoading: false,
              pendingOAuthSignup: signupData,
              isIncompleteProfile: true,
              existingUserHasBirthDate: hasBirthDate,
              existingUserHasAgreedPolicies: hasAgreed,
            );
        }
      },
    );
  }

  /// OAuth 회원가입을 완료합니다. (Google/Apple 신규 사용자용)
  Future<void> completeOAuthSignup({
    required String nickname,
    required DateTime birthDate,
    int? universityId,
    int? majorId,
    List<int>? agreedPolicyIds,
  }) async {
    state = state.copyWith(isLoading: true, clearFailure: true);
    final result = await _authRepository.completeOAuthSignup(
      nickname: nickname,
      birthDate: birthDate,
      universityId: universityId,
      majorId: majorId,
      agreedPolicyIds: agreedPolicyIds,
    );
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (user) {
        state = state.copyWith(
          isLoading: false,
          user: user,
          clearPendingOAuthSignup: true,
        );
        _initializeFcm();
      },
    );
  }

  /// OAuth 회원가입 대기 상태를 초기화합니다.
  void clearPendingOAuthSignup() {
    state = state.copyWith(clearPendingOAuthSignup: true);
  }

  /// 프로필에서 대학교 변경 시 사용자 상태 업데이트
  void updateUniversityId(int? universityId) {
    if (state.user == null) return;
    state = state.copyWith(user: state.user!.copyWith(universityId: universityId));
  }

  /// 로그아웃을 수행하고 모든 인증 상태를 초기화합니다.
  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);
    // FCM 토큰 해제
    try {
      await _fcmService.unregisterToken();
    } catch (e) {
      debugPrint('FCM unregister failed: $e');
    }
    await _authRepository.signOut();
    // isInitialized: true를 유지해야 라우터가 로그인 화면으로 리다이렉트함
    state = const AuthState(isInitialized: true);
  }

  /// 정책 동의를 백엔드에 저장합니다.
  Future<void> agreePolicies(List<int> policyIds) async {
    await _authRepository.agreePolicies(policyIds);
  }

  /// Google 로그아웃을 포함한 전체 로그아웃을 수행합니다.
  Future<void> signOutFull() async {
    state = state.copyWith(isLoading: true);
    await _authRepository.signOutFull();
    // isInitialized: true를 유지해야 라우터가 로그인 화면으로 리다이렉트함
    state = const AuthState(isInitialized: true);
  }

  /// 계정을 삭제하고 상태를 초기화합니다.
  Future<void> deleteAccount() async {
    state = state.copyWith(isLoading: true);
    final result = await _authRepository.deleteAccount();
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      // isInitialized: true를 유지해야 라우터가 로그인 화면으로 리다이렉트함
      (_) => state = const AuthState(isInitialized: true),
    );
  }

  /// 발생한 에러 상태를 초기화합니다.
  void clearError() {
    state = state.copyWith(clearFailure: true);
  }

  /// 인증 상태를 수동으로 새로고침합니다.
  /// 앱이 백그라운드에서 돌아왔을 때 호출하여 토큰 상태를 확인할 수 있습니다.
  /// 이미 인증된 상태에서는 라우터 재계산을 방지하기 위해 state를 변경하지 않고
  /// 백그라운드에서 토큰 유효성만 확인합니다.
  Future<void> refreshAuthState() async {
    // 로딩 중이거나 OAuth 회원가입 대기 중이면 간섭하지 않음
    // (Google/Apple 로그인 흐름 중에 앱이 resume될 때 상태가 리셋되는 것을 방지)
    if (state.isLoading || state.hasPendingOAuthSignup) {
      debugPrint('[AUTH] ⏭️ Skipping refresh - auth operation in progress');
      return;
    }

    // 이미 인증된 상태라면 불필요한 state 변경 없이 백그라운드에서 확인만 합니다.
    if (state.isAuthenticated) {
      debugPrint('[AUTH] 🔄 Refreshing auth state (already authenticated, silent check)...');
      final result = await _authRepository.getCurrentUser();
      result.fold(
        (failure) {
          // 토큰이 만료되었거나 유효하지 않으면 로그아웃 처리
          debugPrint('[AUTH] ⚠️ Token invalid during refresh: ${failure.message}');
          state = state.copyWith(
            isLoading: false,
            isInitialized: true,
            clearUser: true,
          );
        },
        (user) {
          // 토큰이 유효하면 사용자 정보만 업데이트 (변경이 있는 경우에만)
          if (user != null && user.id != state.user?.id) {
            debugPrint('[AUTH] ✅ User info updated during refresh');
            state = state.copyWith(user: user);
          } else {
            debugPrint('[AUTH] ✅ Auth state still valid');
          }
        },
      );
    } else if (state.isInitialized) {
      // 이미 초기화가 완료된 상태에서는 재초기화하지 않음
      debugPrint('[AUTH] ⏭️ Skipping refresh - already initialized');
    } else {
      // 초기화가 안 된 상태에서만 초기화 로직 실행
      await _initializeAuth();
    }
  }
}

/// Auth 제공자
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    signInUseCase: ref.watch(signInUseCaseProvider),
    signUpUseCase: ref.watch(signUpUseCaseProvider),
    googleSignInUseCase: ref.watch(googleSignInUseCaseProvider),
    appleSignInUseCase: ref.watch(appleSignInUseCaseProvider),
    authRepository: ref.watch(authRepositoryProvider),
    fcmService: ref.watch(fcmServiceProvider),
  );
});

/// 편의성 제공자들
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isAuthenticated;
});

final isAuthInitializedProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isInitialized;
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
