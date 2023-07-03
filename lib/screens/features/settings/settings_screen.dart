import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/common/widgets/video_config/video_config.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = false;

  void onChangedNotifications(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notifications = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              AnimatedBuilder(
                animation: videoConfig,
                builder: (context, child) => SwitchListTile.adaptive(
                  value: videoConfig.value,
                  onChanged: (value) {
                    videoConfig.value = !videoConfig.value;
                  },
                  activeColor: Colors.grey.shade400,
                  title: const Text("Mute video"),
                  subtitle: const Text("Videos will be muted by default."),
                ),
              ),
              SwitchListTile.adaptive(
                value: _notifications,
                onChanged: onChangedNotifications,
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
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text("Log out (ios)"),
                textColor: Colors.red,
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                      title: const Text("Are you sure?"),
                      message: const Text("Pls dont go"),
                      actions: [
                        CupertinoActionSheetAction(
                          child: const Text("No"),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        CupertinoActionSheetAction(
                          isDestructiveAction: true,
                          child: const Text("Yes"),
                          onPressed: () => Navigator.of(context).pop(),
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
