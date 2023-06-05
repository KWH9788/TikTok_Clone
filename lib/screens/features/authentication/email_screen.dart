import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/screens/features/authentication/password_screen.dart';
import 'package:tiktok_clone/screens/features/authentication/widgets/form_button.dart';

class EmailScreenArgs {
  final username;
  EmailScreenArgs({required this.username});
}

class EmailScreen extends StatefulWidget {
  static String routeName = "/email";
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  String email = "";
  final TextEditingController _emailController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 컨트롤러
    _emailController.addListener(() {
      setState(() {
        email = _emailController.text;
      });
    });
  }

  // 메모리에서 컨트롤러 제거
  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  // 키보드창 탈출
  void onScaffordTap() {
    FocusScope.of(context).unfocus();
  }

  // 이메일 유효성 검사
  String? _isEmailValid() {
    if (email.isEmpty) return null;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(email)) return "Email not valid";

    return null;
  }

  void _onSubmit() {
    if (email.isEmpty || _isEmailValid() != null) return;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PasswordScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as EmailScreenArgs;

    return GestureDetector(
      onTap: () => onScaffordTap(),
      child: Scaffold(
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
              Text(
                "What is your Email, ${args.username}?",
                style: const TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gaps.v28,
              // Email 입력창
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                onEditingComplete: () => _onSubmit(),
                decoration: InputDecoration(
                  hintText: "Email",
                  errorText: _isEmailValid(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v32,
              GestureDetector(
                onTap: () => _onSubmit(),
                child: FormButton(
                    disabled: email.isEmpty || _isEmailValid() != null
                        ? true
                        : false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
