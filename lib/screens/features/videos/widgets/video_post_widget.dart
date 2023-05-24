import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/screens/features/videos/widgets/ui_button.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'video_comments.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;
  final int index;
  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  // UI관련
  String script = "This is sample video, testing video player";
  bool scriptDetail = true;

  // 비디오관련
  final Duration animationDuration = const Duration(milliseconds: 300);
  bool onPlaying = true;
  bool mute = false;
  late final VideoPlayerController _videoPlayerController;
  late final AnimationController _animationController;

  void _initVideoPlayer() async {
    _videoPlayerController =
        VideoPlayerController.asset("assets/videos/analysis_options.mp4");
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    if (kIsWeb) {
      await _videoPlayerController.setVolume(0);
      mute = true;
    }
    _videoPlayerController.addListener(onFinish);
    setState(() {});
  }

  void onFinish() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    if (info.visibleFraction == 1 &&
        onPlaying &&
        !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      onTap();
    }
  }

  void onTap() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      onPlaying = false;
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      onPlaying = true;
      _animationController.forward();
    }
    setState(() {});
  }

  void onCommentTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      onTap();
    }
    await showModalBottomSheet(
      context: context,
      builder: (context) => const VideoComments(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
    onTap();
  }

  void onMute() {
    if (mute == true) {
      _videoPlayerController.setVolume(1);
    } else if (mute == false) {
      _videoPlayerController.setVolume(0);
    }
    setState(() {
      mute = !mute;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initVideoPlayer();

    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      duration: animationDuration,
    );
    if (script.length > 25) scriptDetail = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      onVisibilityChanged: _onVisibilityChanged,
      key: Key("${widget.index}"),
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: onTap,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: onPlaying ? 0 : 1,
                    duration: animationDuration,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size56,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "@kwh9788",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gaps.v20,
                Row(
                  children: [
                    Text(
                      !scriptDetail
                          ? "${script.substring(0, 24)} ... "
                          : script,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size16,
                      ),
                    ),
                    if (!scriptDetail)
                      GestureDetector(
                        onTap: () {
                          scriptDetail = true;
                          setState(() {});
                        },
                        child: const Text(
                          "See more",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Sizes.size16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            bottom: 20,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                      "https://avatars.githubusercontent.com/u/88845841?v=4"),
                  child: Text("우현"),
                ),
                Gaps.v28,
                const UiButton(icon: FontAwesomeIcons.solidHeart, text: "2.9M"),
                Gaps.v16,
                GestureDetector(
                  onTap: () => onCommentTap(context),
                  child: const UiButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: "33K",
                  ),
                ),
                Gaps.v16,
                const UiButton(icon: FontAwesomeIcons.share, text: "Share"),
                Gaps.v36,
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                      "https://avatars.githubusercontent.com/u/88845841?v=4"),
                  child: Text("우현"),
                ),
              ],
            ),
          ),
          Positioned(
            top: Sizes.size40,
            right: Sizes.size10,
            child: IconButton(
              icon: mute
                  ? const FaIcon(
                      FontAwesomeIcons.volumeXmark,
                      color: Colors.white,
                    )
                  : const FaIcon(
                      FontAwesomeIcons.volumeHigh,
                      color: Colors.white,
                    ),
              onPressed: onMute,
            ),
          ),
        ],
      ),
    );
  }
}
