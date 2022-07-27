import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/localization_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/controller/user_controller.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/view/base/custom_button.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:efood_multivendor/view/screens/change_language/widget/language_widget.dart';
import 'package:efood_multivendor/view/screens/change_password/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChangePassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if (_isLoggedIn && Get.find<UserController>().userInfoModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: GetBuilder<UserController>(builder: (userController) {
        return (_isLoggedIn && userController.userInfoModel == null)
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Center(
                      child: ClipOval(
                          child: CustomImage(
                        image:
                            '${Get.find<SplashController>().configModel.baseUrls.customerImageUrl}'
                            '/${(userController.userInfoModel != null && _isLoggedIn) ? userController.userInfoModel.image : ''}',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      )),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 50,
                      color: Theme.of(context).primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("change_password".tr,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w200)),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(Images.backSvg)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("old_password".tr,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w100)),
                      ),
                    ),
                    FixedTextField(
                      onChanged: (v) {},
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("new_password".tr,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w100)),
                      ),
                    ),
                    FixedTextField(
                      onChanged: (v) {},
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("confirm_password".tr,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w100)),
                      ),
                    ),
                    FixedTextField(
                      onChanged: (v) {},
                    ),
                    SizedBox(height: 80),
                    CustomButton(
                        radius: 25,
                        width: MediaQuery.of(context).size.width - 100,
                        buttonText: 'change'.tr,
                        onPressed: () {}),
                  ],
                ),
              );
      }),
    );
  }
}
