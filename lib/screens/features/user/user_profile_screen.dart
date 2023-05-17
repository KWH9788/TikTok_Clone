import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          stretch: true,
          floating: true,
          backgroundColor: Colors.teal,
          collapsedHeight: 80,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.blurBackground,
              StretchMode.zoomBackground,
              StretchMode.fadeTitle,
            ],
            background: Image.asset(
              "assets/images/space-gab40051d8_1920.jpg",
              fit: BoxFit.cover,
            ),
            title: const Text("Hello!"),
          ),
        ),
        SliverPersistentHeader(
          delegate: CustomDelegate(),
          pinned: true,
        ),
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            childCount: 50,
            (context, index) => Container(
              alignment: Alignment.center,
              color: Colors.amber[100 * (index % 9)],
              child: Text(
                "item $index",
              ),
            ),
          ),
          itemExtent: 100,
        ),
        SliverPersistentHeader(
          delegate: CustomDelegateGrid(),
          pinned: true,
        ),
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            childCount: 50,
            (context, index) => Container(
              alignment: Alignment.center,
              color: Colors.blue[100 * (index % 9)],
              child: Text(
                "item $index",
              ),
            ),
          ),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100,
            mainAxisSpacing: Sizes.size20,
            crossAxisSpacing: Sizes.size20,
            childAspectRatio: 1,
          ),
        )
      ],
    );
  }
}

class CustomDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      alignment: Alignment.center,
      color: Colors.amber,
      child: const Text(
        "List",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class CustomDelegateGrid extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      alignment: Alignment.center,
      color: Colors.blue,
      child: const Text(
        "Grid",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
