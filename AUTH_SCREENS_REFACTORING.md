# 인증 스크린 리팩토링 제안

## 개요
`login_screen_v1.dart`와 `signup_screen_v1.dart` 파일의 TODO 주석을 한글로 변경했으며, PRD 문서와 PROJECT_GUIDE.md를 참고하여 리팩토링이 필요한 부분을 정리했습니다.

## 완료된 작업

### ✅ TODO 주석 한글화
- [x] login_screen_v1.dart - 모든 TODO 주석 한글로 변경
- [x] signup_screen_v1.dart - 모든 TODO 주석 한글로 변경
- [x] Routes 상수 사용 (`/home` → `Routes.home`)

## 리팩토링 제안 사항

### 🔴 높은 우선순위

#### 1. 언어 선택기 공통 위젯 추출
**문제점**:
- `login_screen_v1.dart`와 `signup_screen_v1.dart` 모두 동일한 언어 선택기 코드 반복 (100줄 이상)
- 유지보수 시 두 파일을 모두 수정해야 함

**해결 방안**:
```dart
// lib/features/auth/presentation/widgets/language_selector.dart
class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    // 언어 선택기 UI
  }
}
```

**적용 위치**:
- `login_screen_v1.dart:89-169`
- `signup_screen_v1.dart:301-383`

**참고**: PROJECT_GUIDE.md - "Feature-Based Organization" 및 "UI Logic Rule"

---

#### 2. Validation 에러 메시지 다국어화
**문제점**:
- UI 텍스트는 우즈베크어인데 validation 에러는 영어
- 사용자 경험 일관성 부족

**현재**:
```dart
validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';  // ❌ 영어
  }
  // ...
}
```

**제안**:
```dart
validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Emailingizni kiriting';  // ✅ 우즈베크어
  }
  // 또는
  return AppLocalizations.of(context)!.emailRequired;  // ✅ l10n 사용
}
```

**적용 위치**:
- `login_screen_v1.dart`: line 255-263, 275-283
- `signup_screen_v1.dart`: line 195-228, 239-266

**참고**: PROJECT_GUIDE.md - "17. Localization" 섹션

---

#### 3. 하드코딩된 색상을 AppColors로 변경
**문제점**:
- PROJECT_GUIDE.md의 "Theme & Styling" 가이드 위반
- 색상 값이 코드 전체에 하드코딩되어 있음
- 테마 변경 시 모든 파일 수정 필요

**현재 하드코딩된 색상들**:
```dart
Color(0xFFE0DBF8)  // 배경 그라디언트 시작
Color(0xFFDEF4EB)  // 배경 그라디언트 끝
Color(0xFFFFFFFF)  // 카드 배경, 테두리
Color(0xFF7C3BEE)  // 메인 컬러 (아이콘, 링크, 버튼)
Color(0xFF111827)  // 텍스트 다크
Color(0xFF6B7280)  // 텍스트 그레이
Color(0xFFE0E0E0)  // 테두리
Color(0xFFE9F0FE)  // 입력 필드 배경
Color(0xFFF9FAFB)  // 정책 동의 섹션 배경
Color(0xFFE5E7EB)  // 정책 동의 섹션 테두리
Color(0xFFEF4444)  // 필수 라벨 빨강
Color(0xFF10B981)  // 선택 라벨 초록
```

**해결 방안**:
1. `lib/core/theme/app_colors.dart`에 색상 정의 추가
2. 모든 하드코딩된 색상을 `AppColors.xxx`로 교체

**예시**:
```dart
// lib/core/theme/app_colors.dart
class AppColors {
  // 기존 색상들...

  // Auth screens
  static const gradientStart = Color(0xFFE0DBF8);
  static const gradientEnd = Color(0xFFDEF4EB);
  static const mainPurple = Color(0xFF7C3BEE);
  static const inputBackground = Color(0xFFE9F0FE);
  static const textDark = Color(0xFF111827);
  static const textGray = Color(0xFF6B7280);
  static const borderGray = Color(0xFFE0E0E0);
  static const policyBg = Color(0xFFF9FAFB);
  static const policyBorder = Color(0xFFE5E7EB);
  static const requiredRed = Color(0xFFEF4444);
  static const optionalGreen = Color(0xFF10B981);
}
```

**적용 위치**: 두 파일 전체

**참고**: PROJECT_GUIDE.md - "18. Theme & Styling" - "Color System"

---

### 🟡 중간 우선순위

#### 4. TextField 힌트 텍스트 다국어화
**문제점**:
- 힌트 텍스트가 영어로 하드코딩됨 ('Email', 'Password', 'Nickname' 등)
- UI 전체가 우즈베크어인데 입력 필드만 영어

**제안**:
```dart
CustomAuthTextField(
  controller: _emailController,
  hintText: 'Email',  // ❌
  // ...
)

// 수정 후
CustomAuthTextField(
  controller: _emailController,
  hintText: AppLocalizations.of(context)!.email,  // ✅
  // ...
)
```

**적용 위치**:
- login_screen_v1.dart: line 251, 272
- signup_screen_v1.dart: line 193, 216, 236, 255, 441

---

#### 5. 정책 동의 체크박스 개별 관리 개선
**문제점**:
- 정책 동의 상태가 4개의 개별 boolean으로 관리됨
- 확장성 부족 (정책이 추가되면 코드 수정 필요)

