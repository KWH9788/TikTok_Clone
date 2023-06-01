import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/constants/utils.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  void inputEvent() {
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController.addListener(inputEvent);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode(context) ? null : Colors.grey.shade100,
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size10,
          leading: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              const CircleAvatar(
                radius: 20,
                foregroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/88845841?v=4"),
                child: Text("우현"),
              ),
              Positioned(
                left: 23,
                top: 13,
                width: 22,
                child: CircleAvatar(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.greenAccent[700],
                      border: Border.all(
                        color: Colors.grey.shade100,
                        width: 4,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          title: const Text(
            "xxxxmmm967",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: const Opacity(
            opacity: 0.8,
            child: Text(
              "Active now",
              style: TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                color: isDarkMode(context) ? Colors.white : Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h24,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: isDarkMode(context) ? Colors.white : Colors.black,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
      backgroundColor:
          isDarkMode(context) ? Colors.grey.shade900 : Colors.grey.shade100,
      body: Stack(
        children: [
          ListView.separated(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size16,
              horizontal: Sizes.size14,
            ),
            itemCount: 10,
            itemBuilder: (context, index) {
              final bool isMine = index % 2 != 0;
              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment:
                    isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(Sizes.size14),
                    decoration: BoxDecoration(
                      color:
                          isMine ? Colors.blue : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(Sizes.size28),
                        topRight: const Radius.circular(Sizes.size28),
                        bottomLeft: Radius.circular(
                            isMine ? Sizes.size28 : Sizes.size5),
                        bottomRight: Radius.circular(
                            isMine ? Sizes.size5 : Sizes.size28),
                      ),
                    ),
                    child: const Text(
                      "this. is a message!",
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => Gaps.v16,
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Container(
              color: isDarkMode(context)
                  ? Colors.grey.shade900
                  : Colors.grey.shade100,
              padding: const EdgeInsets.only(
                left: Sizes.size10,
                right: Sizes.size10,
                top: Sizes.size10,
                bottom: Sizes.size28,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size16,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: CustomPaint(
                              painter: isDarkMode(context)
                                  ? DarkModeChatBubbleTriangle()
                                  : ChatBubbleTriangle(),
                            ),
                          ),
                          TextField(
                            controller: _textEditingController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(5),
                                ),
                              ),
                              contentPadding:
                                  const EdgeInsetsDirectional.symmetric(
                                vertical: Sizes.size10,
                                horizontal: Sizes.size14,
                              ),
                              hintText: "Send a message...",
                              filled: true,
                              fillColor: isDarkMode(context)
                                  ? Colors.black
                                  : Colors.white,
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.faceLaugh,
                                    color: isDarkMode(context)
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gaps.h16,
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _textEditingController.text.isNotEmpty
                            ? Theme.of(context).primaryColor
                            : isDarkMode(context)
                                ? Colors.grey.shade800
                                : Colors.grey.shade300,
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(Sizes.size12),
                          child: FaIcon(
                            FontAwesomeIcons.solidPaperPlane,
                            color: Colors.white,
                            size: Sizes.size20,
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
    );
  }
}

class ChatBubbleTriangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.white;

    var path = Path();
    path.lineTo(-10, 0);
    path.lineTo(0, -15);
    path.lineTo(10, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class DarkModeChatBubbleTriangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.black;

    var path = Path();
    path.lineTo(-10, 0);
    path.lineTo(0, -15);
    path.lineTo(10, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
