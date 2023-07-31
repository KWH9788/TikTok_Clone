import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/screens/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/screens/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/screens/features/videos/view_models/playback_config_vm.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: Breakpoints.md),
          child: ListView(
            children: [
              SwitchListTile.adaptive(
                value: ref.watch(playbackConfigProvider).muted,
                onChanged: (value) =>
                    ref.read(playbackConfigProvider.notifier).setMuted(value),
                activeColor: Colors.grey.shade400,
                title: const Text("Mute video"),
                subtitle: const Text(
                  "Video will be muted by default.",
                ),
              ),
              SwitchListTile.adaptive(
                value: ref.watch(playbackConfigProvider).autoplay,
                onChanged: (value) => ref
                    .read(playbackConfigProvider.notifier)
                    .setAutoplay(value),
                activeColor: Colors.grey.shade400,
                title: const Text("Autoplay"),
                subtitle: const Text(
                  "Video will start playing automatically.",
                ),
              ),
              SwitchListTile.adaptive(
                value: false,
                onChanged: (value) {},
                activeColor: Colors.grey.shade400,
                title: const Text("Enable notifications"),
              ),
              ListTile(
                onTap: () => showAboutDialog(context: context),
                title: const Text(
                  "About",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: const Text("About this app....."),
              ),
              const AboutListTile(),
              ListTile(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1980),
                    lastDate: DateTime(2030),
                  );
                  print(date);

                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  print(time);

                  final booking = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(1980),
                    lastDate: DateTime(2030),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData(
                          appBarTheme: const AppBarTheme(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  print(booking);
                },
                title: const Text("What is your birthday"),
              ),
              ListTile(
                title: const Text("Log out (ios)"),
                textColor: Colors.red,
                onTap: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: const Text("Are you sure?"),
                      content: const Text("Pls dont go"),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text("No"),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        CupertinoDialogAction(
                          isDestructiveAction: true,
                          child: const Text("Yes"),
                          onPressed: () {
                            ref.read(authRepo).signOut();
                            context.go(SignUpScreen.routeUrl);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
