# 회원가입 기능 구현 계획 (Signup Implementation Plan)

## 1. 개요
현재 UI만 구현된 `SignupScreenV1`에 실제 백엔드 API를 연동하여 회원가입 기능을 완성합니다.
백엔드 `nonstop-backend`의 코드 분석 결과를 바탕으로, 현재 API 스펙에 맞는 프론트엔드 구현 전략을 수립했습니다.

## 2. 현황 분석 및 제약 사항

### 2.1. 백엔드 API 현황
| 기능 | 엔드포인트 | 메소드 | 입력 데이터 (DTO) | 비고 |
|---|---|---|---|---|
| **회원가입** | `/api/v1/auth/signup` | `POST` | `SignUpRequestDto` (email, password, nickname) | **University 정보 포함 불가** |
| **로그인** | `/api/v1/auth/login` | `POST` | `LoginRequestDto` (email, password) | 토큰 발급 (Access/Refresh) |
| **프로필 수정** | `/api/v1/users/me` | `PATCH` | `ProfileUpdateRequestDto` (universityId, majorId, etc.) | **University 정보 설정 가능** |
| **대학 목록** | (없음) | - | - | **API 미구현 상태** |

### 2.2. 주요 이슈
1.  **회원가입 API의 한계**: 현재 `signup` API는 대학교(`universityId`) 정보를 받지 않습니다.
2.  **대학 목록 API 부재**: 대학교 목록을 서버에서 받아올 수 없어, 프론트엔드에 하드코딩하거나 Mock을 사용해야 합니다.
3.  **복잡한 플로우**: 사용자가 대학교를 선택하고 가입하지만, 실제로는 [가입 -> 로그인 -> 프로필 업데이트]의 3단계 과정을 거쳐야 대학교 정보가 저장됩니다.

## 3. 구현 전략 (Two-Step Flow)

백엔드 수정 없이 현재 스펙으로 기능을 구현하기 위해 **3단계 연쇄 호출(Chain)** 방식을 사용합니다.

1.  **Step 1: 회원가입 요청** (`POST /signup`)
    -   이메일, 비밀번호, 닉네임 전송.
2.  **Step 2: 로그인 요청** (`POST /login`)
    -   Step 1 성공 시, 동일한 이메일/비밀번호로 즉시 로그인하여 Access Token 획득.
3.  **Step 3: 프로필 업데이트** (`PATCH /users/me`)
    -   획득한 토큰을 사용하여 선택한 대학교(`universityId`) 정보를 업데이트.
    -   **방어 코드**: 백엔드 DB 상태(데이터 부재)를 고려하여, 현재는 `universityId`를 `null`로 전송하여 에러를 방지함. (추후 백엔드 준비 완료 시 복구 예정)

> **Risk**: Step 3에서 실패할 경우, 계정은 생성되었으나 대학교 정보가 없는 상태가 될 수 있음. (이 경우 에러 처리 및 재시도 로직 필요)

## 4. 상세 구현 계획

### 4.1. Domain Layer (`lib/features/auth/domain`)
-   **UseCase 업데이트**: `SignUpUseCase`가 단순히 가입만 하는 것이 아니라, 위 3단계 로직을 오케스트레이션하도록 수정합니다.
    ```dart
    class SignUpUseCase {
      Future<Either<Failure, User>> call(SignUpParams params) async {
        // 1. Signup
        // 2. Login (Auto)
        // 3. Update Profile (University)
      }
    }
    ```

### 4.2. Data Layer (`lib/features/auth/data`)
-   **AuthApi / AuthRepository 수정**:
    -   `updateProfile` 메서드가 이미 존재하므로 이를 활용.
    -   `signUp` 메서드는 기존대로 유지하되, UseCase에서 조합하여 사용.
-   **UniversityRepository (신규)**:
    -   **임시 구현**: 백엔드 API가 준비되지 않았으므로, 로컬 Mock 데이터를 사용하여 대학 목록을 제공 (`UniversityRepositoryMock`).
    -   **목적**: 프론트엔드 UI/UX 흐름 검증 및 백엔드 회원가입 로직(가입->로그인->프로필수정) 연동 테스트.
    -   추후 `GET /api/v1/universities` API가 개발되면 네트워크 호출로 교체.

### 4.3. Presentation Layer (`lib/features/auth/presentation`)
-   **SignupViewModel (Riverpod Provider)**:
    -   `SignupScreenV1`의 로직을 담당 (`AuthNotifier`).
    -   `SignUpUseCase`를 호출하고 로딩/에러 상태 관리.
