import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nonstop/core/constants/routes.dart';
import 'package:nonstop/core/services/analytics_service.dart';
import 'package:nonstop/features/auth/presentation/providers/auth_provider.dart';
import 'package:nonstop/features/auth/presentation/screens/login_screen_v1.dart';
import 'package:nonstop/features/auth/presentation/screens/signup_screen_v1.dart';
import 'package:nonstop/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:nonstop/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:nonstop/features/auth/presentation/screens/home_screen.dart';
import 'package:nonstop/features/board/presentation/screens/board_screen.dart';
import 'package:nonstop/features/board/presentation/screens/create_post_screen.dart';
import 'package:nonstop/features/board/presentation/screens/board_detail_screen.dart';
import 'package:nonstop/features/timetable/presentation/screens/timetable_screen.dart';
import 'package:nonstop/features/timetable/domain/entities/timetable_entry.dart';
import 'package:nonstop/features/timetable/presentation/screens/add_timetable_entry_screen.dart';
import 'package:nonstop/features/timetable/presentation/screens/gpa_calculator_screen.dart';
import 'package:nonstop/features/timetable/presentation/screens/timetable_test_screen.dart';
import 'package:nonstop/features/settings/presentation/screens/settings_screen.dart';
import 'package:nonstop/features/chat/presentation/screens/chat_screen.dart';
import 'package:nonstop/features/chat/presentation/screens/chat_room_screen.dart';
import 'package:nonstop/features/profile/presentation/screens/profile_screen.dart';
import 'package:nonstop/features/friends/presentation/screens/friends_screen.dart';
import 'package:nonstop/features/notification/presentation/screens/notification_screen.dart';
import 'package:nonstop/features/settings/presentation/screens/blocked_users_screen.dart';
import 'package:nonstop/features/verification/presentation/screens/verification_screen.dart';
import 'package:nonstop/shared/components/main_scaffold.dart';

/// Main router with authentication guard and bottom navigation
final routerProvider = Provider<GoRouter>((ref) {
  // authProvider 전체를 watch하는 대신 isAuthenticated 여부만 watch하여
  // 이메일 인증 시의 미세한 상태 변화(로딩 등)에 라우터가 재계산되는 것을 방지합니다.
  final authState = ref.watch(authProvider);
  final analyticsService = ref.watch(analyticsServiceProvider);

  return GoRouter(
    initialLocation: authState.isAuthenticated ? Routes.board : Routes.login,
    observers: [analyticsService.observer],
    redirect: (context, state) {
      final path = state.uri.path;

      // 초기화가 완료되지 않았으면 리다이렉트하지 않음 (로딩 중)
      if (!authState.isInitialized) {
        return null;
      }

      // 현재 페이지가 로그인, 회원가입, 비밀번호 찾기 페이지인지 확인
      final isAuthPage = path == Routes.login ||
          path == Routes.register ||
          path == Routes.forgotPassword;

      // 인증되지 않은 상태에서 보호된 경로에 접근하려고 하면 로그인으로 리다이렉트
      if (!authState.isAuthenticated && !isAuthPage) {
        return Routes.login;
      }

      // 이미 인증된 상태에서 인증 페이지(로그인/회원가입)에 접근하면 게시판으로 리다이렉트
      if (authState.isAuthenticated && isAuthPage) {
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
        path: Routes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: Routes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
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
                  GoRoute(
                    path: ':id',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return BoardDetailScreen(boardId: id);
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
                builder: (context, state) => const TimetableScreen(),
                routes: [
                  GoRoute(
                    path: 'create',
                    builder: (context, state) {
                      final entry = state.extra as TimetableEntry?;
                      return AddTimetableEntryScreen(initialEntry: entry);
                    },
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
                      final roomId =
                          int.tryParse(state.pathParameters['roomId'] ?? '') ??
                          0;
                      return ChatRoomScreen(roomId: roomId);
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
                builder: (context, state) => const FriendsScreen(),
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
      GoRoute(
        path: Routes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: Routes.blockedUsers,
        builder: (context, state) => const BlockedUsersScreen(),
      ),
      GoRoute(
        path: Routes.timetableTest,
        builder: (context, state) => const TimetableTestScreen(),
      ),
      GoRoute(
        path: Routes.notifications,
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        path: Routes.verification,
        builder: (context, state) => const VerificationScreen(),
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
