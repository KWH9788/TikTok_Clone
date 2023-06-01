import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/constants/utils.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  List<String> listTiles = List.generate(20, (index) => "${index}h");

  bool modalBarrier = false;
  final List<Map<String, dynamic>> _tabs = [
    {
      "title": "All activity",
      "icon": FontAwesomeIcons.solidMessage,
    },
    {
      "title": "Likes",
      "icon": FontAwesomeIcons.solidHeart,
    },
    {
      "title": "Comments",
      "icon": FontAwesomeIcons.solidComments,
    },
    {
      "title": "Mentions",
      "icon": FontAwesomeIcons.at,
    },
    {
      "title": "Followers",
      "icon": FontAwesomeIcons.solidUser,
    },
    {
      "title": "From TikTok",
      "icon": FontAwesomeIcons.tiktok,
    },
  ];

  late final AnimationController _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ));

  late final Animation<double> _turnAnimation =
      Tween(begin: 0.0, end: 0.5).animate(_animationController);

  late final Animation<Offset> _positionAnimation =
      Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
          .animate(_animationController);

  late final Animation<Color?> _colorAnimation =
      ColorTween(begin: Colors.transparent, end: Colors.grey.withOpacity(0.4))
          .animate(_animationController);

  void _onDismissed(String listtile) {
    listTiles.remove(listtile);
    setState(() {});
  }

  void _onTitleTap() async {
    if (_animationController.isCompleted) {
      await _animationController.reverse();
    } else {
      _animationController.forward();
    }

    setState(() {
      modalBarrier = !modalBarrier;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _onTitleTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("All activity"),
              Gaps.h3,
              RotationTransition(
                turns: _turnAnimation,
                child: const FaIcon(
                  FontAwesomeIcons.angleDown,
                  size: Sizes.size16,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              ListTile(
                title: Text(
                  "New",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              for (var listtile in listTiles)
                Dismissible(
                  onDismissed: (direction) => _onDismissed(listtile),
                  key: Key(listtile),
                  background: Container(
                    alignment: Alignment.centerLeft,
                    color: Colors.green,
                    child: const Padding(
                      padding: EdgeInsets.only(
                        left: Sizes.size10,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.check,
                        color: Colors.white,
                        size: Sizes.size32,
                      ),
                    ),
                  ),
                  secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.only(
                        right: Sizes.size10,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.trashCan,
                        color: Colors.white,
                        size: Sizes.size32,
                      ),
                    ),
                  ),
                  child: ListTile(
                    minVerticalPadding: Sizes.size16,
                    leading: Container(
                      width: Sizes.size56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDark ? Colors.grey.shade900 : Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.bell,
                          size: Sizes.size28,
                        ),
                      ),
                    ),
                    title: Text.rich(
                      TextSpan(
                        text: "Account updates:",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Sizes.size16,
                        ),
                        children: [
                          const TextSpan(
                            text: " Upload longer videos",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                            text: " $listtile",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: const FaIcon(
                      FontAwesomeIcons.angleRight,
                    ),
                  ),
                ),
            ],
          ),
          if (modalBarrier)
            AnimatedModalBarrier(
              color: _colorAnimation,
              dismissible: true,
              onDismiss: _onTitleTap,
            ),
          SlideTransition(
            position: _positionAnimation,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(Sizes.size6),
                  bottomRight: Radius.circular(Sizes.size6),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var tab in _tabs)
                    ListTile(
                      title: Row(
                        children: [
                          Icon(
                            tab["icon"],
                            size: Sizes.size16,
                          ),
                          Gaps.h16,
                          Text(
                            tab["title"],
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
