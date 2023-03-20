import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  String username = "";
  final TextEditingController _usernameController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernameController.addListener(() {
      setState(() {
        username = _usernameController.text;
      });
    });
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
              "Create username",
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Gaps.v14,
            const Text(
              "You can always change this later.",
              style: TextStyle(color: Colors.black45),
            ),
            Gaps.v28,
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: "Username",
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
            FractionallySizedBox(
              widthFactor: 1,
              child: AnimatedContainer(
                padding: const EdgeInsets.symmetric(vertical: Sizes.size14),
                decoration: BoxDecoration(
                  color: username.isEmpty
                      ? Colors.grey.shade200
                      : Theme.of(context).primaryColor,
                ),
                duration: const Duration(milliseconds: 100),
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: TextStyle(
                      color: username.isEmpty
                          ? Colors.grey.shade500
                          : Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: Sizes.size16),
                  child: const Text(
                    "Next",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
