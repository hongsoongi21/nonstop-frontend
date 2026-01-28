import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uz.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ko'),
    Locale('ru'),
    Locale('uz'),
  ];

  /// The conventional newborn programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Hello World!'**
  String get helloWorld;

  /// Button text for editing a post
  ///
  /// In en, this message translates to:
  /// **'Edit Post'**
  String get editPost;

  /// Button text for canceling an action
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Button text for saving changes
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Button text for deleting a post
  ///
  /// In en, this message translates to:
  /// **'Delete Post'**
  String get deletePost;

  /// Confirmation message for deleting a post
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this post?'**
  String get confirmDeletePost;

  /// Button text for editing a comment
  ///
  /// In en, this message translates to:
  /// **'Edit Comment'**
  String get editComment;

  /// Button text for deleting a comment
  ///
  /// In en, this message translates to:
  /// **'Delete Comment'**
  String get deleteComment;

  /// Confirmation message for deleting a comment
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this comment?'**
  String get confirmDeleteComment;

  /// Message indicating university verification is needed
  ///
  /// In en, this message translates to:
  /// **'University verification required'**
  String get universityVerificationRequired;

  /// Message for community access requiring university verification
  ///
  /// In en, this message translates to:
  /// **'University verification required to access this community'**
  String get universityVerificationRequiredAccess;

  /// Label for title field
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// Label for content field
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get content;

  /// Title for community selection modal
  ///
  /// In en, this message translates to:
  /// **'Select Community'**
  String get selectCommunity;

  /// Chat screen title
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// Message when chat list is empty
  ///
  /// In en, this message translates to:
  /// **'No conversations yet'**
  String get chatListEmpty;

  /// Hint for empty chat list
  ///
  /// In en, this message translates to:
  /// **'Tap + to start a conversation'**
  String get chatListEmptyHint;

  /// Error message when chat list fails to load
  ///
  /// In en, this message translates to:
  /// **'Failed to load conversations'**
  String get chatLoadError;

  /// Title for new chat sheet
  ///
  /// In en, this message translates to:
  /// **'New Chat'**
  String get newChat;

  /// Placeholder for user search
  ///
  /// In en, this message translates to:
  /// **'Search users...'**
  String get searchUsers;

  /// Shows number of selected users
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String selectedCount(int count);

  /// Button to start a chat
  ///
  /// In en, this message translates to:
  /// **'Start Chat'**
  String get startChat;

  /// Button to create a group
  ///
  /// In en, this message translates to:
  /// **'Create Group'**
  String get createGroup;

  /// Label for group name
  ///
  /// In en, this message translates to:
  /// **'Group Name'**
  String get groupName;

  /// Placeholder for group name input
  ///
  /// In en, this message translates to:
  /// **'Enter group name'**
  String get groupNameHint;

  /// Camera option label
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// Gallery option label
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// Connection status connected
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connectionConnected;

  /// Connection status connecting
  ///
  /// In en, this message translates to:
  /// **'Connecting...'**
  String get connectionConnecting;

  /// Connection status disconnected
  ///
  /// In en, this message translates to:
  /// **'Disconnected - Tap to reconnect'**
  String get connectionDisconnected;

  /// Today label for date separator
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// Yesterday label for date separator
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// Placeholder for message input
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get messageHint;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ko', 'ru', 'uz'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ko':
      return AppLocalizationsKo();
    case 'ru':
      return AppLocalizationsRu();
    case 'uz':
      return AppLocalizationsUz();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
