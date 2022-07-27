import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/cart_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/controller/user_controller.dart';
import 'package:efood_multivendor/controller/wishlist_controller.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/view/base/confirmation_dialog.dart';
import 'package:efood_multivendor/view/base/custom_button.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:efood_multivendor/view/base/web_menu_bar.dart';
import 'package:efood_multivendor/view/screens/order/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if (_isLoggedIn && Get.find<UserController>().userInfoModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    final List<String> images = [
      Images.svgUser,
      Images.SvgGlobe,
      Images.SvgMarker,
      Images.orderSvg,
      Images.SvgSettings
    ];
    final List<String> titles = [
      "personal_information".tr,
      "language".tr,
      "delivery_address".tr,
      "my_orders".tr,
      "settings".tr,
    ];
    final List<String> subTitles = [
      "design_profile".tr,
      "select_language".tr,
      "add_address".tr,
      "view_orders".tr,
      "design_profile".tr,
    ];

    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context) ? WebMenuBar() : null,
      backgroundColor: Theme.of(context).cardColor,
      body: Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        body: GetBuilder<UserController>(builder: (userController) {
          return (_isLoggedIn && userController.userInfoModel == null)
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
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
                      SizedBox(height: 10),
                      Container(
                        width: context.width - 25,
                        height: context.height * 0.3,
                        decoration: BoxDecoration(
                            color: Color(0xFFE1E1E1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Text("name".tr,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: Dimensions.fontSizeLarge,
                                      )),
                                  Text(
                                    ' : ${(userController.userInfoModel != null && _isLoggedIn) ? userController.userInfoModel.fName : ''}' +
                                        ' ${(userController.userInfoModel != null && _isLoggedIn) ? userController.userInfoModel.lName : ''}',
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("email".tr,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: Dimensions.fontSizeLarge,
                                      )),
                                  Text(
                                      ' : ${(userController.userInfoModel != null && _isLoggedIn) ? userController.userInfoModel.email : ''}'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("user".tr,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: Dimensions.fontSizeLarge,
                                      )),
                                  Text(
                                      ' : ${(userController.userInfoModel != null && _isLoggedIn) ? userController.userInfoModel.user_name : ''}'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("phone".tr,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: Dimensions.fontSizeLarge,
                                      )),
                                  Text(
                                      ' : ${(userController.userInfoModel != null && _isLoggedIn) ? userController.userInfoModel.phone : ''}'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Country".tr,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: Dimensions.fontSizeLarge,
                                      )),
                                  Flexible(
                                    child: Text(
                                      ' : ${(userController.userInfoModel != null && _isLoggedIn) ? userController.userInfoModel.country : ''}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("address".tr,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: Dimensions.fontSizeLarge,
                                      )),
                                  Flexible(
                                    child: Text(
                                      ' : ${(userController.userInfoModel != null && _isLoggedIn) ? userController.userInfoModel.address : ''}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("City".tr,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: Dimensions.fontSizeLarge,
                                      )),
                                  Flexible(
                                    child: Text(
                                      ' : ${(userController.userInfoModel != null && _isLoggedIn) ? userController.userInfoModel.city : ''}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("date_birth".tr,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: Dimensions.fontSizeLarge,
                                      )),
                                  Flexible(
                                    child: Text(
                                      ' : ${(userController.userInfoModel != null && _isLoggedIn) ? userController.userInfoModel.date_of_birth : ''}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Divider(
                          color: Colors.grey,
                          thickness: 1,
                          endIndent: 20,
                          indent: 20),
                      SizedBox(height: 10),
                      SizedBox(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: images.length,
                            itemBuilder: (ctx, index) => Column(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        if (index == 0) {
                                          Get.toNamed(
                                              RouteHelper.updateProfile);
                                        } else if (index == 1) {
                                          Get.toNamed(
                                              RouteHelper.changeLanguage);
                                        } else if (index == 2) {
                                          Get.toNamed(RouteHelper.address);
                                        } else if (index == 3) {
                                          Get.to(() => OrderScreen());
                                        } else if (index == 4) {
                                          Get.toNamed(RouteHelper.setting);
                                        }
                                      },
                                      leading: SvgPicture.asset(images[index]),
                                      trailing: Icon(Icons.arrow_forward_ios),
                                      title: Text(titles[index].tr,
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: Dimensions.fontSizeLarge,
                                          )),
                                      subtitle: Text(subTitles[index].tr,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: Dimensions.fontSizeSmall,
                                          )),
                                    ),
                                    Divider(
                                        color: Colors.grey,
                                        thickness: 1,
                                        endIndent: 20,
                                        indent: 20),
                                  ],
                                )),
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                          radius: 25,
                          width: MediaQuery.of(context).size.width - 80,
                          buttonText: _isLoggedIn ? 'logout'.tr : 'sign_in'.tr,
                          onPressed: () {
                            if (Get.find<AuthController>().isLoggedIn()) {
                              Get.dialog(
                                  ConfirmationDialog(
                                      icon: Images.support,
                                      description: 'are_you_sure_to_logout'.tr,
                                      isLogOut: true,
                                      onYesPressed: () {
                                        Get.find<AuthController>()
                                            .clearSharedData();
                                        Get.find<CartController>()
                                            .clearCartList();
                                        Get.find<WishListController>()
                                            .removeWishes();
                                        Get.offAllNamed(
                                            RouteHelper.getSignInRoute(
                                                RouteHelper.splash));
                                      }),
                                  useSafeArea: false);
                            } else {
                              Get.find<WishListController>().removeWishes();
                              Get.toNamed(
                                  RouteHelper.getSignInRoute(RouteHelper.main));
                            }
                          }),
                      SizedBox(height: 20),
                    ],
                  ),
                );

          // ProfileBgWidget(
          //   backButton: true,
          //   circularImage: Container(
          //     decoration: BoxDecoration(
          //       border: Border.all(width: 2, color: Theme.of(context).cardColor),
          //       shape: BoxShape.circle,
          //     ),
          //     alignment: Alignment.center,
          //     child:
          //     ClipOval(child:
          //     CustomImage(
          //       image: '${Get.find<SplashController>().configModel.baseUrls.customerImageUrl}'
          //           '/${(userController.userInfoModel != null && _isLoggedIn) ? userController.userInfoModel.image : ''}',
          //       height: 100, width: 100, fit: BoxFit.cover,
          //     )),
          //   ),
          //   mainWidget: SingleChildScrollView(physics: BouncingScrollPhysics(), child: Center(child: Container(
          //     width: Dimensions.WEB_MAX_WIDTH, color: Theme.of(context).cardColor,
          //     padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          //     child: Column(children: [
          //
          //       Text(
          //         _isLoggedIn ? '${userController.userInfoModel.fName} ${userController.userInfoModel.lName}' : 'guest'.tr,
          //         style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
          //       ),
          //       SizedBox(height: 30),
          //
          //       _isLoggedIn ? Row(children: [
          //         ProfileCard(title: 'since_joining'.tr, data: '${userController.userInfoModel.memberSinceDays} ${'days'.tr}'),
          //         SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          //         ProfileCard(title: 'total_order'.tr, data: userController.userInfoModel.orderCount.toString()),
          //       ]) : SizedBox(),
          //       SizedBox(height: _isLoggedIn ? 30 : 0),
          //
          //       ProfileButton(icon: Icons.dark_mode, title: 'dark_mode'.tr, isButtonActive: Get.isDarkMode, onTap: () {
          //         Get.find<ThemeController>().toggleTheme();
          //       }),
          //       SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
          //
          //       _isLoggedIn ? GetBuilder<AuthController>(builder: (authController) {
          //         return ProfileButton(
          //           icon: Icons.notifications, title: 'notification'.tr,
          //           isButtonActive: authController.notification, onTap: () {
          //           authController.setNotificationActive(!authController.notification);
          //         },
          //         );
          //       }) : SizedBox(),
          //       SizedBox(height: _isLoggedIn ? Dimensions.PADDING_SIZE_SMALL : 0),
          //
          //       _isLoggedIn ? ProfileButton(icon: Icons.lock, title: 'change_password'.tr, onTap: () {
          //         Get.toNamed(RouteHelper.getResetPasswordRoute('', '', 'password-change'));
          //       }) : SizedBox(),
          //       SizedBox(height: _isLoggedIn ? Dimensions.PADDING_SIZE_SMALL : 0),
          //
          //       ProfileButton(icon: Icons.edit, title: 'edit_profile'.tr, onTap: () {
          //         Get.toNamed(RouteHelper.getUpdateProfileRoute());
          //       }),
          //       SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
          //
          //       Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          //         Text('${'version'.tr}:', style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall)),
          //         SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          //         Text(AppConstants.APP_VERSION.toString(), style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall)),
          //       ]),
          //
          //     ]),
          //   ))),
          // );
        }),
      ),
    );
  }
}
