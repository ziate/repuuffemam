// import 'package:efood_multivendor/controller/auth_controller.dart';
// import 'package:efood_multivendor/controller/location_controller.dart';
// import 'package:efood_multivendor/controller/splash_controller.dart';
// import 'package:efood_multivendor/controller/user_controller.dart';
// import 'package:efood_multivendor/helper/get_substring.dart';
// import 'package:efood_multivendor/helper/responsive_helper.dart';
// import 'package:efood_multivendor/helper/route_helper.dart';
// import 'package:efood_multivendor/util/dimensions.dart';
// import 'package:efood_multivendor/util/images.dart';
// import 'package:efood_multivendor/view/base/confirmation_dialog.dart';
// import 'package:efood_multivendor/view/base/custom_app_bar.dart';
// import 'package:efood_multivendor/view/base/custom_divider.dart';
// import 'package:efood_multivendor/view/base/custom_image.dart';
// import 'package:efood_multivendor/view/base/custom_loader.dart';
// import 'package:efood_multivendor/view/base/custom_radio_button.dart';
// import 'package:efood_multivendor/view/base/custom_snackbar.dart';
// import 'package:efood_multivendor/view/base/no_data_screen.dart';
// import 'package:efood_multivendor/view/base/not_logged_in_screen.dart';
// import 'package:efood_multivendor/view/base/shared_button.dart';
// import 'package:efood_multivendor/view/screens/address/widget/address_widget.dart';
// import 'package:efood_multivendor/view/screens/dashboard/dashboard_screen.dart';
// import 'package:efood_multivendor/view/screens/home/widget/divider.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AddressScreen extends StatefulWidget {
//   @override
//   State<AddressScreen> createState() => _AddressScreenState();
// }

// class _AddressScreenState extends State<AddressScreen> {
//   bool _isLoggedIn;
//   int selected = 0;

//   @override
//   void initState() {
//     super.initState();

