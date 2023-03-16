import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;
  const AuthButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Sizes.size7),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(Sizes.size14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
