import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/screens/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/screens/features/onboarding/interests_screen.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  String birthday = "";

  // 현재 날짜
  DateTime now = DateTime.now();
  // 현재 날짜 - 12년
  late DateTime initialdate;
  String year = "", month = "", day = "";

  // TextField Controller
  final TextEditingController _birthdayController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _birthdayController.addListener(() {
      setState(() {
        birthday = _birthdayController.text;
      });
    });
    initialdate = DateTime(now.year - 12, now.month, now.day);
    _setTextFieldDate(initialdate);
  }

  // 메모리에서 컨트롤러 제거
  @override
  void dispose() {
    // TODO: implement dispose
    _birthdayController.dispose();
    super.dispose();
  }

  void onNextTap(BuildContext context) {
    // 유효성 검사
    if (birthday.isEmpty) return;

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const InterestsScreen(),
    ));
  }

  // DateFormat & TextField Context Update
  void _setTextFieldDate(DateTime date) {
    var temp = date.toString().substring(0, 10).split("-");
    year = temp[0];
    month = temp[1];
    day = temp[2];
    _birthdayController.value = TextEditingValue(text: "$day $month $year");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign up",
        ),
        // actions: [
        //   Text(
        //     "Skip",
        //     style: TextStyle(
        //         color: Colors.black.withOpacity(0.45),
        //         fontSize: Sizes.size20,
        //         fontWeight: FontWeight.w400),
        //   ),
        //   FaIcon(
        //     FontAwesomeIcons.circleQuestion,
        //     color: Colors.black.withOpacity(0.45),
        //   )
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size32,
          vertical: Sizes.size24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "When's your birthday?",
                      style: TextStyle(
                        fontSize: Sizes.size20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Gaps.v14,
                    Text(
                      "Your birthday won't be shown publicly.",
                      style: TextStyle(color: Colors.black45),
                    ),
                  ],
                ),
                const FaIcon(FontAwesomeIcons.cakeCandles),
              ],
            ),
            Gaps.v28,
            // birthday 입력창
            TextField(
              enabled: false,
              controller: _birthdayController,
              keyboardType: TextInputType.name,
              onEditingComplete: () => onNextTap(context),
              decoration: InputDecoration(
                hintText: "Day / Month / Year",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),
            Gaps.v32,
            GestureDetector(
              onTap: () => onNextTap(context),
              child: FormButton(disabled: birthday.isEmpty),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 300,
          child: CupertinoDatePicker(
            initialDateTime: initialdate,
            maximumDate: initialdate,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: _setTextFieldDate,
          ),
        ),
      ),
    );
  }
}
