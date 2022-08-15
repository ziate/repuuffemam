import 'dart:developer';
import 'dart:io';

import 'package:efood_multivendor/controller/used_market_controller.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/view/base/custom_app_bar.dart';
import 'package:efood_multivendor/view/base/custom_button.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:efood_multivendor/view/base/web_menu_bar.dart';
import 'package:efood_multivendor/view/screens/change_password/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/styles.dart';

class UsedMarketScreen extends StatefulWidget {
  const UsedMarketScreen({Key key}) : super(key: key);

  @override
  State<UsedMarketScreen> createState() => _UsedMarketScreenState();
}

class _UsedMarketScreenState extends State<UsedMarketScreen> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  String name;
  String des;
  String price;
  String address;
  String phone;
  bool isLoading = false;
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
          : CustomAppBar(
              isSmallAppBar: true,
              title: "add_product".tr,
              titleWidget: Text(
                'add_product'.tr,
                style: kTextStyleBold18,
              ),
            ),
      body: GetBuilder<UsedMarketController>(builder: (usedmarketcontroller) {
        return SingleChildScrollView(
            child: Form(
          key: _key,
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
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ]),
              ),
              SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "name_product".tr + ":",
                        style: TextStyle(fontSize: 16, color: kTextColor),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: FixedTextField(
                        onChanged: (v) {
                          name = v;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "description_product".tr + ":",
                        style: TextStyle(fontSize: 16, color: kTextColor),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: FixedTextField(
                        onChanged: (v) {
                          des = v;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "price_product".tr + ":",
                        style: TextStyle(fontSize: 16, color: kTextColor),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: FixedTextField(
                        onChanged: (v) {
                          price = v;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "address".tr + ":",
                        style: TextStyle(fontSize: 16, color: kTextColor),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: FixedTextField(
                        onChanged: (v) {
                          address = v;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "phone".tr + ":",
                        style: TextStyle(fontSize: 16, color: kTextColor),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: FixedTextField(
                        onChanged: (v) {
                          phone = v;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              !usedmarketcontroller.isLoading
                  ? !isLoading
                      ? CustomButton(
                          color: kPrimaryColor,
                          width: MediaQuery.of(context).size.width - 100,
                          radius: 25,
                          onPressed: () {
                            isLoading = true;
                            log('$name $address $phone $price $des');
                            if (name != null &&
                                price != null &&
                                address != null) {
                              usedmarketcontroller.addUsedProduct(
                                address: address,
                                description: des,
                                name: name,
                                phone: phone,
                                price: price,
                              );

                              // Get.to(DashboardScreen(pageIndex: 0));
                              // Get.snackbar('Product added successfully', '');
                            } else {
                              Get.snackbar('Product not added',
                                  'make sure all fields are filled');
                            }
                          },
                          // onPressed: () => _updateProfile(userController),
                          margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          buttonText: 'add_product'.tr,
                        )
                      : CircularProgressIndicator()
                  : Center(child: CircularProgressIndicator()),
            ],
          ),
        ));
      }),
    ));
  }
}
