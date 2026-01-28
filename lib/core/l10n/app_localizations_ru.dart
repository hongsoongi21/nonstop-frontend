// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

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
}
