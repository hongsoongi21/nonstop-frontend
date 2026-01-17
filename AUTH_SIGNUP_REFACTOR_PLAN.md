# 회원가입 로직 및 대학교 정보 통합 수정 계획서

## 1. 개요
현재 프론트엔드 회원가입 화면(`SignupScreenV1`)에서는 대학교 선택 UI가 구현되어 있으나, 실제 백엔드 API 호출 시 해당 정보가 누락되고 있습니다. 이를 백엔드 `SignUpRequestDto` 사양에 맞춰 수정하고 데이터 무결성을 보장하기 위한 계획입니다.

## 2. 현재 문제점 분석
- **DTO 불일치**: 프론트엔드의 `SignUpRequestDto`에 `universityId`와 `majorId` 필드가 정의되어 있지 않음.
- **인터페이스 제한**: `AuthApi` 및 `AuthRepository`의 `signUp` 메서드 시그니처가 `email`, `password`, `nickname`만 전달받도록 설계됨.
- **데이터 흐름 단절**: UI(`SignupScreenV1`)에서 선택된 `_selectedUniversityId` 값이 실제 API 호출까지 전달되지 못함.

## 3. 수정 계획

### A. Data Layer 수정
1. **`auth_request_dto.dart`**:
    - `SignUpRequestDto`에 `int? universityId` 및 `int? majorId` 필드 추가.
    - `freezed` 코드 생성을 통해 JSON 직렬화 대응.
2. **`auth_api.dart` & `auth_api_impl.dart`**:
    - `signUp` 메서드 파라미터에 `universityId`, `majorId` 추가.
    - `AuthApiImpl`에서 `SignUpRequestDto` 생성 시 해당 값들을 전달하도록 수정.
3. **`auth_api_mock.dart`**:
    - 인터페이스 변경에 따른 Mock 클래스 업데이트.

### B. Domain Layer 수정
1. **`auth_repository.dart` & `auth_repository_impl.dart`**:
    - `signUp` 메서드 파라미터에 `universityId`, `majorId` 추가.
    - Repository 구현체에서 API 호출 시 해당 값들을 전달하도록 수정.

### C. Presentation Layer 수정
1. **`auth_provider.dart` (Notifier)**:
    - `signUp` 메서드에서 대학교 및 전공 ID를 추가로 받도록 수정.
2. **`signup_screen_v1.dart`**:
    - `_handleSignup` 호출 시 상태 변수(`_selectedUniversityId`)를 `authProvider`로 전달.

## 4. 사이드 이펙트 분석 및 대책

| 잠재적 사이드 이펙트 | 영향도 | 대응 방안 |
| :--- | :---: | :--- |
| **인터페이스 파손** | 높음 | `AuthApi` 및 `AuthRepository`를 참조하는 모든 파일(Mock, Test 등)을 동시에 수정하여 컴파일 에러 방지. |
| **기존 회원가입 흐름 영향** | 낮음 | `universityId`와 `majorId`를 선택적 파라미터(Optional)로 처리하여 기존 로직과의 호환성 유지 가능. |
| **코드 생성 에러** | 중간 | `freezed` 관련 필드 추가 후 `flutter pub run build_runner build`를 실행하여 최신 코드로 업데이트 필요. |
| **UI 유효성 검사** | 낮음 | 현재 `SignupScreenV1`에 이미 대학교 선택 필드에 대한 null 체크가 구현되어 있어 UI 로직 상의 큰 변화는 없음. |

## 5. 검증 계획
1. **정적 분석**: `dart analyze`를 통해 인터페이스 변경에 따른 모든 컴파일 에러 해결 여부 확인.
2. **회원가입 테스트**:
    - 대학교를 선택하고 가입 시 백엔드 DB에 `university_id`가 올바르게 저장되는지 확인.
    - 전공을 선택하지 않았을 때(`null`) 정상적으로 가입되는지 확인 (Optional 처리 확인).
3. **로그인 연동 테스트**: 회원가입 성공 후 자동으로 수행되는 로그인 로직이 정상 작동하는지 확인.

## 6. 상세 검증 체크리스트

### A. 기능 검증
- [ ] **대학교 정보 전달 확인**: 회원가입 시 선택한 대학교의 ID가 백엔드 API 요청 바디에 포함되는지 확인.
- [ ] **선택적 필드(전공) 확인**: 전공(`majorId`)을 선택하지 않아도 회원가입이 성공하는지 확인 (null 안정성).
- [ ] **필수 약관 동의 확인**: 필수 약관 미동의 시 회원가입 버튼이 작동하지 않거나 에러 메시지가 표시되는지 확인.
- [ ] **자동 로그인 확인**: 회원가입 성공 후 즉시 `signIn` API가 호출되어 토큰을 발급받고 홈 화면으로 이동하는지 확인.

### B. 예외 처리 검증
- [ ] **중복 이메일/닉네임**: 이미 존재하는 이메일이나 닉네임으로 가입 시도 시 서버의 에러 메시지가 UI에 올바르게 표시되는지 확인.
- [ ] **네트워크 오류**: 서버 연결 실패 시 `NetworkFailure` 메시지가 사용자에게 노출되는지 확인.
- [ ] **유효성 검사**: 비밀번호 8자 미만 등 프론트엔드 유효성 검사기가 백엔드 제약 조건보다 먼저 작동하는지 확인.

### C. 데이터 및 보안 검증
- [ ] **토큰 저장**: 회원가입/로그인 후 `SecureStorage`에 `accessToken`과 `refreshToken`이 정상적으로 저장되는지 확인.
- [ ] **민감 정보 노출**: 로그 출력 시 비밀번호 등 민감한 정보가 평문으로 노출되지 않는지 확인.

### D. 기술적 검증
- [ ] **컴파일 에러 전무**: 모든 레이어 수정 후 `dart analyze` 결과 에러가 없는지 확인.
- [ ] **Mock 객체 업데이트**: `AuthApiMock` 클래스가 새로운 인터페이스를 구현하고 있어 테스트 코드 실행 시 문제가 없는지 확인.

## 7. 결론
이번 수정은 프론트엔드와 백엔드 간의 데이터 사양을 일치시키는 필수 작업입니다. 인터페이스 변경이 수반되지만, 영향 범위가 인증 도메인에 한정되어 있어 계획대로 진행 시 리스크는 낮을 것으로 판단됩니다.
