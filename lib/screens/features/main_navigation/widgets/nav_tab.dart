import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';

class NavTab extends StatelessWidget {
  final String text;
  final bool selected;
  final IconData icon;
  final IconData selectedicon;
  final Function onTap;
  const NavTab({
    super.key,
    required this.text,
    required this.selected,
    required this.icon,
    required this.selectedicon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: AnimatedOpacity(
          opacity: selected ? 1 : 0.7,
          duration: const Duration(milliseconds: 300),
          child: Container(
            color: Colors.black,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  selected ? selectedicon : icon,
                  color: Colors.white,
                ),
                Gaps.v6,
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
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
