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

  /// Save button label
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

  /// Placeholder for chat search
  ///
  /// In en, this message translates to:
  /// **'Search chats...'**
  String get searchChats;

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

  /// Profile screen title
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Settings screen title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Edit profile button text
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// Posts stat label
  ///
  /// In en, this message translates to:
  /// **'Posts'**
  String get posts;

  /// Comments stat label
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get comments;

  /// Friends stat label
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get friends;

  /// All posts filter tab
  ///
  /// In en, this message translates to:
  /// **'All Posts'**
  String get allPosts;

  /// Bookmarks filter tab
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get bookmarks;

  /// Favorites filter tab
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// Notifications section header
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// Privacy section header
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// Account section header
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// Logout button text
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Push notifications setting title
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get pushNotifications;

  /// Push notifications setting subtitle
  ///
  /// In en, this message translates to:
  /// **'Receive push notifications on this device'**
  String get pushNotificationsSubtitle;

  /// Email notifications setting title
  ///
  /// In en, this message translates to:
  /// **'Email Notifications'**
  String get emailNotifications;

  /// Email notifications setting subtitle
  ///
  /// In en, this message translates to:
  /// **'Get updates via email'**
  String get emailNotificationsSubtitle;

  /// Board notifications setting title
  ///
  /// In en, this message translates to:
  /// **'Board Notifications'**
  String get boardNotifications;

  /// Board notifications setting subtitle
  ///
  /// In en, this message translates to:
  /// **'New posts and comments'**
  String get boardNotificationsSubtitle;

  /// Chat notifications setting title
  ///
  /// In en, this message translates to:
  /// **'Chat Notifications'**
  String get chatNotifications;

  /// Chat notifications setting subtitle
  ///
  /// In en, this message translates to:
  /// **'New messages and replies'**
  String get chatNotificationsSubtitle;

  /// Timetable notifications setting title
  ///
  /// In en, this message translates to:
  /// **'Timetable Notifications'**
  String get timetableNotifications;

  /// Timetable notifications setting subtitle
  ///
  /// In en, this message translates to:
  /// **'Class reminders and updates'**
  String get timetableNotificationsSubtitle;

  /// Sound notifications setting title
  ///
  /// In en, this message translates to:
  /// **'Sound Notifications'**
  String get soundNotifications;

  /// Sound notifications setting subtitle
  ///
  /// In en, this message translates to:
  /// **'Play sound for notifications'**
  String get soundNotificationsSubtitle;

  /// Allow friend requests setting title
  ///
  /// In en, this message translates to:
  /// **'Allow Friend Requests'**
  String get allowFriendRequests;

  /// Allow friend requests setting subtitle
  ///
  /// In en, this message translates to:
  /// **'Let others send you friend requests'**
  String get allowFriendRequestsSubtitle;

  /// Show online status setting title
  ///
  /// In en, this message translates to:
  /// **'Show Online Status'**
  String get showOnlineStatus;

  /// Show online status setting subtitle
  ///
  /// In en, this message translates to:
  /// **'Let friends see when you\'re online'**
  String get showOnlineStatusSubtitle;

  /// Allow message requests setting title
  ///
  /// In en, this message translates to:
  /// **'Allow Message Requests'**
  String get allowMessageRequests;

  /// Allow message requests setting subtitle
  ///
  /// In en, this message translates to:
  /// **'Receive messages from non-friends'**
  String get allowMessageRequestsSubtitle;

  /// Show profile to strangers setting title
  ///
  /// In en, this message translates to:
  /// **'Show Profile to Strangers'**
  String get showProfileToStrangers;

  /// Show profile to strangers setting subtitle
  ///
  /// In en, this message translates to:
  /// **'Make your profile visible to everyone'**
  String get showProfileToStrangersSubtitle;

  /// Logout subtitle
  ///
  /// In en, this message translates to:
  /// **'Sign out of your account'**
  String get logoutSubtitle;

  /// Logout confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get confirmLogout;

  /// Error occurred message
  ///
  /// In en, this message translates to:
  /// **'Error occurred'**
  String get errorOccurred;

  /// Retry button text
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Notifications coming soon message
  ///
  /// In en, this message translates to:
  /// **'Notifications - coming soon!'**
  String get notificationsComingSoon;

  /// Edit profile coming soon message
  ///
  /// In en, this message translates to:
  /// **'Edit Profile - coming soon!'**
  String get editProfileComingSoon;

  /// Filter prefix for filter tab change
  ///
  /// In en, this message translates to:
  /// **'Filter: '**
  String get filterPrefix;

  /// Profile not loaded message
  ///
  /// In en, this message translates to:
  /// **'Profile information not loaded'**
  String get profileNotLoaded;

  /// Settings not loaded message
  ///
  /// In en, this message translates to:
  /// **'Settings not loaded'**
  String get settingsNotLoaded;

  /// Posts load error message
  ///
  /// In en, this message translates to:
  /// **'Failed to load posts'**
  String get postsLoadError;

  /// No posts message
  ///
  /// In en, this message translates to:
  /// **'No posts yet'**
  String get noPostsYet;

  /// Button to mark all notifications as read
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get markAllAsRead;

  /// Empty state title for notifications
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get noNotificationsYet;

  /// Empty state hint for notifications
  ///
  /// In en, this message translates to:
  /// **'New notifications will appear here'**
  String get noNotificationsHint;

  /// Error message when notifications fail to load
  ///
  /// In en, this message translates to:
  /// **'Failed to load notifications'**
  String get notificationLoadError;

  /// Time label for notifications less than 1 minute old
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// Time label for notifications in minutes
  ///
  /// In en, this message translates to:
  /// **'{count} minutes ago'**
  String minutesAgo(int count);

  /// Time label for notifications in hours
  ///
  /// In en, this message translates to:
  /// **'{count} hours ago'**
  String hoursAgo(int count);

  /// Time label for notifications in days
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String daysAgo(int count);

  /// Board screen title
  ///
  /// In en, this message translates to:
  /// **'Board'**
  String get board;

  /// Write button text
  ///
  /// In en, this message translates to:
  /// **'Write'**
  String get write;

  /// Search posts placeholder
  ///
  /// In en, this message translates to:
  /// **'Search posts...'**
  String get searchPosts;

  /// Message when no board is selected
  ///
  /// In en, this message translates to:
  /// **'Please select a board first'**
  String get pleaseSelectBoardFirst;

  /// Empty state message for no posts in board
  ///
  /// In en, this message translates to:
  /// **'No posts in {boardName} yet'**
  String noPostsInBoard(String boardName);

  /// Empty state encouragement message
  ///
  /// In en, this message translates to:
  /// **'Be the first to start a conversation!'**
  String get beFirstToPost;

  /// Button to create first post
  ///
  /// In en, this message translates to:
  /// **'Create First Post'**
  String get createFirstPost;

  /// Student badge label
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get student;

  /// Post label/button
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get post;

  /// Edit button text
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Delete button text
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Anonymous user label
  ///
  /// In en, this message translates to:
  /// **'Anonymous'**
  String get anonymous;

  /// Label when replying to a comment
  ///
  /// In en, this message translates to:
  /// **'Replying to comment'**
  String get replyingToComment;

  /// Empty state for no comments
  ///
  /// In en, this message translates to:
  /// **'No comments yet'**
  String get noCommentsYet;

  /// Empty state encouragement for comments
  ///
  /// In en, this message translates to:
  /// **'Be the first to share your thoughts'**
  String get beFirstToComment;

  /// Comment input placeholder
  ///
  /// In en, this message translates to:
  /// **'Write a comment...'**
  String get writeComment;

  /// Anonymous posting option
  ///
  /// In en, this message translates to:
  /// **'Post Anonymously'**
  String get postAnonymously;

  /// Comment button label
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// Like button label
  ///
  /// In en, this message translates to:
  /// **'Like'**
  String get like;

  /// Reply button label
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get reply;

  /// Create post screen title
  ///
  /// In en, this message translates to:
  /// **'Create Post'**
  String get createPost;

  /// Message when no boards are available
  ///
  /// In en, this message translates to:
  /// **'No boards available. Please select a community first.'**
  String get noBoardsAvailable;

  /// Title field placeholder
  ///
  /// In en, this message translates to:
  /// **'Write a clear, engaging title...'**
  String get writeClearTitle;

  /// Title validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter a title'**
  String get pleaseEnterTitle;

  /// Title length validation error
  ///
  /// In en, this message translates to:
  /// **'Title is too short'**
  String get titleTooShort;

  /// Content field placeholder
  ///
  /// In en, this message translates to:
  /// **'Share your thoughts...'**
  String get shareYourThoughts;

  /// Content validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter some content'**
  String get pleaseEnterContent;

  /// Board selection error message
  ///
  /// In en, this message translates to:
  /// **'Please select a board'**
  String get pleaseSelectBoard;

  /// Anonymous posting description
  ///
  /// In en, this message translates to:
  /// **'Hide your identity from others'**
  String get hideIdentity;

  /// Secret post option
  ///
  /// In en, this message translates to:
  /// **'Secret Post'**
  String get secretPost;

  /// Secret post description
  ///
  /// In en, this message translates to:
  /// **'Only visible to authorized users'**
  String get onlyVisibleToAuthorized;

  /// login label/message
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// email label/message
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// password label/message
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// forgotPassword label/message
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// welcomeBack label/message
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get welcomeBack;

  /// loginToContinue label/message
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get loginToContinue;

  /// continueWithGoogle label/message
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// continueWithApple label/message
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continueWithApple;

  /// appleSignInFailed with placeholders
  ///
  /// In en, this message translates to:
  /// **'Apple Sign-In failed: {error}'**
  String appleSignInFailed(String error);

  /// appleSignInNotAvailable message
  ///
  /// In en, this message translates to:
  /// **'Apple Sign-In is only available on iOS'**
  String get appleSignInNotAvailable;

  /// orSocialMedia label/message
  ///
  /// In en, this message translates to:
  /// **'Or via social networks'**
  String get orSocialMedia;

  /// noAccount label/message
  ///
  /// In en, this message translates to:
  /// **'No account?'**
  String get noAccount;

  /// signUpLink label/message
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpLink;

  /// validationEmailRequired label/message
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get validationEmailRequired;

  /// validationEmailInvalid label/message
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get validationEmailInvalid;

  /// validationPasswordRequired label/message
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get validationPasswordRequired;

  /// validationPasswordMin6 label/message
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get validationPasswordMin6;

  /// validationPasswordMin8 label/message
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get validationPasswordMin8;

  /// googleSignInFailed with placeholders
  ///
  /// In en, this message translates to:
  /// **'Google Sign-In failed: {error}'**
  String googleSignInFailed(String error);

  /// createAccount label/message
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// enterYourInfo label/message
  ///
  /// In en, this message translates to:
  /// **'Enter your information'**
  String get enterYourInfo;

  /// nickname label/message
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get nickname;

  /// selectUniversity label/message
  ///
  /// In en, this message translates to:
  /// **'Select University'**
  String get selectUniversity;

  /// selectBirthDate label/message
  ///
  /// In en, this message translates to:
  /// **'Select Birth Date'**
  String get selectBirthDate;

  /// confirmPassword label/message
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// agreeToAll label/message
  ///
  /// In en, this message translates to:
  /// **'Agree to all'**
  String get agreeToAll;

  /// required label/message
  ///
  /// In en, this message translates to:
  /// **'[Required]'**
  String get required;

  /// optional label/message
  ///
  /// In en, this message translates to:
  /// **'[Optional]'**
  String get optional;

  /// view label/message
  ///
  /// In en, this message translates to:
  /// **'[View]'**
  String get view;

  /// haveAccount label/message
  ///
  /// In en, this message translates to:
  /// **'Have an account?'**
  String get haveAccount;

  /// loginLink label/message
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginLink;

  /// validationNicknameRequired label/message
  ///
  /// In en, this message translates to:
  /// **'Please enter your nickname'**
  String get validationNicknameRequired;

  /// validationNickname2to20 label/message
  ///
  /// In en, this message translates to:
  /// **'Nickname must be 2-20 characters'**
  String get validationNickname2to20;

  /// validationPasswordsNoMatch label/message
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get validationPasswordsNoMatch;

  /// validationConfirmPassword label/message
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get validationConfirmPassword;

  /// send label/message
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// resend label/message
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// verify label/message
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// sixDigitCode label/message
  ///
  /// In en, this message translates to:
  /// **'6-digit code'**
  String get sixDigitCode;

  /// emailVerified label/message
  ///
  /// In en, this message translates to:
  /// **'Email verified'**
  String get emailVerified;

  /// verificationCodeSent label/message
  ///
  /// In en, this message translates to:
  /// **'Verification code sent!'**
  String get verificationCodeSent;

  /// emailVerifiedSuccess label/message
  ///
  /// In en, this message translates to:
  /// **'Email verified successfully!'**
  String get emailVerifiedSuccess;

  /// invalidCode label/message
  ///
  /// In en, this message translates to:
  /// **'Invalid code'**
  String get invalidCode;

  /// failedToSendCode label/message
  ///
  /// In en, this message translates to:
  /// **'Failed to send code'**
  String get failedToSendCode;

  /// pleaseVerifyEmail label/message
  ///
  /// In en, this message translates to:
  /// **'Please verify your email first'**
  String get pleaseVerifyEmail;

  /// pleaseWaitPoliciesLoad label/message
  ///
  /// In en, this message translates to:
  /// **'Please wait for policies to load'**
  String get pleaseWaitPoliciesLoad;

  /// agreeMandatoryPolicies label/message
  ///
  /// In en, this message translates to:
  /// **'Please agree to all mandatory policies'**
  String get agreeMandatoryPolicies;

  /// pleaseSelectUniversity label/message
  ///
  /// In en, this message translates to:
  /// **'Please select a university'**
  String get pleaseSelectUniversity;

  /// pleaseSelectBirthDate label/message
  ///
  /// In en, this message translates to:
  /// **'Please select your birth date'**
  String get pleaseSelectBirthDate;

  /// signupFailed label/message
  ///
  /// In en, this message translates to:
  /// **'Sign up failed'**
  String get signupFailed;

  /// couldNotLaunch with placeholders
  ///
  /// In en, this message translates to:
  /// **'Could not launch {url}'**
  String couldNotLaunch(String url);

  /// errorLaunchingUrl with placeholders
  ///
  /// In en, this message translates to:
  /// **'Error launching URL: {error}'**
  String errorLaunchingUrl(String error);

  /// selectYourBirthDate label/message
  ///
  /// In en, this message translates to:
  /// **'Select your birth date'**
  String get selectYourBirthDate;

  /// noPoliciesAvailable label/message
  ///
  /// In en, this message translates to:
  /// **'No policies available'**
  String get noPoliciesAvailable;

  /// resetPassword label/message
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// enterRegisteredEmail label/message
  ///
  /// In en, this message translates to:
  /// **'Enter your registered email address'**
  String get enterRegisteredEmail;

  /// sendCode label/message
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get sendCode;

  /// verifyCode label/message
  ///
  /// In en, this message translates to:
  /// **'Verify Code'**
  String get verifyCode;

  /// codeVerified label/message
  ///
  /// In en, this message translates to:
  /// **'Code verified!'**
  String get codeVerified;

  /// verificationCodeLabel label/message
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get verificationCodeLabel;

  /// resendCode label/message
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resendCode;

  /// newPassword label/message
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// enterNewPassword label/message
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get enterNewPassword;

  /// updatePassword label/message
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePassword;

  /// success label/message
  ///
  /// In en, this message translates to:
  /// **'Success!'**
  String get success;

  /// passwordChangedSuccess label/message
  ///
  /// In en, this message translates to:
  /// **'Your password has been successfully changed. You can now login with your new password.'**
  String get passwordChangedSuccess;

  /// stepEmail label/message
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get stepEmail;

  /// stepVerification label/message
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get stepVerification;

  /// stepNewPassword label/message
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get stepNewPassword;

  /// validationEnterEmail label/message
  ///
  /// In en, this message translates to:
  /// **'Enter email'**
  String get validationEnterEmail;

  /// validationEnterValidEmail label/message
  ///
  /// In en, this message translates to:
  /// **'Enter valid email'**
  String get validationEnterValidEmail;

  /// validationEnterCode label/message
  ///
  /// In en, this message translates to:
  /// **'Enter code'**
  String get validationEnterCode;

  /// validationCodeMinLength label/message
  ///
  /// In en, this message translates to:
  /// **'Code must be at least 4 digits'**
  String get validationCodeMinLength;

  /// validationEnterPassword label/message
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get validationEnterPassword;

  /// validationPasswordMinLength label/message
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get validationPasswordMinLength;

  /// validationConfirmNewPassword label/message
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get validationConfirmNewPassword;

  /// codeResent label/message
  ///
  /// In en, this message translates to:
  /// **'Code resent!'**
  String get codeResent;

  /// Friends screen title
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get friendsTitle;

  /// Friend requests tab label
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get requests;

  /// Search tab label
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Empty state title when user has no friends
  ///
  /// In en, this message translates to:
  /// **'No friends yet'**
  String get noFriendsYet;

  /// Empty state subtitle for no friends
  ///
  /// In en, this message translates to:
  /// **'Add friends via search'**
  String get addFriendsViaSearch;

  /// Friend status label
  ///
  /// In en, this message translates to:
  /// **'Friend'**
  String get friend;

  /// Friend request sent status label
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get sent;

  /// Accept friend request button
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// Reject friend request button
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// Remove friend menu option
  ///
  /// In en, this message translates to:
  /// **'Remove Friend'**
  String get removeFriend;

  /// Confirmation message for removing friend
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove {name}?'**
  String confirmRemoveFriend(String name);

  /// Remove button
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// Empty state title when there are no friend requests
  ///
  /// In en, this message translates to:
  /// **'No requests'**
  String get noRequests;

  /// Empty state subtitle for no requests
  ///
  /// In en, this message translates to:
  /// **'Friend requests appear here'**
  String get requestsAppearHere;

  /// Search input placeholder
  ///
  /// In en, this message translates to:
  /// **'Search users...'**
  String get searchUsersHint;

  /// Empty state title for search
  ///
  /// In en, this message translates to:
  /// **'Start searching'**
  String get startSearching;

  /// Empty state subtitle for search
  ///
  /// In en, this message translates to:
  /// **'Type in the search bar above'**
  String get typeInSearchBar;

  /// Empty state title when search returns no results
  ///
  /// In en, this message translates to:
  /// **'No results'**
  String get noResults;

  /// Empty state subtitle for no search results
  ///
  /// In en, this message translates to:
  /// **'Try a different name'**
  String get tryDifferentName;

  /// Online status label
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// Offline status label
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// Success message after sending friend request
  ///
  /// In en, this message translates to:
  /// **'Friend request sent'**
  String get friendRequestSent;

  /// Success message after accepting friend request
  ///
  /// In en, this message translates to:
  /// **'Friend request accepted'**
  String get friendRequestAccepted;

  /// Success message after rejecting friend request
  ///
  /// In en, this message translates to:
  /// **'Request rejected'**
  String get requestRejected;

  /// Success message after removing friend
  ///
  /// In en, this message translates to:
  /// **'Removed from friends'**
  String get removedFromFriends;

  /// Add friend button
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addFriend;

  /// Timetable screen title
  ///
  /// In en, this message translates to:
  /// **'Timetable'**
  String get timetable;

  /// Button text for adding a course
  ///
  /// In en, this message translates to:
  /// **'Add Course'**
  String get addCourse;

  /// Button text for editing a course
  ///
  /// In en, this message translates to:
  /// **'Edit Course'**
  String get editCourse;

  /// Monday full name
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get dayMonday;

  /// Tuesday full name
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get dayTuesday;

  /// Wednesday full name
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get dayWednesday;

  /// Thursday full name
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get dayThursday;

  /// Friday full name
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get dayFriday;

  /// Saturday full name
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get daySaturday;

  /// Sunday full name
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get daySunday;

  /// Monday short name
  ///
  /// In en, this message translates to:
  /// **'MON'**
  String get dayMondayShort;

  /// Tuesday short name
  ///
  /// In en, this message translates to:
  /// **'TUE'**
  String get dayTuesdayShort;

  /// Wednesday short name
  ///
  /// In en, this message translates to:
  /// **'WED'**
  String get dayWednesdayShort;

  /// Thursday short name
  ///
  /// In en, this message translates to:
  /// **'THU'**
  String get dayThursdayShort;

  /// Friday short name
  ///
  /// In en, this message translates to:
  /// **'FRI'**
  String get dayFridayShort;

  /// Saturday short name
  ///
  /// In en, this message translates to:
  /// **'SAT'**
  String get daySaturdayShort;

  /// Sunday short name
  ///
  /// In en, this message translates to:
  /// **'SUN'**
  String get daySundayShort;

  /// Semester label
  ///
  /// In en, this message translates to:
  /// **'Semester'**
  String get semester;

  /// Spring semester name
  ///
  /// In en, this message translates to:
  /// **'Spring'**
  String get semesterSpring;

  /// Fall semester name
  ///
  /// In en, this message translates to:
  /// **'Fall'**
  String get semesterFall;

  /// Summer semester name
  ///
  /// In en, this message translates to:
  /// **'Summer'**
  String get semesterSummer;

  /// Winter semester name
  ///
  /// In en, this message translates to:
  /// **'Winter'**
  String get semesterWinter;

  /// GPA Calculator title
  ///
  /// In en, this message translates to:
  /// **'GPA Calculator'**
  String get gpaCalculator;

  /// Credit hours label
  ///
  /// In en, this message translates to:
  /// **'Credit Hours'**
  String get creditHours;

  /// Credits text
  ///
  /// In en, this message translates to:
  /// **'credits'**
  String get credits;

  /// GPA calculator subtitle when empty
  ///
  /// In en, this message translates to:
  /// **'Calculate and track'**
  String get calculateAndTrack;

  /// Course name field label
  ///
  /// In en, this message translates to:
  /// **'Course Name'**
  String get courseName;

  /// Course name field hint
  ///
  /// In en, this message translates to:
  /// **'e.g., Programming Fundamentals'**
  String get courseNameHint;

  /// Course name required validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter course name'**
  String get courseNameRequired;

  /// Professor field label
  ///
  /// In en, this message translates to:
  /// **'Professor'**
  String get professor;

  /// Professor field hint
  ///
  /// In en, this message translates to:
  /// **'e.g., Prof. Kim'**
  String get professorHint;

  /// Room/location field label
  ///
  /// In en, this message translates to:
  /// **'Room / Location'**
  String get room;

  /// Room field hint
  ///
  /// In en, this message translates to:
  /// **'e.g., Room 301'**
  String get roomHint;

  /// Color selection label
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// Color selection description
  ///
  /// In en, this message translates to:
  /// **'Choose a color to highlight the course'**
  String get colorDescription;

  /// Start time label
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get startTime;

  /// End time label
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get endTime;

  /// Day selection label
  ///
  /// In en, this message translates to:
  /// **'Select Day'**
  String get selectDay;

  /// Day of week label
  ///
  /// In en, this message translates to:
  /// **'Day of Week'**
  String get dayOfWeek;

  /// Time and day section title
  ///
  /// In en, this message translates to:
  /// **'Time and Day'**
  String get timeAndDay;

  /// Basic information section title
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get basicInfo;

  /// Delete course button text
  ///
  /// In en, this message translates to:
  /// **'Delete Course'**
  String get deleteCourse;

  /// Confirm delete course message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this course?'**
  String get confirmDeleteCourse;

  /// Course deleted success message
  ///
  /// In en, this message translates to:
  /// **'Course deleted'**
  String get courseDeleted;

  /// Course added success message
  ///
  /// In en, this message translates to:
  /// **'Course added successfully'**
  String get courseAdded;

  /// Course updated success message
  ///
  /// In en, this message translates to:
  /// **'Course updated'**
  String get courseUpdated;

  /// Save changes button text
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// Empty state title when no courses
  ///
  /// In en, this message translates to:
  /// **'No courses added'**
  String get noCoursesAdded;

  /// Empty state description when no courses
  ///
  /// In en, this message translates to:
  /// **'Add your courses to create\na weekly schedule'**
  String get noCoursesDescription;

  /// Loading state text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Refresh tooltip
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// My timetables sheet title
  ///
  /// In en, this message translates to:
  /// **'My Timetables'**
  String get myTimetables;

  /// Create new timetable button text
  ///
  /// In en, this message translates to:
  /// **'Create New Timetable'**
  String get createNewTimetable;

  /// Default name for timetable without title
  ///
  /// In en, this message translates to:
  /// **'Untitled Timetable'**
  String get untitledTimetable;

  /// New course section label
  ///
  /// In en, this message translates to:
  /// **'NEW COURSE'**
  String get newCourse;

  /// Edit course section label
  ///
  /// In en, this message translates to:
  /// **'EDIT'**
  String get editCourseTitle;

  /// New course description
  ///
  /// In en, this message translates to:
  /// **'Create a new course for your timetable'**
  String get createNewCourse;

  /// Edit course description
  ///
  /// In en, this message translates to:
  /// **'Update course information'**
  String get updateCourseInfo;

  /// Time conflict label
  ///
  /// In en, this message translates to:
  /// **'CONFLICT'**
  String get conflict;

  /// Confirm new password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// Birth date field label
  ///
  /// In en, this message translates to:
  /// **'Birth Date'**
  String get birthDate;

  /// Report button/dialog title
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// Report reason selection label
  ///
  /// In en, this message translates to:
  /// **'Select report reason'**
  String get reportReason;

  /// Spam report reason
  ///
  /// In en, this message translates to:
  /// **'Spam/Inappropriate promotion'**
  String get reportReasonSpam;

  /// Abuse report reason
  ///
  /// In en, this message translates to:
  /// **'Profanity/Insult'**
  String get reportReasonAbuse;

  /// Sexual content report reason
  ///
  /// In en, this message translates to:
  /// **'Sexual content'**
  String get reportReasonSexual;

  /// Hate speech report reason
  ///
  /// In en, this message translates to:
  /// **'Hate speech'**
  String get reportReasonHate;

  /// Illegal content report reason
  ///
  /// In en, this message translates to:
  /// **'Illegal content'**
  String get reportReasonIllegal;

  /// Privacy violation report reason
  ///
  /// In en, this message translates to:
  /// **'Privacy violation'**
  String get reportReasonPrivacy;

  /// Impersonation report reason
  ///
  /// In en, this message translates to:
  /// **'Impersonation'**
  String get reportReasonImpersonation;

  /// Other report reason
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get reportReasonOther;

  /// Report description field placeholder
  ///
  /// In en, this message translates to:
  /// **'Additional details (optional)'**
  String get reportDescription;

  /// Submit report button text
  ///
  /// In en, this message translates to:
  /// **'Submit report'**
  String get reportSubmit;

  /// Report success message
  ///
  /// In en, this message translates to:
  /// **'Report submitted successfully'**
  String get reportSuccess;

  /// Already reported error message
  ///
  /// In en, this message translates to:
  /// **'You have already reported this'**
  String get reportAlreadyReported;

  /// Block user dialog title
  ///
  /// In en, this message translates to:
  /// **'Block user'**
  String get blockUser;

  /// Block user confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to block {name}?'**
  String blockUserConfirm(String name);

  /// Block user description text
  ///
  /// In en, this message translates to:
  /// **'You will no longer receive messages or friend requests from this user.'**
  String get blockUserDescription;

  /// Block button text
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get block;

  /// Unblock button text
  ///
  /// In en, this message translates to:
  /// **'Unblock'**
  String get unblock;

  /// Blocked users screen title
  ///
  /// In en, this message translates to:
  /// **'Blocked users'**
  String get blockedUsers;

  /// Empty state message for blocked users
  ///
  /// In en, this message translates to:
  /// **'No blocked users'**
  String get noBlockedUsers;

  /// Success message after blocking user
  ///
  /// In en, this message translates to:
  /// **'User blocked'**
  String get userBlocked;

  /// Success message after unblocking user
  ///
  /// In en, this message translates to:
  /// **'User unblocked'**
  String get userUnblocked;

  /// University verification screen title
  ///
  /// In en, this message translates to:
  /// **'University Verification'**
  String get universityVerification;

  /// Student ID verification tab label
  ///
  /// In en, this message translates to:
  /// **'Student ID'**
  String get studentIdVerification;

  /// Email verification tab label
  ///
  /// In en, this message translates to:
  /// **'Email Verification'**
  String get emailVerification;

  /// Upload student ID section title
  ///
  /// In en, this message translates to:
  /// **'Upload Student ID'**
  String get uploadStudentId;

  /// Select image button text
  ///
  /// In en, this message translates to:
  /// **'Select Image'**
  String get selectImage;

  /// Take photo option
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// Choose from gallery option
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseFromGallery;

  /// Submit verification button text
  ///
  /// In en, this message translates to:
  /// **'Submit for Verification'**
  String get submitVerification;

  /// Verification pending status message
  ///
  /// In en, this message translates to:
  /// **'Verification is pending review'**
  String get verificationPending;

  /// Verification approved status message
  ///
  /// In en, this message translates to:
  /// **'Verification Approved'**
  String get verificationApproved;

  /// School email input label
  ///
  /// In en, this message translates to:
  /// **'School Email'**
  String get schoolEmail;

  /// Send verification code button text
  ///
  /// In en, this message translates to:
  /// **'Send Verification Code'**
  String get sendVerificationCode;

  /// Verification code input label
  ///
  /// In en, this message translates to:
  /// **'Enter Verification Code'**
  String get enterVerificationCode;

  /// Code sent success message
  ///
  /// In en, this message translates to:
  /// **'Verification code sent to your email'**
  String get codeSent;

  /// Verification success message
  ///
  /// In en, this message translates to:
  /// **'Email verified successfully!'**
  String get verificationSuccess;

  /// Countdown timer label
  ///
  /// In en, this message translates to:
  /// **'Time remaining'**
  String get timeRemaining;

  /// Delete account button text
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// Delete account subtitle
  ///
  /// In en, this message translates to:
  /// **'Permanently delete your account'**
  String get deleteAccountSubtitle;

  /// Delete account confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account?'**
  String get confirmDeleteAccount;

  /// Delete account warning message
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone. All your data will be deleted.'**
  String get deleteAccountWarning;

  /// Delete account success message
  ///
  /// In en, this message translates to:
  /// **'Account deleted successfully'**
  String get deleteAccountSuccess;

  /// Delete account failed message
  ///
  /// In en, this message translates to:
  /// **'Failed to delete account'**
  String get deleteAccountFailed;
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
