import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/localization_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/controller/user_controller.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/view/base/custom_app_bar.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:efood_multivendor/view/screens/change_language/widget/language_widget.dart';
import 'package:efood_multivendor/view/screens/change_password/change_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../theme/styles.dart';

class SettingScreen extends StatelessWidget {
  final Color iconColor = const Color(0xff727C8E);
  final TextStyle fontStyle = kTextStyleBold18.copyWith(
    color: Colors.white,
    fontSize: 20,
  );
  @override
  Widget build(BuildContext context) {
    List<String> images = [Images.doorKey, Images.customerCare];
    List<String> labels = ["change_password".tr, "contact_us".tr];
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if (_isLoggedIn && Get.find<UserController>().userInfoModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: CustomAppBar(
        appBarColor: kPrimaryColor,
        titleWidget: Column(
          children: [
            SizedBox(height: 5),
            Icon(Icons.settings, size: 38),
            SizedBox(height: 5),
            Text('settings'.tr, style: kTextStyleBold15),
            SizedBox(height: 10),
          ],
        ),
        title: 'settings'.tr,
        isBackButtonExist: true,
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        return (_isLoggedIn && userController.userInfoModel == null)
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    // SizedBox(height: 20),
                    // Container(
                    //   width: double.infinity,
                    //   height: 50,
                    //   color: Theme.of(context).primaryColor,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //     children: [
                    //       Text(
                    //         "settings".tr,
                    //         style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 20,
                    //             fontWeight: FontWeight.w200),
                    //       ),
                    //       SvgPicture.asset(Images.backSvg),
                    //     ],
                    //   ),
                    // ),
                    ListView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (ctx, index) => Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    if (index == 0) {
                                      showModelSheet(context, ChangePassword());
                                      // Get.toNamed(RouteHelper.changePassword);
                                    } else {
                                      Get.toNamed('/contact_us');
                                    }
                                  },
                                  leading: SvgPicture.asset(
                                    images[index],
                                    color: iconColor,
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    labels[index],
                                    style: fontStyle,
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                              ],
                            ))
                  ],
                ),
              );
      }),
    );
  }

  void showModelSheet(BuildContext context, Widget content) {
    showModalBottomSheet(
      backgroundColor: kPrimaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) => content,
    );
  }
}
