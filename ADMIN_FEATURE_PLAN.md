# 관리자 기능 구현 및 권한 연동 계획 (Admin Feature Implementation Plan)

## 1. 개요
백엔드로부터 수신한 사용자 정보의 권한(Role)을 기반으로, 프론트엔드 앱 내에서 관리자(ADMIN) 여부를 식별하고 전용 UI(관리자 버튼)를 제공하기 위한 구현 계획입니다.

## 2. 백엔드 스펙 분석
- **DTO 파일**: `com.app.nonstop.domain.user.dto.UserResponseDto`
- **핵심 필드**: `userRole` (Enum 타입 추정)
- **JSON 응답 예시 (예상)**:
  ```json
  {
    "id": 1,
    "email": "admin@nonstop.com",
    "nickname": "총관리자",
    "userRole": "ADMIN",  // <-- 핵심 식별자
    ...
  }
  ```
- **권한 값**:
  - `USER`: 일반 사용자 (기본값)
  - `ADMIN`: 관리자 (타겟)

## 3. 프론트엔드 구현 계획

### A. 데이터 계층 (Data Layer)
1.  **`UserDto` (`lib/features/auth/data/dto/user_dto.dart`) 수정**
    - 백엔드 JSON 필드 `userRole`을 수신하기 위한 필드 추가.
    - `@JsonKey(name: 'userRole')` 어노테이션을 사용하여 JSON 키와 매핑.
    - `toDomain()` 메서드에서 엔티티로 데이터 전달.

### B. 도메인 계층 (Domain Layer)
1.  **`User` 엔티티 (`lib/features/auth/domain/entities/user.dart`) 수정**
    - `String? role` 필드 추가.
    - 관리자 여부를 쉽게 확인하기 위한 Getter 추가:
      ```dart
      bool get isAdmin => role == 'ADMIN';
      ```

### C. 프레젠테이션 계층 (Presentation Layer)
1.  **메인 화면 선정**: 홈 화면 또는 네비게이션 셸(Shell) 화면.
    - 위치 후보: `MainScreen` 또는 `HomeScreen`의 우측 하단 (`FloatingActionButton` 활용).
2.  **조건부 렌더링 로직**:
    - `authProvider`를 통해 현재 로그인한 사용자의 정보를 조회 (`ref.watch`).
    - `user.isAdmin`이 `true`일 때만 버튼 렌더링.
3.  **버튼 동작**:
    - 클릭 시 동작은 현재 구현하지 않고 `// TODO: 관리자 페이지 이동` 주석 처리.

## 4. 검토 및 주의사항 (Checklist)

### 1) 보안 관련
- **클라이언트 측 보안의 한계**: 앱 내에서 버튼을 숨기는 것은 UX 차원의 편의 기능일 뿐, 실제 관리자 API 호출 시 백엔드에서도 반드시 권한 검증(Security Guard)이 이루어져야 합니다.
- **권한 위변조 방지**: `User` 객체는 불변(`freezed`)으로 관리되므로 앱 실행 중 임의 조작은 어렵지만, 메모리 변조 등의 위협은 존재함을 인지해야 합니다.

### 2) 데이터 정합성
- **Enum 값 확인**: 백엔드에서 `ADMIN`이 정확히 대문자인지, `ROLE_ADMIN` 형태인지 최종 확인 필요. (현재 `example = "USER"`로 보아 `ADMIN`일 확률 높음)
- **Null 처리**: `userRole`이 `null`로 올 경우 일반 사용자(`USER`)로 간주하는 안전 장치 필요.

### 3) 개발 프로세스
- **Code Generation**: DTO 및 Entity 수정 후 `flutter pub run build_runner build --delete-conflicting-outputs` 명령어를 실행하여 `.freezed.dart` 및 `.g.dart` 파일을 재생성해야 합니다.

## 5. 작업 순서
1. `User` 엔티티 수정
2. `UserDto` 수정
3. `build_runner` 실행
4. 메인 화면 UI에 관리자 버튼 추가
