import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/constants/utils.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  bool isCommenting = false;
  final ScrollController _scrollController = ScrollController();

  void onPopTap() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.75,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Scaffold(
        backgroundColor: isDark ? null : Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: isDark ? null : Colors.grey.shade50,
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
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            isCommenting = false;
            setState(() {});
          },
          child: Scrollbar(
            controller: _scrollController,
            child: Stack(
              children: [
                ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(
                    left: Sizes.size16,
                    right: Sizes.size16,
                    top: Sizes.size10,
                    bottom: Sizes.size96 + Sizes.size20,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                isDark ? Colors.grey.shade500 : null,
                            foregroundColor: isDark ? Colors.white : null,
                            child: const Text("우현"),
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
                Positioned(
                  bottom: 0,
                  width: size.width,
                  child: Container(
                    padding: const EdgeInsets.only(
                      bottom: Sizes.size28,
                      top: Sizes.size5,
                    ),
                    color: Theme.of(context).scaffoldBackgroundColor,
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
                          Gaps.h10,
                          Expanded(
                            child: SizedBox(
                              height: Sizes.size44,
                              child: TextField(
                                onTap: () {
                                  setState(() {
                                    isCommenting = true;
                                  });
                                },
                                expands: true,
                                minLines: null,
                                maxLines: null,
                                textInputAction: TextInputAction.newline,
                                cursorColor: Theme.of(context).primaryColor,
                                decoration: InputDecoration(
                                  suffixIconColor: isDark
                                      ? Colors.grey.shade300
                                      : Colors.grey.shade900,
                                  filled: true,
                                  fillColor: isDark
                                      ? Colors.grey.shade900
                                      : Colors.grey.shade100,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: Sizes.size12,
                                  ),
                                  hintText: "Add comment...",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.circular(Sizes.size16),
                                  ),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: Sizes.size10,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const FaIcon(
                                          FontAwesomeIcons.at,
                                        ),
                                        Gaps.h14,
                                        const FaIcon(
                                          FontAwesomeIcons.gift,
                                        ),
                                        Gaps.h14,
                                        const FaIcon(
                                          FontAwesomeIcons.faceSmile,
                                        ),
                                        if (isCommenting) Gaps.h14,
                                        if (isCommenting)
                                          GestureDetector(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              isCommenting = false;
                                              setState(() {});
                                            },
                                            child: const FaIcon(
                                              FontAwesomeIcons.paperPlane,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
