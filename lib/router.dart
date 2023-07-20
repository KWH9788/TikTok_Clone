import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/screens/features/authentication/log_in_screen.dart';
import 'package:tiktok_clone/screens/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/screens/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/screens/features/inbox/activity_screen.dart';
import 'package:tiktok_clone/screens/features/inbox/chat_detail_screen.dart';
import 'package:tiktok_clone/screens/features/inbox/chats_screen.dart';
import 'package:tiktok_clone/screens/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/screens/features/videos/video_recording_screen.dart';

// 다른 Provider를 읽을 수 있게 GoRouter를 Provider안에 넣음
final routerProvider = Provider(
  (ref) {
    return GoRouter(
      initialLocation: "/home",
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepo).isLoggedIn;
        // subloc = sub location (user의 위치)
        if (!isLoggedIn) {
          if (state.subloc != SignUpScreen.routeUrl &&
              state.subloc != LogInScreen.routeUrl) {
            return SignUpScreen.routeUrl;
          }
        }
        return null;
      },
      routes: [
        GoRoute(
          name: SignUpScreen.routeName,
          path: SignUpScreen.routeUrl,
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          name: LogInScreen.routeName,
          path: LogInScreen.routeUrl,
          builder: (context, state) => const LogInScreen(),
        ),
        GoRoute(
          name: InterestsScreen.routeName,
          path: InterestsScreen.routeUrl,
          builder: (context, state) => const InterestsScreen(),
        ),
        GoRoute(
          name: MainNavigationScreen.routeName,
          path: "/:tab(home|discover|inbox|profile)",
          builder: (context, state) {
            final tab = state.params["tab"]!;
            return MainNavigationScreen(
              tab: tab,
            );
          },
        ),
        GoRoute(
          name: ActivityScreen.routeName,
          path: ActivityScreen.routeUrl,
          builder: (context, state) => const ActivityScreen(),
        ),
        GoRoute(
          name: ChatsScreen.routeName,
          path: ChatsScreen.routeUrl,
          builder: (context, state) => const ChatsScreen(),
          routes: [
            GoRoute(
              name: ChatDetailScreen.routeName,
              path: ChatDetailScreen.routeUrl,
              builder: (context, state) {
                final chatId = state.params["chatId"]!;
                return ChatDetailScreen(
                  chatId: chatId,
                );
              },
            ),
          ],
        ),
        GoRoute(
          name: VideoRecordingScreen.routeName,
          path: VideoRecordingScreen.routeUrl,
          pageBuilder: (context, state) => CustomTransitionPage(
            transitionDuration: const Duration(
              milliseconds: 200,
            ),
            child: const VideoRecordingScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final position = Tween(
                begin: const Offset(0, 1),
                end: const Offset(0, 0),
              ).animate(animation);
              return SlideTransition(
                position: position,
                child: child,
              );
            },
          ),
        ),
      ],
    );
  },
);
