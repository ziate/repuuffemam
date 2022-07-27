import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/restaurant_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/controller/wishlist_controller.dart';
import 'package:efood_multivendor/data/model/response/address_model.dart';
import 'package:efood_multivendor/data/model/response/restaurant_model.dart';
import 'package:efood_multivendor/helper/price_converter.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:efood_multivendor/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RestaurantDescriptionView extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantDescriptionView({@required this.restaurant});

  @override
  Widget build(BuildContext context) {
    bool _isAvailable = Get.find<RestaurantController>()
        .isRestaurantOpenNow(restaurant.active, restaurant.schedules);
    Color _textColor =
        ResponsiveHelper.isDesktop(context) ? Colors.white : null;
    return Row(children: [
      Container(
        clipBehavior: Clip.antiAlias,
        height: ResponsiveHelper.isDesktop(context) ? 80 : 100,
        width: ResponsiveHelper.isDesktop(context) ? 100 : 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
        ),
        child: CustomImage(
          image:
              '${Get.find<SplashController>().configModel.baseUrls.restaurantImageUrl}/${restaurant.logo}',
          fit: BoxFit.cover,
        ),
      ),
      SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
      Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          restaurant.name,
          style: robotoMedium.copyWith(
              fontSize: Dimensions.fontSizeLarge, color: Colors.red),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        Text(
          restaurant.address ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: robotoRegular.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: Theme.of(context).primaryColor),
        ),
        SizedBox(
            height: ResponsiveHelper.isDesktop(context)
                ? Dimensions.PADDING_SIZE_EXTRA_SMALL
                : 0),
        // Row(children: [
        //   Text('minimum_order'.tr,
        //       style: robotoRegular.copyWith(
        //         fontSize: Dimensions.fontSizeExtraSmall,
        //         color: Theme.of(context).disabledColor,
        //       )),
        //   SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        //   Text(
        //     PriceConverter.convertPrice(restaurant.minimumOrder),
        //     style: robotoMedium.copyWith(
        //         fontSize: Dimensions.fontSizeExtraSmall,
        //         color: Theme.of(context).primaryColor),
        //   ),
        // ]),
      ])),
      SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
      Column(
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.chat,
                color: Theme.of(context).primaryColor,
              )),
          Text("Story Chat",
              style: robotoMedium.copyWith(
                  fontSize: Dimensions.fontSizeExtraSmall,
                  color: Theme.of(context).errorColor)),
          SizedBox(height: 10),
          InkWell(
            onTap: () => Get.toNamed(
                RouteHelper.getRestaurantReviewRoute(restaurant.id)),
            child: Column(children: [
              Row(children: [
                Icon(Icons.star,
                    color: Theme.of(context).primaryColor, size: 20),
                SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                Text(
                  restaurant.avgRating.toStringAsFixed(1),
                  style: robotoMedium.copyWith(
                      fontSize: Dimensions.fontSizeSmall, color: _textColor),
                ),
              ]),
              SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Text(
                '${restaurant.ratingCount} ${'ratings'.tr}',
                style: robotoRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall, color: _textColor),
              ),
            ]),
          ),
        ],
      ),

      // GetBuilder<WishListController>(builder: (wishController) {
      //   bool _isWished =
      //       wishController.wishRestIdList.contains(restaurant.id);
      //   return InkWell(
      //     onTap: () {
      //       if (Get.find<AuthController>().isLoggedIn()) {
      //         _isWished
      //             ? wishController.removeFromWishList(restaurant.id, true)
      //             : wishController.addToWishList(null, restaurant, true);
      //       } else {
      //         showCustomSnackBar('you_are_not_logged_in'.tr);
      //       }
      //     },
      //     child: Icon(
      //       _isWished ? Icons.favorite : Icons.favorite_border,
      //       color: _isWished
      //           ? Theme.of(context).primaryColor
      //           : Theme.of(context).disabledColor,
      //     ),
      //   );
      // }),
    ]);
  }
}
