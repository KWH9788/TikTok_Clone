import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/screens/features/authentication/birthday_screen.dart';
import 'package:tiktok_clone/screens/features/authentication/widgets/form_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  String password = "";
  bool _obscure = true;
  bool lenghtCheak = false;
  bool mustIncludeCheck = false;
  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordController.dispose();
    super.dispose();
  }

  bool _isLenghtCheck() {
    if (password.length >= 8) {
      setState(() {
        lenghtCheak = true;
      });
      return true;
    } else {
      setState(() {
        lenghtCheak = false;
      });
      return false;
    }
  }

  bool _isMustIncludeCheck() {
    final regExp = RegExp(
        r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$");
    if (regExp.hasMatch(password)) {
      setState(() {
        mustIncludeCheck = true;
      });
      return true;
    }
    setState(() {
      mustIncludeCheck = false;
    });
    return false;
  }

  bool _isPasswordValied() {
    // 규칙 체크
    if (!_isLenghtCheck()) return true;
    if (_isMustIncludeCheck()) return false;
    return true;
  }

  void onClearTap() {
    _passwordController.clear();
  }

  void onObscureTap() {
    setState(() {
      _obscure = !_obscure;
    });
  }

  void _onSubmit() {
    if (_isPasswordValied()) return;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BirthdayScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign up",
        ),
        // actions: [
        //   Text(
        //     "Skip",
        //     style: TextStyle(
        //         color: Colors.black.withOpacity(0.45),
        //         fontSize: Sizes.size20,
        //         fontWeight: FontWeight.w400),
        //   ),
        //   FaIcon(
        //     FontAwesomeIcons.circleQuestion,
        //     color: Colors.black.withOpacity(0.45),
        //   )
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size32,
          vertical: Sizes.size24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create password",
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gaps.v28,
            TextField(
              controller: _passwordController,
              obscureText: _obscure,
              decoration: InputDecoration(
                suffix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: onClearTap,
                      child: FaIcon(
                        FontAwesomeIcons.solidCircleXmark,
                        size: Sizes.size16,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    Gaps.h20,
                    GestureDetector(
                      onTap: onObscureTap,
                      child: FaIcon(
                        _obscure
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                        size: Sizes.size16,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    Gaps.h16,
                  ],
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),
            Gaps.v10,
            const Text(
              "Your password must have:",
              style: TextStyle(
                fontSize: Sizes.size12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Gaps.v10,
            Row(
              children: [
                Icon(
                  Icons.check_circle_outline_outlined,
                  size: Sizes.size20,
                  color: _isLenghtCheck() ? Colors.green : Colors.red,
                ),
                const Text(
                  "8 to 20 characters",
                  style: TextStyle(
                    fontSize: Sizes.size12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.check_circle_outline_outlined,
                  size: Sizes.size20,
                  color: _isMustIncludeCheck() ? Colors.green : Colors.red,
                ),
                const Text(
                  "Letters, numbers, and special characters",
                  style: TextStyle(
                    fontSize: Sizes.size12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            Gaps.v32,
            GestureDetector(
              onTap: _onSubmit,
              child: FormButton(disabled: _isPasswordValied()),
            ),
          ],
        ),
      ),
    );
  }
}
