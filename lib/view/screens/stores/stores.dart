import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/location_controller.dart';
import 'package:efood_multivendor/controller/restaurant_controller.dart';
import 'package:efood_multivendor/controller/user_controller.dart';
import 'package:efood_multivendor/helper/get_substring.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/screens/category/category_screen.dart';
import 'package:efood_multivendor/view/screens/stores/widgets/store_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Stores extends StatelessWidget {
  static Future<void> loadData(bool reload) async {
    Get.find<RestaurantController>()
        .getPopularRestaurantList(reload, 'all', false);
    Get.find<RestaurantController>()
        .getLatestRestaurantList(reload, 'all', false);

    Get.find<RestaurantController>().getRestaurantList('1', reload);
    if (Get.find<AuthController>().isLoggedIn()) {
      Get.find<UserController>().getUserInfo();
    }
  }

  const Stores({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    loadData(false);
    final ScrollController _scrollController = ScrollController();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'stores'.tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                GetBuilder<RestaurantController>(
                  builder: (restaurantController) => ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount:
                        restaurantController.popularRestaurantList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(CategoryScreen(
                            name: restaurantController
                                .popularRestaurantList[index].name,
                          ));
                        },
                        child: StoreItemBuilder(
                          imageUrl: Images.eventsSvg,
                          // imageUrl: restaurantController
                          //             .popularRestaurantList[index].coverPhoto ==
                          //         ''
                          //     ? Images.logopng
                          //     : restaurantController
                          //         .popularRestaurantList[index].coverPhoto,
                          rate: restaurantController
                              .popularRestaurantList[index].ratingCount,
                          storeName: restaurantController
                              .popularRestaurantList[index].name,
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
