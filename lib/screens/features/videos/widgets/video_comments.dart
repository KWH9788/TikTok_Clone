import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  void onPopTap() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          automaticallyImplyLeading: false,
          title: const Text("22796 comments"),
          actions: [
            IconButton(
              onPressed: onPopTap,
              icon: const FaIcon(
                FontAwesomeIcons.xmark,
              ),
            )
          ],
        ),
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size16,
            vertical: Sizes.size10,
          ),
          itemBuilder: (context, index) {
            return Container(
              child: Row(
                children: [
                  const CircleAvatar(
                    child: Text("우현"),
                  ),
                  Gaps.h10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "우현",
                          style: TextStyle(
                            color: Colors.grey.shade800,
                          ),
                        ),
                        Gaps.v5,
                        const Text(
                            "That's not it l've seen the same thing but also in a cave")
                      ],
                    ),
                  ),
                  Gaps.h10,
                  Column(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.heart,
                        size: Sizes.size24,
                        color: Colors.grey.shade500,
                      ),
                      Gaps.v2,
                      Text(
                        "52.2k",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => Gaps.v16,
          itemCount: 10,
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
              vertical: Sizes.size10,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.shade500,
                  foregroundColor: Colors.white,
                  child: const Text("우현"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
