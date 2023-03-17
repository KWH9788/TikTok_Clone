import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class EmailScreen extends StatelessWidget {
  const EmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Sign up",
          style: TextStyle(
              color: Colors.black.withOpacity(0.9),
              fontWeight: FontWeight.w700,
              fontSize: Sizes.size20),
        ),
        backgroundColor: Colors.white.withOpacity(0),
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
          children: const [
            Text(
              "Create username",
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Gaps.v14,
            Text(
              "You can always change this later.",
              style: TextStyle(color: Colors.black45),
            ),
          ],
        ),
      ),
    );
  }
}
