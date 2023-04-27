import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

final List<String> taps = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: taps.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const Text("Discover"),
          bottom: TabBar(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            tabs: [
              for (var tap in taps) Text(tap),
            ],
            isScrollable: true,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
            labelStyle: const TextStyle(
              fontSize: Sizes.size20,
              fontWeight: FontWeight.w600,
            ),
            indicatorColor: Colors.black,
            splashFactory: NoSplash.splashFactory,
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              padding: const EdgeInsets.all(Sizes.size10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,
                childAspectRatio: 9 / 16,
              ),
              itemCount: 20,
              itemBuilder: (context, index) => Container(
                color: Colors.lightBlueAccent,
                child: Center(
                  child: Text("$index"),
                ),
              ),
            ),
            for (var tap in taps.skip(1))
              Center(
                child: Text(
                  tap,
                  style: const TextStyle(
                    fontSize: Sizes.size28,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
