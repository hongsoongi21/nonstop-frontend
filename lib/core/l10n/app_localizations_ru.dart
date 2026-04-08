// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get language => 'Язык';

  @override
  String get languageSubtitle => 'Выберите предпочитаемый язык';

  @override
  String get systemDefault => 'Системный язык';

  @override
  String loginSuccessWelcome(String nickname) {
    return 'Добро пожаловать, $nickname!';
  }

  @override
  String get helloWorld => 'Привет, мир!';

  @override
  String get editPost => 'Редактировать пост';

  @override
  String get cancel => 'Отмена';

  @override
  String get save => 'Сохранить';

  @override
  String get deletePost => 'Удалить пост';

  @override
  String get confirmDeletePost => 'Вы уверены, что хотите удалить этот пост?';

  @override
  String get editComment => 'Редактировать комментарий';

  @override
  String get deleteComment => 'Удалить комментарий';

  @override
  String get confirmDeleteComment =>
      'Вы уверены, что хотите удалить этот комментарий?';

  @override
  String get universityVerificationRequired =>
      'Требуется верификация университета';

  @override
  String get universityVerificationRequiredAccess =>
      'Для доступа к этому сообществу требуется верификация университета';

  @override
  String get title => 'Заголовок';

  @override
  String get content => 'Содержание';

  @override
  String get selectCommunity => 'Выбрать сообщество';

  @override
  String get chat => 'Чат';

  @override
  String get chatListEmpty => 'Пока нет чатов';

  @override
  String get chatListEmptyHint => 'Нажмите + чтобы начать разговор';

  @override
  String get chatLoadError => 'Не удалось загрузить чаты';

  @override
  String get searchChats => 'Поиск чатов...';

  @override
  String get newChat => 'Новый чат';

  @override
  String get searchUsers => 'Поиск пользователей...';

  @override
  String selectedCount(int count) {
    return '$count выбрано';
  }

  @override
  String get startChat => 'Начать чат';

  @override
  String get createGroup => 'Создать группу';

  @override
  String get groupName => 'Название группы';

  @override
  String get groupNameHint => 'Введите название группы';

  @override
  String get camera => 'Камера';

  @override
  String get gallery => 'Галерея';

  @override
  String get connectionConnected => 'Подключено';

  @override
  String get connectionConnecting => 'Подключение...';

  @override
  String get connectionDisconnected =>
      'Отключено - нажмите для переподключения';

  @override
  String get today => 'Сегодня';

  @override
  String get yesterday => 'Вчера';

  @override
  String get messageHint => 'Введите сообщение...';

  @override
  String get profile => 'Профиль';

  @override
  String get settings => 'Настройки';

  @override
  String get editProfile => 'Редактировать профиль';

  @override
  String get posts => 'Посты';

  @override
  String get comments => 'Комментарии';

  @override
  String get friends => 'Друзья';

  @override
  String get allPosts => 'Все посты';

  @override
  String get bookmarks => 'Закладки';

  @override
  String get favorites => 'Избранное';

  @override
  String get notifications => 'Уведомления';

  @override
  String get privacy => 'Приватность';

  @override
  String get account => 'Аккаунт';

  @override
  String get logout => 'Выйти';

  @override
  String get pushNotifications => 'Push-уведомления';

  @override
  String get pushNotificationsSubtitle =>
      'Получать push-уведомления на этом устройстве';

  @override
  String get emailNotifications => 'Email-уведомления';

  @override
  String get emailNotificationsSubtitle => 'Получать обновления по email';

  @override
  String get boardNotifications => 'Уведомления доски';

  @override
  String get boardNotificationsSubtitle => 'Новые посты и комментарии';

  @override
  String get chatNotifications => 'Уведомления чата';

  @override
  String get chatNotificationsSubtitle => 'Новые сообщения и ответы';

  @override
  String get timetableNotifications => 'Уведомления расписания';

  @override
  String get timetableNotificationsSubtitle =>
      'Напоминания о занятиях и обновления';

  @override
  String get soundNotifications => 'Звуковые уведомления';

  @override
  String get soundNotificationsSubtitle =>
      'Воспроизводить звук для уведомлений';

  @override
  String get allowFriendRequests => 'Разрешить запросы в друзья';

  @override
  String get allowFriendRequestsSubtitle =>
      'Позволить другим отправлять вам запросы в друзья';

  @override
  String get showOnlineStatus => 'Показывать онлайн статус';

  @override
  String get showOnlineStatusSubtitle =>
      'Позволить друзьям видеть когда вы онлайн';

  @override
  String get allowMessageRequests => 'Разрешить запросы сообщений';

  @override
  String get allowMessageRequestsSubtitle => 'Получать сообщения от не-друзей';

  @override
  String get showProfileToStrangers => 'Показывать профиль незнакомцам';

  @override
  String get showProfileToStrangersSubtitle =>
      'Сделать ваш профиль видимым для всех';

  @override
  String get logoutSubtitle => 'Выйти из аккаунта';

  @override
  String get confirmLogout => 'Вы уверены, что хотите выйти?';

  @override
  String get errorOccurred => 'Произошла ошибка';

  @override
  String get retry => 'Повторить';

  @override
  String get notificationsComingSoon => 'Уведомления - скоро!';

  @override
  String get editProfileComingSoon => 'Редактирование профиля - скоро!';

  @override
  String get searchComingSoon => 'Поиск - скоро!';

  @override
  String get filterPrefix => 'Фильтр: ';

  @override
  String get profileNotLoaded => 'Профиль не загружен';

  @override
  String get settingsNotLoaded => 'Настройки не загружены';

  @override
  String get postsLoadError => 'Не удалось загрузить посты';

  @override
  String get noPostsYet => 'Пока нет постов';

  @override
  String get markAllAsRead => 'Отметить все прочитанным';

  @override
  String get noNotificationsYet => 'Пока нет уведомлений';

  @override
  String get noNotificationsHint => 'Новые уведомления появятся здесь';

  @override
  String get notificationLoadError => 'Не удалось загрузить уведомления';

  @override
  String get justNow => 'Только что';

  @override
  String minutesAgo(int count) {
    return '$count минут назад';
  }

  @override
  String hoursAgo(int count) {
    return '$count часов назад';
  }

  @override
  String daysAgo(int count) {
    return '$count дней назад';
  }

  @override
  String get board => 'Форум';

  @override
  String get write => 'Написать';

  @override
  String get searchPosts => 'Поиск постов...';

  @override
  String get pleaseSelectBoardFirst => 'Пожалуйста, сначала выберите доску';

  @override
  String noPostsInBoard(String boardName) {
    return 'В $boardName пока нет постов';
  }

  @override
  String get beFirstToPost => 'Будьте первым, кто начнёт разговор!';

  @override
  String get createFirstPost => 'Создать первый пост';

  @override
  String get student => 'Студент';

  @override
  String get post => 'Опубликовать';

  @override
  String get edit => 'Изменить';

  @override
  String get delete => 'Удалить';

  @override
  String get anonymous => 'Аноним';

  @override
  String get replyingToComment => 'Ответ на комментарий';

  @override
  String get noCommentsYet => 'Пока нет комментариев';

  @override
  String get beFirstToComment => 'Поделитесь своим мнением первым';

  @override
  String get writeComment => 'Написать комментарий...';

  @override
  String get postAnonymously => 'Опубликовать анонимно';

  @override
  String get comment => 'Комментарий';

  @override
  String get like => 'Нравится';

  @override
  String get reply => 'Ответить';

  @override
  String get createPost => 'Создать пост';

  @override
  String get noBoardsAvailable =>
      'Нет доступных досок. Пожалуйста, сначала выберите сообщество.';

  @override
  String get writeClearTitle => 'Напишите чёткий и интересный заголовок...';

  @override
  String get pleaseEnterTitle => 'Введите заголовок';

  @override
  String get titleTooShort => 'Заголовок слишком короткий';

  @override
  String get shareYourThoughts => 'Поделитесь своими мыслями...';

  @override
  String get pleaseEnterContent => 'Введите содержание';

  @override
  String get pleaseSelectBoard => 'Выберите доску';

  @override
  String get hideIdentity => 'Скрыть вашу личность от других';

  @override
  String get secretPost => 'Секретный пост';

  @override
  String get onlyVisibleToAuthorized =>
      'Видно только авторизованным пользователям';

  @override
  String get login => 'Войти';

  @override
  String get email => 'Email';

  @override
  String get password => 'Пароль';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get welcomeBack => 'Добро пожаловать!';

  @override
  String get loginToContinue => 'Войдите, чтобы продолжить';

  @override
  String get continueWithGoogle => 'Продолжить с Google';

  @override
  String get continueWithApple => 'Продолжить с Apple';

  @override
  String appleSignInFailed(String error) {
    return 'Ошибка входа через Apple: $error';
  }

  @override
  String get appleSignInNotAvailable =>
      'Вход через Apple доступен только на iOS';

  @override
  String get orSocialMedia => 'Или через социальные сети';

  @override
  String get noAccount => 'Нет аккаунта?';

  @override
  String get signUpLink => 'Зарегистрироваться';

  @override
  String get validationEmailRequired => 'Введите email';

  @override
  String get validationEmailInvalid => 'Введите корректный email';

  @override
  String get validationPasswordRequired => 'Введите пароль';

  @override
  String get validationPasswordMin6 =>
      'Пароль должен содержать минимум 6 символов';

  @override
  String get validationPasswordMin8 =>
      'Пароль должен содержать минимум 8 символов';

  @override
  String googleSignInFailed(String error) {
    return 'Ошибка входа через Google: $error';
  }

  @override
  String get createAccount => 'Создать аккаунт';

  @override
  String get enterYourInfo => 'Введите вашу информацию';

  @override
  String get nickname => 'Никнейм';

  @override
  String get selectUniversity => 'Выберите университет';

  @override
  String get selectBirthDate => 'Выберите дату рождения';

  @override
  String get confirmPassword => 'Подтвердите пароль';

  @override
  String get agreeToAll => 'Согласен со всем';

  @override
  String get required => '[Обязательно]';

  @override
  String get optional => '[Опционально]';

  @override
  String get view => '[Просмотр]';

  @override
  String get haveAccount => 'Есть аккаунт?';

  @override
  String get loginLink => 'Войти';

  @override
  String get validationNicknameRequired => 'Введите никнейм';

  @override
  String get validationNickname2to20 =>
      'Никнейм должен содержать 2-20 символов';

  @override
  String get validationPasswordsNoMatch => 'Пароли не совпадают';

  @override
  String get validationConfirmPassword => 'Подтвердите пароль';

  @override
  String get send => 'Отправить';

  @override
  String get resend => 'Отправить снова';

  @override
  String get verify => 'Проверить';

  @override
  String get sixDigitCode => '6-значный код';

  @override
  String get emailVerified => 'Email подтвержден';

  @override
  String get oauthEmailVerified => 'Email подтвержден через социальную сеть';

  @override
  String get verificationCodeSent => 'Код подтверждения отправлен!';

  @override
  String get emailVerifiedSuccess => 'Email успешно подтвержден!';

  @override
  String get invalidCode => 'Неверный код';

  @override
  String get failedToSendCode => 'Не удалось отправить код';

  @override
  String get pleaseVerifyEmail => 'Пожалуйста, сначала подтвердите email';

  @override
  String get pleaseWaitPoliciesLoad => 'Подождите, идет загрузка политик';

  @override
  String get agreeMandatoryPolicies =>
      'Пожалуйста, согласитесь со всеми обязательными политиками';

  @override
  String get pleaseSelectUniversity => 'Пожалуйста, выберите университет';

  @override
  String get pleaseSelectBirthDate => 'Пожалуйста, выберите дату рождения';

  @override
  String get signupFailed => 'Регистрация не удалась';

  @override
  String couldNotLaunch(String url) {
    return 'Не удалось открыть $url';
  }

  @override
  String errorLaunchingUrl(String error) {
    return 'Ошибка открытия URL: $error';
  }

  @override
  String get selectYourBirthDate => 'Выберите дату рождения';

  @override
  String get noPoliciesAvailable => 'Политики недоступны';

  @override
  String get resetPassword => 'Сброс пароля';

  @override
  String get enterRegisteredEmail => 'Введите зарегистрированный email адрес';

  @override
  String get sendCode => 'Отправить код';

  @override
  String get verifyCode => 'Проверить код';

  @override
  String get codeVerified => 'Код подтвержден!';

  @override
  String get verificationCodeLabel => 'Код подтверждения';

  @override
  String get resendCode => 'Отправить код повторно';

  @override
  String get newPassword => 'Новый пароль';

  @override
  String get enterNewPassword => 'Введите новый пароль';

  @override
  String get updatePassword => 'Обновить пароль';

  @override
  String get success => 'Успешно!';

  @override
  String get passwordChangedSuccess =>
      'Ваш пароль успешно изменен. Теперь вы можете войти с новым паролем.';

  @override
  String get stepEmail => 'Email';

  @override
  String get stepVerification => 'Проверка';

  @override
  String get stepNewPassword => 'Новый пароль';

  @override
  String get validationEnterEmail => 'Введите email';

  @override
  String get validationEnterValidEmail => 'Введите корректный email';

  @override
  String get validationEnterCode => 'Введите код';

  @override
  String get validationCodeMinLength => 'Код должен содержать минимум 4 цифры';

  @override
  String get validationEnterPassword => 'Введите пароль';

  @override
  String get validationPasswordMinLength =>
      'Пароль должен содержать минимум 8 символов';

  @override
  String get validationConfirmNewPassword => 'Подтвердите пароль';

  @override
  String get codeResent => 'Код отправлен повторно!';

  @override
  String get friendsTitle => 'Друзья';

  @override
  String get requests => 'Полученные';

  @override
  String get search => 'Поиск';

  @override
  String get noFriendsYet => 'Пока нет друзей';

  @override
  String get addFriendsViaSearch => 'Добавьте друзей через поиск';

  @override
  String get friend => 'Друг';

  @override
  String get sent => 'Отправлено';

  @override
  String get accept => 'Принять';

  @override
  String get reject => 'Отклонить';

  @override
  String get removeFriend => 'Удалить из друзей';

  @override
  String confirmRemoveFriend(String name) {
    return 'Вы уверены, что хотите удалить $name из друзей?';
  }

  @override
  String get remove => 'Удалить';

  @override
  String get noRequests => 'Нет запросов';

  @override
  String get requestsAppearHere => 'Запросы в друзья появятся здесь';

  @override
  String get searchUsersHint => 'Поиск пользователей...';

  @override
  String get startSearching => 'Начать поиск';

  @override
  String get typeInSearchBar => 'Введите в строке поиска выше';

  @override
  String get noResults => 'Нет результатов';

  @override
  String get tryDifferentName => 'Попробуйте другое имя';

  @override
  String get keepTyping => 'Продолжайте ввод';

  @override
  String get minTwoCharacters => 'Введите минимум 2 символа для поиска';

  @override
  String get online => 'Онлайн';

  @override
  String get offline => 'Оффлайн';

  @override
  String get friendRequestSent => 'Запрос в друзья отправлен';

  @override
  String get friendRequestAccepted => 'Запрос в друзья принят';

  @override
  String get requestRejected => 'Запрос отклонен';

  @override
  String get removedFromFriends => 'Удалено из друзей';

  @override
  String get addFriend => 'Добавить';

  @override
  String get timetable => 'Расписание';

  @override
  String get addCourse => 'Добавить предмет';

  @override
  String get editCourse => 'Редактировать предмет';

  @override
  String get dayMonday => 'Понедельник';

  @override
  String get dayTuesday => 'Вторник';

  @override
  String get dayWednesday => 'Среда';

  @override
  String get dayThursday => 'Четверг';

  @override
  String get dayFriday => 'Пятница';

  @override
  String get daySaturday => 'Суббота';

  @override
  String get daySunday => 'Воскресенье';

  @override
  String get dayMondayShort => 'ПН';

  @override
  String get dayTuesdayShort => 'ВТ';

  @override
  String get dayWednesdayShort => 'СР';

  @override
  String get dayThursdayShort => 'ЧТ';

  @override
  String get dayFridayShort => 'ПТ';

  @override
  String get daySaturdayShort => 'СБ';

  @override
  String get daySundayShort => 'ВС';

  @override
  String get semester => 'Семестр';

  @override
  String get semesterSpring => 'Весна';

  @override
  String get semesterFall => 'Осень';

  @override
  String get semesterSummer => 'Лето';

  @override
  String get semesterWinter => 'Зима';

  @override
  String get gpaCalculator => 'Калькулятор GPA';

  @override
  String get creditHours => 'Кредитные часы';

  @override
  String get credits => 'кредиты';

  @override
  String get calculateAndTrack => 'Рассчитать и отслеживать';

  @override
  String get courseName => 'Название предмета';

  @override
  String get courseNameHint => 'Например: Основы программирования';

  @override
  String get courseNameRequired => 'Введите название предмета';

  @override
  String get professor => 'Преподаватель';

  @override
  String get professorHint => 'Например: Проф. Ким';

  @override
  String get room => 'Аудитория / Место';

  @override
  String get roomHint => 'Например: Аудитория 301';

  @override
  String get color => 'Цвет';

  @override
  String get colorDescription => 'Выберите цвет для выделения предмета';

  @override
  String get startTime => 'Время начала';

  @override
  String get endTime => 'Время окончания';

  @override
  String get selectDay => 'Выберите день';

  @override
  String get dayOfWeek => 'День недели';

  @override
  String get timeAndDay => 'Время и день';

  @override
  String get basicInfo => 'Основная информация';

  @override
  String get deleteCourse => 'Удалить предмет';

  @override
  String get confirmDeleteCourse =>
      'Вы уверены, что хотите удалить этот предмет?';

  @override
  String get courseDeleted => 'Предмет удален';

  @override
  String get courseAdded => 'Предмет успешно добавлен';

  @override
  String get courseUpdated => 'Предмет обновлен';

  @override
  String get saveChanges => 'Сохранить изменения';

  @override
  String get noCoursesAdded => 'Предметы не добавлены';

  @override
  String get noCoursesDescription =>
      'Добавьте предметы для создания\nнедельного расписания';

  @override
  String get loading => 'Загрузка...';

  @override
  String get refresh => 'Обновить';

  @override
  String get myTimetables => 'Мои расписания';

  @override
  String get createNewTimetable => 'Создать новое расписание';

  @override
  String get untitledTimetable => 'Расписание без названия';

  @override
  String get newCourse => 'НОВЫЙ ПРЕДМЕТ';

  @override
  String get editCourseTitle => 'РЕДАКТИРОВАТЬ';

  @override
  String get createNewCourse => 'Создайте новый предмет для расписания';

  @override
  String get updateCourseInfo => 'Обновите информацию о предмете';

  @override
  String get conflict => 'КОНФЛИКТ';

  @override
  String get confirmNewPassword => 'Подтвердите новый пароль';

  @override
  String get birthDate => 'Дата рождения';

  @override
  String get report => 'Жалоба';

  @override
  String get reportReason => 'Выберите причину жалобы';

  @override
  String get reportReasonSpam => 'Спам/Неуместная реклама';

  @override
  String get reportReasonAbuse => 'Оскорбления/Ругательства';

  @override
  String get reportReasonSexual => 'Сексуальный контент';

  @override
  String get reportReasonHate => 'Разжигание ненависти';

  @override
  String get reportReasonIllegal => 'Незаконный контент';

  @override
  String get reportReasonPrivacy => 'Нарушение конфиденциальности';

  @override
  String get reportReasonImpersonation => 'Выдача себя за другого';

  @override
  String get reportReasonOther => 'Другое';

  @override
  String get reportDescription => 'Дополнительные детали (необязательно)';

  @override
  String get reportSubmit => 'Отправить жалобу';

  @override
  String get reportSuccess => 'Жалоба успешно отправлена';

  @override
  String get reportAlreadyReported => 'Вы уже отправили жалобу';

  @override
  String get blockUser => 'Заблокировать пользователя';

  @override
  String blockUserConfirm(String name) {
    return 'Вы уверены, что хотите заблокировать $name?';
  }

  @override
  String get blockUserDescription =>
      'Вы больше не будете получать сообщения или запросы в друзья от этого пользователя.';

  @override
  String get block => 'Заблокировать';

  @override
  String get unblock => 'Разблокировать';

  @override
  String get blockedUsers => 'Заблокированные пользователи';

  @override
  String get noBlockedUsers => 'Нет заблокированных пользователей';

  @override
  String get userBlocked => 'Пользователь заблокирован';

  @override
  String get userUnblocked => 'Пользователь разблокирован';

  @override
  String get universityVerification => 'Верификация университета';

  @override
  String get studentIdVerification => 'Студенческий билет';

  @override
  String get emailVerification => 'Верификация email';

  @override
  String get uploadStudentId => 'Загрузить студенческий билет';

  @override
  String get selectImage => 'Выбрать изображение';

  @override
  String get takePhoto => 'Сделать фото';

  @override
  String get chooseFromGallery => 'Выбрать из галереи';

  @override
  String get submitVerification => 'Отправить на верификацию';

  @override
  String get verificationPending => 'Верификация находится на рассмотрении';

  @override
  String get verificationApproved => 'Верификация одобрена';

  @override
  String get schoolEmail => 'Университетская почта';

  @override
  String get sendVerificationCode => 'Отправить код верификации';

  @override
  String get enterVerificationCode => 'Введите код верификации';

  @override
  String get codeSent => 'Код верификации отправлен на вашу почту';

  @override
  String get verificationSuccess => 'Email успешно верифицирован!';

  @override
  String get timeRemaining => 'Осталось времени';

  @override
  String get deleteAccount => 'Удалить аккаунт';

  @override
  String get deleteAccountSubtitle => 'Навсегда удалить аккаунт';

  @override
  String get confirmDeleteAccount => 'Вы уверены, что хотите удалить аккаунт?';

  @override
  String get deleteAccountWarning =>
      'Это действие нельзя отменить. Все ваши данные будут удалены.';

  @override
  String get deleteAccountSuccess => 'Аккаунт успешно удален';

  @override
  String get deleteAccountFailed => 'Не удалось удалить аккаунт';

  @override
  String get leaveRoom => 'Выйти из чата';

  @override
  String get leaveRoomConfirm =>
      'Вы уверены, что хотите выйти из этого чата? Вы больше не будете получать сообщения из этого разговора.';

  @override
  String get leaveRoomSuccess => 'Вы покинули чат';

  @override
  String get latest => 'Новые';

  @override
  String get trending => 'Популярные';

  @override
  String get mostCommented => 'Обсуждаемые';

  @override
  String get completeProfile => 'Заполнить профиль';

  @override
  String get completeProfileSubtitle =>
      'Пожалуйста, заполните необходимую информацию';

  @override
  String get introduction => 'О себе';

  @override
  String get introductionHint => 'Расскажите о себе...';

  @override
  String get major => 'Специальность';

  @override
  String get majorHint => 'напр. Информатика';

  @override
  String get changePhoto => 'Изменить фото';

  @override
  String get profileUpdated => 'Профиль успешно обновлён';

  @override
  String get profileUpdateFailed => 'Не удалось обновить профиль';

  @override
  String get avatarUploadFailed => 'Не удалось загрузить аватар';

  @override
  String get selectImageSource => 'Выберите источник изображения';

  @override
  String get introductionMaxLength =>
      'О себе должно быть не более 200 символов';

  @override
  String get sentRequests => 'Отправленные запросы';

  @override
  String get cancelRequest => 'Отменить запрос';

  @override
  String get requestCancelled => 'Запрос отменён';

  @override
  String get alreadyRequested => 'Запрос уже отправлен';

  @override
  String get legal => 'Правовая информация';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get termsOfService => 'Условия использования';

  @override
  String get policyTermsOfService => 'Условия использования';

  @override
  String get policyPrivacyPolicy => 'Политика конфиденциальности';

  @override
  String get policyMarketing => 'Маркетинговые уведомления';

  @override
  String get policyUnknown => 'Политика';

  @override
  String get academicYear => 'Учебный год';

  @override
  String get attachImage => 'Прикрепить изображение';

  @override
  String get boardNameRequired => 'Введите название доски';

  @override
  String get chatAction => 'Чат';

  @override
  String confirmDeleteTimetable(String name) {
    return 'Удалить \"$name\"?';
  }

  @override
  String get continueText => 'Продолжить';

  @override
  String get coursesImportedFromTimetable =>
      'Курсы импортированы из расписания';

  @override
  String get createButton => 'Создать';

  @override
  String get createTimetable => 'Создать новое расписание';

  @override
  String get deleteTimetable => 'Удалить расписание';

  @override
  String get enterSchoolEmail => 'Введите электронную почту университета';

  @override
  String get errorLoadingPolicies => 'Не удалось загрузить политики';

  @override
  String get majorSubject => 'Профильный предмет';

  @override
  String get noMessagesYet => 'Сообщений пока нет';

  @override
  String get noSentRequests => 'Нет отправленных запросов';

  @override
  String get noUniversitiesFound => 'Университеты не найдены';

  @override
  String timetableCreated(String name) {
    return 'Расписание \"$name\" создано';
  }

  @override
  String get timetableName => 'Название расписания';

  @override
  String get uploading => 'Загрузка...';
}
