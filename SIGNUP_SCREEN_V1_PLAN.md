# 회원가입 스크린 V1 구현 계획

## 개요
- 파일명: `signup_screen_v1.dart`
- 위치: `lib/features/auth/presentation/screens/`
- 스타일 기준: `login_screen_v1.dart`와 동일한 디자인 시스템 사용
- 기능: UI만 우선 구현 (실제 회원가입 로직은 나중에)

## 현재 파일 구조 분석

### 기존 파일
```
lib/features/auth/
├─ data/
│  ├─ api/
│  │  ├─ auth_api.dart
│  │  └─ auth_api_mock.dart
│  ├─ dto/
│  │  └─ user_dto.dart
│  └─ repository_impl/
│     └─ auth_repository_impl.dart
├─ domain/
│  ├─ entities/
│  │  └─ user.dart
│  ├─ repository/
│  │  └─ auth_repository.dart
│  └─ usecases/
│     ├─ sign_in_usecase.dart
│     ├─ sign_out_usecase.dart
│     └─ sign_up_usecase.dart
└─ presentation/
   ├─ providers/
   │  └─ auth_provider.dart
   ├─ screens/
   │  ├─ login_screen.dart (기존)
   │  ├─ login_screen_v1.dart (새 버전)
   │  ├─ signup_screen.dart (기존)
   │  └─ signup_screen_v1.dart (생성 예정) ⬅️ 이번에 만들 파일
   └─ widgets/
      ├─ custom_auth_text_field.dart
      └─ gradient_button.dart
```

### 활용 가능한 공통 위젯
- `CustomAuthTextField`: 이메일, 비밀번호, 아이디 등 입력 필드에 재사용
- `GradientButton`: 회원가입 버튼에 재사용

## UI 구성 요소 (위에서 아래로)

### 1. 배경 레이어
```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xFFE0DBF8), // #E0DBF8
        Color(0xDEF4EB),   // #DEF4EB
      ],
    ),
  ),
)
```

### 2. 언어 선택기
- 위젯: `LanguageSelector` (공통 위젯으로 구현됨)
- 스타일: login_screen_v1.dart와 동일
- 버튼: UZ | RU | EN

### 3. 메인 컨테이너 (흰색 카드)
- 크기: 343.w × auto
- borderRadius: 40.r
- background: #FFFFFF
- boxShadow: #7C3BEE with opacity
- padding: top 25.h, bottom 40.h, left/right 24.w

#### 3.1 헤더 섹션
```
타이틀: "Ro'yxatdan o'tish"
- fontSize: 24.sp
- fontWeight: w800
- color: #111827

서브타이틀: "Ma'lumotlaringizni kiriting"
- fontSize: 14.sp
- fontWeight: w500
- color: #6B7280
```

#### 3.2 입력 필드 섹션
**간격**: 각 필드 사이 20.h

1. **아이디(Nickname) 입력 필드**
   - 위젯: `CustomAuthTextField`
   - prefixIcon: `Icons.person_outline`
   - hintText: "Nickname"
   - validator: 2-20자 길이 체크

2. **대학교 선택 드롭다운**
   - 위젯: `DropdownButtonFormField` (CustomAuthTextField 스타일 적용)
   - prefixIcon: `Icons.school_outlined`
   - suffixIcon: `Icons.arrow_drop_down`
   - hintText: "Select University"
   - 배경색: #E9F0FE
   - borderRadius: 15.r
   - 크기: 275.w × 55.h
   - 임시 대학교 목록:
     - Tashkent State University of Economics
     - National University of Uzbekistan
     - Westminster International University in Tashkent
     - Inha University in Tashkent
     - Turin Polytechnic University in Tashkent
     - Management Development Institute of Singapore in Tashkent
     - Tashkent University of Information Technologies
     - Tashkent State Technical University

3. **이메일 입력 필드**
   - 위젯: `CustomAuthTextField`
   - prefixIcon: `Icons.email_outlined`
   - hintText: "Email"
   - keyboardType: `TextInputType.emailAddress`
   - validator: 이메일 형식 체크 (정규식)

4. **비밀번호 입력 필드**
   - 위젯: `CustomAuthTextField`
   - prefixIcon: `Icons.lock_outline`
   - hintText: "Password"
   - obscureText: true
   - validator: 최소 6자

5. **비밀번호 확인 입력 필드**
   - 위젯: `CustomAuthTextField`
   - prefixIcon: `Icons.lock_outline`
   - hintText: "Confirm Password"
   - obscureText: true
   - validator: 비밀번호와 일치 여부

#### 3.3 정책 동의 섹션
- Container with padding
- 배경: #F9FAFB
- border: #E5E7EB
- borderRadius: 12.r

