import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/screens/features/videos/view_models/timeline_view_model.dart';
import 'package:tiktok_clone/screens/features/videos/views/widgets/video_post_widget.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
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
    return;
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
    return ref.watch(timelineProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text("Could not load videos: $error"),
          ),
          data: (videos) => RefreshIndicator(
            onRefresh: () => Future.delayed(const Duration(seconds: 2)),
            displacement: 50,
            edgeOffset: 20,
            color: Theme.of(context).primaryColor,
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: videos.length,
              onPageChanged: onPageChanged,
              itemBuilder: (context, index) {
                return VideoPost(
                  onVideoFinished: onVideoFinished,
                  index: index,
                );
              },
            ),
          ),
        );
  }
}
