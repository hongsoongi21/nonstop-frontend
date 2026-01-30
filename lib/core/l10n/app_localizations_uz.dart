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
}
