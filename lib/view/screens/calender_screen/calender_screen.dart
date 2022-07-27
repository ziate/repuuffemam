import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/view/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({Key key}) : super(key: key);

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  // DateTime dateTime = DateTime.now();
  String selectTime;
  int check = 0;

  // void initState() {
  //   super.initState();
  //   if (_checkConfiguration()) {
  //     Future.delayed(Duration.zero, () {
  //       DatePicker.showDatePicker(context,
  //           showTitleActions: true,
  //           minTime: DateTime(1950, 1, 1),
  //           maxTime: DateTime(2030, 12, 30), onChanged: (date) {
  //         selectTime = "${(dateTime.difference(date).inDays / 365).round()}";
  //         check = int.parse(selectTime);
  //         print('confirm $selectTime');
  //         print('confirm $check');
  //         print('change $date');
  //       }, onConfirm: (date) {
  //         selectTime = "${(dateTime.difference(date).inDays / 365).round()}";
  //         check = int.parse(selectTime);
  //         print('confirm $selectTime');
  //         print('confirm $check');
  //       }, currentTime: DateTime.now(), locale: LocaleType.en);
  //     });
  //   }
  // }

  final dateTime = DateTime.now().obs;

  Future<DateTime> showCalender({BuildContext context}) async =>
      await showDatePicker(
        context: context,
        lastDate: DateTime(2100),
        firstDate: DateTime(1950),
        initialDate: dateTime.value,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 250,
          child: CustomButton(
            buttonText: "enter_birthDate".tr,
            radius: 50,
            onPressed: () async {
              final date = await showCalender(context: context);
              if (date == null) {
                return null;
              } else {
                print(date.toIso8601String());
                DateFormat dateFormat = DateFormat("yyyy-MM-dd");
                Get.find<AuthController>().birthDate(dateFormat.format(date));

                selectTime =
                    "${(dateTime.value.difference(date).inDays / 365).round()}";
                check = int.parse(selectTime);
                print('confirm $selectTime');
                print('confirm $check');
              }

              if (check <= 18) {
                Get.snackbar("Can't Login in", "You are less than 18 year old",
                    backgroundColor: Color(0xFFDB0013),
                    colorText: Colors.white);
              } else {
                print("next");
                Get.toNamed(RouteHelper.selectLogin);
              }
            },
          ),
        ),
      ),
    );
  }
}
