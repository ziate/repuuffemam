import 'package:efood_multivendor/controller/order_controller.dart';
import 'package:efood_multivendor/theme/styles.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class ConfirmationDialog extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  final Function onYesPressed;
  final bool isLogOut;
  final Function onNoPressed;
  ConfirmationDialog(
      {@required this.icon,
      this.title,
      @required this.description,
      @required this.onYesPressed,
      this.isLogOut = false,
      this.onNoPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kPrimaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      insetPadding: EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: PointerInterceptor(
        child: Container(
          color: Color(0xffE1003C),
          padding: EdgeInsets.all(4),
          child: Container(
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              width: 500,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  // Padding(
                  //   padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                  //   child: Image.asset(icon, width: 50, height: 50),
                  // ),
                  title != null
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_LARGE),
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: kTextStyleBold18.copyWith(
                              fontSize: 21,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : SizedBox(),
                  Padding(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                    child: Text(
                      description,
                      style: kTextStyleBold18.copyWith(
                        fontSize: 21,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  GetBuilder<OrderController>(builder: (orderController) {
                    return !orderController.isLoading
                        ? Row(children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () => isLogOut
                                    ? onYesPressed()
                                    : onNoPressed != null
                                        ? onNoPressed()
                                        : Get.back(),
                                style: TextButton.styleFrom(
                                  minimumSize:
                                      Size(Dimensions.WEB_MAX_WIDTH, 40),
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.RADIUS_SMALL)),
                                ),
                                child: Text(
                                  isLogOut ? 'yes'.tr : 'no'.tr,
                                  textAlign: TextAlign.center,
                                  style: kTextStyleBold18.copyWith(
                                    fontSize: 21,
                                    color: Color(0xffE1003C),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: Dimensions.PADDING_SIZE_LARGE),
                            Expanded(
                                child: TextButton(
                              child: Text(isLogOut ? 'no'.tr : 'yes'.tr,
                                  style: kTextStyleBold18.copyWith(
                                    fontSize: 21,
                                    color: Colors.white,
                                  )),
                              onPressed: () =>
                                  isLogOut ? Get.back() : onYesPressed(),
                              style: TextButton.styleFrom(
                                minimumSize: Size(Dimensions.WEB_MAX_WIDTH, 40),
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.RADIUS_SMALL)),
                              ),
                            )),
                          ])
                        : Center(child: CircularProgressIndicator());
                  }),
                ]),
              )),
        ),
      ),
    );
  }
}
