// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'Language';

  @override
  String get languageSubtitle => 'Choose your preferred language';

  @override
  String get systemDefault => 'System Default';

  @override
  String loginSuccessWelcome(String nickname) {
    return 'Welcome, $nickname!';
  }

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
  String get searchChats => 'Search chats...';

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

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get posts => 'Posts';

  @override
  String get comments => 'Comments';

  @override
  String get friends => 'Friends';

  @override
  String get allPosts => 'All Posts';

  @override
  String get bookmarks => 'Bookmarks';

  @override
  String get favorites => 'Favorites';

  @override
  String get notifications => 'Notifications';

  @override
  String get privacy => 'Privacy';

  @override
  String get account => 'Account';

  @override
  String get logout => 'Logout';

  @override
  String get pushNotifications => 'Push Notifications';

  @override
  String get pushNotificationsSubtitle =>
      'Receive push notifications on this device';

  @override
  String get emailNotifications => 'Email Notifications';

  @override
  String get emailNotificationsSubtitle => 'Get updates via email';

  @override
  String get boardNotifications => 'Board Notifications';

  @override
  String get boardNotificationsSubtitle => 'New posts and comments';

  @override
  String get chatNotifications => 'Chat Notifications';

  @override
  String get chatNotificationsSubtitle => 'New messages and replies';

  @override
  String get timetableNotifications => 'Timetable Notifications';

  @override
  String get timetableNotificationsSubtitle => 'Class reminders and updates';

  @override
  String get soundNotifications => 'Sound Notifications';

  @override
  String get soundNotificationsSubtitle => 'Play sound for notifications';

  @override
  String get allowFriendRequests => 'Allow Friend Requests';

  @override
  String get allowFriendRequestsSubtitle =>
      'Let others send you friend requests';

  @override
  String get showOnlineStatus => 'Show Online Status';

  @override
  String get showOnlineStatusSubtitle => 'Let friends see when you\'re online';

  @override
  String get allowMessageRequests => 'Allow Message Requests';

  @override
  String get allowMessageRequestsSubtitle =>
      'Receive messages from non-friends';

  @override
  String get showProfileToStrangers => 'Show Profile to Strangers';

  @override
  String get showProfileToStrangersSubtitle =>
      'Make your profile visible to everyone';

  @override
  String get logoutSubtitle => 'Sign out of your account';

  @override
  String get confirmLogout => 'Are you sure you want to logout?';

  @override
  String get errorOccurred => 'Error occurred';

  @override
  String get retry => 'Retry';

  @override
  String get notificationsComingSoon => 'Notifications - coming soon!';

  @override
  String get editProfileComingSoon => 'Edit Profile - coming soon!';

  @override
  String get searchComingSoon => 'Search - coming soon!';

  @override
  String get filterPrefix => 'Filter: ';

  @override
  String get profileNotLoaded => 'Profile information not loaded';

  @override
  String get settingsNotLoaded => 'Settings not loaded';

  @override
  String get postsLoadError => 'Failed to load posts';

  @override
  String get noPostsYet => 'No posts yet';

  @override
  String get markAllAsRead => 'Mark all as read';

  @override
  String get noNotificationsYet => 'No notifications yet';

  @override
  String get noNotificationsHint => 'New notifications will appear here';

  @override
  String get notificationLoadError => 'Failed to load notifications';

  @override
  String get justNow => 'Just now';

  @override
  String minutesAgo(int count) {
    return '$count minutes ago';
  }

  @override
  String hoursAgo(int count) {
    return '$count hours ago';
  }

  @override
  String daysAgo(int count) {
    return '$count days ago';
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
  String get delete => 'Delete';

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
  String get login => 'Login';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get welcomeBack => 'Welcome Back!';

  @override
  String get loginToContinue => 'Sign in to continue';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get continueWithApple => 'Continue with Apple';

  @override
  String appleSignInFailed(String error) {
    return 'Apple Sign-In failed: $error';
  }

  @override
  String get appleSignInNotAvailable =>
      'Apple Sign-In is only available on iOS';

  @override
  String get orSocialMedia => 'Or via social networks';

  @override
  String get noAccount => 'No account?';

  @override
  String get signUpLink => 'Sign Up';

  @override
  String get validationEmailRequired => 'Please enter your email';

  @override
  String get validationEmailInvalid => 'Please enter a valid email';

  @override
  String get validationPasswordRequired => 'Please enter your password';

  @override
  String get validationPasswordMin6 => 'Password must be at least 6 characters';

  @override
  String get validationPasswordMin8 => 'Password must be at least 8 characters';

  @override
  String googleSignInFailed(String error) {
    return 'Google Sign-In failed: $error';
  }

  @override
  String get createAccount => 'Create Account';

  @override
  String get enterYourInfo => 'Enter your information';

  @override
  String get nickname => 'Nickname';

  @override
  String get selectUniversity => 'Select University';

  @override
  String get selectBirthDate => 'Select Birth Date';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get agreeToAll => 'Agree to all';

  @override
  String get required => '[Required]';

  @override
  String get optional => '[Optional]';

  @override
  String get view => '[View]';

  @override
  String get haveAccount => 'Have an account?';

  @override
  String get loginLink => 'Login';

  @override
  String get validationNicknameRequired => 'Please enter your nickname';

  @override
  String get validationNickname2to20 => 'Nickname must be 2-20 characters';

  @override
  String get validationPasswordsNoMatch => 'Passwords do not match';

  @override
  String get validationConfirmPassword => 'Please confirm your password';

  @override
  String get send => 'Send';

  @override
  String get resend => 'Resend';

  @override
  String get verify => 'Verify';

  @override
  String get sixDigitCode => '6-digit code';

  @override
  String get emailVerified => 'Email verified';

  @override
  String get oauthEmailVerified => 'Email verified via social login';

  @override
  String get verificationCodeSent => 'Verification code sent!';

  @override
  String get emailVerifiedSuccess => 'Email verified successfully!';

  @override
  String get invalidCode => 'Invalid code';

  @override
  String get failedToSendCode => 'Failed to send code';

  @override
  String get pleaseVerifyEmail => 'Please verify your email first';

  @override
  String get pleaseWaitPoliciesLoad => 'Please wait for policies to load';

  @override
  String get agreeMandatoryPolicies => 'Please agree to all mandatory policies';

  @override
  String get pleaseSelectUniversity => 'Please select a university';

  @override
  String get pleaseSelectBirthDate => 'Please select your birth date';

  @override
  String get signupFailed => 'Sign up failed';

  @override
  String couldNotLaunch(String url) {
    return 'Could not launch $url';
  }

  @override
  String errorLaunchingUrl(String error) {
    return 'Error launching URL: $error';
  }

  @override
  String get selectYourBirthDate => 'Select your birth date';

  @override
  String get noPoliciesAvailable => 'No policies available';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get enterRegisteredEmail => 'Enter your registered email address';

  @override
  String get sendCode => 'Send Code';

  @override
  String get verifyCode => 'Verify Code';

  @override
  String get codeVerified => 'Code verified!';

  @override
  String get verificationCodeLabel => 'Verification code';

  @override
  String get resendCode => 'Resend Code';

  @override
  String get newPassword => 'New Password';

  @override
  String get enterNewPassword => 'Enter your new password';

  @override
  String get updatePassword => 'Update Password';

  @override
  String get success => 'Success!';

  @override
  String get passwordChangedSuccess =>
      'Your password has been successfully changed. You can now login with your new password.';

  @override
  String get stepEmail => 'Email';

  @override
  String get stepVerification => 'Verification';

  @override
  String get stepNewPassword => 'New Password';

  @override
  String get validationEnterEmail => 'Enter email';

  @override
  String get validationEnterValidEmail => 'Enter valid email';

  @override
  String get validationEnterCode => 'Enter code';

  @override
  String get validationCodeMinLength => 'Code must be at least 4 digits';

  @override
  String get validationEnterPassword => 'Enter password';

  @override
  String get validationPasswordMinLength =>
      'Password must be at least 8 characters';

  @override
  String get validationConfirmNewPassword => 'Confirm password';

  @override
  String get codeResent => 'Code resent!';

  @override
  String get friendsTitle => 'Friends';

  @override
  String get requests => 'Received';

  @override
  String get search => 'Search';

  @override
  String get noFriendsYet => 'No friends yet';

  @override
  String get addFriendsViaSearch => 'Add friends via search';

  @override
  String get friend => 'Friend';

  @override
  String get sent => 'Sent';

  @override
  String get accept => 'Accept';

  @override
  String get reject => 'Reject';

  @override
  String get removeFriend => 'Remove Friend';

  @override
  String confirmRemoveFriend(String name) {
    return 'Are you sure you want to remove $name?';
  }

  @override
  String get remove => 'Remove';

  @override
  String get noRequests => 'No requests';

  @override
  String get requestsAppearHere => 'Friend requests appear here';

  @override
  String get searchUsersHint => 'Search users...';

  @override
  String get startSearching => 'Start searching';

  @override
  String get typeInSearchBar => 'Type in the search bar above';

  @override
  String get noResults => 'No results';

  @override
  String get tryDifferentName => 'Try a different name';

  @override
  String get keepTyping => 'Keep typing';

  @override
  String get minTwoCharacters => 'Enter at least 2 characters to search';

  @override
  String get online => 'Online';

  @override
  String get offline => 'Offline';

  @override
  String get friendRequestSent => 'Friend request sent';

  @override
  String get friendRequestAccepted => 'Friend request accepted';

  @override
  String get requestRejected => 'Request rejected';

  @override
  String get removedFromFriends => 'Removed from friends';

  @override
  String get addFriend => 'Add';

  @override
  String get timetable => 'Timetable';

  @override
  String get addCourse => 'Add Course';

  @override
  String get editCourse => 'Edit Course';

  @override
  String get dayMonday => 'Monday';

  @override
  String get dayTuesday => 'Tuesday';

  @override
  String get dayWednesday => 'Wednesday';

  @override
  String get dayThursday => 'Thursday';

  @override
  String get dayFriday => 'Friday';

  @override
  String get daySaturday => 'Saturday';

  @override
  String get daySunday => 'Sunday';

  @override
  String get dayMondayShort => 'MON';

  @override
  String get dayTuesdayShort => 'TUE';

  @override
  String get dayWednesdayShort => 'WED';

  @override
  String get dayThursdayShort => 'THU';

  @override
  String get dayFridayShort => 'FRI';

  @override
  String get daySaturdayShort => 'SAT';

  @override
  String get daySundayShort => 'SUN';

  @override
  String get semester => 'Semester';

  @override
  String get semesterSpring => 'Spring';

  @override
  String get semesterFall => 'Fall';

  @override
  String get semesterSummer => 'Summer';

  @override
  String get semesterWinter => 'Winter';

  @override
  String get gpaCalculator => 'GPA Calculator';

  @override
  String get creditHours => 'Credit Hours';

  @override
  String get credits => 'credits';

  @override
  String get calculateAndTrack => 'Calculate and track';

  @override
  String get courseName => 'Course Name';

  @override
  String get courseNameHint => 'e.g., Programming Fundamentals';

  @override
  String get courseNameRequired => 'Please enter course name';

  @override
  String get professor => 'Professor';

  @override
  String get professorHint => 'e.g., Prof. Kim';

  @override
  String get room => 'Room / Location';

  @override
  String get roomHint => 'e.g., Room 301';

  @override
  String get color => 'Color';

  @override
  String get colorDescription => 'Choose a color to highlight the course';

  @override
  String get startTime => 'Start Time';

  @override
  String get endTime => 'End Time';

  @override
  String get selectDay => 'Select Day';

  @override
  String get dayOfWeek => 'Day of Week';

  @override
  String get timeAndDay => 'Time and Day';

  @override
  String get basicInfo => 'Basic Information';

  @override
  String get deleteCourse => 'Delete Course';

  @override
  String get confirmDeleteCourse =>
      'Are you sure you want to delete this course?';

  @override
  String get courseDeleted => 'Course deleted';

  @override
  String get courseAdded => 'Course added successfully';

  @override
  String get courseUpdated => 'Course updated';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get noCoursesAdded => 'No courses added';

  @override
  String get noCoursesDescription =>
      'Add your courses to create\na weekly schedule';

  @override
  String get loading => 'Loading...';

  @override
  String get refresh => 'Refresh';

  @override
  String get myTimetables => 'My Timetables';

  @override
  String get createNewTimetable => 'Create New Timetable';

  @override
  String get untitledTimetable => 'Untitled Timetable';

  @override
  String get newCourse => 'NEW COURSE';

  @override
  String get editCourseTitle => 'EDIT';

  @override
  String get createNewCourse => 'Create a new course for your timetable';

  @override
  String get updateCourseInfo => 'Update course information';

  @override
  String get conflict => 'CONFLICT';

  @override
  String get confirmNewPassword => 'Confirm New Password';

  @override
  String get birthDate => 'Birth Date';

  @override
  String get report => 'Report';

  @override
  String get reportReason => 'Select report reason';

  @override
  String get reportReasonSpam => 'Spam/Inappropriate promotion';

  @override
  String get reportReasonAbuse => 'Profanity/Insult';

  @override
  String get reportReasonSexual => 'Sexual content';

  @override
  String get reportReasonHate => 'Hate speech';

  @override
  String get reportReasonIllegal => 'Illegal content';

  @override
  String get reportReasonPrivacy => 'Privacy violation';

  @override
  String get reportReasonImpersonation => 'Impersonation';

  @override
  String get reportReasonOther => 'Other';

  @override
  String get reportDescription => 'Additional details (optional)';

  @override
  String get reportSubmit => 'Submit report';

  @override
  String get reportSuccess => 'Report submitted successfully';

  @override
  String get reportAlreadyReported => 'You have already reported this';

  @override
  String get blockUser => 'Block user';

  @override
  String blockUserConfirm(String name) {
    return 'Are you sure you want to block $name?';
  }

  @override
  String get blockUserDescription =>
      'You will no longer receive messages or friend requests from this user.';

  @override
  String get block => 'Block';

  @override
  String get unblock => 'Unblock';

  @override
  String get blockedUsers => 'Blocked users';

  @override
  String get noBlockedUsers => 'No blocked users';

  @override
  String get userBlocked => 'User blocked';

  @override
  String get userUnblocked => 'User unblocked';

  @override
  String get universityVerification => 'University Verification';

  @override
  String get studentIdVerification => 'Student ID';

  @override
  String get emailVerification => 'Email Verification';

  @override
  String get uploadStudentId => 'Upload Student ID';

  @override
  String get selectImage => 'Select Image';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get chooseFromGallery => 'Choose from Gallery';

  @override
  String get submitVerification => 'Submit for Verification';

  @override
  String get verificationPending => 'Verification is pending review';

  @override
  String get verificationApproved => 'Verification Approved';

  @override
  String get schoolEmail => 'School Email';

  @override
  String get sendVerificationCode => 'Send Verification Code';

  @override
  String get enterVerificationCode => 'Enter Verification Code';

  @override
  String get codeSent => 'Verification code sent to your email';

  @override
  String get verificationSuccess => 'Email verified successfully!';

  @override
  String get timeRemaining => 'Time remaining';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountSubtitle => 'Permanently delete your account';

  @override
  String get confirmDeleteAccount =>
      'Are you sure you want to delete your account?';

  @override
  String get deleteAccountWarning =>
      'This action cannot be undone. All your data will be deleted.';

  @override
  String get deleteAccountSuccess => 'Account deleted successfully';

  @override
  String get deleteAccountFailed => 'Failed to delete account';

  @override
  String get leaveRoom => 'Leave Room';

  @override
  String get leaveRoomConfirm =>
      'Are you sure you want to leave this chat room? You will no longer receive messages from this conversation.';

  @override
  String get leaveRoomSuccess => 'Left the chat room';

  @override
  String get latest => 'Latest';

  @override
  String get trending => 'Trending';

  @override
  String get mostCommented => 'Most Discussed';

  @override
  String get completeProfile => 'Complete Profile';

  @override
  String get completeProfileSubtitle =>
      'Please fill in the required information';

  @override
  String get introduction => 'Introduction';

  @override
  String get introductionHint => 'Tell us about yourself...';

  @override
  String get major => 'Major';

  @override
  String get majorHint => 'e.g. Computer Science';

  @override
  String get changePhoto => 'Change Photo';

  @override
  String get profileUpdated => 'Profile updated successfully';

  @override
  String get profileUpdateFailed => 'Failed to update profile';

  @override
  String get avatarUploadFailed => 'Failed to upload avatar';

  @override
  String get selectImageSource => 'Select Image Source';

  @override
  String get introductionMaxLength =>
      'Introduction must be 200 characters or less';

  @override
  String get sentRequests => 'Sent Requests';

  @override
  String get cancelRequest => 'Cancel Request';

  @override
  String get requestCancelled => 'Request cancelled';

  @override
  String get alreadyRequested => 'Already requested';

  @override
  String get legal => 'Legal';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get policyTermsOfService => 'Terms of Service';

  @override
  String get policyPrivacyPolicy => 'Privacy Policy';

  @override
  String get policyMarketing => 'Marketing Communications';

  @override
  String get policyUnknown => 'Policy';

  @override
  String get academicYear => 'Academic Year';

  @override
  String get attachImage => 'Attach image';

  @override
  String get boardNameRequired => 'Board name is required';

  @override
  String get chatAction => 'Chat';

  @override
  String confirmDeleteTimetable(String name) {
    return 'Delete \"$name\"?';
  }

  @override
  String get continueText => 'Continue';

  @override
  String get coursesImportedFromTimetable => 'Courses imported from timetable';

  @override
  String get createButton => 'Create';

  @override
  String get createTimetable => 'Create New Timetable';

  @override
  String get deleteTimetable => 'Delete Timetable';

  @override
  String get enterSchoolEmail => 'Please enter your school email';

  @override
  String get errorLoadingPolicies => 'Failed to load policies';

  @override
  String get majorSubject => 'Major Subject';

  @override
  String get noMessagesYet => 'No messages yet';

  @override
  String get noSentRequests => 'No sent requests';

  @override
  String get noUniversitiesFound => 'No universities found';

  @override
  String timetableCreated(String name) {
    return 'Timetable \"$name\" created';
  }

  @override
  String get timetableName => 'Timetable Name';

  @override
  String get uploading => 'Uploading...';

  @override
  String anonymousRoomWithCount(int count) {
    return 'Anonymous ($count)';
  }
}
