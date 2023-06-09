import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/constants/utils.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final FaIcon icon;
  final void Function(BuildContext context) onTapEvent;

  const AuthButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTapEvent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapEvent(context),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size7),
          child: Container(
            padding: const EdgeInsets.all(Sizes.size14),
            decoration: BoxDecoration(
              border: Border.all(
                color: isDarkMode(context)
                    ? Colors.grey.shade800
                    : Colors.grey.shade300,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: icon,
                ),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
