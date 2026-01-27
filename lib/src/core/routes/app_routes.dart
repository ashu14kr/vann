import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:van_life/src/features/auth/presentation/authentication_screen.dart';
import 'package:van_life/src/features/chat/presentation/chat_screen.dart';
import 'package:van_life/src/features/home/presentation/home_screen.dart';
import 'package:van_life/src/features/onboarding/presentation/account_loading_screen.dart';
import 'package:van_life/src/features/onboarding/presentation/age_Onboarding_Screen.dart';
import 'package:van_life/src/features/onboarding/presentation/interest_Onboarding_screen.dart';
import 'package:van_life/src/features/onboarding/presentation/name_onboaring_screen.dart';
import 'package:van_life/src/features/splash/presentation/splash_screen.dart';
import 'package:van_life/src/features/travel_progress/presentation/travel_progress.dart';

import '../../features/chat/presentation/chat_detailed_screen.dart';
import '../../features/onboarding/presentation/gender_Onboarding_Screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => SplashScreen()),
      GoRoute(
        path: '/authentication-screen',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const AuthenticationScreen(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 600),
          );
        },
      ),
      GoRoute(
        path: '/onboarding-name',
        builder: (context, state) => const NameOnboardingScreen(),
      ),
      GoRoute(
        path: '/onboarding-age',
        builder: (context, state) => const AgeOnboardingScreen(),
      ),
      GoRoute(
        path: '/onboarding-gender',
        builder: (context, state) => const GenderOnboardingScreen(),
      ),
      GoRoute(
        path: '/onboarding-interests',
        builder: (context, state) => const InterestOnboardingScreen(),
      ),
      GoRoute(
        path: '/onboarding-accountLoading',
        builder: (context, state) => const AccountLoadingScreen(),
      ),
      // /home
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/travel-progress',
        builder: (context, state) => const TravelProgressScreen(),
      ),
      GoRoute(path: '/chat', builder: (context, state) => const ChatScreen()),
      GoRoute(
        path: '/chat-details',
        builder: (context, state) => const DetailedChatScreen(),
      ),
      // Add more routes for Age, Gender, etc.
    ],
    errorBuilder:
        (context, state) => Scaffold(
          body: Center(child: Text('Page not found: ${state.error}')),
        ),
  );
}
