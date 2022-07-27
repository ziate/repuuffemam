import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/sign_up_screen.dart';

class SelectLogin extends StatelessWidget {
  const SelectLogin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  Images.logo,
                  width: 200,
                ),
              ),
              SizedBox(
                height: 80,
              ),
              button(context, 'sign_in'.tr, () {
                Get.toNamed(
                    RouteHelper.getSignInRoute(RouteHelper.selectLogin));
              }),
              SizedBox(height: 20),
              button(context, 'sign_up'.tr, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignUpScreen(
                            exitFromApp: false,
                          )),
                );
              }),
              SizedBox(height: 20),
              button(context, 'create_store_account'.tr, () {}),
            ],
          ),
        ),
      ),
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
