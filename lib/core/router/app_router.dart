import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nonstop/features/auth/presentation/screens/login_screen.dart';
import 'package:nonstop/features/auth/presentation/screens/signup_screen.dart';
import 'package:nonstop/features/auth/presentation/screens/email_verification_screen.dart';
import 'package:nonstop/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:nonstop/features/auth/presentation/screens/home_screen.dart';
import 'package:nonstop/features/board/presentation/screens/board_screen.dart';
import 'package:nonstop/features/timetable/presentation/screens/timetable_screen.dart';
import 'package:nonstop/features/chat/presentation/screens/chat_screen.dart';
import 'package:nonstop/features/profile/presentation/screens/profile_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/signup', builder: (context, state) => const SignupScreen()),
    GoRoute(
      path: '/email-verification',
      builder: (context, state) => const EmailVerificationScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/board', builder: (context, state) => const BoardScreen()),
    GoRoute(
      path: '/timetable',
      builder: (context, state) => const TimetableScreen(),
    ),
    GoRoute(path: '/chat', builder: (context, state) => const ChatScreen()),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);
