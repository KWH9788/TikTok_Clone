import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/screens/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/screens/features/authentication/username_screen.dart';
import 'package:tiktok_clone/screens/features/authentication/widgets/auth_button.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  void onSignUpTap(BuildContext context) {
    Navigator.of(context).pop(
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  void onEmailTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              Text(
                "Manage your account, check notifications, comment on videos, and more.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              Gaps.v32,
              AuthButton(
                text: "Use phone & email",
                icon: const FaIcon(FontAwesomeIcons.user),
                onTapEvent: onEmailTap,
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
      bottomNavigationBar: BottomAppBar(
          elevation: 2,
          color: Colors.grey.shade100,
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
