import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

enum Direction { left, right }

enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.left;
  Page _page = Page.first;
  void onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx < 0) {
      if (_direction == Direction.left) return;
      setState(() {
        _direction = Direction.left;
      });
    } else {
      if (_direction == Direction.right) return;
      setState(() {
        _direction = Direction.right;
      });
    }
  }

  void onPanEnd(DragEndDetails details) {
    if (_direction == Direction.left) {
      if (_page == Page.first) {
        setState(() {
          _page = Page.second;
        });
      }
    } else {
      if (_page == Page.second) {
        setState(() {
          _page = Page.first;
        });
      }
    }
  }

  void _onStartTap() {
    context.go("/home");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size24,
              horizontal: Sizes.size36,
            ),
            child: AnimatedCrossFade(
              firstChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Watch cool videos!",
                    style: TextStyle(
                      fontSize: Sizes.size32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v16,
                  Text(
                    "Videos are personalized for you based on what you watch, like, and share.",
                    style: TextStyle(
                      fontSize: Sizes.size20,
                    ),
                  ),
                ],
              ),
              secondChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Follow the rules",
                    style: TextStyle(
                      fontSize: Sizes.size32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v16,
                  Text(
                    "Videos are personalized for you based on what you watch, like, and share.",
                    style: TextStyle(
                      fontSize: Sizes.size20,
                    ),
                  ),
                ],
              ),
              crossFadeState: Page.first == _page
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size36,
            vertical: Sizes.size24,
          ),
          child: AnimatedOpacity(
            opacity: Page.second == _page ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: CupertinoButton(
              color: Theme.of(context).primaryColor,
              onPressed: Page.first == _page ? () {} : _onStartTap,
              child: const Text("Start"),
            ),
          ),
        ),
      ),
    );
  }
}
