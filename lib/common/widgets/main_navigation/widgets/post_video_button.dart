import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/constants/utils.dart';

class PostVideoButton extends StatelessWidget {
  bool inverted;
  PostVideoButton({
    super.key,
    required this.inverted,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: Sizes.size24,
          child: Container(
            height: Sizes.size32,
            width: Sizes.size24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.size9),
              color: const Color(0xff61D4F0),
            ),
          ),
        ),
        Positioned(
          left: Sizes.size24,
          child: Container(
            height: Sizes.size32,
            width: Sizes.size24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.size9),
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: Sizes.size32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.size9),
            color: isDark ? Colors.white : Colors.black,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size12),
            child: FaIcon(
              FontAwesomeIcons.plus,
              color: isDark ? Colors.black : Colors.white,
              size: Sizes.size20,
            ),
          ),
        ),
      ],
    );
  }
}
