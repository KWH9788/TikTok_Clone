import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/screens/features/authentication/email_screen.dart';
import 'package:tiktok_clone/screens/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/screens/features/authentication/username_screen.dart';
import 'package:tiktok_clone/screens/features/user/user_profile_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeUrl,
      builder: (context, state) => const SignUpScreen(),
      routes: [
        GoRoute(
          path: UsernameScreen.routeUrl,
          name: UsernameScreen.routeName,
          builder: (context, state) => const UsernameScreen(),
          routes: [
            GoRoute(
              path: EmailScreen.routeUrl,
              name: EmailScreen.routeName,
              builder: (context, state) {
                final arg = state.extra as EmailScreenArgs;
                return EmailScreen(username: arg.username);
              },
            ),
          ],
        ),
      ],
    ),
    // GoRoute(
    //   path: LogInScreen.routeName,
    //   builder: (context, state) => const LogInScreen(),
    // ),

    // GoRoute(
    //   path: UsernameScreen.routeName,
    //   pageBuilder: (context, state) {
    //     return CustomTransitionPage(
    //       child: const UsernameScreen(),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         return FadeTransition(
    //           opacity: animation,
    //           child: child,
    //         );
    //       },
    //     );
    //   },
    // ),

    GoRoute(
      path: "/users/:username",
      builder: (context, state) {
        final username = state.params['username'];
        final tab = state.queryParams['show'];
        return UserProfileScreen(
          username: username,
          tab: tab,
        );
      },
    )
  ],
);
