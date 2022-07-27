import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/localization_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/controller/user_controller.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:efood_multivendor/view/screens/change_language/widget/language_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> images = [Images.doorKey, Images.customerCare];
    List<String> labels = ["change_password".tr, "contact_us".tr];
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
                          Text("settings".tr,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w200)),
                          SvgPicture.asset(Images.backSvg),
                        ],
                      ),
                    ),
                    ListView.builder(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (ctx, index) => Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    if (index == 0) {
                                      Get.toNamed(RouteHelper.changePassword);
                                    } else {
                                      Get.toNamed('/contact_us');
                                    }
                                  },
                                  leading: SvgPicture.asset(images[index]),
                                  trailing: Icon(Icons.arrow_forward_ios),
                                  title: Text(labels[index],
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w100)),
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
}
