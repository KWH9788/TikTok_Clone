import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/constants/utils.dart';
import 'package:tiktok_clone/screens/features/discover/discover_screen.dart';
import 'package:tiktok_clone/screens/features/inbox/inbox_screen.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/screens/features/user/user_profile_screen.dart';
import 'package:tiktok_clone/screens/features/videos/video_recording_screen.dart';
import 'package:tiktok_clone/screens/features/videos/video_timeline_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  static const String routeName = "mainNavigation";
  String tab;
  MainNavigationScreen({
    super.key,
    required this.tab,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = [
    "home",
    "discover",
    "post",
    "inbox",
    "profile",
  ];

  late int _currentScreen = _tabs.indexOf(widget.tab);

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
    context.go("/${_tabs[index]}");
    setState(() {
      _currentScreen = index;
    });
    print(_currentScreen);
  }

  _onPostTap() {
    context.pushNamed(VideoRecordingScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:
          _currentScreen == 0 || isDark ? Colors.black : Colors.white,
      body: Stack(
        children: [
          Offstage(
            offstage: _currentScreen != 0,
            child: const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: _currentScreen != 1,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _currentScreen != 3,
            child: const InboxScreen(),
          ),
          Offstage(
            offstage: _currentScreen != 4,
            child: const UserProfileScreen(
              username: "KWH9788",
              tab: "",
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: Sizes.size24),
        color: _currentScreen == 0 || isDark ? Colors.black : Colors.white,
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
                invert: _currentScreen != 0,
              ),
              NavTab(
                text: "Discover",
                selected: _currentScreen == 1,
                icon: FontAwesomeIcons.compass,
                selectedicon: FontAwesomeIcons.solidCompass,
                onTap: () => _onTabTap(1),
                invert: _currentScreen != 0,
              ),
              Gaps.h12,
              GestureDetector(
                onTap: _onPostTap,
                child: PostVideoButton(inverted: isDark),
              ),
              Gaps.h12,
              NavTab(
                text: "Inbox",
                selected: _currentScreen == 3,
                icon: FontAwesomeIcons.message,
                selectedicon: FontAwesomeIcons.solidMessage,
                onTap: () => _onTabTap(3),
                invert: _currentScreen != 0,
              ),
              NavTab(
                text: "Profile",
                selected: _currentScreen == 4,
                icon: FontAwesomeIcons.user,
                selectedicon: FontAwesomeIcons.solidUser,
                onTap: () => _onTabTap(4),
                invert: _currentScreen != 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