//     _isLoggedIn = Get.find<AuthController>().isLoggedIn();
//     if (_isLoggedIn) {
//       Get.find<LocationController>().getAddressList();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GetBuilder<UserController>(
//         builder: (userController) => SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 width: double.infinity,
//                 child: Stack(
//                   children: [
//                     Container(
//                       height: 100,
//                       child: Column(
//                         children: [
//                           Container(
//                             color: Theme.of(context).scaffoldBackgroundColor,
//                             height: 70,
//                             width: double.infinity,
//                           ),
//                           Container(
//                             color: Theme.of(context).primaryColor,
//                             height: 30,
//                             width: double.infinity,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Center(
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 25.50),
//                         child: ClipOval(
//                           child: CustomImage(
//                             image:
//                                 '${Get.find<SplashController>().configModel.baseUrls.customerImageUrl}'
//                                 '/${(userController.userInfoModel != null && _isLoggedIn) ? userController.userInfoModel.image : ''}',
//                             height: 70,
//                             width: 70,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 color: Theme.of(context).primaryColor,
//                 height: MediaQuery.of(context).size.height,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             "delivery_address".tr,
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Icon(
//                             Icons.location_on_outlined,
//                             color: Theme.of(context).splashColor,
//                           )
//                         ],
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         child: GetBuilder<LocationController>(
//                           builder: (locationController) => ListView.builder(
//                             shrinkWrap: true,
//                             physics: ClampingScrollPhysics(),
//                             itemBuilder: (context, index) => InkWell(
//                               onTap: () {
//                                 Get.toNamed(RouteHelper.getMapRoute(
//                                   locationController.addressList[index],
//                                   'address',
//                                 ));
//                               },
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 10.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         MyRadioOption(
//                                             value: index,
//                                             groupValue: selected,
//                                             text: locationController
//                                                 .addressList[index].addressType,
//                                             onChanged: (i) {
//                                               setState(() {
//                                                 selected = i;
//                                               });
//                                             }),
//                                         SizedBox(
//                                           width: 10,
//                                         ),
//                                         // Text(
//                                         //   locationController
//                                         //       .addressList[index].addressType,
//                                         //   // 'Home',
//                                         //   style: TextStyle(
//                                         //       color: Colors.white,
//                                         //       fontSize: 18,
//                                         //       fontWeight: FontWeight.bold),
//                                         // ),
//                                         // SizedBox(
//                                         //   width: 10,
//                                         // ),
//                                         Text(
//                                           getSubString(
//                                               locationController.address),
//                                           style: TextStyle(
//                                               color: Colors.grey, fontSize: 12),
//                                         )
//                                       ],
//                                     ),
//                                     IconButton(
//                                         icon: Icon(
//                                           Icons.delete,
//                                           color: Colors.white,
//                                         ),
//                                         onPressed: () {
//                                           if (Get.isSnackbarOpen) {
//                                             Get.back();
//                                           }

//                                           Get.dialog(ConfirmationDialog(
//                                               icon: Images.warning,
//                                               description:
//                                                   'are_you_sure_want_to_delete_address'
//                                                       .tr,
//                                               onYesPressed: () {
//                                                 Get.back();
//                                                 Get.dialog(CustomLoader(),
//                                                     barrierDismissible: false);
//                                                 locationController
//                                                     .deleteUserAddressByID(
//                                                         locationController
//                                                             .addressList[index]
//                                                             .id,
//                                                         index)
//                                                     .then((response) {
//                                                   Get.back();
//                                                   showCustomSnackBar(
//                                                       response.message,
//                                                       isError:
//                                                           !response.isSuccess);
//                                                 });
//                                               }));
//                                         })
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             itemCount: locationController.addressList.length,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: SingleChildScrollView(
//         child: Container(
//           color: Theme.of(context).primaryColor,
//           child: Column(
//             children: [
//               customDivider(context),
//               SizedBox(
//                 height: 10,
//               ),
//               SharedButton(
//                 width: MediaQuery.of(context).size.width * 0.5,
//                 text: "add_new_address".tr,
//                 color: Color(0xff2b3038),
//                 onPressed: () {
//                   Get.toNamed(RouteHelper.getAddAddressRoute(false));
//                 },
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               SharedButton(
//                 onPressed: () {
//                   if (selected != 0) {
//                     showCustomSnackBar("Succeeded", isError: false);
//                   }
//                   Get.to(DashboardScreen(pageIndex: 0));
//                 },
//                 width: MediaQuery.of(context).size.width * 0.25,
//                 text: "save".tr,
//                 color: Color(0xff2b3038),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//             ],
//           ),
//         ),
//       ),

//       // appBar: CustomAppBar(title: 'my_address'.tr),
//       // floatingActionButton: FloatingActionButton(
//       //   child: Icon(Icons.add, color: Colors.black),
//       //   backgroundColor: Colors.white,
//       //   onPressed: () => Get.toNamed(RouteHelper.getAddAddressRoute(false)),
//       // ),
//       // floatingActionButtonLocation: ResponsiveHelper.isDesktop(context)
//       //     ? FloatingActionButtonLocation.centerFloat
//       //     : null,

//       // _isLoggedIn
//       //     ? GetBuilder<LocationController>(builder: (locationController) {
//       //         return locationController.addressList != null
//       //             ? locationController.addressList.length > 0
//       //                 ? RefreshIndicator(
//       //                     onRefresh: () async {
//       //                       await locationController.getAddressList();
//       //                     },
//       //                     child: Scrollbar(
//       //                         child: SingleChildScrollView(
//       //                       physics: AlwaysScrollableScrollPhysics(),
//       //                       child: Center(
//       //                           child: SizedBox(
//       //                         width: Dimensions.WEB_MAX_WIDTH,
//       //                         child: ListView.builder(
//       //                           padding: EdgeInsets.all(
//       //                               Dimensions.PADDING_SIZE_SMALL),
//       //                           itemCount:
//       //                               locationController.addressList.length,
//       //                           physics: NeverScrollableScrollPhysics(),
//       //                           shrinkWrap: true,
//       //                           itemBuilder: (context, index) {
//       //                             return Dismissible(
//       //                               key: UniqueKey(),
//       //                               onDismissed: (dir) {
//       //                                 showDialog(
//       //                                     context: context,
//       //                                     builder: (context) => CustomLoader(),
//       //                                     barrierDismissible: false);
//       //                                 locationController
//       //                                     .deleteUserAddressByID(
//       //                                         locationController
//       //                                             .addressList[index].id,
//       //                                         index)
//       //                                     .then((response) {
//       //                                   Navigator.pop(context);
//       //   showCustomSnackBar(response.message,
//       //       isError: !response.isSuccess);
//       // });
//       //                               },
//       //                               child: AddressWidget(
//       //                                 address:
//       //                                     locationController.addressList[index],
//       //                                 fromAddress: true,
//       //---------------------------------------------------------------------------------------
//       //                                 onTap: () {
//       // Get.toNamed(RouteHelper.getMapRoute(
//       //   locationController.addressList[index],
//       //   'address',
//       // ));
//       //                                 },
//       //                                 onEditPressed: () {
//       //                                   Get.toNamed(
//       //                                       RouteHelper.getEditAddressRoute(
//       //                                           locationController
//       //                                               .addressList[index]));
//       //                                 },
//       //                                 onRemovePressed: () {
//       // if (Get.isSnackbarOpen) {
//       //   Get.back();
//       // }
//       // Get.dialog(ConfirmationDialog(
//       //     icon: Images.warning,
//       //     description:
//       //         'are_you_sure_want_to_delete_address'
//       //             .tr,
//       //     onYesPressed: () {
//       //       Get.back();
//       //       Get.dialog(CustomLoader(),
//       //           barrierDismissible: false);
//       //       locationController
//       //           .deleteUserAddressByID(
//       //               locationController
//       //                   .addressList[index]
//       //                   .id,
//       //               index)
//       //           .then((response) {
//       //         Get.back();
//       //         showCustomSnackBar(
//       //             response.message,
//       //             isError:
//       //                 !response.isSuccess);
//       //       });
//       //                                       }));
//       //                                 },
//       //                               ),
//       //                             );
//       //                           },
//       //                         ),
//       //                       )),
//       //                     )),
//       //                   )
//       //                 : NoDataScreen(text: 'no_saved_address_found'.tr)
//       //             : Center(child: CircularProgressIndicator());
//       //       })
//       //     : NotLoggedInScreen(),
//     );
//   }
// }





