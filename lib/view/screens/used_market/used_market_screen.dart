import 'dart:io';

import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/used_market_controller.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/view/base/custom_button.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:efood_multivendor/view/base/web_menu_bar.dart';
import 'package:efood_multivendor/view/screens/change_password/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UsedMarketScreen extends StatefulWidget {
  const UsedMarketScreen({Key key}) : super(key: key);

  @override
  State<UsedMarketScreen> createState() => _UsedMarketScreenState();
}

class _UsedMarketScreenState extends State<UsedMarketScreen> {
  @override
  void initState() {
    super.initState();

    Get.find<UsedMarketController>().initData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: ResponsiveHelper.isDesktop(context)
          ? WebMenuBar()
          : PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: Container(
                width: double.infinity,
                height: 60,
                color: Theme.of(context).primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        clipBehavior: Clip.antiAlias,
                        width: 50,
                        height: 50,
                        child: Center(
                          child: Image.asset(
                            Images.logopng,
                          ),
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white)),
                    Text("add_product".tr,
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
            ),
      body: GetBuilder<UsedMarketController>(builder: (usedmarketcontroller) {
        return SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(height: 50),
            Center(
              child: Stack(children: [
                Container(
                    clipBehavior: Clip.antiAlias,
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: usedmarketcontroller.pickedFile != null
                        ? GetPlatform.isWeb
                            ? Image.network(
                                usedmarketcontroller.pickedFile.path,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(usedmarketcontroller.pickedFile.path),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                        : CustomImage(
                            image:
                                "https://booster.io/wp-content/uploads/product-add-to-cart-e1438362099361.png",
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: InkWell(
                    onTap: () => usedmarketcontroller.pickImage(),
                    child: Icon(
                      Icons.camera_alt,
                      color: Theme.of(context).primaryColor,
                      size: 30,
                    ),
                  ),
                ),
              ]),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "name_product".tr + ":",
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: FixedTextField(
                      onChanged: (v) {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "description_product".tr + ":",
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: FixedTextField(
                      onChanged: (v) {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "price_product".tr + ":",
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: FixedTextField(
                      onChanged: (v) {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "address".tr + ":",
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: FixedTextField(
                      onChanged: (v) {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "phone".tr + ":",
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: FixedTextField(
                      onChanged: (v) {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            !usedmarketcontroller.isLoading
                ? CustomButton(
                    width: MediaQuery.of(context).size.width - 100,
                    radius: 25,
                    onPressed: () {},
                    // onPressed: () => _updateProfile(userController),
                    margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    buttonText: 'add_product'.tr,
                  )
                : Center(child: CircularProgressIndicator()),
          ],
        ));
      }),
    ));
  }
}
