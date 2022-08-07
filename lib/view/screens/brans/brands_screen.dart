import 'dart:developer';

import 'package:efood_multivendor/controller/banner_controller.dart';
import 'package:efood_multivendor/controller/category_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/data/model/body/brand_model.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_app_bar.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:efood_multivendor/view/base/no_data_screen.dart';
import 'package:efood_multivendor/view/screens/category/category_product_screen.dart';
import 'package:efood_multivendor/view/screens/home/widget/banner_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandsScreen extends StatefulWidget {
  final String name;
  final int categoryId;
  final int shopId;

  const BrandsScreen(
      {Key key,
      @required this.name,
      @required this.categoryId,
      @required this.shopId})
      : super(key: key);

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  List<Brand> _brands = [];
  @override
  void initState() {
    log("shop id from brand screen = ${widget.shopId}");
    if (Get.find<CategoryController>().brands == null ||
        Get.find<CategoryController>().brands.length == 0) {
      Get.find<CategoryController>().getBrans();
    }
    // _brands.addAll(Get.find<CategoryController>().brands);
    // Get.find<CategoryController>().brands == null
    //     ? _brands = null
    //     : _brands.addAll(Get.find<CategoryController>().brands);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: '',
          titleWidget: Text(
            widget.name,
            style: TextStyle(color: Colors.white),
          ),
          isSmallAppBar: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(
                //   height: 10,
                // ),
                // Center(
                //   child: Container(
                //     height: 30,
                //     width: Dimensions.WEB_MAX_WIDTH,
                //     color: Colors.transparent,
                //     // padding: EdgeInsets.symmetric(
                //     //     horizontal: Dimensions.PADDING_SIZE_SMALL),
                //     child: InkWell(
                //       onTap: () => Get.toNamed(RouteHelper.getSearchRoute()),
                //       child: Container(
                //         padding: EdgeInsets.symmetric(
                //             horizontal: Dimensions.PADDING_SIZE_SMALL),
                //         decoration: BoxDecoration(
                //           color: Theme.of(context).cardColor,
                //           borderRadius: BorderRadius.circular(
                //               Dimensions.RADIUS_EXTRA_LARGE),
                //         ),
                //         child: Row(
                //           children: [
                //             Image(
                //               height: 15,
                //               image: AssetImage(Images.search_icon),
                //             ),
                //             SizedBox(
                //               width: 10,
                //             ),
                //             Center(
                //               child: Text(
                //                 'search_food_or_restaurant'.tr,
                //                 style: robotoRegular.copyWith(
                //                   fontSize: Dimensions.fontSizeSmall,
                //                   color: Theme.of(context).hintColor,
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                //-------------------------------------------------------------------------------
                Center(
                  child: SizedBox(
                    width: Dimensions.WEB_MAX_WIDTH,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GetBuilder<BannerController>(
                          builder: (bannerController) {
                            return bannerController.bannerImageList == null
                                ? BannerView(bannerController: bannerController)
                                : bannerController.bannerImageList.length == 0
                                    ? SizedBox()
                                    : BannerView(
                                        bannerController: bannerController);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                //--------------------------------------------------------------------------
                GetBuilder<CategoryController>(builder: (catController) {
                  //  catController.getBrans();
                  catController.brands != null
                      ? _brands.addAll(catController.brands)
                      : _brands = null;
                  return catController.brands != null
                      ? catController.brands.length > 0
                          ? GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    ResponsiveHelper.isDesktop(context)
                                        ? 6
                                        : ResponsiveHelper.isTab(context)
                                            ? 4
                                            : 3,
                                childAspectRatio: (1 / 1),
                                mainAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
                                crossAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
                              ),
                              padding:
                                  EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                              itemCount: catController.brands.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    log("shop id fucken again : ${widget.shopId}");
                                    Get.to(
                                      CategoryProductScreen(
                                          categoryID: catController
                                              .categoryList[index].id
                                              .toString(),
                                          categoryName: catController
                                              .categoryList[index].name,
                                          brandId: _brands[index].id,
                                          shopId: widget.shopId),
                                    );
                                  },
                                  //  Get.toNamed(
                                  //   RouteHelper.getCategoryProductRoute(
                                  //       catController.categoryList[index].id,
                                  //       catController.categoryList[index].name,
                                  //       catController.brands[index].id,

                                  //       ),
                                  // ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      //   color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.RADIUS_SMALL),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //       color: Colors.grey[
                                      //           Get.isDarkMode ? 800 : 200],
                                      //       blurRadius: 5,
                                      //       spreadRadius: 1)
                                      // ],
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.RADIUS_SMALL),
                                            child: CustomImage(
                                                height: 50,
                                                width: 50,
                                                fit: BoxFit.cover,
                                                image:
                                                    'https://repuffapp.com/storage/app/public/brands/${_brands[index].image}'
                                                //   '${Get.find<SplashController>().configModel.baseUrls.categoryImageUrl}/${_brands[index].image}',
                                                ),
                                          ),
                                          SizedBox(
                                              height: Dimensions
                                                  .PADDING_SIZE_EXTRA_SMALL),
                                          Text(
                                            _brands[index].name,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ]),
                                  ),
                                );
                              },
                            )
                          : NoDataScreen(text: 'no_brands_found'.tr)
                      : Center(child: CircularProgressIndicator());
                })
                //
              ],
            ),
          ),
        )

        //  SafeArea(
        //   child: Scrollbar(
        //     child: SingleChildScrollView(
        //       child: Center(
        //         child: SizedBox(
        //           width: Dimensions.WEB_MAX_WIDTH,
        //           child: GetBuilder<CategoryController>(builder: (catController) {
        //             return catController.categoryList != null
        //                 ? catController.categoryList.length > 0
        //                     ? GridView.builder(
        //                         physics: NeverScrollableScrollPhysics(),
        //                         shrinkWrap: true,
        //                         gridDelegate:
        //                             SliverGridDelegateWithFixedCrossAxisCount(
        //                           crossAxisCount:
        //                               ResponsiveHelper.isDesktop(context)
        //                                   ? 6
        //                                   : ResponsiveHelper.isTab(context)
        //                                       ? 4
        //                                       : 3,
        //                           childAspectRatio: (1 / 1),
        //                           mainAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
        //                           crossAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
        //                         ),
        //                         padding:
        //                             EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        //                         itemCount: catController.categoryList.length,
        //                         itemBuilder: (context, index) {
        //                           return InkWell(
        //                             onTap: () => Get.toNamed(
        //                                 RouteHelper.getCategoryProductRoute(
        //                               catController.categoryList[index].id,
        //                               catController.categoryList[index].name,
        //                             )),
        //                             child: Container(
        //                               decoration: BoxDecoration(
        //                                 color: Theme.of(context).cardColor,
        //                                 borderRadius: BorderRadius.circular(
        //                                     Dimensions.RADIUS_SMALL),
        //                                 boxShadow: [
        //                                   BoxShadow(
        //                                       color: Colors.grey[
        //                                           Get.isDarkMode ? 800 : 200],
        //                                       blurRadius: 5,
        //                                       spreadRadius: 1)
        //                                 ],
        //                               ),
        //                               alignment: Alignment.center,
        //                               child: Column(
        //                                   mainAxisAlignment:
        //                                       MainAxisAlignment.center,
        //                                   children: [
        //                                     ClipRRect(
        //                                       borderRadius: BorderRadius.circular(
        //                                           Dimensions.RADIUS_SMALL),
        //                                       child: CustomImage(
        //                                         height: 50,
        //                                         width: 50,
        //                                         fit: BoxFit.cover,
        //                                         image:
        //                                             '${Get.find<SplashController>().configModel.baseUrls.categoryImageUrl}/${catController.categoryList[index].image}',
        //                                       ),
        //                                     ),
        //                                     SizedBox(
        //                                         height: Dimensions
        //                                             .PADDING_SIZE_EXTRA_SMALL),
        //                                     Text(
        //                                       catController
        //                                           .categoryList[index].name,
        //                                       textAlign: TextAlign.center,
        //                                       style: robotoMedium.copyWith(
        //                                           fontSize:
        //                                               Dimensions.fontSizeSmall),
        //                                       maxLines: 2,
        //                                       overflow: TextOverflow.ellipsis,
        //                                     ),
        //                                   ]),
        //                             ),
        //                           );
        //                         },
        //                       )
        //                     : NoDataScreen(text: 'no_category_found'.tr)
        //                 : Center(child: CircularProgressIndicator());
        //           }),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
}
