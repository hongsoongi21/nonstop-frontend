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
}
