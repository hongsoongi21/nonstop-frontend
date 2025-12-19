/// Single source of truth for all application routes
/// Contains route constants and path builders
class Routes {
  // 🚦 Splash & Auth
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // 🏠 Main Navigation
  static const String home = '/home';
  static const String board = '/board';
  static const String chat = '/chat';
  static const String friends = '/friends';
  static const String timetable = '/timetable';
  static const String settings = '/settings';

  // 📄 Detail Screens (with parameters)
  static const String boardDetail = '/board/:id';
  static const String chatRoom = '/chat/:roomId';
  static const String userProfile = '/profile/:userId';

  // 🔍 Query parameters
  static const String search = '/search?query=:query';
  static const String notifications = '/notifications';

  // 🛠️ Path Builders
  static String boardDetailPath(String id) => '/board/$id';
  static String chatRoomPath(String roomId) => '/chat/$roomId';
  static String userProfilePath(String userId) => '/profile/$userId';
  static String searchPath(String query) => '/search?query=$query';
}
