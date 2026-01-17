# 백엔드 연동 및 시스템 개선 작업 보고서

## 1. 개요
프론트엔드 프로젝트를 로컬 백엔드 서버(Spring Boot)와 연동하고, 개발 효율성을 높이기 위해 인증 로직 고도화 및 디버깅 시스템을 개선함.

## 2. 주요 작업 내용

### A. 백엔드 통신 규격 동기화
- **회원가입 로직 개선**: 기존의 '가입 후 별도 프로필 업데이트' 방식에서, 백엔드 `SignUpRequestDto` 사양에 맞춰 가입 시 `universityId`와 `majorId`를 한 번에 전송하도록 최적화.
- **DTO 및 엔티티 보강**: `University` 엔티티 및 DTO에 `logoImageUrl`, `region` 등 백엔드 필드 추가 및 코드 생성.
- **Mock 제거 및 실데이터 연동**: 대학교 목록 조회 기능을 `UniversityRepositoryMock`에서 실제 API를 호출하는 `UniversityRepositoryImpl`로 교체.

### B. 로컬 개발 환경 설정
- **네트워크 설정**: 안드로이드 에뮬레이터에서 로컬 백엔드 서버에 접속할 수 있도록 `env_config.dart`의 기본 주소를 `http://10.0.2.2:28080`으로 변경.
- **웹소켓 주소 업데이트**: 채팅 기능을 위한 WS 엔드포인트 동기화.

### C. 디버깅 및 로깅 시스템 강화
- **로거 커스터마이징**: 모든 앱 로그에 `[NONSTOP]` 접두사를 추가하고 `debugPrint`를 사용하여 터미널 가독성 향상.
- **HTTP 트래픽 가시성**:
    - 요청/응답 로그에 색상 태그 및 이모지 적용.
    - HTML/JS 등 너무 긴 응답 데이터는 1000자로 제한(Truncate)하여 콘솔 도배 방지.
- **인증 토큰 추적**:
    - 로그인/회원가입 성공 시 수신하는 Access/Refresh 토큰 전체 출력 기능 추가.
    - API 요청 시 헤더에 주입되는 토큰 실시간 확인 로그 추가.
    - `SecureStorage` 조회 시 데이터 유무(EXISTS/NULL) 및 값 출력.

## 3. 수정된 파일 목록
- `lib/core/config/env_config.dart`: 서버 주소 변경
- `lib/core/network/dio_client.dart`: 로깅 인터셉터 개선 및 토큰 로그 추가
- `lib/core/utils/logger.dart`: 로거 초기화 및 접두사 추가
- `lib/core/storage/secure_storage_service.dart`: 토큰 조회 로그 추가
- `lib/features/auth/data/api/university_api.dart`: 실데이터 API 추가 (신규)
- `lib/features/auth/data/repository_impl/university_repository_impl.dart`: 실데이터 저장소 추가 (신규)
- `lib/features/auth/presentation/providers/university_provider.dart`: Mock에서 실데이터로 교체
- 기타 DTO 및 엔티티 파일 다수

## 4. 검증 결과
- `GET /api/v1/users/me` 호출 시 `Authorization` 헤더 정상 주입 확인.
- 백엔드 응답(JSON) 정상 수신 및 로그 출력 확인.
- `dart analyze` 통과 (불필요한 import 및 경고 정리 완료).

## 5. 향후 과제
- 회원가입 UI에 전공(Major) 선택 드롭다운 추가 연동.
- 토큰 만료 시 리프레시 로직 실제 서버 환경 테스트.
