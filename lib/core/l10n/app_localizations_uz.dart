// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class AppLocalizationsUz extends AppLocalizations {
  AppLocalizationsUz([String locale = 'uz']) : super(locale);

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
  String get selectCommunity => 'Select Community';
}
