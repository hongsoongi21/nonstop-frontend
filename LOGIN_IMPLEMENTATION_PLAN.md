# 로그인 기능 구현 계획 (Login Implementation Plan) - 업데이트됨

## 1. 개요
현재 UI만 구현된 `LoginScreenV1`(`lib/features/auth/presentation/screens/login_screen_v1.dart`)을 실제 백엔드 API(`POST /api/v1/auth/login`)와 연동하고, `PROJECT_GUIDE.md`에 명시된 보안 저장소(`flutter_secure_storage`)를 활용한 토큰 관리 및 자동 로그인 기능을 구현했습니다.

## 2. 현황 분석 및 요구사항

### 2.1 백엔드 API (`nonstop-backend` 참조)
*   **Endpoint**: `POST /api/v1/auth/login`
*   **Request**: `LoginRequestDto` (email, password)
*   **Response**: `TokenResponseDto` (accessToken, refreshToken)
*   **특이사항**: 로그인 성공 시 발급받은 Access Token을 이후 요청 헤더(`Authorization: Bearer <token>`)에 포함해야 함.

### 2.2 프론트엔드 현황
*   **UI**: `LoginScreenV1` 구현 및 백엔드 정책(비밀번호 최소 6자 이상) 연결 완료.
*   **Data Layer**: `AuthApiImpl`이 `SecureStorageService`를 사용하여 토큰을 영구 저장하도록 고도화 완료.
*   **State**: `AuthProvider` (Riverpod)를 통해 로그인 상태 및 사용자 정보를 전역적으로 관리.

## 3. 상세 구현 단계 및 진행 상황

### [x] Step 1: Data Layer 보완 (토큰 관리)
1.  **Dependency 확인**: `flutter_secure_storage` 패키지 확인 완료.
2.  **SecureStorageService 구현**: `lib/core/storage/secure_storage_service.dart` 생성 완료.
3.  **DioClient Interceptor 고도화**:
    *   `_AuthInterceptor`가 요청 시마다 저장소에서 토큰을 읽어 헤더에 자동 주입하도록 수정 완료.
    *   (수동으로 헤더를 관리하던 방식에서 인터셉터 기반 자동 관리 방식으로 전환)

### [x] Step 2: Domain Layer (비즈니스 로직)
1.  **SignInUseCase 구현**: `lib/features/auth/domain/usecases/sign_in_usecase.dart` 확인 및 연동 완료.
2.  **자동 로그인 초기화**: `AuthNotifier` 생성 시 `_initializeAuth`를 통해 앱 시작 시 자동 로그인 처리 로직 확인 완료.

### [x] Step 3: Presentation Layer (상태 관리 & UI)
1.  **AuthProvider (AuthNotifier) 업데이트**:
    *   `signIn`, `signOut` 메서드가 `SecureStorageService`와 연동된 `AuthApi`를 사용하도록 업데이트 완료.
2.  **LoginScreenV1 로직 연결**:
    *   이메일/비밀번호 유효성 검사 및 `signIn` 호출 연동 완료.
    *   로그인 성공/실패 시의 화면 전환 및 에러 메시지 표시 로직 확인 완료.

## 4. 백엔드 연동 시 우려 사항 및 향후 과제 (Risk & TODO)

### 4.1 필드 명세 및 타입 불일치 (Critical Risk)
*   **현황**: 백엔드 `UserResponseDto`와 프런트엔드 `UserDto`/`User` 엔티티의 필드명이 다릅니다.
    *   백엔드: `id` (Long), `profileImageUrl`, `introduction`, `isVerified`
    *   프런트엔드: `id` (String), `avatarUrl`, `bio`, `isEmailVerified`
*   **우려사항**: 현재 롤백 상태이므로 `/api/v1/users/me` 호출 시 데이터가 정확히 매핑되지 않아 사용자 프로필 정보가 비어 보일 수 있습니다.
*   **제안**: 프런트엔드 전체 코드(Mock 데이터 포함)에 대한 대대적인 필드명 리팩토링이 필요합니다. (현재는 에러 방지를 위해 기존 명칭 유지 중)

### 4.2 토큰 리프레시 로직 (TODO)
*   **현황**: 백엔드는 Refresh Token을 제공하지만, 현재 `DioClient`의 인터셉터에서 401 에러 시 토큰을 갱신하는 로직은 `TODO`로 남아 있습니다.
*   **계획**: 만료된 Access Token을 감지하여 `/api/v1/auth/refresh` API를 호출하는 로직 추가가 필요합니다.

### 4.3 구글 로그인 연동 (TODO)
*   **현황**: 백엔드에 `POST /api/v1/auth/google` API가 존재하지만 프런트엔드에는 아직 버튼 클릭 시의 비즈니스 로직이 구현되지 않았습니다.
*   **계획**: Google Sign-In 패키지 연동 후 발급받은 ID Token을 백엔드에 전달하는 프로세스 추가가 필요합니다.

### 4.4 API 메서드 싱크 (Warning)
*   **현황**: 백엔드 중복 체크 API(`email/check`, `nickname/check`)는 `POST` 메서드를 사용합니다. 
*   **확인**: 프런트엔드 `AuthApiImpl`에서도 `POST`로 호출 중이나, 다른 문서나 PRD에서 `GET`으로 오표기되어 있을 수 있으니 주의가 필요합니다.

## 5. 테스트 및 검증 결과
1.  **빌드**: `build_runner`를 통한 코드 생성 및 프로젝트 빌드 성공.
2.  **주석**: 모든 수정 파일 내 영어 주석을 한국어로 변환 완료.