**현재**:
```dart
bool _allAgreed = false;
bool _termsAgreed = false;
bool _privacyAgreed = false;
bool _marketingAgreed = false;
```

**제안**:
```dart
// 정책 모델 정의
class PolicyItem {
  final String id;
  final String label;
  final bool isRequired;
  bool isAgreed;

  PolicyItem({
    required this.id,
    required this.label,
    required this.isRequired,
    this.isAgreed = false,
  });
}

// 상태 관리
late List<PolicyItem> _policies;

@override
void initState() {
  super.initState();
  _policies = [
    PolicyItem(id: 'terms', label: 'Foydalanish shartlari', isRequired: true),
    PolicyItem(id: 'privacy', label: 'Maxfiylik siyosati', isRequired: true),
    PolicyItem(id: 'marketing', label: 'Marketing xabarlari', isRequired: false),
  ];
}
```

**장점**:
- 확장성: 새 정책 추가 시 리스트에만 추가
- 유지보수성: 로직 중복 제거
- 가독성: 정책 관리가 명확함

---

#### 6. API 관련 상수 분리
**문제점**:
- 대학교 목록이 화면 파일에 하드코딩되어 있음
- 나중에 API로 교체 시 화면 파일 수정 필요

**제안**:
```dart
// lib/features/auth/domain/entities/university.dart
class University {
  final String id;
  final String name;

  const University({required this.id, required this.name});
}

// lib/features/auth/data/datasources/universities_mock.dart
class UniversitiesMock {
  static const universities = [
    University(id: '1', name: 'Tashkent State University of Economics'),
    University(id: '2', name: 'National University of Uzbekistan'),
    // ...
  ];
}
```

**적용 위치**: signup_screen_v1.dart:34-43

---

### 🟢 낮은 우선순위 (향후 개선)

#### 7. 로딩 상태 개선
**제안**:
- signup_screen_v1.dart도 login처럼 로딩 상태 추가
- GradientButton에 isLoading 파라미터 전달

#### 8. 에러 메시지 표시 UI 통일
**제안**:
- login_screen_v1.dart의 에러 메시지 UI를 signup에도 적용
- 공통 ErrorMessage 위젯 추출 가능

#### 9. 폼 검증 로직 분리
**제안**:
- validator 함수들을 `lib/core/utils/validators.dart`로 분리
- 재사용성 증가

**예시**:
```dart
// lib/core/utils/validators.dart
class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Emailingizni kiriting';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'To\'g\'ri email kiriting';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Parolni kiriting';
    }
    if (value.length < 6) {
      return 'Parol kamida 6 belgidan iborat bo\'lishi kerak';
    }
    return null;
  }

  static String? nickname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nicknameni kiriting';
    }
    if (value.length < 2 || value.length > 20) {
      return 'Nickname 2-20 belgi orasida bo\'lishi kerak';
    }
    return null;
  }
}
```

**참고**: PROJECT_GUIDE.md - "core/utils/" 섹션

---

## 구현 우선순위

### Phase 1 (즉시 적용 권장)
1. ✅ TODO 주석 한글화 (완료)
2. ✅ Routes 상수 사용 (완료)
3. 🔴 언어 선택기 공통 위젯 추출
4. 🔴 Validation 에러 메시지 다국어화

### Phase 2 (다음 스프린트)
5. 🔴 하드코딩된 색상을 AppColors로 변경
6. 🟡 TextField 힌트 텍스트 다국어화
7. 🟡 정책 동의 체크박스 개별 관리 개선

### Phase 3 (향후 개선)
8. 🟡 API 관련 상수 분리
9. 🟢 로딩 상태 개선
10. 🟢 에러 메시지 표시 UI 통일
11. 🟢 폼 검증 로직 분리

---

## PROJECT_GUIDE.md 준수 체크리스트

### ✅ 준수하고 있는 항목
- [x] Clean Architecture 3 Layers (presentation만 구현)
- [x] Feature-Based Organization
- [x] Naming Conventions (snake_case 파일명, PascalCase 클래스)
- [x] Build Method Discipline (private methods로 UI 분리)
- [x] UI Logic Rule (비즈니스 로직 없음)
- [x] State Management (Riverpod 사용)
- [x] Navigation (go_router + Routes 상수)
- [x] Performance Rules (const 사용, autoDispose)

### ⚠️ 개선 필요한 항목
- [ ] **Theme & Styling**: 하드코딩된 색상 대신 AppColors 사용
- [ ] **Localization**: l10n 사용하지 않고 하드코딩된 텍스트
- [ ] **Code Reusability**: 중복 코드 (언어 선택기)

### 📝 아직 적용 안 된 항목 (UI만 구현이므로 정상)
- Domain Layer (Entity, Repository, UseCase)
- Data Layer (API, DTO, Repository Impl)
- Error Handling (Failure types)
- Testing

---

## 다음 단계

1. **언어 선택기 위젯 추출** - 가장 쉽고 즉시 효과 있음
2. **AppColors 정의 및 적용** - 테마 일관성 확보
3. **l10n 설정** - 다국어 지원 인프라 구축
4. **validation 메시지 다국어화** - 사용자 경험 개선

---

## 참고 문서
- `PROJECT_GUIDE.md` - 전체 아키텍처 및 코딩 표준
- `prd_draft.md` - 기능 요구사항
- `SIGNUP_SCREEN_V1_PLAN.md` - 회원가입 화면 구현 계획
