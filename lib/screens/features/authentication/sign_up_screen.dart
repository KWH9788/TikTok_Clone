import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/constants/utils.dart';
import 'package:tiktok_clone/screens/features/authentication/log_in_screen.dart';
import 'package:tiktok_clone/screens/features/authentication/username_screen.dart';
import 'package:tiktok_clone/screens/features/authentication/widgets/auth_button.dart';

import '../videos/view_models/social_auth_view_model.dart';

class SignUpScreen extends ConsumerWidget {
  static String routeName = "signup";
  static String routeUrl = "/";
  const SignUpScreen({super.key});

  void onLoginTap(BuildContext context) async {
    context.pushNamed(LogInScreen.routeName);
  }

  void onEmailTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(MediaQuery.of(context).platformBrightness);
    return OrientationBuilder(
      builder: (context, orientation) {
        print(orientation);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
              child: Column(
                children: [
                  Gaps.v52,
                  const Text(
                    "Sign Up for TikTok",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: Sizes.size24,
                    ),
                  ),
                  Gaps.v24,
                  const Opacity(
                    opacity: 0.5,
                    child: Text(
                        "Create a profile, follow other accounts, make your own videos, and more.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: Sizes.size16,
                        )),
                  ),
                  Gaps.v32,
                  if (orientation == Orientation.portrait) ...[
                    AuthButton(
                      text: "Use phone & email",
                      icon: const FaIcon(FontAwesomeIcons.user),
                      onTapEvent: onEmailTap,
                    ),
                    AuthButton(
                      text: "Continue with Github",
                      icon: const FaIcon(FontAwesomeIcons.github),
                      onTapEvent: (context) => ref
                          .read(socialAuthProvider.notifier)
                          .githubSignIn(context),
                    ),
                  ],
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: AuthButton(
                            text: "Use phone & email",
                            icon: const FaIcon(FontAwesomeIcons.user),
                            onTapEvent: onEmailTap,
                          ),
                        ),
                        Gaps.h14,
                        Expanded(
                          child: AuthButton(
                            text: "Continue with Apple",
                            icon: const FaIcon(FontAwesomeIcons.apple),
                            onTapEvent: (context) {},
                          ),
                        ),
                      ],
                    ),
                  Gaps.v16,
                  const Icon(
                    Icons.keyboard_arrow_down_sharp,
                    size: Sizes.size32,
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.only(
              top: Sizes.size12,
              bottom: Sizes.size24,
            ),
            color: isDarkMode(context)
                ? Colors.grey.shade900
                : Colors.grey.shade100,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.size24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: Sizes.size14,
                    ),
                  ),
                  Gaps.h3,
                  GestureDetector(
                    onTap: () => onLoginTap(context),
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        fontSize: Sizes.size14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
