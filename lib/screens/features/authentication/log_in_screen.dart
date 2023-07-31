import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/constants/utils.dart';
import 'package:tiktok_clone/screens/features/authentication/login_form_screen.dart';
import 'package:tiktok_clone/screens/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/screens/features/videos/view_models/social_auth_view_model.dart';

class LogInScreen extends ConsumerWidget {
  static String routeUrl = "/login";
  static String routeName = "login";
  const LogInScreen({super.key});

  void onSignUpTap(BuildContext context) {
    context.pop();
  }

  void onEmailTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginFormScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
          child: Column(
            children: [
              Gaps.v52,
              const Text(
                "Log in to TikTok",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v24,
              const Opacity(
                opacity: 0.5,
                child: Text(
                  "Manage your account, check notifications, comment on videos, and more.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Sizes.size16,
                  ),
                ),
              ),
              Gaps.v32,
              AuthButton(
                text: "Use email & password",
                icon: const FaIcon(FontAwesomeIcons.user),
                onTapEvent: onEmailTap,
              ),
              Gaps.v16,
              AuthButton(
                text: "Continue with Github",
                icon: const FaIcon(FontAwesomeIcons.github),
                onTapEvent: (context) =>
                    ref.read(socialAuthProvider.notifier).githubSignIn(context),
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
          color:
              isDarkMode(context) ? Colors.grey.shade900 : Colors.grey.shade50,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.size24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(
                    fontSize: Sizes.size14,
                  ),
                ),
                Gaps.h3,
                GestureDetector(
                  onTap: () => onSignUpTap(context),
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: Sizes.size14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