-   **SignupScreenV1 수정**:
    -   대학 목록을 `UniversityRepository`의 Mock 데이터로 교체.
    -   사용자가 선택한 Mock 대학 ID를 사용하여 실제 가입 프로세스 진행.

### 4.4. Error Handling & Validation (PROJECT_GUIDE.md 준수)
-   **중복 체크 전략 (`prd_draft.md` 3.1 항목):**
    -   **닉네임/이메일**: 사용자가 입력을 마치고 포커스를 잃거나(onBlur), "가입하기" 버튼을 누르기 전 별도의 중복 확인 과정을 수행.
    -   API: `POST /api/v1/auth/email/check`, `POST /api/v1/auth/nickname/check` 활용.
-   **유효성 검사 (Validation Rules):**
    -   **비밀번호**: 백엔드 `SignUpRequestDto` 정책에 맞춰 8자 이상, 영문/숫자/특수문자 포함 규칙 적용.
-   **Failure Mapping (`core/errors/failures.dart`):**
    -   백엔드 에러 응답을 도메인 `Failure`로 변환.
    -   예: 409 Conflict -> `Failure.validation(message: "이미 사용 중인 이메일입니다.")`
    -   UI에서는 `GlobalErrorHandler` 또는 SnackBar를 통해 사용자 친화적인 메시지 노출.

## 5. 단계별 작업 목록 (완료)

- [x] **Task 1: University Data Layer 구성**
    -   `University` 엔티티 생성.
    -   `UniversityRepository` 인터페이스 및 Mock 구현체 생성.
- [x] **Task 2: Auth Data Layer 보완**
    -   `AuthApi`에 `updateProfile` 등이 잘 구현되어 있는지 재확인.
    -   `DioClient`에 JWT Token Interceptor 연동 (로그인 후 자동 헤더 주입).
- [x] **Task 3: SignUpUseCase 구현**
    -   [가입 -> 로그인 -> 프로필 업데이트] 트랜잭션 로직 구현.
- [x] **Task 4: SignupScreenV1 연동**
    -   ViewModel 생성 및 UI 바인딩.
    -   유효성 검사 및 에러 메시지 표시 로직 고도화.
    -   기존 레거시 파일(`signup_screen.dart`)과의 호환성 문제 해결.

## 6. 백엔드 개선 제안 및 추후 보완 과제 (Risk & Improvements)

### 6.1. 백엔드 API 개선 제안
1.  **회원가입 트랜잭션 원자성 확보 (Critical)**
    -   **현황**: [가입 -> 로그인 -> 프로필 업데이트] 3단계가 분리되어 있어, 중간에 실패 시 '대학교 정보가 없는 계정'이 생성될 위험이 있음.
    -   **제안**: `POST /api/v1/auth/signup` 요청 시 `universityId`, `majorId`를 함께 받을 수 있도록 DTO 수정 필요.
2.  **대학 목록 API 제공**
    -   **현황**: 프론트엔드에서 Mock 데이터 사용 중.
    -   **제안**: `GET /api/v1/universities` API를 조속히 구현하여 데이터 정합성(ID 불일치 문제) 해결 필요.

### 6.2. 프론트엔드 보완 과제
1.  **로그인 유지 (Token Persistence)**
    -   **현황**: 현재는 메모리(`DioClient`)에만 토큰을 저장하여 앱 재실행 시 로그인이 풀림.
    -   **계획**: `PROJECT_GUIDE.md`에 따라 `flutter_secure_storage`를 도입하여 Access/Refresh Token을 안전하게 로컬에 저장하고, 앱 실행 시 자동 로그인 로직 구현 필요.
2.  **불완전 계정 처리 (Guard Logic)**
    -   **현황**: 프로필 업데이트 실패 시에도 가입 성공으로 처리됨.
    -   **계획**: 홈 화면 진입 전, 사용자의 `universityId`가 `null`인 경우 강제로 '추가 정보 입력 화면'으로 리다이렉트하는 라우팅 가드(Guard) 로직 추가 검토.
3.  **Interceptor 고도화**
    -   **현황**: 현재 `AuthApiImpl`에서 수동으로 토큰을 주입하는 방식을 병행 사용 중.
    -   **계획**: `PROJECT_GUIDE.md` 원칙에 따라 `Dio`의 `Interceptor`에서 `flutter_secure_storage`를 읽어 자동으로 토큰을 주입하도록 리팩토링 필요.