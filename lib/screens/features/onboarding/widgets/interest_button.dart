import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class InterestButton extends StatefulWidget {
  const InterestButton({
    super.key,
    required this.interest,
  });

  final String interest;

  @override
  State<InterestButton> createState() => _InterestButtonState();
}

class _InterestButtonState extends State<InterestButton> {
  bool _onSelected = false;
  void _onTap() {
    setState(() {
      _onSelected = !_onSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
          color: _onSelected ? Theme.of(context).primaryColor : Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.09)),
          borderRadius: BorderRadius.circular(Sizes.size24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size16,
          vertical: Sizes.size14,
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 100),
          style: TextStyle(
            color: _onSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
          child: Text(
            widget.interest,
          ),
        ),
      ),
    );
  }
}
