import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../theme/styles.dart';
import '../../base/custom_button.dart';
import '../auth/sign_up_screen.dart';
import '../auth/widget/powered_by_widget.dart';
import 'auth_widget.dart';

class SelectLogin extends StatelessWidget {
  const SelectLogin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                SvgPicture.asset("assets/image/re.svg"),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: SvgPicture.asset("assets/image/Puff.svg"),
                ),
                Positioned(
                  top: 280,
                  child: Column(
                    children: [
                      Text('welcom'.tr, style: kTextStyleBold24),
                      Text(
                        'start_page_hint1'.tr,
                        style: kTextStyleReg14,
                      ),
                      Text(
                        'start_page_hint2'.tr,
                        style: kTextStyleReg14,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            CustomButton(
              color: Color(0xFF515C6F),
              height: 49,
              radius: 15,
              width: MediaQuery.of(context).size.width - 80,
              buttonText: 'creat_account'.tr,
              onPressed: () {
                onAuthPressed(0, context);
              },
            ),
            SizedBox(height: 20),
            CustomButton(
              color: Color(0xFF515C6F),
              height: 49,
              radius: 15,
              width: MediaQuery.of(context).size.width - 80,
              buttonText: 'login'.tr,
              onPressed: () {
                onAuthPressed(1, context);
              },
            ),
            SizedBox(height: 20),
            // button(context, 'create_store_account'.tr, () {}),

            // SvgPicture.asset("assets/image/Puff.svg"),
            // SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: PoweredByWidget(),
    );

    //   Center(
    //     child: SingleChildScrollView(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Center(
    //             child: Image.asset(
    //               Images.logo,
    //               width: 200,
    //             ),
    //           ),
    //           SizedBox(
    //             height: 80,
    //           ),
    //           button(context, 'sign_in'.tr, () {
    //             Get.toNamed(
    //                 RouteHelper.getSignInRoute(RouteHelper.selectLogin));
    //           }),
    //           SizedBox(height: 20),
    //           button(context, 'sign_up'.tr, () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                   builder: (context) => SignUpScreen(
    //                         exitFromApp: false,
    //                       )),
    //             );
    //           }),
    //           SizedBox(height: 20),
    //           button(context, 'create_store_account'.tr, () {}),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  void onAuthPressed(int tapIndex, BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) => AuthWidget(tapIndex),
    );
  }
}

Widget button(BuildContext context, String label, Function onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 50,
      width: MediaQuery.of(context).size.width - 50,
      child: Center(
          child: Text(label,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Colors.white))),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: Color(0xFF0F4F80)),
    ),
  );
}
