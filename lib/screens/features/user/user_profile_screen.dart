import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/screens/features/settings/settings_screen.dart';
import 'package:tiktok_clone/screens/features/user/widgets/persistent_tab_bar.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  _onTapSettings() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: const Text("KWH9788"),
                actions: [
                  IconButton(
                    onPressed: _onTapSettings,
                    icon: const FaIcon(
                      FontAwesomeIcons.gear,
                      size: Sizes.size20,
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 45,
                      foregroundColor: Colors.blue,
                      foregroundImage: NetworkImage(
                        'https://avatars.githubusercontent.com/u/88845841',
                      ),
                      child: Text("우현"),
                    ),
                    Gaps.v14,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "@kwh9788",
                          style: TextStyle(
                            fontSize: Sizes.size16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gaps.h5,
                        FaIcon(
                          FontAwesomeIcons.solidCircleCheck,
                          color: Colors.blue.shade300,
                          size: Sizes.size14,
                        ),
                      ],
                    ),
                    Gaps.v20,
                    SizedBox(
                      height: Sizes.size48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          makeIndicator("37", "Following"),
                          VerticalDivider(
                            color: Colors.grey.shade300,
                            width: Sizes.size32,
                            thickness: Sizes.size1,
                            indent: Sizes.size14,
                            endIndent: Sizes.size14,
                          ),
                          makeIndicator("10.5M", "Followers"),
                          VerticalDivider(
                            color: Colors.grey.shade300,
                            width: Sizes.size32,
                            thickness: Sizes.size1,
                            indent: Sizes.size14,
                            endIndent: Sizes.size14,
                          ),
                          makeIndicator("149.3M", "Likes"),
                        ],
                      ),
                    ),
                    Gaps.v14,
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: Breakpoints.sm,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: FractionallySizedBox(
                              widthFactor: 1,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: Sizes.size14,
                                ),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius:
                                      BorderRadius.circular(Sizes.size2),
                                ),
                                child: const Text(
                                  "Follow",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Gaps.h6,
                          Flexible(
                            child: FractionallySizedBox(
                              widthFactor: 0.35,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: Sizes.size10,
                                ),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(Sizes.size2),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    )),
                                child: const FaIcon(FontAwesomeIcons.youtube),
                              ),
                            ),
                          ),
                          Gaps.h4,
                          Flexible(
                            child: FractionallySizedBox(
                              widthFactor: 0.35,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: Sizes.size14,
                                ),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(Sizes.size2),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    )),
                                child: const FaIcon(
                                  FontAwesomeIcons.caretDown,
                                  size: Sizes.size16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gaps.v12,
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: Sizes.size28),
                      child: Text(
                        "All highlights and where to watch live matches on FIFA+",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Gaps.v24,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        FaIcon(
                          FontAwesomeIcons.link,
                          size: Sizes.size12,
                        ),
                        Gaps.h4,
                        Text(
                          "https://www.fifa.com/fifaplus/en/home",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                    Gaps.v16,
                  ],
                ),
              ),
              SliverPersistentHeader(
                delegate: PersistentTabBar(),
                pinned: true,
              ),
            ];
          },
          body: SizedBox(
            child: TabBarView(
              children: [
                GridView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: width > Breakpoints.lg ? 5 : 3,
                    crossAxisSpacing: Sizes.size2,
                    mainAxisSpacing: Sizes.size2,
                    childAspectRatio: 9 / 13,
                  ),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    bool image = index % 2 == 0;
                    return Stack(
                      children: [
                        Positioned(
                          child: Container(
                            child: AspectRatio(
                              aspectRatio: 9 / 13,
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.cover,
                                placeholder:
                                    "assets/images/photo-1616578492900-ea5a8fc6c341.jpeg",
                                image:
                                    "https://images.unsplash.com/photo-1682687981922-7b55dbb30892?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1742&q=80",
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 7,
                          left: 7,
                          child: Row(
                            children: const [
                              FaIcon(
                                FontAwesomeIcons.play,
                                size: Sizes.size12,
                                color: Colors.white,
                              ),
                              Gaps.h7,
                              Text(
                                "29.6K",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Sizes.size12,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                        if (image)
                          const Positioned(
                            top: 4,
                            right: 4,
                            child: FaIcon(
                              FontAwesomeIcons.solidImage,
                              size: Sizes.size20,
                              color: Colors.white,
                            ),
                          )
                      ],
                    );
                  },
                ),
                const Center(
                  child: Text("Page two"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column makeIndicator(String num, String category) {
    return Column(
      children: [
        Text(
          num,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size20,
          ),
        ),
        Gaps.v5,
        Text(
          category,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: Sizes.size14,
          ),
        ),
      ],
    );
  }
}
