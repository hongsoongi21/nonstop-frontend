// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get editPost => 'Edit Post';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get deletePost => 'Delete Post';

  @override
  String get confirmDeletePost => 'Are you sure you want to delete this post?';

  @override
  String get editComment => 'Edit Comment';

  @override
  String get deleteComment => 'Delete Comment';

  @override
  String get confirmDeleteComment =>
      'Are you sure you want to delete this comment?';

  @override
  String get universityVerificationRequired =>
      'University verification required';

  @override
  String get universityVerificationRequiredAccess =>
      'University verification required to access this community';

  @override
  String get title => 'Title';

  @override
  String get content => 'Content';

  @override
  String get selectCommunity => 'Select Community';
}
