import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitly/app/home_shell.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/app/splash_screen.dart';
import 'package:orbitly/features/achievements/presentation/screens/collection_screen.dart';
import 'package:orbitly/features/achievements/presentation/screens/wardrobe_screen.dart';
import 'package:orbitly/features/auth/presentation/controllers/auth_controller.dart';
import 'package:orbitly/features/auth/presentation/screens/login_screen.dart';
import 'package:orbitly/features/camera/presentation/screens/camera_screen.dart';
import 'package:orbitly/features/chat/presentation/screens/chat_screen.dart';
import 'package:orbitly/features/chat/presentation/screens/chats_screen.dart';
import 'package:orbitly/features/friends/presentation/screens/friends_screen.dart';
import 'package:orbitly/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:orbitly/features/planet/presentation/controllers/my_planet_controller.dart';
import 'package:orbitly/features/planet/presentation/screens/my_planet_screen.dart';
import 'package:orbitly/features/report/presentation/screens/report_screen.dart';
import 'package:orbitly/features/system/presentation/screens/system_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  // Re-run the redirect whenever sign-in or "has a planet" changes.
  final signedIn = ValueNotifier<AsyncValue<bool>>(const AsyncLoading());
  final hasPlanet = ValueNotifier<AsyncValue<bool>>(const AsyncLoading());
  ref
    ..listen(
      signedInProvider,
      (_, next) => signedIn.value = next,
      fireImmediately: true,
    )
    ..listen(
      hasPlanetProvider,
      (_, next) => hasPlanet.value = next,
      fireImmediately: true,
    );

  final router = GoRouter(
    initialLocation: AppRoutes.system,
    refreshListenable: Listenable.merge([signedIn, hasPlanet]),
    redirect: (context, state) {
      final location = state.matchedLocation;
      final auth = signedIn.value;
      if (auth is! AsyncData<bool>) {
        return location == AppRoutes.splash ? null : AppRoutes.splash;
      }
      if (!auth.value) {
        return location == AppRoutes.login ? null : AppRoutes.login;
      }
      final status = hasPlanet.value;
      if (status is! AsyncData<bool>) {
        return location == AppRoutes.splash ? null : AppRoutes.splash;
      }
      if (!status.value) {
        return location == AppRoutes.onboarding ? null : AppRoutes.onboarding;
      }
      if (location == AppRoutes.splash ||
          location == AppRoutes.onboarding ||
          location == AppRoutes.login) {
        return AppRoutes.system;
      }
      return null;
    },
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (_, _) => const SplashScreen()),
      GoRoute(path: AppRoutes.login, builder: (_, _) => const LoginScreen()),
      GoRoute(
        path: AppRoutes.collection,
        builder: (_, _) => const CollectionScreen(),
      ),
      GoRoute(
        path: AppRoutes.wardrobe,
        builder: (_, _) => const WardrobeScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (_, _) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, _, shell) => HomeShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.system,
                builder: (_, _) => const SystemScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.chats,
                builder: (_, _) => const ChatsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.friends,
                builder: (_, _) => const FriendsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.planet,
                builder: (_, _) => const MyPlanetScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/chat/:friendId',
        builder: (_, state) =>
            ChatScreen(friendId: state.pathParameters['friendId']!),
      ),
      GoRoute(
        path: AppRoutes.camera,
        pageBuilder: (_, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const CameraScreen(),
          transitionsBuilder: _slideFromRight,
        ),
      ),
      GoRoute(path: AppRoutes.report, builder: (_, _) => const ReportScreen()),
    ],
  );

  ref.onDispose(() {
    router.dispose();
    hasPlanet.dispose();
    signedIn.dispose();
  });
  return router;
}

/// The camera slides in from the right, continuing the swipe left.
Widget _slideFromRight(
  BuildContext context,
  Animation<double> animation,
  Animation<double> _,
  Widget child,
) {
  if (MediaQuery.disableAnimationsOf(context)) return child;
  return SlideTransition(
    position: animation.drive(
      Tween(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeOutCubic)),
    ),
    child: child,
  );
}
