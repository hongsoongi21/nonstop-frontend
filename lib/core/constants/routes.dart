/// Single source of truth for all application routes
/// Contains route constants and path builders
class Routes {
  // 🚦 Splash & Auth
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String onboarding = '/onboarding';
  static const String forgotPassword = '/forgot-password';

  // 🏠 Main Navigation
  static const String home = '/home';
  static const String board = '/board';
  static const String chat = '/chat';
  static const String friends = '/friends';
  static const String timetable = '/timetable';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String editProfile = '/profile/edit';
  static const String blockedUsers = '/settings/blocked-users';
  static const String verification = '/verification';

  // 👥 Friends
  static const String friendRequests = '/friends/requests';
  static const String friendSearch = '/friends/search';

  // 📄 Detail Screens (with parameters)
  static const String boardDetail = '/board/:id';
  static const String boardCreate = '/board/create';
  static const String boardSearch = '/board/search';
  static const String chatRoom = '/chat/:roomId';
  static const String userProfile = '/profile/:userId';
  static const String timetableCreate = '/timetable/create';
  static const String timetableEvent = '/timetable/event/:id';
  static const String gpaCalculator = '/timetable/gpa-calculator';
  static const String timetableTest = '/timetable-test';

  // 🔍 Query parameters
  static const String search = '/search?query=:query';
  static const String notifications = '/notifications';

  // 🛠️ Path Builders
  static String boardDetailPath(String id) => '/board/$id';
  static String boardCreatePath() => '/board/create';
  static String boardSearchPath() => '/board/search';
  static String chatRoomPath(String roomId) => '/chat/$roomId';
  static String userProfilePath(String userId) => '/profile/$userId';
  static String timetableCreatePath() => '/timetable/create';
  static String timetableEventPath(String eventId) =>
      '/timetable/event/$eventId';
  static String gpaCalculatorPath() => '/timetable/gpa-calculator';
  static String searchPath(String query) => '/search?query=$query';
}
