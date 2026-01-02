import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nonstop/core/constants/routes.dart';
import 'package:nonstop/features/auth/presentation/providers/auth_provider.dart';
import 'package:nonstop/features/auth/presentation/screens/login_screen_v1.dart';
import 'package:nonstop/features/auth/presentation/screens/signup_screen_v1.dart';
import 'package:nonstop/features/auth/presentation/screens/email_verification_screen.dart';
import 'package:nonstop/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:nonstop/features/auth/presentation/screens/home_screen.dart';
import 'package:nonstop/features/board/presentation/screens/board_screen.dart';
import 'package:nonstop/features/board/presentation/screens/create_post_screen.dart';
import 'package:nonstop/features/timetable/presentation/screens/timetable_screen.dart';
import 'package:nonstop/features/timetable/presentation/screens/create_event_screen.dart';
import 'package:nonstop/features/timetable/presentation/screens/gpa_calculator_screen.dart';
import 'package:nonstop/features/chat/presentation/screens/chat_screen.dart';
import 'package:nonstop/features/chat/presentation/screens/chat_room_screen.dart';
import 'package:nonstop/features/profile/presentation/screens/profile_screen.dart';
import 'package:nonstop/shared/components/main_scaffold.dart';

/// Main router with authentication guard and bottom navigation
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: authState.isAuthenticated ? Routes.board : Routes.login,
    redirect: (context, state) {
      final isAuthenticated = authState.isAuthenticated;
      final isGoingToAuth =
          state.uri.toString() == Routes.login ||
          state.uri.toString() == Routes.register ||
          state.uri.toString() == Routes.forgotPassword;

      // If not authenticated and trying to access protected route, redirect to login
      if (!isAuthenticated && !isGoingToAuth) {
        return Routes.login;
      }

      // If authenticated and on auth screen, redirect to board
      if (isAuthenticated && isGoingToAuth) {
        return Routes.board;
      }

      return null;
    },
    routes: [
      // Auth routes
      GoRoute(
        path: Routes.login,
        builder: (context, state) =>
            const LoginScreenV1(), // Using V1 for development
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) =>
            const SignupScreenV1(), // Using V1 for development
      ),
      GoRoute(
        path: Routes.forgotPassword,
        builder: (context, state) =>
            const EmailVerificationScreen(), // TODO: Create forgot password screen
      ),
      GoRoute(
        path: Routes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Main app with bottom navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScaffold(navigationShell: navigationShell);
        },
        branches: [
          // Board
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.board,
                builder: (context, state) => const BoardScreen(),
                routes: [
                  GoRoute(
                    path: 'create',
                    builder: (context, state) => const CreatePostScreen(),
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
                builder: (context, state) => const TimetableScreen(),
                routes: [
                  GoRoute(
                    path: 'create',
                    builder: (context, state) => const CreateEventScreen(),
                  ),
                  GoRoute(
                    path: 'gpa-calculator',
                    builder: (context, state) => const GpaCalculatorScreen(),
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
                builder: (context, state) => const ChatScreen(),
                routes: [
                  GoRoute(
                    path: ':roomId',
                    builder: (context, state) {
                      final roomId = int.tryParse(state.pathParameters['roomId'] ?? '') ?? 0;
                      return ChatRoomScreen(roomId: roomId);
                    },
                  ),
                ],
              ),
            ],
          ),

          // Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),

      // Hidden/Standalone Routes
      GoRoute(
        path: Routes.home,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.uri.path}')),
    ),
  );
});

// TODO: Add auth guard redirect logic
// redirect: (context, state) {
//   final isAuthenticated = authState.maybeWhen(
//     data: (user) => user != null,
//     orElse: () => false,
//   );

//   final isGoingToAuth = state.uri.toString().startsWith(Routes.login) ||
//       state.uri.toString().startsWith(Routes.register);

//   if (!isAuthenticated && !isGoingToAuth) return Routes.login;
//   if (isAuthenticated && state.uri.toString() == Routes.splash) return Routes.home;

//   return null;
// },
