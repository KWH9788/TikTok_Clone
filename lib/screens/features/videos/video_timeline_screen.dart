import 'package:flutter/material.dart';
import 'package:tiktok_clone/screens/features/videos/widgets/video_post_widget.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  final Duration animatedDuration = const Duration(milliseconds: 300);
  final Curve pageCurvers = Curves.linear;
  final PageController _pageController = PageController();
  int _itemCount = 4;

  void onPageChanged(int index) {
    _pageController.animateToPage(
      index,
      duration: animatedDuration,
      curve: pageCurvers,
    );
    if (index == _itemCount - 1) {
      _itemCount += 4;
      setState(() {});
    }
    print(index % 4);
  }

  void onVideoFinished() {
    _pageController.nextPage(
      duration: animatedDuration,
      curve: pageCurvers,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemCount: _itemCount,
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) {
        return VideoPost(
          onVideoFinished: onVideoFinished,
          index: index,
        );
      },
    );
  }
}
