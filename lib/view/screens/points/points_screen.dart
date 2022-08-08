import 'package:efood_multivendor/view/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/styles.dart';
import '../../base/custom_image.dart';

class PointsScreen extends StatelessWidget {
  final String image;
  const PointsScreen(this.image, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                color: Colors.transparent,
                height: 60,
              ),
              Expanded(
                child: Container(
                  color: kPrimaryColor,
                  width: double.infinity,
                ),
              )
            ],
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            // bottomNavigationBar: CustomButton(buttonText: "redeem_points".tr),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
                top: 20,
              ),
              child: Column(
                children: [
                  ClipOval(
                    child: CustomImage(
                      image: image,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money_rounded,
                        color: kTextColor,
                        // size: 28,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "points".tr,
                        style: kTextStyleBold18.copyWith(color: Colors.white),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "total_points".tr,
                              style:
                                  kTextStyleReg14.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "100",
                              style: kTextStyleBold24.copyWith(
                                  color: Colors.white),
                            ),
                            SizedBox(width: 3),
                            Text(
                              "points".tr,
                              style: kTextStyleBold15.copyWith(
                                  color: Colors.white),
                            )
                          ],
                        ),
                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Make many orders to get points",
                              style: kTextStyleSemiBold15.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomButton(
                      onPressed: () {},
                      buttonText: "redeem_points".tr,
                      radius: 13,
                      color: Color(0xff20242A),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
