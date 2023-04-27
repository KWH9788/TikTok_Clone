import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';

class NavTab extends StatelessWidget {
  final String text;
  final bool selected;
  final IconData icon;
  final IconData selectedicon;
  final Function onTap;
  final bool invert;
  const NavTab({
    super.key,
    required this.text,
    required this.selected,
    required this.icon,
    required this.selectedicon,
    required this.onTap,
    required this.invert,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          color: invert ? Colors.white : Colors.black,
          child: AnimatedOpacity(
            opacity: selected ? 1 : 0.7,
            duration: const Duration(milliseconds: 300),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  selected ? selectedicon : icon,
                  color: invert ? Colors.black : Colors.white,
                ),
                Gaps.v6,
                Text(
                  text,
                  style: TextStyle(
                    color: invert ? Colors.black : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
