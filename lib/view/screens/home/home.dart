import 'package:efood_multivendor/controller/banner_controller.dart';
import 'package:efood_multivendor/controller/location_controller.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/screens/home/home_screen.dart';
import 'package:efood_multivendor/view/screens/home/widget/banner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  static Future<void> loadData(bool reload) async {
    Get.find<BannerController>().getBannerList(reload);
  }

  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    loadData(false);
    List<String> images = [
      Images.storespng,
      Images.used_marketSvg,
      Images.eventsSvg,
    ];
    List<String> labels = [
      "STORES",
      "USED MARKET",
      "EVENTS",
    ];
    return Scaffold(
        appBar: PreferredSize(
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
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Center(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Container(
                    height: 40,
                    width: Dimensions.WEB_MAX_WIDTH,
                    color: Colors.transparent,
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_SMALL),
                    child: InkWell(
                      onTap: () => Get.toNamed(RouteHelper.getSearchRoute()),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_SMALL),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(
                              Dimensions.RADIUS_EXTRA_LARGE),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[Get.isDarkMode ? 800 : 200],
                                spreadRadius: 1,
                                blurRadius: 5)
                          ],
                        ),
                        child: Row(children: [
                          Icon(Icons.search,
                              size: 25, color: Theme.of(context).primaryColor),
                          SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          Expanded(
                              child: Text('search_food_or_restaurant'.tr,
                                  style: robotoRegular.copyWith(
                                    fontSize: Dimensions.fontSizeSmall,
                                    color: Theme.of(context).hintColor,
                                  ))),
                        ]),
                      ),
                    ),
                  ))),
          Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: Dimensions.WEB_MAX_WIDTH,
              height: 50,
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius:
                      BorderRadius.circular(Dimensions.RADIUS_EXTRA_LARGE)),
              child: Row(children: [
                Expanded(
                    child: InkWell(
                  onTap: () =>
                      Get.toNamed(RouteHelper.getAccessLocationRoute('home')),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_SMALL,
                      horizontal: ResponsiveHelper.isDesktop(context)
                          ? Dimensions.PADDING_SIZE_SMALL
                          : 0,
                    ),
                    child: GetBuilder<LocationController>(
                        builder: (locationController) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            locationController.getUserAddress().addressType ==
                                    'home'
                                ? Icons.home_filled
                                : locationController
                                            .getUserAddress()
                                            .addressType ==
                                        'office'
                                    ? Icons.work
                                    : Icons.location_on,
                            size: 20,
                            color: Theme.of(context).textTheme.bodyText1.color,
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              locationController.getUserAddress().address,
                              style: robotoRegular.copyWith(
                                color:
                                    Theme.of(context).textTheme.bodyText1.color,
                                fontSize: Dimensions.fontSizeSmall,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                )),
                Icon(Icons.arrow_forward_ios_outlined)
              ]),
            ),
          )),
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
                        }),
                      ]))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: images.length,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      if (index == 0) {
                        Get.toNamed(RouteHelper.storesScreen);
                      } else if (index == 1) {
                        Get.toNamed(RouteHelper.usedMarket);
                      } else if (index == 2) {
                        Get.toNamed(RouteHelper.eventScreen);
                      }
                    },
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(
                                Dimensions.RADIUS_EXTRA_LARGE),
                            child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.RADIUS_EXTRA_LARGE),
                                    color: Colors.white),
                                child: Image.asset(
                                  images[index],
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(labels[index],
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeExtraLarge,
                                color: Theme.of(context).primaryColor)),
                      ],
                    ),
                  );
                }),
          ),
        ])));
  }
}
