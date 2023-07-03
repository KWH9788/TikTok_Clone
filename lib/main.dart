import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/common/widgets/video_config/video_config.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  runApp(const TiktokCloneApp());
}

class TiktokCloneApp extends StatelessWidget {
  const TiktokCloneApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => VideoConfig(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'Tiktok Clone',
        themeMode: ThemeMode.system,
        theme: ThemeData(
          useMaterial3: true,
          textTheme: Typography.blackMountainView,
          brightness: Brightness.light,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0XFFE9435A),
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: const Color(0XFFE9435A),
          appBarTheme: AppBarTheme(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black.withOpacity(0.9),
            elevation: 0,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: Sizes.size20,
              color: Colors.black.withOpacity(0.9),
            ),
          ),
          tabBarTheme: TabBarTheme(
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
          ),
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.grey.shade50,
          ),
          listTileTheme: const ListTileThemeData(
            iconColor: Colors.black,
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          textTheme: Typography.whiteMountainView,
          brightness: Brightness.dark,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0XFFE9435A),
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.black,
          primaryColor: const Color(0XFFE9435A),
          appBarTheme: AppBarTheme(
            surfaceTintColor: Colors.grey.shade900,
            backgroundColor: Colors.grey.shade900,
            foregroundColor: Colors.white.withOpacity(0.9),
            elevation: 0,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: Sizes.size20,
              color: Colors.white.withOpacity(0.9),
            ),
            actionsIconTheme: IconThemeData(color: Colors.grey.shade100),
            iconTheme: IconThemeData(color: Colors.grey.shade100),
          ),
          tabBarTheme: TabBarTheme(
            labelColor: Colors.grey.shade50,
            indicatorColor: Colors.grey.shade50,
            unselectedLabelColor: Colors.grey.shade500,
          ),
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.grey.shade900,
          ),
          listTileTheme: ListTileThemeData(
            iconColor: Colors.grey.shade100,
          ),
        ),
      ),
    );
  }
}
