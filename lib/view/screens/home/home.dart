import 'package:efood_multivendor/controller/banner_controller.dart';
import 'package:efood_multivendor/controller/location_controller.dart';
import 'package:efood_multivendor/helper/get_substring.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/screens/event/event_screen.dart';
import 'package:efood_multivendor/view/screens/home/widget/banner_view.dart';
import 'package:efood_multivendor/view/screens/home/widget/divider.dart';
import 'package:efood_multivendor/view/screens/stores/stores.dart';
import 'package:efood_multivendor/view/screens/used_market/used_market_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  static Future<void> loadData(bool reload) async {
    Get.find<BannerController>().getBannerList(reload);
  }

  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    loadData(false);
    List<String> images = [
      Images.stores_home,
      Images.eventsSvg,
      Images.used_marketSvg,
    ];
    List<String> labels = [
      "stores".tr,
      "events".tr,
      "used_markets".tr,
    ];

    List screens = [Stores(), EventScreen(), UsedMarketScreen()];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      //height: 100,
                      //  width: 100,
                      child: Stack(children: [
                        Image(
                          image: AssetImage(Images.location),
                        ),
                        GetBuilder<LocationController>(
                          builder: (locationController) => Row(
                            children: [
                              Center(
                                child: Text(
                                  getSubString(locationController
                                      .getUserAddress()
                                      .address),
                                  style: TextStyle(
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 12),
                                ),
                              ),
                              Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 25,
                              )
                            ],
                          ),
                        )
                      ]),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: Container(
                      //width: 100,
                      child: Image(
                        image: AssetImage(Images.logopng),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                  child: Container(
                height: 20,
                width: Dimensions.WEB_MAX_WIDTH,
                color: Colors.transparent,
                // padding: EdgeInsets.symmetric(
                //     horizontal: Dimensions.PADDING_SIZE_SMALL),
                child: InkWell(
                  onTap: () => Get.toNamed(RouteHelper.getSearchRoute()),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_SMALL),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius:
                          BorderRadius.circular(Dimensions.RADIUS_EXTRA_LARGE),
                    ),
                    child: Row(
                      children: [
                        Image(
                          height: 15,
                          image: AssetImage(Images.search_icon),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Center(
                          child: Text(
                            'search_food_or_restaurant'.tr,
                            style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //---------------------------------------------------------------------------------

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
              //---------------------------------------------------------------------------------

              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    customDivider(context),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "explore_by_category".tr,
                      style: robotoRegular.copyWith(
                          color: Colors.white,
                          fontSize: Dimensions.fontSizeExtraSmall,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: _height / 8,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        itemBuilder: (ctx, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(screens[index]);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                height: _height / 8,
                                width: _width / 4,
                                child: Stack(children: [
                                  Image.asset(
                                    images[index],
                                    fit: BoxFit.cover,
                                  ),
                                  Center(
                                    child: Container(
                                      width: _width / 6,
                                      child: Center(
                                        child: Text(
                                          labels[index],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    //-----------------------------------------------------------------------
                    SizedBox(
                      height: 20,
                    ),
                    customDivider(context),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "flash_sale".tr,
                      style: robotoRegular.copyWith(
                          color: Colors.white,
                          fontSize: Dimensions.fontSizeExtraSmall,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: _height / 8,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        itemBuilder: (ctx, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              height: _height / 8,
                              width: _width / 4,
                              child: Stack(children: [
                                Image.asset(
                                  images[index],
                                  fit: BoxFit.cover,
                                ),
                                Center(
                                  child: Container(
                                    width: _width / 6,
                                    child: Center(
                                      child: Text(
                                        labels[index],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
