// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class AppLocalizationsUz extends AppLocalizations {
  AppLocalizationsUz([String locale = 'uz']) : super(locale);

  @override
  String get language => 'Til';

  @override
  String get languageSubtitle => 'O\'zingizga qulay tilni tanlang';

  @override
  String get systemDefault => 'Tizim tili';

  @override
  String loginSuccessWelcome(String nickname) {
    return 'Xush kelibsiz, $nickname!';
  }

  @override
  String get helloWorld => 'Salom, dunyo!';

  @override
  String get editPost => 'Postni tahrirlash';

  @override
  String get cancel => 'Bekor qilish';

  @override
  String get save => 'Saqlash';

  @override
  String get deletePost => 'Postni o\'chirish';

  @override
  String get confirmDeletePost =>
      'Bu postni o\'chirishga ishonchingiz komilmi?';

  @override
  String get editComment => 'Sharhni tahrirlash';

  @override
  String get deleteComment => 'Sharhni o\'chirish';

  @override
  String get confirmDeleteComment =>
      'Bu sharhni o\'chirishga ishonchingiz komilmi?';

  @override
  String get universityVerificationRequired =>
      'Universitet tekshiruvi talab qilinadi';

  @override
  String get universityVerificationRequiredAccess =>
      'Bu jamiyatga kirish uchun universitet tekshiruvi talab qilinadi';

  @override
  String get title => 'Sarlavha';

  @override
  String get content => 'Tarkib';

  @override
  String get selectCommunity => 'Jamiyatni tanlang';

  @override
  String get chat => 'Chat';

  @override
  String get chatListEmpty => 'Hozircha suhbatlar yo\'q';

  @override
  String get chatListEmptyHint => 'Suhbat boshlash uchun + tugmasini bosing';

  @override
  String get chatLoadError => 'Suhbatlarni yuklashda xatolik';

  @override
  String get searchChats => 'Search chats...';

  @override
  String get newChat => 'Yangi suhbat';

  @override
  String get searchUsers => 'Foydalanuvchilarni qidirish...';

  @override
  String selectedCount(int count) {
    return '$count tanlangan';
  }

  @override
  String get startChat => 'Suhbatni boshlash';

  @override
  String get createGroup => 'Guruh yaratish';

  @override
  String get groupName => 'Guruh nomi';

  @override
  String get groupNameHint => 'Guruh nomini kiriting';

  @override
  String get camera => 'Kamera';

  @override
  String get gallery => 'Galereya';

  @override
  String get connectionConnected => 'Ulangan';

  @override
  String get connectionConnecting => 'Ulanmoqda...';

  @override
  String get connectionDisconnected => 'Uzildi - qayta ulash uchun bosing';

  @override
  String get today => 'Bugun';

  @override
  String get yesterday => 'Kecha';

  @override
  String get messageHint => 'Xabar yozing...';

  @override
  String get profile => 'Profil';

  @override
  String get settings => 'Sozlamalar';

  @override
  String get editProfile => 'Profilni tahrirlash';

  @override
  String get posts => 'Postlar';

  @override
  String get comments => 'Sharhlar';

  @override
  String get friends => 'Do\'stlar';

  @override
  String get allPosts => 'Barcha postlar';

  @override
  String get bookmarks => 'Xatcho\'plar';

  @override
  String get favorites => 'Sevimlilar';

  @override
  String get notifications => 'Bildirishnomalar';

  @override
  String get privacy => 'Maxfiylik';

  @override
  String get account => 'Hisob';

  @override
  String get logout => 'Chiqish';

  @override
  String get pushNotifications => 'Push bildirishnomalar';

  @override
  String get pushNotificationsSubtitle =>
      'Bu qurilmada push bildirishnomalarni olish';

  @override
  String get emailNotifications => 'Email bildirishnomalar';

  @override
  String get emailNotificationsSubtitle =>
      'Email orqali yangilanishlarni olish';

  @override
  String get boardNotifications => 'Taxta bildirishnomalari';

  @override
  String get boardNotificationsSubtitle => 'Yangi postlar va sharhlar';

  @override
  String get chatNotifications => 'Chat bildirishnomalari';

  @override
  String get chatNotificationsSubtitle => 'Yangi xabarlar va javoblar';

  @override
  String get timetableNotifications => 'Jadval bildirishnomalari';

  @override
  String get timetableNotificationsSubtitle =>
      'Dars eslatmalari va yangilanishlar';

  @override
  String get soundNotifications => 'Ovozli bildirishnomalar';

  @override
  String get soundNotificationsSubtitle =>
      'Bildirishnomalar uchun ovoz chalish';

  @override
  String get allowFriendRequests => 'Do\'stlik so\'rovlariga ruxsat berish';

  @override
  String get allowFriendRequestsSubtitle =>
      'Boshqalarga sizga do\'stlik so\'rovi yuborishga ruxsat berish';

  @override
  String get showOnlineStatus => 'Onlayn holatini ko\'rsatish';

  @override
  String get showOnlineStatusSubtitle =>
      'Do\'stlaringizga onlayn ekanligingizni ko\'rsatish';

  @override
  String get allowMessageRequests => 'Xabar so\'rovlariga ruxsat berish';

  @override
  String get allowMessageRequestsSubtitle =>
      'Do\'st bo\'lmaganlardan xabar qabul qilish';

  @override
  String get showProfileToStrangers => 'Profilni hamma uchun ko\'rsatish';

  @override
  String get showProfileToStrangersSubtitle =>
      'Profilingizni barchaga ko\'rinadigan qilish';

  @override
  String get logoutSubtitle => 'Hisobingizdan chiqish';

  @override
  String get confirmLogout => 'Chiqishni xohlaysizmi?';

  @override
  String get errorOccurred => 'Xatolik yuz berdi';

  @override
  String get retry => 'Qayta urinish';

  @override
  String get notificationsComingSoon => 'Bildirishnomalar - tez orada!';

  @override
  String get editProfileComingSoon => 'Profilni tahrirlash - tez orada!';

  @override
  String get filterPrefix => 'Filtr: ';

  @override
  String get profileNotLoaded => 'Profil ma\'lumotlari yuklanmadi';

  @override
  String get settingsNotLoaded => 'Sozlamalar yuklanmadi';

  @override
  String get postsLoadError => 'Postlarni yuklashda xatolik';

  @override
  String get noPostsYet => 'Hozircha postlar yo\'q';

  @override
  String get markAllAsRead => 'Hammasini o\'qilgan qilish';

  @override
  String get noNotificationsYet => 'Hozircha bildirishnomalar yo\'q';

  @override
  String get noNotificationsHint =>
      'Yangi bildirishnomalar shu yerda ko\'rinadi';

  @override
  String get notificationLoadError => 'Bildirishnomalarni yuklashda xatolik';

  @override
  String get justNow => 'Hozir';

  @override
  String minutesAgo(int count) {
    return '$count daqiqa oldin';
  }

  @override
  String hoursAgo(int count) {
    return '$count soat oldin';
  }

  @override
  String daysAgo(int count) {
    return '$count kun oldin';
  }

  @override
  String get board => 'Board';

  @override
  String get write => 'Write';

  @override
  String get searchPosts => 'Search posts...';

  @override
  String get pleaseSelectBoardFirst => 'Please select a board first';

  @override
  String noPostsInBoard(String boardName) {
    return 'No posts in $boardName yet';
  }

  @override
  String get beFirstToPost => 'Be the first to start a conversation!';

  @override
  String get createFirstPost => 'Create First Post';

  @override
  String get student => 'Student';

  @override
  String get post => 'Post';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'O\'chirish';

  @override
  String get anonymous => 'Anonymous';

  @override
  String get replyingToComment => 'Replying to comment';

  @override
  String get noCommentsYet => 'No comments yet';

  @override
  String get beFirstToComment => 'Be the first to share your thoughts';

  @override
  String get writeComment => 'Write a comment...';

  @override
  String get postAnonymously => 'Post Anonymously';

  @override
  String get comment => 'Comment';

  @override
  String get like => 'Like';

  @override
  String get reply => 'Reply';

  @override
  String get createPost => 'Create Post';

  @override
  String get noBoardsAvailable =>
      'No boards available. Please select a community first.';

  @override
  String get writeClearTitle => 'Write a clear, engaging title...';

  @override
  String get pleaseEnterTitle => 'Please enter a title';

  @override
  String get titleTooShort => 'Title is too short';

  @override
  String get shareYourThoughts => 'Share your thoughts...';

  @override
  String get pleaseEnterContent => 'Please enter some content';

  @override
  String get pleaseSelectBoard => 'Please select a board';

  @override
  String get hideIdentity => 'Hide your identity from others';

  @override
  String get secretPost => 'Secret Post';

  @override
  String get onlyVisibleToAuthorized => 'Only visible to authorized users';

  @override
  String get login => 'Kirish';

  @override
  String get email => 'Email';

  @override
  String get password => 'Parol';

  @override
  String get forgotPassword => 'Parolni unutdingizmi?';

  @override
  String get welcomeBack => 'Xush Kelibsiz!';

  @override
  String get loginToContinue => 'Davom etish uchun tizimga kiring';

  @override
  String get continueWithGoogle => 'Google orqali davom eting';

  @override
  String get continueWithApple => 'Apple orqali davom eting';

  @override
  String appleSignInFailed(String error) {
    return 'Apple orqali kirish muvaffaqiyatsiz: $error';
  }

  @override
  String get appleSignInNotAvailable =>
      'Apple orqali kirish faqat iOS da ishlaydi';

  @override
  String get orSocialMedia => 'Yoki ijtimoly tarmoqlar orqali';

  @override
  String get noAccount => 'Profiling yo\'qmi?';

  @override
  String get signUpLink => 'Ro\'yxatdan o\'tish';

  @override
  String get validationEmailRequired => 'Emailingizni kiriting';

  @override
  String get validationEmailInvalid => 'To\'g\'ri email kiriting';

  @override
  String get validationPasswordRequired => 'Parolingizni kiriting';

  @override
  String get validationPasswordMin6 =>
      'Parol kamida 6 ta belgidan iborat bo\'lishi kerak';

  @override
  String get validationPasswordMin8 =>
      'Parol kamida 8 ta belgidan iborat bo\'lishi kerak';

  @override
  String googleSignInFailed(String error) {
    return 'Google kirish xatosi: $error';
  }

  @override
  String get createAccount => 'Ro\'yxatdan o\'tish';

  @override
  String get enterYourInfo => 'Ma\'lumotlaringizni kiriting';

  @override
  String get nickname => 'Taxallus';

  @override
  String get selectUniversity => 'Universitetni tanlang';

  @override
  String get selectBirthDate => 'Tug\'ilgan kunni tanlang';

  @override
  String get confirmPassword => 'Parolni tasdiqlang';

  @override
  String get agreeToAll => 'Hammaga roziman';

  @override
  String get required => '[Majburiy]';

  @override
  String get optional => '[Ixtiyoriy]';

  @override
  String get view => '[Ko\'rish]';

  @override
  String get haveAccount => 'Profiling bormi?';

  @override
  String get loginLink => 'Kirish';

  @override
  String get validationNicknameRequired => 'Taxallusingizni kiriting';

  @override
  String get validationNickname2to20 =>
      'Taxallus 2-20 ta belgidan iborat bo\'lishi kerak';

  @override
  String get validationPasswordsNoMatch => 'Parollar mos kelmaydi';

  @override
  String get validationConfirmPassword => 'Parolni tasdiqlang';

  @override
  String get send => 'Yuborish';

  @override
  String get resend => 'Qayta yuborish';

  @override
  String get verify => 'Tasdiqlash';

  @override
  String get sixDigitCode => '6 raqamli kod';

  @override
  String get emailVerified => 'Email tasdiqlandi';

  @override
  String get verificationCodeSent => 'Tasdiqlash kodi yuborildi!';

  @override
  String get emailVerifiedSuccess => 'Email muvaffaqiyatli tasdiqlandi!';

  @override
  String get invalidCode => 'Noto\'g\'ri kod';

  @override
  String get failedToSendCode => 'Kodni yuborib bo\'lmadi';

  @override
  String get pleaseVerifyEmail => 'Iltimos, avval pochtangizni tasdiqlang';

  @override
  String get pleaseWaitPoliciesLoad => 'Shartlar yuklanishini kuting';

  @override
  String get agreeMandatoryPolicies => 'Majburiy shartlarni qabul qiling';

  @override
  String get pleaseSelectUniversity => 'Universitetni tanlang';

  @override
  String get pleaseSelectBirthDate => 'Tug\'ilgan kuningizni tanlang';

  @override
  String get signupFailed => 'Ro\'yxatdan o\'ta olmadi';

  @override
  String couldNotLaunch(String url) {
    return '$url ochilmadi';
  }

  @override
  String errorLaunchingUrl(String error) {
    return 'URL ochishda xato: $error';
  }

  @override
  String get selectYourBirthDate => 'Tug\'ilgan kuningizni tanlang';

  @override
  String get noPoliciesAvailable => 'Shartlar mavjud emas';

  @override
  String get resetPassword => 'Parolni tiklash';

  @override
  String get enterRegisteredEmail =>
      'Ro\'yxatdan o\'tgan email manzilingizni kiriting';

  @override
  String get sendCode => 'Kod yuborish';

  @override
  String get verifyCode => 'Kodni tasdiqlash';

  @override
  String get codeVerified => 'Kod tasdiqlandi!';

  @override
  String get verificationCodeLabel => 'Tasdiqlash kodi';

  @override
  String get resendCode => 'Kodni qayta yuborish';

  @override
  String get newPassword => 'Yangi parol';

  @override
  String get enterNewPassword => 'Yangi parolingizni kiriting';

  @override
  String get updatePassword => 'Parolni yangilash';

  @override
  String get success => 'Muvaffaqiyatli!';

  @override
  String get passwordChangedSuccess =>
      'Parolingiz muvaffaqiyatli o\'zgartirildi. Endi yangi parol bilan tizimga kirishingiz mumkin.';

  @override
  String get stepEmail => 'Email';

  @override
  String get stepVerification => 'Tasdiqlash';

  @override
  String get stepNewPassword => 'Yangi parol';

  @override
  String get validationEnterEmail => 'Email kiriting';

  @override
  String get validationEnterValidEmail => 'To\'g\'ri email kiriting';

  @override
  String get validationEnterCode => 'Kodni kiriting';

  @override
  String get validationCodeMinLength =>
      'Kod kamida 4 ta raqamdan iborat bo\'lishi kerak';

  @override
  String get validationEnterPassword => 'Parol kiriting';

  @override
  String get validationPasswordMinLength =>
      'Parol kamida 8 ta belgidan iborat bo\'lishi kerak';

  @override
  String get validationConfirmNewPassword => 'Parolni tasdiqlang';

  @override
  String get codeResent => 'Kod qayta yuborildi!';

  @override
  String get friendsTitle => 'Do\'stlar';

  @override
  String get requests => 'Qabul qilingan';

  @override
  String get search => 'Qidirish';

  @override
  String get noFriendsYet => 'Hali do\'stlaringiz yo\'q';

  @override
  String get addFriendsViaSearch => 'Qidiruv orqali do\'stlar qo\'shing';

  @override
  String get friend => 'Do\'st';

  @override
  String get sent => 'Yuborildi';

  @override
  String get accept => 'Qabul qilish';

  @override
  String get reject => 'Rad etish';

  @override
  String get removeFriend => 'Do\'stlikdan chiqarish';

  @override
  String confirmRemoveFriend(String name) {
    return '$name bilan do\'stlikni tugatmoqchimisiz?';
  }

  @override
  String get remove => 'Chiqarish';

  @override
  String get noRequests => 'So\'rovlar yo\'q';

  @override
  String get requestsAppearHere => 'Do\'stlik so\'rovlari bu yerda ko\'rinadi';

  @override
  String get searchUsersHint => 'Foydalanuvchilarni qidiring...';

  @override
  String get startSearching => 'Qidirishni boshlang';

  @override
  String get typeInSearchBar => 'Yuqoridagi qidiruv qatoriga yozing';

  @override
  String get noResults => 'Natija topilmadi';

  @override
  String get tryDifferentName => 'Boshqa ism bilan qidirib ko\'ring';

  @override
  String get online => 'Onlayn';

  @override
  String get offline => 'Oflayn';

  @override
  String get friendRequestSent => 'Do\'stlik so\'rovi yuborildi';

  @override
  String get friendRequestAccepted => 'Do\'stlik so\'rovi qabul qilindi';

  @override
  String get requestRejected => 'So\'rov rad etildi';

  @override
  String get removedFromFriends => 'Do\'stlikdan chiqarildi';

  @override
  String get addFriend => 'Qo\'shish';

  @override
  String get timetable => 'Dars jadvali';

  @override
  String get addCourse => 'Dars qo\'shish';

  @override
  String get editCourse => 'Darsni tahrirlash';

  @override
  String get dayMonday => 'Dushanba';

  @override
  String get dayTuesday => 'Seshanba';

  @override
  String get dayWednesday => 'Chorshanba';

  @override
  String get dayThursday => 'Payshanba';

  @override
  String get dayFriday => 'Juma';

  @override
  String get daySaturday => 'Shanba';

  @override
  String get daySunday => 'Yakshanba';

  @override
  String get dayMondayShort => 'DU';

  @override
  String get dayTuesdayShort => 'SE';

  @override
  String get dayWednesdayShort => 'CHO';

  @override
  String get dayThursdayShort => 'PAY';

  @override
  String get dayFridayShort => 'JU';

  @override
  String get daySaturdayShort => 'SHA';

  @override
  String get daySundayShort => 'YAK';

  @override
  String get semester => 'Semestr';

  @override
  String get semesterSpring => 'Bahor';

  @override
  String get semesterFall => 'Kuz';

  @override
  String get semesterSummer => 'Yoz';

  @override
  String get semesterWinter => 'Qish';

  @override
  String get gpaCalculator => 'GPA Kalkulyatori';

  @override
  String get creditHours => 'Kredit soatlar';

  @override
  String get credits => 'kredit';

  @override
  String get calculateAndTrack => 'Hisoblang va kuzating';

  @override
  String get courseName => 'Fan nomi';

  @override
  String get courseNameHint => 'Masalan: Dasturlash asoslari';

  @override
  String get courseNameRequired => 'Fan nomini kiriting';

  @override
  String get professor => 'O\'qituvchi';

  @override
  String get professorHint => 'Masalan: Prof. Kim';

  @override
  String get room => 'Xona / Joy';

  @override
  String get roomHint => 'Masalan: 301-xona';

  @override
  String get color => 'Rang';

  @override
  String get colorDescription =>
      'Darsni ajratib ko\'rsatish uchun rang tanlang';

  @override
  String get startTime => 'Boshlanish';

  @override
  String get endTime => 'Tugash';

  @override
  String get selectDay => 'Kunni tanlang';

  @override
  String get dayOfWeek => 'Hafta kuni';

  @override
  String get timeAndDay => 'Vaqt va Kun';

  @override
  String get basicInfo => 'Asosiy ma\'lumotlar';

  @override
  String get deleteCourse => 'Darsni o\'chirish';

  @override
  String get confirmDeleteCourse =>
      'Haqiqatan ham ushbu darsni o\'chirmoqchimisiz?';

  @override
  String get courseDeleted => 'Dars o\'chirildi';

  @override
  String get courseAdded => 'Dars muvaffaqiyatli qo\'shildi';

  @override
  String get courseUpdated => 'Dars o\'zgartirildi';

  @override
  String get saveChanges => 'O\'zgarishlarni saqlash';

  @override
  String get noCoursesAdded => 'Darslar qo\'shilmagan';

  @override
  String get noCoursesDescription =>
      'Haftalik jadval yaratish uchun\ndarslaringizni qo\'shing';

  @override
  String get loading => 'Yuklanmoqda...';

  @override
  String get refresh => 'Yangilash';

  @override
  String get myTimetables => 'Jadvallarim';

  @override
  String get createNewTimetable => 'Yangi jadval yaratish';

  @override
  String get untitledTimetable => 'Nomsiz jadval';

  @override
  String get newCourse => 'YANGI DARS';

  @override
  String get editCourseTitle => 'TAHRIRLASH';

  @override
  String get createNewCourse => 'Dars jadvali uchun yangi dars yarating';

  @override
  String get updateCourseInfo => 'Dars ma\'lumotlarini yangilang';

  @override
  String get conflict => 'KONFLIKT';

  @override
  String get confirmNewPassword => 'Yangi parolni tasdiqlang';

  @override
  String get birthDate => 'Tug\'ilgan sana';

  @override
  String get report => 'Shikoyat';

  @override
  String get reportReason => 'Shikoyat sababini tanlang';

  @override
  String get reportReasonSpam => 'Spam/Noto\'g\'ri reklama';

  @override
  String get reportReasonAbuse => 'Haqorat/So\'kinish';

  @override
  String get reportReasonSexual => 'Jinsiy kontent';

  @override
  String get reportReasonHate => 'Nafrat so\'zlari';

  @override
  String get reportReasonIllegal => 'Noqonuniy kontent';

  @override
  String get reportReasonPrivacy => 'Maxfiylik buzilishi';

  @override
  String get reportReasonImpersonation =>
      'O\'zini boshqa kishi deb ko\'rsatish';

  @override
  String get reportReasonOther => 'Boshqa';

  @override
  String get reportDescription => 'Qo\'shimcha tafsilotlar (ixtiyoriy)';

  @override
  String get reportSubmit => 'Shikoyat yuborish';

  @override
  String get reportSuccess => 'Shikoyat muvaffaqiyatli yuborildi';

  @override
  String get reportAlreadyReported => 'Siz allaqachon shikoyat qilgansiz';

  @override
  String get blockUser => 'Foydalanuvchini bloklash';

  @override
  String blockUserConfirm(String name) {
    return '${name}ni bloklashni xohlaysizmi?';
  }

  @override
  String get blockUserDescription =>
      'Ushbu foydalanuvchidan xabarlar yoki do\'stlik so\'rovlarini olmaysiz.';

  @override
  String get block => 'Bloklash';

  @override
  String get unblock => 'Blokdan chiqarish';

  @override
  String get blockedUsers => 'Bloklangan foydalanuvchilar';

  @override
  String get noBlockedUsers => 'Bloklangan foydalanuvchilar yo\'q';

  @override
  String get userBlocked => 'Foydalanuvchi bloklandi';

  @override
  String get userUnblocked => 'Foydalanuvchi blokdan chiqarildi';

  @override
  String get universityVerification => 'Universitet tasdig\'i';

  @override
  String get studentIdVerification => 'Talaba guvohnomasi';

  @override
  String get emailVerification => 'Email tasdig\'i';

  @override
  String get uploadStudentId => 'Talaba guvohnomasini yuklash';

  @override
  String get selectImage => 'Rasm tanlash';

  @override
  String get takePhoto => 'Surat olish';

  @override
  String get chooseFromGallery => 'Galereyadan tanlash';

  @override
  String get submitVerification => 'Tasdig\'ga yuborish';

  @override
  String get verificationPending => 'Tasdig\'lanish ko\'rib chiqilmoqda';

  @override
  String get verificationApproved => 'Tasdig\'landi';

  @override
  String get schoolEmail => 'Universitet emaili';

  @override
  String get sendVerificationCode => 'Tasdig\'lash kodini yuborish';

  @override
  String get enterVerificationCode => 'Tasdig\'lash kodini kiriting';

  @override
  String get codeSent => 'Tasdig\'lash kodi emailingizga yuborildi';

  @override
  String get verificationSuccess => 'Email muvaffaqiyatli tasdiqlandi!';

  @override
  String get timeRemaining => 'Qolgan vaqt';

  @override
  String get deleteAccount => 'Hisobni o\'chirish';

  @override
  String get deleteAccountSubtitle => 'Hisobingizni butunlay o\'chirish';

  @override
  String get confirmDeleteAccount => 'Hisobingizni o\'chirishni xohlaysizmi?';

  @override
  String get deleteAccountWarning =>
      'Bu amalni qaytarib bo\'lmaydi. Barcha ma\'lumotlaringiz o\'chiriladi.';

  @override
  String get deleteAccountSuccess => 'Hisob muvaffaqiyatli o\'chirildi';

  @override
  String get deleteAccountFailed => 'Hisobni o\'chirib bo\'lmadi';
}
