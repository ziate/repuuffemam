import 'package:efood_multivendor/view/screens/auth/sign_in_screen.dart';
import 'package:efood_multivendor/view/screens/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/styles.dart';

class AuthWidget extends StatelessWidget {
  final int initialTapIndex;
  const AuthWidget(this.initialTapIndex, {Key key}) : super(key: key);

  get kBackgroundColor => null;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: DefaultTabController(
        initialIndex: initialTapIndex,
        length: 2,
        child: Container(
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30.0),
              topLeft: Radius.circular(30.0),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                width: 48,
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  color: Color(0xff515C6F),
                ),
              ),
              SizedBox(
                height: 50,
                child: TabBar(
                  indicatorColor: Color(0xffE1003C),
                  padding: const EdgeInsets.all(0),
                  labelPadding: const EdgeInsets.all(0),
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 50),
                  labelColor: Color(0xffF5F6F8),
                  unselectedLabelColor: const Color(0xff8D8E91),
                  labelStyle: kTextStyleBold16,
                  unselectedLabelStyle: kTextStyleBold16,
                  tabs: [
                    Tab(text: "creat_account".tr),
                    Tab(text: "login".tr),
                  ],
                  // indicatorSize: TabBarIndicatorSize.label,
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    SignUpScreen(exitFromApp: true),
                    SignInScreen(exitFromApp: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