**구성**:
```
[✓] Hammaga roziman (전체 동의 - 굵게)
────────────────────────────────
[✓] [Majburiy] Foydalanish shartlari (필수 - 빨간색, 밑줄)
[✓] [Majburiy] Maxfiylik siyosati (필수 - 빨간색, 밑줄)
[ ] [Ixtiyoriy] Marketing xabarlari (선택 - 초록색, 밑줄)
```

**체크박스 동작**:
- 전체 동의 체크 → 모든 항목 체크
- 개별 항목 모두 체크 → 전체 동의 자동 체크
- 개별 항목 하나라도 해제 → 전체 동의 자동 해제

**정책 텍스트 클릭**:
- TODO: 정책 상세 화면으로 이동
- 임시로 SnackBar 표시 (구현 완료)

#### 3.4 회원가입 버튼
- 위젯: `GradientButton`
- text: "Ro'yxatdan o'tish"
- 크기: 275.w × 55.h
- borderRadius: 15.r
- gradient: #7C3BEE → #B95686 → #F5711E
- boxShadow: #7C3BEE with opacity
- onPressed: validation 로직 실행 (구현 완료)

#### 3.5 로그인 링크
- 위치: 하단 중앙
- 텍스트: "Profiling bormi? " + "Kirish"
- "Kirish" 부분:
  - color: #7C3BEE
  - decoration: underline
  - onTap: `context.go('/login')`

## 상태 관리

### Form Key
```dart
final _formKey = GlobalKey<FormState>();
```

### TextEditingController
```dart
final _nicknameController = TextEditingController();
final _emailController = TextEditingController();
final _passwordController = TextEditingController();
final _confirmPasswordController = TextEditingController();
```

### Local State
```dart
String? _selectedUniversity;
bool _allAgreed = false;
bool _termsAgreed = false;
bool _privacyAgreed = false;
bool _marketingAgreed = false;
```

### Validation Logic
```dart
void _handleSignup() {
  if (!_formKey.currentState!.validate()) return;

  // Check required policies
  if (!_termsAgreed || !_privacyAgreed) {
    // Show error snackbar
    return;
  }
  
  // Check university selection
  if (_selectedUniversity == null) {
    // Show error snackbar
    return;
  }

  // TODO: Call signup API
  // For now, just show success message
}
```

## 스타일 상수 (login_screen_v1.dart 기준)

### Colors
- Background Gradient: #E0DBF8 → #DEF4EB
- Main Purple: #7C3BEE
- Card Background: #FFFFFF
- Input Background: #E9F0FE
- Text Dark: #111827
- Text Gray: #6B7280
- Border: #E0E0E0, #E5E7EB
- Error Red: #EF4444
- Success Green: #10B981

### Typography
- Font Family: Noto Sans
- Title: 24.sp, w800
- Subtitle: 14.sp, w500
- Body: 14.sp, w400-w500
- Small: 12-13.sp

### Spacing
- Container padding: 16-24.w/h
- Field spacing: 20.h
- Section spacing: 30.h
- Small spacing: 8-12.h

## 구현 순서

### ✅ 체크리스트 (V1 구현 완료)
- [x] signup_screen_v1.dart 파일 생성
- [x] Scaffold + 배경 그라디언트 구현
- [x] 언어 선택기 구현 (`LanguageSelector` 위젯 사용)
- [x] 메인 컨테이너 + 헤더 구현
- [x] 입력 필드 5개 구현 (nickname, university, email, password, confirm)
- [x] 대학교 드롭다운 구현
- [x] 정책 동의 섹션 구현 (전체동의 + 개별)
- [x] 회원가입 버튼 구현
- [x] 로그인 링크 구현
- [x] Validation 로직 구현
- [x] dispose() 메서드에서 controller 정리
- [x] 에러 메시지 표시 UI (SnackBar 사용)
- [x] 테스트 및 스타일 조정

## 참고사항

- **V1 UI 구현 완료.** 실제 API 연동은 다음 단계에서 진행.
- 모든 TODO 주석으로 미구현 기능 표시
- login_screen_v1.dart의 스타일을 최대한 일관되게 유지
- 반응형 크기를 위해 모든 수치에 .w, .h, .sp, .r 사용
- CustomAuthTextField와 GradientButton 재사용
- **자주 사용되는 패턴이 보이면 나중에 공통 위젯으로 추출 검토** (예: `LanguageSelector`가 좋은 예시)

## 다음 단계 (이후 작업)
1. 회원가입 API 연동
2. 실제 대학교 목록 API 연동
3. 정책 상세 화면 구현
4. 이메일 인증 플로우 연결
5. 에러 처리 개선 (더 구체적인 메시지 등)
6. 로딩 상태 추가 (버튼 클릭 시)
7. 공통 패턴 위젯 추출 검토 (예: 정책 동의 섹션)
