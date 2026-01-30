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

  @override
  String get chat => 'Chat';

  @override
  String get chatListEmpty => 'No conversations yet';

  @override
  String get chatListEmptyHint => 'Tap + to start a conversation';

  @override
  String get chatLoadError => 'Failed to load conversations';

  @override
  String get newChat => 'New Chat';

  @override
  String get searchUsers => 'Search users...';

  @override
  String selectedCount(int count) {
    return '$count selected';
  }

  @override
  String get startChat => 'Start Chat';

  @override
  String get createGroup => 'Create Group';

  @override
  String get groupName => 'Group Name';

  @override
  String get groupNameHint => 'Enter group name';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get connectionConnected => 'Connected';

  @override
  String get connectionConnecting => 'Connecting...';

  @override
  String get connectionDisconnected => 'Disconnected - Tap to reconnect';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get messageHint => 'Type a message...';
}
