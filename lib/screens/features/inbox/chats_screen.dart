import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/screens/features/inbox/chat_detail_screen.dart';

class ChatsScreen extends StatefulWidget {
  static const String routeName = "chats";
  static const String routeUrl = "/chats";
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();
  final List<int> _tileList = [];
  final Duration _duration = const Duration(milliseconds: 300);

  void addTile() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(
        _tileList.length,
        duration: _duration,
      );
      _tileList.add(_tileList.length);
    }
  }

  void _deleteItem(int index) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(
        index,
        (context, animation) => FadeTransition(
          opacity: animation,
          child: SizeTransition(
            sizeFactor: animation,
            child: makeTile(index),
          ),
        ),
        duration: _duration,
      );
      _tileList.removeAt(index);
    }
  }

  void _tapChatDetail(int index) {
    context.pushNamed(
      ChatDetailScreen.routeName,
      params: {"chatId": "$index"},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Direct messages"),
        elevation: 1,
        actions: [
          IconButton(
            onPressed: addTile,
            icon: const FaIcon(FontAwesomeIcons.plus),
          ),
        ],
      ),
      body: AnimatedList(
        key: _key,
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        itemBuilder: (context, index, animation) {
          return FadeTransition(
            key: Key("$index"),
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              child: makeTile(index),
            ),
          );
        },
      ),
    );
  }

  Widget makeTile(int index) {
    return ListTile(
      onLongPress: () => _deleteItem(index),
      onTap: () => _tapChatDetail(index),
      leading: const CircleAvatar(
        radius: 30,
        foregroundImage: NetworkImage(
            "https://avatars.githubusercontent.com/u/88845841?v=4"),
        child: Text("우현"),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "index($index)",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "2:16 PM",
            style: TextStyle(
              fontSize: Sizes.size14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
      subtitle: const Text("Say hi to AntonioBM"),
    );
  }
}
