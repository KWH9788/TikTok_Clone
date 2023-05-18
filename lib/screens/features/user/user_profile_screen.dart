import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text("KWH9788"),
            actions: [
              IconButton(
                onPressed: () {},
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
                FractionallySizedBox(
                  widthFactor: 0.4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.size14,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(Sizes.size2),
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
                Container(
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: Colors.grey.shade300,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: const TabBar(
                    labelColor: Colors.black,
                    indicatorColor: Colors.black,
                    labelPadding: EdgeInsets.symmetric(vertical: Sizes.size12),
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Sizes.size20),
                        child: Icon(Icons.grid_4x4_rounded),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Sizes.size20),
                        child: FaIcon(FontAwesomeIcons.heart),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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
