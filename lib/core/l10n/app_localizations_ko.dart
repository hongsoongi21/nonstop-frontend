// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get language => '언어';

  @override
  String get languageSubtitle => '원하는 언어를 선택하세요';

  @override
  String get systemDefault => '시스템 기본값';

  @override
  String loginSuccessWelcome(String nickname) {
    return '$nickname님, 환영합니다!';
  }

  @override
  String get helloWorld => '안녕하세요!';

  @override
  String get editPost => '게시물 수정';

  @override
  String get cancel => '취소';

  @override
  String get save => '저장';

  @override
  String get deletePost => '게시물 삭제';

  @override
  String get confirmDeletePost => '이 게시물을 삭제하시겠습니까?';

  @override
  String get editComment => '댓글 수정';

  @override
  String get deleteComment => '댓글 삭제';

  @override
  String get confirmDeleteComment => '이 댓글을 삭제하시겠습니까?';

  @override
  String get universityVerificationRequired => '대학교 인증이 필요합니다';

  @override
  String get universityVerificationRequiredAccess =>
      '이 커뮤니티에 접근하려면 대학교 인증이 필요합니다';

  @override
  String get title => '제목';

  @override
  String get content => '내용';

  @override
  String get selectCommunity => '커뮤니티 선택';

  @override
  String get chat => '채팅';

  @override
  String get chatListEmpty => '채팅이 없습니다';

  @override
  String get chatListEmptyHint => '+ 버튼을 눌러 대화를 시작하세요';

  @override
  String get chatLoadError => '채팅 목록을 불러오지 못했습니다';

  @override
  String get searchChats => '채팅 검색...';

  @override
  String get newChat => '새 채팅';

  @override
  String get searchUsers => '사용자 검색...';

  @override
  String selectedCount(int count) {
    return '$count명 선택됨';
  }

  @override
  String get startChat => '채팅 시작';

  @override
  String get createGroup => '그룹 만들기';

  @override
  String get groupName => '그룹 이름';

  @override
  String get groupNameHint => '그룹 이름을 입력하세요';

  @override
  String get camera => '카메라';

  @override
  String get gallery => '갤러리';

  @override
  String get connectionConnected => '연결됨';

  @override
  String get connectionConnecting => '연결 중...';

  @override
  String get connectionDisconnected => '연결 끊김 - 탭하여 재연결';

  @override
  String get today => '오늘';

  @override
  String get yesterday => '어제';

  @override
  String get messageHint => '메시지를 입력하세요...';

  @override
  String get profile => '프로필';

  @override
  String get settings => '설정';

  @override
  String get editProfile => '프로필 수정';

  @override
  String get posts => '게시물';

  @override
  String get comments => '댓글';

  @override
  String get friends => '친구';

  @override
  String get allPosts => '모든 게시물';

  @override
  String get bookmarks => '북마크';

  @override
  String get favorites => '즐겨찾기';

  @override
  String get notifications => '알림';

  @override
  String get privacy => '개인정보';

  @override
  String get account => '계정';

  @override
  String get logout => '로그아웃';

  @override
  String get pushNotifications => '푸시 알림';

  @override
  String get pushNotificationsSubtitle => '이 기기에서 푸시 알림 받기';

  @override
  String get emailNotifications => '이메일 알림';

  @override
  String get emailNotificationsSubtitle => '이메일로 업데이트 받기';

  @override
  String get boardNotifications => '게시판 알림';

  @override
  String get boardNotificationsSubtitle => '새 게시물 및 댓글';

  @override
  String get chatNotifications => '채팅 알림';

  @override
  String get chatNotificationsSubtitle => '새 메시지 및 답장';

  @override
  String get timetableNotifications => '시간표 알림';

  @override
  String get timetableNotificationsSubtitle => '수업 알림 및 업데이트';

  @override
  String get soundNotifications => '알림음';

  @override
  String get soundNotificationsSubtitle => '알림 시 소리 재생';

  @override
  String get allowFriendRequests => '친구 요청 허용';

  @override
  String get allowFriendRequestsSubtitle => '다른 사용자가 친구 요청을 보낼 수 있도록 허용';

  @override
  String get showOnlineStatus => '온라인 상태 표시';

  @override
  String get showOnlineStatusSubtitle => '친구들에게 온라인 상태 표시';

  @override
  String get allowMessageRequests => '메시지 요청 허용';

  @override
  String get allowMessageRequestsSubtitle => '친구가 아닌 사람의 메시지 받기';

  @override
  String get showProfileToStrangers => '모두에게 프로필 공개';

  @override
  String get showProfileToStrangersSubtitle => '모든 사람에게 프로필 표시';

  @override
  String get logoutSubtitle => '계정에서 로그아웃';

  @override
  String get confirmLogout => '로그아웃 하시겠습니까?';

  @override
  String get errorOccurred => '오류가 발생했습니다';

  @override
  String get retry => '다시 시도';

  @override
  String get notificationsComingSoon => '알림 - 곧 출시 예정!';

  @override
  String get editProfileComingSoon => '프로필 수정 - 곧 출시 예정!';

  @override
  String get searchComingSoon => '검색 - 곧 출시 예정!';

  @override
  String get filterPrefix => '필터: ';

  @override
  String get profileNotLoaded => '프로필 정보를 불러오지 못했습니다';

  @override
  String get settingsNotLoaded => '설정을 불러오지 못했습니다';

  @override
  String get postsLoadError => '게시물을 불러오지 못했습니다';

  @override
  String get noPostsYet => '작성한 게시물이 없습니다';

  @override
  String get markAllAsRead => '모두 읽음';

  @override
  String get noNotificationsYet => '알림이 없습니다';

  @override
  String get noNotificationsHint => '새로운 알림이 도착하면 여기에 표시됩니다';

  @override
  String get notificationLoadError => '알림을 불러오는데 실패했습니다';

  @override
  String get justNow => '방금 전';

  @override
  String minutesAgo(int count) {
    return '$count분 전';
  }

  @override
  String hoursAgo(int count) {
    return '$count시간 전';
  }

  @override
  String daysAgo(int count) {
    return '$count일 전';
  }

  @override
  String get board => '게시판';

  @override
  String get write => '작성';

  @override
  String get searchPosts => '게시물 검색...';

  @override
  String get pleaseSelectBoardFirst => '먼저 게시판을 선택해주세요';

  @override
  String noPostsInBoard(String boardName) {
    return '$boardName에 게시물이 없습니다';
  }

  @override
  String get beFirstToPost => '첫 번째로 대화를 시작해보세요!';

  @override
  String get createFirstPost => '첫 게시물 작성';

  @override
  String get student => '학생';

  @override
  String get post => '게시';

  @override
  String get edit => '수정';

  @override
  String get delete => '삭제';

  @override
  String get anonymous => '익명';

  @override
  String get replyingToComment => '댓글에 답글 달기';

  @override
  String get noCommentsYet => '아직 댓글이 없습니다';

  @override
  String get beFirstToComment => '첫 번째로 의견을 남겨보세요';

  @override
  String get writeComment => '댓글 작성...';

  @override
  String get postAnonymously => '익명으로 게시';

  @override
  String get comment => '댓글';

  @override
  String get like => '좋아요';

  @override
  String get reply => '답글';

  @override
  String get createPost => '게시물 작성';

  @override
  String get noBoardsAvailable => '이용 가능한 게시판이 없습니다. 먼저 커뮤니티를 선택해주세요.';

  @override
  String get writeClearTitle => '명확하고 흥미로운 제목을 작성하세요...';

  @override
  String get pleaseEnterTitle => '제목을 입력해주세요';

  @override
  String get titleTooShort => '제목이 너무 짧습니다';

  @override
  String get shareYourThoughts => '생각을 공유해보세요...';

  @override
  String get pleaseEnterContent => '내용을 입력해주세요';

  @override
  String get pleaseSelectBoard => '게시판을 선택해주세요';

  @override
  String get hideIdentity => '다른 사람에게 신원을 숨깁니다';

  @override
  String get secretPost => '비밀 게시물';

  @override
  String get onlyVisibleToAuthorized => '인증된 사용자에게만 공개됩니다';

  @override
  String get login => '로그인';

  @override
  String get email => '이메일';

  @override
  String get password => '비밀번호';

  @override
  String get forgotPassword => '비밀번호를 잊으셨나요?';

  @override
  String get welcomeBack => '환영합니다!';

  @override
  String get loginToContinue => '계속하려면 로그인하세요';

  @override
  String get continueWithGoogle => 'Google로 계속하기';

  @override
  String get continueWithApple => 'Apple로 계속하기';

  @override
  String appleSignInFailed(String error) {
    return 'Apple 로그인 실패: $error';
  }

  @override
  String get appleSignInNotAvailable => 'Apple 로그인은 iOS에서만 사용할 수 있습니다';

  @override
  String get orSocialMedia => '또는 소셜 네트워크로';

  @override
  String get noAccount => '계정이 없으신가요?';

  @override
  String get signUpLink => '회원가입';

  @override
  String get validationEmailRequired => '이메일을 입력하세요';

  @override
  String get validationEmailInvalid => '올바른 이메일을 입력하세요';

  @override
  String get validationPasswordRequired => '비밀번호를 입력하세요';

  @override
  String get validationPasswordMin6 => '비밀번호는 최소 6자 이상이어야 합니다';

  @override
  String get validationPasswordMin8 => '비밀번호는 최소 8자 이상이어야 합니다';

  @override
  String googleSignInFailed(String error) {
    return 'Google 로그인 실패: $error';
  }

  @override
  String get createAccount => '계정 만들기';

  @override
  String get enterYourInfo => '정보를 입력하세요';

  @override
  String get nickname => '닉네임';

  @override
  String get selectUniversity => '대학교 선택';

  @override
  String get selectBirthDate => '생년월일 선택';

  @override
  String get confirmPassword => '비밀번호 확인';

  @override
  String get agreeToAll => '모두 동의';

  @override
  String get required => '[필수]';

  @override
  String get optional => '[선택]';

  @override
  String get view => '[보기]';

  @override
  String get haveAccount => '계정이 있으신가요?';

  @override
  String get loginLink => '로그인';

  @override
  String get validationNicknameRequired => '닉네임을 입력하세요';

  @override
  String get validationNickname2to20 => '닉네임은 2-20자 이어야 합니다';

  @override
  String get validationPasswordsNoMatch => '비밀번호가 일치하지 않습니다';

  @override
  String get validationConfirmPassword => '비밀번호를 확인하세요';

  @override
  String get send => '전송';

  @override
  String get resend => '재전송';

  @override
  String get verify => '확인';

  @override
  String get sixDigitCode => '6자리 코드';

  @override
  String get emailVerified => '이메일 인증 완료';

  @override
  String get oauthEmailVerified => '소셜 로그인을 통해 이메일이 인증되었습니다';

  @override
  String get verificationCodeSent => '인증 코드가 전송되었습니다!';

  @override
  String get emailVerifiedSuccess => '이메일이 성공적으로 인증되었습니다!';

  @override
  String get invalidCode => '잘못된 코드';

  @override
  String get failedToSendCode => '코드 전송 실패';

  @override
  String get pleaseVerifyEmail => '먼저 이메일을 인증해주세요';

  @override
  String get pleaseWaitPoliciesLoad => '정책을 불러오는 중입니다';

  @override
  String get agreeMandatoryPolicies => '모든 필수 정책에 동의해주세요';

  @override
  String get pleaseSelectUniversity => '대학교를 선택해주세요';

  @override
  String get pleaseSelectBirthDate => '생년월일을 선택해주세요';

  @override
  String get signupFailed => '회원가입 실패';

  @override
  String couldNotLaunch(String url) {
    return '$url을 열 수 없습니다';
  }

  @override
  String errorLaunchingUrl(String error) {
    return 'URL 열기 오류: $error';
  }

  @override
  String get selectYourBirthDate => '생년월일을 선택하세요';

  @override
  String get noPoliciesAvailable => '사용 가능한 정책이 없습니다';

  @override
  String get resetPassword => '비밀번호 재설정';

  @override
  String get enterRegisteredEmail => '등록된 이메일 주소를 입력하세요';

  @override
  String get sendCode => '코드 전송';

  @override
  String get verifyCode => '코드 확인';

  @override
  String get codeVerified => '코드가 확인되었습니다!';

  @override
  String get verificationCodeLabel => '인증 코드';

  @override
  String get resendCode => '코드 재전송';

  @override
  String get newPassword => '새 비밀번호';

  @override
  String get enterNewPassword => '새 비밀번호를 입력하세요';

  @override
  String get updatePassword => '비밀번호 업데이트';

  @override
  String get success => '성공!';

  @override
  String get passwordChangedSuccess =>
      '비밀번호가 성공적으로 변경되었습니다. 이제 새 비밀번호로 로그인할 수 있습니다.';

  @override
  String get stepEmail => '이메일';

  @override
  String get stepVerification => '인증';

  @override
  String get stepNewPassword => '새 비밀번호';

  @override
  String get validationEnterEmail => '이메일 입력';

  @override
  String get validationEnterValidEmail => '올바른 이메일 입력';

  @override
  String get validationEnterCode => '코드 입력';

  @override
  String get validationCodeMinLength => '코드는 최소 4자리여야 합니다';

  @override
  String get validationEnterPassword => '비밀번호 입력';

  @override
  String get validationPasswordMinLength => '비밀번호는 최소 8자 이상이어야 합니다';

  @override
  String get validationConfirmNewPassword => '비밀번호 확인';

  @override
  String get codeResent => '코드가 재전송되었습니다!';

  @override
  String get friendsTitle => '친구';

  @override
  String get requests => '받은 요청';

  @override
  String get search => '검색';

  @override
  String get noFriendsYet => '아직 친구가 없습니다';

  @override
  String get addFriendsViaSearch => '검색을 통해 친구를 추가하세요';

  @override
  String get friend => '친구';

  @override
  String get sent => '전송됨';

  @override
  String get accept => '수락';

  @override
  String get reject => '거절';

  @override
  String get removeFriend => '친구 삭제';

  @override
  String confirmRemoveFriend(String name) {
    return '$name님을 친구에서 삭제하시겠습니까?';
  }

  @override
  String get remove => '삭제';

  @override
  String get noRequests => '요청 없음';

  @override
  String get requestsAppearHere => '친구 요청이 여기에 표시됩니다';

  @override
  String get searchUsersHint => '사용자 검색...';

  @override
  String get startSearching => '검색 시작';

  @override
  String get typeInSearchBar => '위 검색창에 입력하세요';

  @override
  String get noResults => '결과 없음';

  @override
  String get tryDifferentName => '다른 이름으로 검색해보세요';

  @override
  String get keepTyping => '계속 입력하세요';

  @override
  String get minTwoCharacters => '검색하려면 최소 2자 이상 입력하세요';

  @override
  String get online => '온라인';

  @override
  String get offline => '오프라인';

  @override
  String get friendRequestSent => '친구 요청이 전송되었습니다';

  @override
  String get friendRequestAccepted => '친구 요청을 수락했습니다';

  @override
  String get requestRejected => '요청을 거절했습니다';

  @override
  String get removedFromFriends => '친구에서 삭제되었습니다';

  @override
  String get addFriend => '추가';

  @override
  String get timetable => '시간표';

  @override
  String get addCourse => '과목 추가';

  @override
  String get editCourse => '과목 수정';

  @override
  String get dayMonday => '월요일';

  @override
  String get dayTuesday => '화요일';

  @override
  String get dayWednesday => '수요일';

  @override
  String get dayThursday => '목요일';

  @override
  String get dayFriday => '금요일';

  @override
  String get daySaturday => '토요일';

  @override
  String get daySunday => '일요일';

  @override
  String get dayMondayShort => '월';

  @override
  String get dayTuesdayShort => '화';

  @override
  String get dayWednesdayShort => '수';

  @override
  String get dayThursdayShort => '목';

  @override
  String get dayFridayShort => '금';

  @override
  String get daySaturdayShort => '토';

  @override
  String get daySundayShort => '일';

  @override
  String get semester => '학기';

  @override
  String get semesterSpring => '1학기';

  @override
  String get semesterFall => '2학기';

  @override
  String get semesterSummer => '여름';

  @override
  String get semesterWinter => '겨울';

  @override
  String get gpaCalculator => '학점 계산기';

  @override
  String get creditHours => '학점';

  @override
  String get credits => '학점';

  @override
  String get calculateAndTrack => '계산하고 추적하기';

  @override
  String get courseName => '과목명';

  @override
  String get courseNameHint => '예: 프로그래밍 기초';

  @override
  String get courseNameRequired => '과목명을 입력하세요';

  @override
  String get professor => '교수';

  @override
  String get professorHint => '예: 김 교수';

  @override
  String get room => '강의실 / 장소';

  @override
  String get roomHint => '예: 301호';

  @override
  String get color => '색상';

  @override
  String get colorDescription => '과목을 강조할 색상을 선택하세요';

  @override
  String get startTime => '시작 시간';

  @override
  String get endTime => '종료 시간';

  @override
  String get selectDay => '요일 선택';

  @override
  String get dayOfWeek => '요일';

  @override
  String get timeAndDay => '시간 및 요일';

  @override
  String get basicInfo => '기본 정보';

  @override
  String get deleteCourse => '과목 삭제';

  @override
  String get confirmDeleteCourse => '이 과목을 삭제하시겠습니까?';

  @override
  String get courseDeleted => '과목이 삭제되었습니다';

  @override
  String get courseAdded => '과목이 추가되었습니다';

  @override
  String get courseUpdated => '과목이 수정되었습니다';

  @override
  String get saveChanges => '변경사항 저장';

  @override
  String get noCoursesAdded => '추가된 과목이 없습니다';

  @override
  String get noCoursesDescription => '주간 시간표를 만들기 위해\n과목을 추가하세요';

  @override
  String get loading => '로딩 중...';

  @override
  String get refresh => '새로고침';

  @override
  String get myTimetables => '내 시간표';

  @override
  String get createNewTimetable => '새 시간표 만들기';

  @override
  String get untitledTimetable => '제목 없는 시간표';

  @override
  String get newCourse => '새 과목';

  @override
  String get editCourseTitle => '수정';

  @override
  String get createNewCourse => '시간표에 새 과목을 만드세요';

  @override
  String get updateCourseInfo => '과목 정보를 업데이트하세요';

  @override
  String get conflict => '충돌';

  @override
  String get confirmNewPassword => '새 비밀번호 확인';

  @override
  String get birthDate => '생년월일';

  @override
  String get report => '신고';

  @override
  String get reportReason => '신고 사유 선택';

  @override
  String get reportReasonSpam => '스팸/부적절한 홍보';

  @override
  String get reportReasonAbuse => '욕설/비하';

  @override
  String get reportReasonSexual => '음란물';

  @override
  String get reportReasonHate => '혐오 발언';

  @override
  String get reportReasonIllegal => '불법 정보';

  @override
  String get reportReasonPrivacy => '개인정보 노출';

  @override
  String get reportReasonImpersonation => '사칭';

  @override
  String get reportReasonOther => '기타';

  @override
  String get reportDescription => '추가 설명 (선택사항)';

  @override
  String get reportSubmit => '신고하기';

  @override
  String get reportSuccess => '신고가 접수되었습니다';

  @override
  String get reportAlreadyReported => '이미 신고한 내용입니다';

  @override
  String get blockUser => '사용자 차단';

  @override
  String blockUserConfirm(String name) {
    return '$name님을 차단하시겠습니까?';
  }

  @override
  String get blockUserDescription => '이 사용자로부터 메시지나 친구 요청을 받지 않게 됩니다.';

  @override
  String get block => '차단';

  @override
  String get unblock => '차단 해제';

  @override
  String get blockedUsers => '차단된 사용자';

  @override
  String get noBlockedUsers => '차단된 사용자 없음';

  @override
  String get userBlocked => '사용자를 차단했습니다';

  @override
  String get userUnblocked => '사용자 차단을 해제했습니다';

  @override
  String get universityVerification => '대학교 인증';

  @override
  String get studentIdVerification => '학생증 인증';

  @override
  String get emailVerification => '이메일 인증';

  @override
  String get uploadStudentId => '학생증 업로드';

  @override
  String get selectImage => '이미지 선택';

  @override
  String get takePhoto => '사진 찍기';

  @override
  String get chooseFromGallery => '갤러리에서 선택';

  @override
  String get submitVerification => '인증 제출';

  @override
  String get verificationPending => '인증 검토 중입니다';

  @override
  String get verificationApproved => '인증 완료';

  @override
  String get schoolEmail => '학교 이메일';

  @override
  String get sendVerificationCode => '인증 코드 발송';

  @override
  String get enterVerificationCode => '인증 코드 입력';

  @override
  String get codeSent => '이메일로 인증 코드를 발송했습니다';

  @override
  String get verificationSuccess => '이메일 인증 성공!';

  @override
  String get timeRemaining => '남은 시간';

  @override
  String get deleteAccount => '회원 탈퇴';

  @override
  String get deleteAccountSubtitle => '계정을 영구적으로 삭제합니다';

  @override
  String get confirmDeleteAccount => '정말로 회원 탈퇴를 하시겠습니까?';

  @override
  String get deleteAccountWarning => '이 작업은 되돌릴 수 없습니다. 모든 데이터가 삭제됩니다.';

  @override
  String get deleteAccountSuccess => '계정이 삭제되었습니다';

  @override
  String get deleteAccountFailed => '계정 삭제에 실패했습니다';

  @override
  String get leaveRoom => '채팅방 나가기';

  @override
  String get leaveRoomConfirm =>
      '정말로 이 채팅방을 나가시겠습니까? 더 이상 이 대화의 메시지를 받을 수 없습니다.';

  @override
  String get leaveRoomSuccess => '채팅방을 나갔습니다';

  @override
  String get latest => '최신순';

  @override
  String get trending => '인기순';

  @override
  String get mostCommented => '댓글순';

  @override
  String get completeProfile => '프로필 완성';

  @override
  String get completeProfileSubtitle => '필수 정보를 입력해 주세요';

  @override
  String get introduction => '자기소개';

  @override
  String get introductionHint => '자기소개를 입력하세요...';

  @override
  String get major => '전공';

  @override
  String get majorHint => '예: 컴퓨터공학';

  @override
  String get changePhoto => '사진 변경';

  @override
  String get profileUpdated => '프로필이 성공적으로 업데이트되었습니다';

  @override
  String get profileUpdateFailed => '프로필 업데이트에 실패했습니다';

  @override
  String get avatarUploadFailed => '아바타 업로드에 실패했습니다';

  @override
  String get selectImageSource => '이미지 소스 선택';

  @override
  String get introductionMaxLength => '자기소개는 200자 이하여야 합니다';

  @override
  String get sentRequests => '보낸 요청';

  @override
  String get cancelRequest => '요청 취소';

  @override
  String get requestCancelled => '요청이 취소되었습니다';

  @override
  String get alreadyRequested => '이미 요청한 상대방입니다';

  @override
  String get legal => '법적 고지';

  @override
  String get privacyPolicy => '개인정보처리방침';

  @override
  String get termsOfService => '이용약관';

  @override
  String get policyTermsOfService => '서비스 이용약관';

  @override
  String get policyPrivacyPolicy => '개인정보 처리방침';

  @override
  String get policyMarketing => '마케팅 정보 수신 동의';

  @override
  String get policyUnknown => '정책';

  @override
  String get academicYear => '학년도';

  @override
  String get attachImage => '이미지 첨부';

  @override
  String get boardNameRequired => '게시판 이름을 입력해주세요';

  @override
  String get chatAction => '채팅하기';

  @override
  String confirmDeleteTimetable(String name) {
    return '\"$name\"을(를) 삭제하시겠습니까?';
  }

  @override
  String get continueText => '계속';

  @override
  String get coursesImportedFromTimetable => '시간표에서 과목을 가져왔습니다';

  @override
  String get createButton => '만들기';

  @override
  String get createTimetable => '새 시간표 만들기';

  @override
  String get deleteTimetable => '시간표 삭제';

  @override
  String get enterSchoolEmail => '학교 이메일을 입력해주세요';

  @override
  String get errorLoadingPolicies => '정책을 불러오지 못했습니다';

  @override
  String get majorSubject => '전공 과목';

  @override
  String get noMessagesYet => '아직 메시지가 없습니다';

  @override
  String get noSentRequests => '보낸 요청이 없습니다';

  @override
  String get noUniversitiesFound => '대학교를 찾을 수 없습니다';

  @override
  String timetableCreated(String name) {
    return '\"$name\" 시간표가 생성되었습니다';
  }

  @override
  String get timetableName => '시간표 이름';

  @override
  String get uploading => '업로드 중...';
}
