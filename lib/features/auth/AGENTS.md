<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-03-08 | Updated: 2026-03-08 -->

# auth

## Purpose
Handles all authentication flows for the Nonstop app, including email/password login and registration, Google OAuth, Apple Sign In (iOS only), email verification, password reset, and account deletion. On startup, `AuthNotifier` checks local Supabase session tokens to restore authenticated state automatically. OAuth flows detect whether the user is new, existing, or has an incomplete profile and route accordingly. FCM token registration and de-registration is also managed here on login/logout.

## Key Files
| File | Description |
|------|-------------|
| `presentation/providers/auth_provider.dart` | Core `AuthNotifier` / `AuthState` + convenience providers (`currentUserProvider`, `isAuthenticatedProvider`, `isAuthInitializedProvider`) |
| `presentation/screens/login_screen_v1.dart` | Login UI with email/password form, Google Sign-In, and Apple Sign-In buttons |
| `presentation/screens/signup_screen_v1.dart` | Registration screen with university/major selection and policy agreement (active version) |
| `presentation/screens/email_verification_screen.dart` | Email OTP verification flow |
| `presentation/screens/forgot_password_screen.dart` | Password reset flow |
| `presentation/screens/onboarding_screen.dart` | First-run onboarding |
| `domain/entities/user.dart` | `User` entity with `isAdmin`, `isProfileComplete`, `displayName`, `initials` helpers |
| `domain/entities/university.dart` | `University` entity |
| `domain/entities/policy.dart` | `Policy` entity for terms/privacy agreement |
| `domain/repository/auth_repository.dart` | Repository interface |
| `domain/usecases/sign_in_usecase.dart` | Email sign-in use case |
| `domain/usecases/sign_up_usecase.dart` | Email registration use case |
| `domain/usecases/google_sign_in_usecase.dart` | Google OAuth use case returning `OAuthExistingUser`, `OAuthNewUser`, or `OAuthIncompleteUser` |
| `domain/usecases/apple_sign_in_usecase.dart` | Apple OAuth use case |
| `data/api/auth_api_impl.dart` | Supabase auth API implementation |
| `data/repository_impl/auth_repository_impl.dart` | Repository implementation |
| `data/dto/auth_response_dto.dart` | `OAuthSignupData` and OAuth result sealed classes |

## Subdirectories
| Directory | Purpose |
|-----------|---------|
| `data/` | API clients, DTOs (auth_request, auth_response, user, policy, university), repository implementations |
| `domain/` | User/University/Policy entities, auth & university repository interfaces, 5 use cases |
| `presentation/` | 6 screens, 4 providers, 3 widgets (CustomAuthTextField, GradientButton, LanguageSelector) |

## For AI Agents

### Working In This Directory
- `AuthState.isInitialized` must be `true` before the router redirects — never set it to `false` on sign-out.
- OAuth result handling uses Dart sealed classes (`OAuthExistingUser`, `OAuthNewUser`, `OAuthIncompleteUser`) — match all cases.
- On iOS, Google Sign-In requires both `idToken` and `accessToken` from `authorizationClient`; Android only needs `idToken`.
- Apple Sign-In uses a SHA-256 nonce passed as `rawNonce` to Supabase for verification.
- Store Riverpod `ref.read(provider.notifier)` before async gaps to avoid "ref after dispose" errors.
- University repository has both a real implementation (`university_repository_impl.dart`) and a mock (`university_repository_mock.dart`).

### Key Providers
| Provider | Type | Purpose |
|----------|------|---------|
| `authProvider` | `StateNotifierProvider<AuthNotifier, AuthState>` | Root auth state manager |
| `currentUserProvider` | `Provider<User?>` | Currently authenticated user |
| `isAuthenticatedProvider` | `Provider<bool>` | Quick auth check |
| `isAuthInitializedProvider` | `Provider<bool>` | Splash/router guard |
| `isLoadingProvider` | `Provider<bool>` | Auth loading state |
| `authErrorProvider` | `Provider<Failure?>` | Current auth error |
| `signInUseCaseProvider` | `Provider<SignInUseCase>` | Email sign-in |
| `googleSignInUseCaseProvider` | `Provider<GoogleSignInUseCase>` | Google OAuth |
| `appleSignInUseCaseProvider` | `Provider<AppleSignInUseCase>` | Apple OAuth |

### API Endpoints
- Supabase Auth: `signInWithPassword`, `signUp`, `signOut`, `verifyOTP`, `resetPasswordForEmail`
- Supabase OAuth: `signInWithIdToken` (provider: `google` / `apple`)
- Custom Supabase Edge Functions or REST for `agreePolicies`, `completeOAuthSignup`, `deleteAccount`

## Dependencies

### Internal
- `core/errors/failures.dart` — `Failure` sealed class for error typing
- `core/services/fcm_service.dart` — FCM token management on login/logout
- `core/constants/routes.dart` — Navigation after auth events
- `core/l10n/` — All UI strings via `AppLocalizations`
- `core/theme/` — `AppColors`, typography, spacing

### External
- `flutter_riverpod` — State management
- `supabase_flutter` — Auth backend
- `google_sign_in` (v7.x) — Google OAuth; uses `authorizationClient` for access token
- `sign_in_with_apple` — Apple Sign In with nonce
- `crypto` — SHA-256 nonce hashing for Apple Sign In
- `go_router` — Navigation
- `fpdart` — `Either` for error handling
- `freezed_annotation` — Immutable entities

<!-- MANUAL: -->
