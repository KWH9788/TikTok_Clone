import 'package:flutter/material.dart';

void main() {
  runApp(const TiktokCloneApp());
}

class TiktokCloneApp extends StatelessWidget {
  const TiktokCloneApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Tiktok Clone',
        theme: ThemeData(
          primaryColor: const Color(0XFFE9435A),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Tiktok Clone",
            ),
          ),
        ));
  }
}
