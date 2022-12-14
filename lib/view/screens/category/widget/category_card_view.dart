import 'package:efood_multivendor/data/model/body/brand_model.dart';
import 'package:efood_multivendor/data/model/response/product_model.dart';
import 'package:efood_multivendor/data/model/response/restaurant_model.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/view/base/no_data_screen.dart';
import 'package:efood_multivendor/view/base/product_shimmer.dart';
import 'package:efood_multivendor/view/base/product_widget.dart';
import 'package:efood_multivendor/view/base/veg_filter_widget.dart';
import 'package:efood_multivendor/view/screens/category/widget/category_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryView extends StatelessWidget {
  final List<Product> products; // List<Product>
  final List<Restaurant> restaurants;
  final bool isRestaurant;
  final EdgeInsetsGeometry padding;
  final bool isScrollable;
  final int shimmerLength;
  final String noDataText;
  final bool isCampaign;
  final bool inRestaurantPage;
  final String type;
  final Function(String type) onVegFilterTap;
  // final List<Brand> brands;
  // final bool isBrand;

  CategoryView({
    @required this.restaurants,
    @required this.products,
    @required this.isRestaurant,
    this.isScrollable = false,
    this.shimmerLength = 20,
    this.padding = const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
    this.noDataText,
    this.isCampaign = false,
    this.inRestaurantPage = false,
    this.type,
    this.onVegFilterTap,
    // @required this.brands,
    // @required this.isBrand,
  });

  @override
  Widget build(BuildContext context) {
    bool _isNull = true;
    int _length = 0;
    if (isRestaurant) {
      _isNull = restaurants == null;
      if (!_isNull) {
        _length = restaurants.length;
      }
    } else {
      _isNull = products == null;
      if (!_isNull) {
        _length = products.length;
      }
    }

    return Column(children: [
      type != null
          ? VegFilterWidget(type: type, onSelected: onVegFilterTap)
          : SizedBox(),
      !_isNull
          ? _length > 0
              ? GridView.builder(
                  key: UniqueKey(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: Dimensions.PADDING_SIZE_LARGE,
                    mainAxisSpacing: ResponsiveHelper.isDesktop(context)
                        ? Dimensions.PADDING_SIZE_LARGE
                        : 0.01,
                    childAspectRatio:
                        ResponsiveHelper.isDesktop(context) ? 3 : 1 / 1.35,
                    crossAxisCount: ResponsiveHelper.isMobile(context) ? 2 : 1,
                  ),
                  physics: isScrollable
                      ? BouncingScrollPhysics()
                      : NeverScrollableScrollPhysics(),
                  shrinkWrap: isScrollable ? false : true,
                  itemCount: _length,
                  padding: padding,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CategoryWidget(
                        isRestaurant: isRestaurant,
                        product: isRestaurant ? null : products[index],
                        restaurant: isRestaurant ? restaurants[index] : null,
                        index: index,
                        length: _length,
                        isCampaign: isCampaign,
                        inRestaurant: inRestaurantPage,
                      ),
                    );
                  },
                )
              : NoDataScreen(
                  text: noDataText != null
                      ? noDataText
                      : isRestaurant
                          ? 'no_restaurant_available'.tr
                          : 'no_food_available'.tr,
                )
          : GridView.builder(
              key: UniqueKey(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: Dimensions.PADDING_SIZE_LARGE,
                mainAxisSpacing: ResponsiveHelper.isDesktop(context)
                    ? Dimensions.PADDING_SIZE_LARGE
                    : 0.01,
                childAspectRatio: ResponsiveHelper.isDesktop(context) ? 4 : 4,
                crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 2,
              ),
              physics: isScrollable
                  ? BouncingScrollPhysics()
                  : NeverScrollableScrollPhysics(),
              shrinkWrap: isScrollable ? false : true,
              itemCount: shimmerLength,
              padding: padding,
              itemBuilder: (context, index) {
                return ProductShimmer(
                    isEnabled: _isNull,
                    isRestaurant: isRestaurant,
                    hasDivider: index != shimmerLength - 1);
              },
            ),
    ]);
  }
}
