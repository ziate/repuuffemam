import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/cart_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/controller/user_controller.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartWidget extends StatelessWidget {
  final Color color;
  final double size;
  final bool fromRestaurant;

  CartWidget(
      {@required this.color, @required this.size, this.fromRestaurant = false});

  @override
  Widget build(BuildContext context) {
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if (_isLoggedIn && Get.find<UserController>().userInfoModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    return Stack(clipBehavior: Clip.none, children: [
      GetBuilder<UserController>(builder: (userController) {
        return (_isLoggedIn && userController.userInfoModel == null)
            ? Center(child: CircularProgressIndicator())
            : Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(width: 2, color: Theme.of(context).cardColor),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: ClipOval(
                    child: CustomImage(
                  image:
                      '${Get.find<SplashController>().configModel.baseUrls.customerImageUrl}'
                      '/${(userController.userInfoModel != null && _isLoggedIn) ? userController.userInfoModel.image : ''}',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                )));
      }),
      // GetBuilder<CartController>(builder: (cartController) {
      //   return cartController.cartList.length > 0
      //       ? Positioned(
      //           top: -5,
      //           right: -5,
      //           child: Container(
      //             height: size < 20 ? 10 : size / 2,
      //             width: size < 20 ? 10 : size / 2,
      //             alignment: Alignment.center,
      //             decoration: BoxDecoration(
      //               shape: BoxShape.circle,
      //               color: fromRestaurant
      //                   ? Theme.of(context).cardColor
      //                   : Theme.of(context).primaryColor,
      //               border: Border.all(
      //                   width: size < 20 ? 0.7 : 1,
      //                   color: fromRestaurant
      //                       ? Theme.of(context).primaryColor
      //                       : Theme.of(context).cardColor),
      //             ),
      //             child: Text(
      //               cartController.cartList.length.toString(),
      //               style: robotoRegular.copyWith(
      //                 fontSize: size < 20 ? size / 3 : size / 3.8,
      //                 color: fromRestaurant
      //                     ? Theme.of(context).primaryColor
      //                     : Theme.of(context).cardColor,
      //               ),
      //             ),
      //           ),
      //         )
      //       : SizedBox();
      // }),
    ]);
  }
}
