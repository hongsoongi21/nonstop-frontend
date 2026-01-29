# 백엔드 이메일 인증 로직 수정 가이드 (For Pre-Signup Verification)

## 1. 개요
현재 백엔드의 이메일 인증 로직은 DB에 사용자가 이미 존재해야만 인증 번호를 발송할 수 있도록 설계되어 있습니다 (`UserNotFoundException` 발생). 이를 수정하여 **회원가입 전 비회원 상태에서도 이메일 인증이 가능하도록** 개선해야 합니다.

## 2. 현재 문제점 분석
- **파일 위치**: `com.app.nonstop.domain.auth.service.AuthServiceImpl.java`
- **문제 코드**: `sendEmailVerification` 메서드에서 `authMapper.findByEmail(email).orElseThrow(UserNotFoundException::new);` 호출.
- **현상**: 회원가입 하려는 이메일은 DB에 없으므로 에러가 발생하며, Spring Security에 의해 `401 Unauthorized` 응답이 반환됨.

---

## 3. 수정 권장 사항

### A. AuthServiceImpl.java 수정 (`sendEmailVerification`)
사용자 존재 여부 체크를 제거하고, 대신 **중복 가입 방지**를 위해 이메일 중복 체크를 먼저 수행하도록 변경합니다.

```java
// AS-IS
@Override
public void sendEmailVerification(EmailVerificationRequestDto request) {
    String email = request.getEmail();
    
    // 이 부분이 문제: 가입 안 된 사용자는 여기서 에러 발생
    User user = authMapper.findByEmail(email)
            .orElseThrow(UserNotFoundException::new);

    if (Boolean.TRUE.equals(user.getEmailVerified())) {
        throw new AlreadyVerifiedException();
    }
    sendVerificationEmail(email);
}

// TO-BE (수정 제안)
@Override
public void sendEmailVerification(EmailVerificationRequestDto request) {
    String email = request.getEmail();

    // 1. 이미 가입된 계정인지 확인 (선택 사항이나 권장)
    if (authMapper.existsByEmail(email)) {
        throw new DuplicateEmailException(); 
    }

    // 2. Rate Limit 및 발송 로직 실행
    String rateLimitKey = SIGNUP_RESEND_LIMIT_PREFIX + email;
    if (Boolean.TRUE.equals(redisTemplate.hasKey(rateLimitKey))) {
        throw new ResendRateLimitedException();
    }

    sendVerificationEmail(email); // Redis에 코드 저장 및 메일 발송
    
    redisTemplate.opsForValue().set(rateLimitKey, "1", SIGNUP_RESEND_LIMIT_TTL, TimeUnit.MINUTES);
}
```

### B. AuthServiceImpl.java 수정 (`verifyEmail`)
인증 완료 시 DB 업데이트를 시도하는 로직을 분리해야 합니다. 비회원 가입 전 단계이므로 DB에 유저가 없을 수 있음을 고려합니다.

```java
// TO-BE (수정 제안)
@Override
public TokenResponseDto verifyEmail(SignupVerificationRequestDto request) {
    String email = request.getEmail();
    String code = request.getCode();
    String redisKey = SIGNUP_VERIFICATION_PREFIX + email;

    String storedCode = redisTemplate.opsForValue().get(redisKey);
    if (storedCode == null) throw new VerificationCodeExpiredException();
    if (!storedCode.equals(code)) throw new VerificationCodeMismatchException();

    // 인증 성공 처리
    // 1. Redis에 "이메일 인증됨" 플래그 저장 (회원가입 API에서 검증용)
    redisTemplate.opsForValue().set("verified:email:" + email, "true", 30, TimeUnit.MINUTES);
    
    // 2. 만약 DB에 유저가 있다면 (비밀번호 찾기 등의 유즈케이스 대비) 업데이트
    authMapper.findByEmail(email).ifPresent(user -> {
        authMapper.updateEmailVerified(user.getId(), true, LocalDateTime.now());
    });

    redisTemplate.delete(redisKey);

    // 가입 전 단계이므로 토큰을 발행할 유저가 없으면 null 혹은 성공 메시지만 반환
    return null; 
}
```

### C. signUp API 내 인증 여부 검증 추가
실제 회원가입 시, 해당 이메일이 Redis를 통해 인증되었는지 최종 확인하는 절차를 추가합니다.

```java
@Override
public SignUpResponseDto signUp(SignUpRequestDto signUpRequest) {
    // Redis에서 인증 완료 여부 확인
    String isVerified = redisTemplate.opsForValue().get("verified:email:" + signUpRequest.getEmail());
    if (isVerified == null || !isVerified.equals("true")) {
        throw new EmailNotVerifiedException(); // 커스텀 예외 정의 필요
    }

    checkEmailDuplicate(signUpRequest.getEmail());
    // ... 가입 로직 수행
}
```

---

## 4. 기대 효과
1. **사용자 경험 개선**: 가입 프로세스 중간에 막히지 않고 이메일 인증 후 부드럽게 가입 완료 가능.
2. **보안 강화**: 실제 인증된 이메일로만 계정 생성이 가능해짐.
3. **유연성**: 현재의 로직은 비밀번호 재설정 등 다른 인증 flow와도 쉽게 통합 가능.

## 5. 프론트엔드 엔드포인트 참조
프론트엔드에서는 현재 다음 엔드포인트를 호출하도록 설정되어 있습니다:
- **발송**: `POST /api/v1/auth/email/send-verification`
- **확인**: `POST /api/v1/auth/email/verify`
