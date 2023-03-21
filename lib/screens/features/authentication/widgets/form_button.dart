import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class FormButton extends StatelessWidget {
  FormButton({
    super.key,
    required this.disabled,
  });

  bool disabled;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(vertical: Sizes.size14),
        decoration: BoxDecoration(
          color:
              disabled ? Colors.grey.shade200 : Theme.of(context).primaryColor,
        ),
        duration: const Duration(milliseconds: 100),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: TextStyle(
              color: disabled ? Colors.grey.shade500 : Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: Sizes.size16),
          child: const Text(
            "Next",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
