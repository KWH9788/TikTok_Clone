import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/screens/features/authentication/log_in_screen.dart';
import 'package:tiktok_clone/screens/features/authentication/username_screen.dart';
import 'package:tiktok_clone/screens/features/authentication/widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void onLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LogInScreen(),
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
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v24,
                  Text(
                    "Create a profile, follow other accounts, make your own videos, and more.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  Gaps.v32,
                  if (orientation == Orientation.portrait) ...[
                    AuthButton(
                      text: "Use phone & email",
                      icon: const FaIcon(FontAwesomeIcons.user),
                      onTapEvent: onEmailTap,
                    ),
                    AuthButton(
                      text: "Continue with Apple",
                      icon: const FaIcon(FontAwesomeIcons.apple),
                      onTapEvent: (context) {},
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
          bottomNavigationBar: BottomAppBar(
            elevation: 2,
            color: Colors.grey.shade100,
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
