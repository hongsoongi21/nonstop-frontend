import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/routes.dart';

/// Application router configuration
/// Manages all navigation routes and guards
final routerProvider = Provider<GoRouter>((ref) {
  // TODO: Add auth state provider when implemented
  // final auth = ref.watch(authProvider);

  return GoRouter(
    initialLocation: Routes.splash,

    // TODO: Add auth guard when auth is implemented
    redirect: (context, state) {
      // For now, always allow navigation
      // Later: check auth state and redirect to login if needed
      return null;
    },

    routes: [
      // Splash screen
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const _SplashScreen(),
      ),

      // Auth routes
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const _LoginScreen(),
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) => const _RegisterScreen(),
      ),
      GoRoute(
        path: Routes.forgotPassword,
        builder: (context, state) => const _ForgotPasswordScreen(),
      ),

      // Main app with bottom navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return _MainScaffold(navigationShell: navigationShell);
        },
        branches: [
          // Home/Dashboard
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.home,
                builder: (context, state) => const _HomeScreen(),
              ),
            ],
          ),

          // Board
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.board,
                builder: (context, state) => const _BoardListScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return _BoardDetailScreen(boardId: id);
                    },
                  ),
                ],
              ),
            ],
          ),

          // Chat
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.chat,
                builder: (context, state) => const _ChatListScreen(),
                routes: [
                  GoRoute(
                    path: ':roomId',
                    builder: (context, state) {
                      final roomId = state.pathParameters['roomId']!;
                      return _ChatRoomScreen(roomId: roomId);
                    },
                  ),
                ],
              ),
            ],
          ),

          // Friends
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.friends,
                builder: (context, state) => const _FriendsListScreen(),
                routes: [
                  GoRoute(
                    path: ':userId',
                    builder: (context, state) {
                      final userId = state.pathParameters['userId']!;
                      return _UserProfileScreen(userId: userId);
                    },
                  ),
                ],
              ),
            ],
          ),

          // Timetable
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.timetable,
                builder: (context, state) => const _TimetableScreen(),
              ),
            ],
          ),
        ],
      ),

      // Settings (full screen, no bottom nav)
      GoRoute(
        path: Routes.settings,
        builder: (context, state) => const _SettingsScreen(),
      ),

      // Notifications
      GoRoute(
        path: Routes.notifications,
        builder: (context, state) => const _NotificationsScreen(),
      ),
    ],

    errorBuilder: (context, state) => _ErrorScreen(error: state.error),
  );
});

// Temporary placeholder screens
// These will be replaced with actual implementations

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Splash Screen')));
  }
}

class _LoginScreen extends StatelessWidget {
  const _LoginScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Login Screen')));
  }
}

class _RegisterScreen extends StatelessWidget {
  const _RegisterScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Register Screen')));
  }
}

class _ForgotPasswordScreen extends StatelessWidget {
  const _ForgotPasswordScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Forgot Password Screen')));
  }
}

class _MainScaffold extends StatelessWidget {
  const _MainScaffold({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Board'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Friends'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Timetable',
          ),
        ],
      ),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Home Screen')));
  }
}

class _BoardListScreen extends StatelessWidget {
  const _BoardListScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Board List Screen')));
  }
}

class _BoardDetailScreen extends StatelessWidget {
  const _BoardDetailScreen({required this.boardId});

  final String boardId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Board Detail: $boardId')));
  }
}

class _ChatListScreen extends StatelessWidget {
  const _ChatListScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Chat List Screen')));
  }
}

class _ChatRoomScreen extends StatelessWidget {
  const _ChatRoomScreen({required this.roomId});

  final String roomId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Chat Room: $roomId')));
  }
}

class _FriendsListScreen extends StatelessWidget {
  const _FriendsListScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Friends List Screen')));
  }
}

class _UserProfileScreen extends StatelessWidget {
  const _UserProfileScreen({required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('User Profile: $userId')));
  }
}

class _TimetableScreen extends StatelessWidget {
  const _TimetableScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Timetable Screen')));
  }
}

class _SettingsScreen extends StatelessWidget {
  const _SettingsScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Settings Screen')));
  }
}

class _NotificationsScreen extends StatelessWidget {
  const _NotificationsScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Notifications Screen')));
  }
}

class _ErrorScreen extends StatelessWidget {
  const _ErrorScreen({required this.error});

  final Exception? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Error: ${error?.toString() ?? 'Unknown error'}'),
      ),
    );
  }
}
