import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/location_controller.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/view/base/confirmation_dialog.dart';
import 'package:efood_multivendor/view/base/custom_button.dart';
import 'package:efood_multivendor/view/base/custom_loader.dart';
import 'package:efood_multivendor/view/base/custom_snackbar.dart';
import 'package:efood_multivendor/view/base/no_data_screen.dart';
import 'package:efood_multivendor/view/base/not_logged_in_screen.dart';
import 'package:efood_multivendor/view/screens/address/add_address_screen%20copy.dart';
import 'package:efood_multivendor/view/screens/address/widget/address_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/styles.dart';
import '../../base/custom_image.dart';

class AddressScreen extends StatefulWidget {
  AddressScreen({this.image});
  final String image;
  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  bool _isLoggedIn;

  @override
  void initState() {
    super.initState();

    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if (_isLoggedIn) {
      Get.find<LocationController>().getAddressList();
    }
  }

  // appBar: CustomAppBar(
  //   isSmallAppBar: true,
  //   title: 'my_address'.tr,
  //   titleWidget: Text(
  //     'my_address'.tr,
  //     style: kTextStyleBold18,
  //   ),
  // ),
  // floatingActionButton: FloatingActionButton(
  //   child: Icon(Icons.add, color: Theme.of(context).cardColor),
  //   backgroundColor: Theme.of(context).primaryColor,
  //   onPressed: () => Get.toNamed(RouteHelper.getAddAddressRoute(false)),
  // ),
  // floatingActionButtonLocation: ResponsiveHelper.isDesktop(context)
  //     ? FloatingActionButtonLocation.centerFloat
  //     : null,
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.7,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                color: Colors.transparent,
                height: 50,
              ),
              Expanded(
                child: Container(
                  color: kPrimaryColor,
                  width: double.infinity,
                ),
              )
            ],
          ),
          Column(
            children: [
              ClipOval(
                child: CustomImage(
                  image: widget.image,
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'my_address'.tr,
                style: kTextStyleBold18.copyWith(color: Colors.white),
              ),
              SizedBox(height: 20),
              Expanded(
                child: _isLoggedIn
                    ? GetBuilder<LocationController>(
                        builder: (locationController) {
                        return locationController.addressList != null
                            ? locationController.addressList.length > 0
                                ? SingleChildScrollView(
                                    physics: AlwaysScrollableScrollPhysics(),
                                    child: Center(
                                        child: SizedBox(
                                      width: Dimensions.WEB_MAX_WIDTH,
                                      child: ListView.builder(
                                        padding: EdgeInsets.all(
                                            Dimensions.PADDING_SIZE_SMALL),
                                        itemCount: locationController
                                            .addressList.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Dismissible(
                                            key: UniqueKey(),
                                            onDismissed: (dir) {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      CustomLoader(),
                                                  barrierDismissible: false);
                                              locationController
                                                  .deleteUserAddressByID(
                                                      locationController
                                                          .addressList[index]
                                                          .id,
                                                      index)
                                                  .then((response) {
                                                Navigator.pop(context);
                                                showCustomSnackBar(
                                                    response.message,
                                                    isError:
                                                        !response.isSuccess);
                                              });
                                            },
                                            child: AddressWidget(
                                              address: locationController
                                                  .addressList[index],
                                              fromAddress: true,
                                              onTap: () {
                                                Get.toNamed(
                                                    RouteHelper.getMapRoute(
                                                  locationController
                                                      .addressList[index],
                                                  'address',
                                                ));
                                              },
                                              onEditPressed: () {
                                                Get.toNamed(RouteHelper
                                                    .getEditAddressRoute(
                                                        locationController
                                                                .addressList[
                                                            index]));
                                              },
                                              onRemovePressed: () {
                                                if (Get.isSnackbarOpen) {
                                                  Get.back();
                                                }
                                                Get.dialog(ConfirmationDialog(
                                                    icon: Images.warning,
                                                    description:
                                                        'are_you_sure_want_to_delete_address'
                                                            .tr,
                                                    onYesPressed: () {
                                                      Get.back();
                                                      Get.dialog(CustomLoader(),
                                                          barrierDismissible:
                                                              false);
                                                      locationController
                                                          .deleteUserAddressByID(
                                                              locationController
                                                                  .addressList[
                                                                      index]
                                                                  .id,
                                                              index)
                                                          .then((response) {
                                                        Get.back();
                                                        showCustomSnackBar(
                                                            response.message,
                                                            isError: !response
                                                                .isSuccess);
                                                      });
                                                    }));
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    )),
                                  )
                                : NoDataScreen(
                                    text: 'no_saved_address_found'.tr)
                            : Center(child: CircularProgressIndicator());
                      })
                    : NotLoggedInScreen(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  onPressed: () {
                    showModelSheet(
                      context,
                      AddAddressScreen(
                          fromCheckout: false, image: widget.image),
                      color: Colors.transparent,
                    );
                    // return Get.toNamed(RouteHelper.getAddAddressRoute(false));
                  },
                  buttonText: "add_new_address".tr,
                  radius: 13,
                  color: Color(0xff20242A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showModelSheet(BuildContext context, Widget content, {Color color}) {
    showModalBottomSheet(
      backgroundColor: color ?? kPrimaryColor,
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
