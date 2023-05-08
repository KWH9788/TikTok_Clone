import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
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

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  bool searchFormEmpty = true;

  void _onChanged() {
    if (_textEditingController.text.isNotEmpty) {
      setState(() {
        searchFormEmpty = false;
      });
      print("search for ${_textEditingController.text}");
    } else {
      setState(() {
        searchFormEmpty = true;
      });
    }
  }

  void _onSubmitted(String value) {
    print("submit $value");
  }

  void _onPressXmark() {
    if (!searchFormEmpty) _textEditingController.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController.addListener(_onChanged);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: taps.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          title: TextField(
            controller: _textEditingController,
            textInputAction: TextInputAction.search,
            onSubmitted: _onSubmitted,
            style: const TextStyle(
              fontSize: Sizes.size16,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: Sizes.size11,
              ),
              prefixIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: Colors.black,
                  ),
                ],
              ),
              suffixIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    splashColor: Colors.transparent,
                    style: const ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                    ),
                    onPressed: _onPressXmark,
                    icon: FaIcon(
                      FontAwesomeIcons.solidCircleXmark,
                      size: Sizes.size20,
                      color: searchFormEmpty
                          ? Colors.grey.shade100
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(Sizes.size10)),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
          ),
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
            onTap: (value) => FocusScope.of(context).unfocus(),
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.all(Sizes.size10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,
                childAspectRatio: 9 / 20,
              ),
              itemCount: 20,
              itemBuilder: (context, index) => Column(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Sizes.size4),
                    ),
                    child: AspectRatio(
                      aspectRatio: 9 / 16,
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder:
                            "assets/images/photo-1616578492900-ea5a8fc6c341.jpeg",
                        image:
                            "https://images.unsplash.com/photo-1682687981922-7b55dbb30892?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1742&q=80",
                      ),
                    ),
                  ),
                  Gaps.v10,
                  const Text(
                    "This is a very long caption for my  tiktok that im upload just now currently.",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gaps.v6,
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: Sizes.size14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: Sizes.size14,
                          backgroundImage: NetworkImage(
                              "https://avatars.githubusercontent.com/u/88845841?v=4"),
                        ),
                        Gaps.h5,
                        const Expanded(
                          child: Text(
                            "My avatar is very long name",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Gaps.h3,
                        FaIcon(
                          FontAwesomeIcons.heart,
                          size: Sizes.size16,
                          color: Colors.grey.shade600,
                        ),
                        Gaps.h3,
                        const Text(
                          "2.0M",
                        ),
                      ],
                    ),
                  )
                ],
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
