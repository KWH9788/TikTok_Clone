import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/screens/features/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/screens/features/videos/video_timeline_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentScreen = 0;
  final screens = [
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Text("Home"),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Text("Search"),
      ],
    ),
  ];

  _onTabTap(int index) {
    setState(() {
      _currentScreen = index;
    });
    print(_currentScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: _currentScreen != 0,
            child: const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: _currentScreen != 1,
            child: const Center(
              child: Text(
                "Discover",
                style: TextStyle(fontSize: Sizes.size28),
              ),
            ),
          ),
          Offstage(
            offstage: _currentScreen != 3,
            child: const Center(
              child: Text(
                "Inbox",
                style: TextStyle(fontSize: Sizes.size28),
              ),
            ),
          ),
          Offstage(
            offstage: _currentScreen != 4,
            child: const Center(
              child: Text(
                "Profile",
                style: TextStyle(fontSize: Sizes.size28),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: "Home",
                selected: _currentScreen == 0,
                icon: FontAwesomeIcons.house,
                selectedicon: FontAwesomeIcons.house,
                onTap: () => _onTabTap(0),
              ),
              NavTab(
                text: "Discover",
                selected: _currentScreen == 1,
                icon: FontAwesomeIcons.compass,
                selectedicon: FontAwesomeIcons.solidCompass,
                onTap: () => _onTabTap(1),
              ),
              Gaps.h12,
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: Sizes.size24,
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
                    right: Sizes.size24,
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
                      color: Colors.white,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: Sizes.size12),
                      child: FaIcon(
                        FontAwesomeIcons.plus,
                        color: Colors.black,
                        size: Sizes.size20,
                      ),
                    ),
                  ),
                ],
              ),
              Gaps.h12,
              NavTab(
                text: "Inbox",
                selected: _currentScreen == 3,
                icon: FontAwesomeIcons.message,
                selectedicon: FontAwesomeIcons.solidMessage,
                onTap: () => _onTabTap(3),
              ),
              NavTab(
                text: "Profile",
                selected: _currentScreen == 4,
                icon: FontAwesomeIcons.user,
                selectedicon: FontAwesomeIcons.solidUser,
                onTap: () => _onTabTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
