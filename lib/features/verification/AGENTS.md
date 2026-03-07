<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-03-08 | Updated: 2026-03-08 -->

# verification

## Purpose
Handles university identity verification for students via two methods accessible through a tabbed screen: (1) email domain verification — user enters a university email, receives a 6-digit OTP, enters the code (5-minute expiry with countdown timer), and gets `isUniversityVerified` set to `true`; (2) student ID photo verification — user uploads a photo of their student ID card for manual admin review. The resulting `isUniversityVerified` flag on the `User` entity (in `auth/`) controls access to university-specific communities in the board feature. There is no dedicated Riverpod provider — the screen manages its own local state.

## Key Files
| File | Description |
|------|-------------|
| `presentation/screens/verification_screen.dart` | Tabbed screen: email OTP tab + student ID photo upload tab; local state management only |
| `data/api/verification_api.dart` | API interface with `sendEmailVerification`, `confirmEmailVerification`, `uploadStudentId`, `getVerificationStatus` |
| `data/api/verification_api_impl.dart` | Supabase implementation |
| `data/dto/verification_dto.dart` | `EmailVerificationRequestDto`, `EmailVerificationConfirmDto`, `VerificationStatusDto`, `VerificationMethod` enum |

## Subdirectories
| Directory | Purpose |
|-----------|---------|
| `data/` | API interface, Supabase implementation, DTOs |
| `domain/` | Not present — no domain entities or use cases; verification state is in screen |
| `presentation/` | 1 screen only (no providers file) |

## For AI Agents

### Working In This Directory
- There is no Riverpod provider for this feature — `VerificationScreen` uses `ConsumerStatefulWidget` with all state stored in widget state fields (`_codeSent`, `_remainingSeconds`, `_emailStatus`, `_studentIdStatus`, `_selectedImage`).
- OTP expiry countdown uses a `Timer` that fires every second and decrements `_remainingSeconds` from 300; cancel it in `dispose()` to prevent memory leaks.
- Email confirmation DTO only requires `code`, not `email` — the backend validates the code against the pending session.
- `VerificationMethod` enum has three values: `emailDomain`, `manualReview`, `studentIdPhoto` — use these when checking status.
- After successful verification, call `authProvider.notifier.refreshAuthState()` to update `User.isUniversityVerified` in the auth state, which also updates board community access.
- Student ID photo upload uses `ImagePicker` — must handle both camera and gallery sources.
- This feature does not have a `VerificationStatus` entity in the domain layer; status is tracked via `VerificationStatusDto` from the API response.

### Key Providers
None. All state is local to `VerificationScreen` widget.

### API Endpoints
Backed by Supabase via `verification_api_impl.dart`:
- `POST /verification/email` — send OTP to university email
- `POST /verification/email/confirm` — confirm OTP code (`{ "code": "123456" }`)
- `POST /verification/student-id` — upload student ID photo (multipart)
- `GET /verification/status` — get `{ isUniversityVerified, verificationMethod }`

### VerificationMethod Values
| Enum | JSON | Description |
|------|------|-------------|
| `emailDomain` | `EMAIL_DOMAIN` | Verified via university email OTP |
| `manualReview` | `MANUAL_REVIEW` | Admin manually verified |
| `studentIdPhoto` | `STUDENT_ID_PHOTO` | Verified via student ID photo |

## Dependencies

### Internal
- `features/auth/presentation/providers/auth_provider.dart` — `authProvider.notifier.refreshAuthState()` to sync verification status post-completion
- `core/l10n/` — Localized UI strings
- `core/theme/` — `AppColors`, `AppSpacing`, `AppTypography`
- `core/widgets/` — `AppButton`, `AppTextField`

### External
- `flutter_riverpod` — `ConsumerStatefulWidget` base class
- `image_picker` — Student ID photo selection (camera + gallery)
- `supabase_flutter` — OTP and photo upload

<!-- MANUAL: -->
