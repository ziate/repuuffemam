import 'package:efood_multivendor/controller/category_controller.dart';
import 'package:efood_multivendor/controller/localization_controller.dart';
import 'package:efood_multivendor/data/model/body/brand_model.dart';
import 'package:efood_multivendor/data/model/response/product_model.dart';
import 'package:efood_multivendor/data/model/response/restaurant_model.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_app_bar.dart';
import 'package:efood_multivendor/view/base/web_menu_bar.dart';
import 'package:efood_multivendor/view/screens/category/widget/category_card_view.dart';
import 'package:efood_multivendor/view/screens/home/widget/category_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CategoryProductScreen extends StatefulWidget {
  final String categoryID;
  final String categoryName;
  final int brandId;
  final int shopId;

  CategoryProductScreen(
      {@required this.categoryID,
      @required this.categoryName,
      this.brandId,
      this.shopId});

  @override
  _CategoryProductScreenState createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen>
    with TickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  final ScrollController restaurantScrollController = ScrollController();
  final bool _ltr = Get.find<LocalizationController>().isLtr;
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    Get.find<CategoryController>().getSubCategoryList(
        widget.categoryID, widget.shopId.toString(), widget.brandId);
    // Get.find<CategoryController>().getBrans();
    scrollController?.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          Get.find<CategoryController>().categoryProductList != null &&
          !Get.find<CategoryController>().isLoading) {
        int pageSize = (Get.find<CategoryController>().pageSize / 10).ceil();
        if (Get.find<CategoryController>().offset < pageSize) {
          print('end of the page');
          Get.find<CategoryController>().showBottomLoader();
          Get.find<CategoryController>().getCategoryProductList(
              Get.find<CategoryController>().subCategoryIndex == 0
                  ? widget.categoryID
                  : Get.find<CategoryController>()
                      .subCategoryList[
                          Get.find<CategoryController>().subCategoryIndex]
                      .id
                      .toString(),
              Get.find<CategoryController>().shopId,
              Get.find<CategoryController>().offset + 1,
              Get.find<CategoryController>().type,
              false,
              widget.brandId);
        }
      }
    });
    restaurantScrollController?.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          Get.find<CategoryController>().categoryRestList != null &&
          !Get.find<CategoryController>().isLoading) {
        int pageSize =
            (Get.find<CategoryController>().restPageSize / 10).ceil();
        if (Get.find<CategoryController>().offset < pageSize) {
          print('end of the page');
          Get.find<CategoryController>().showBottomLoader();
          Get.find<CategoryController>().getCategoryRestaurantList(
            Get.find<CategoryController>().subCategoryIndex == 0
                ? widget.categoryID
                : Get.find<CategoryController>()
                    .subCategoryList[
                        Get.find<CategoryController>().subCategoryIndex]
                    .id,
            Get.find<CategoryController>().offset + 1,
            Get.find<CategoryController>().type,
            false,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (catController) {
      List<Product> _products;
      List<Brand> _brands = [];
      List<Restaurant> _restaurants;
      if (catController.categoryProductList != null &&
          catController.searchProductList != null) {
        _products = [];
        if (catController.isSearching) {
          _products.addAll(catController.searchProductList);
        } else {
          _products.addAll(catController.categoryProductList);
        }
      }
      if (catController.categoryRestList != null &&
          catController.searchRestList != null) {
        _restaurants = [];
        if (catController.isSearching) {
          _restaurants.addAll(catController.searchRestList);
        } else {
          _restaurants.addAll(catController.categoryRestList);
        }
      }
      if (catController.brands != null) {
        _brands.addAll(catController.brands);
      }
      return WillPopScope(
        onWillPop: () async {
          if (catController.isSearching) {
            catController.toggleSearch();
            return false;
          } else {
            return true;
          }
        },
        child: SafeArea(
          child: Scaffold(
            appBar: CustomAppBar(
              title: '',
              titleWidget: Text(
                widget.categoryName,
                style: TextStyle(color: Colors.white),
              ),
              isSmallAppBar: true,
            ),
            // appBar: ResponsiveHelper.isDesktop(context)
            //     ? WebMenuBar()
            //     : PreferredSize(
            //         preferredSize: Size.fromHeight(70),
            //         child: Container(
            //           width: double.infinity,
            //           height: 60,
            //           color: Theme.of(context).primaryColor,
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceAround,
            //             children: [
            //               Container(
            //                 clipBehavior: Clip.antiAlias,
            //                 width: 50,
            //                 height: 50,
            //                 child: Center(
            //                   child: Image.asset(
            //                     Images.logopng,
            //                   ),
            //                 ),
            //                 decoration: BoxDecoration(
            //                     shape: BoxShape.circle, color: Colors.white),
            //               ),
            //               Text(
            //                 widget.categoryName.tr,
            //                 style: TextStyle(
            //                     color: Colors.white,
            //                     fontSize: 20,
            //                     fontWeight: FontWeight.w200),
            //               ),
            //               InkWell(
            //                   onTap: () {
            //                     Get.back();
            //                   },
            //                   child: SvgPicture.asset(Images.backSvg)),
            //             ],
            //           ),
            //         ),
            //       ),
            body: Center(
                child: SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          height: 30,
                          width: Dimensions.WEB_MAX_WIDTH,
                          color: Colors.transparent,
                          // padding: EdgeInsets.symmetric(
                          //     horizontal: Dimensions.PADDING_SIZE_SMALL),
                          child: InkWell(
                            onTap: () =>
                                Get.toNamed(RouteHelper.getSearchRoute()),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_SMALL),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.RADIUS_EXTRA_LARGE),
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
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: SizedBox(
                      //         height: 40,
                      //         child: TextField(
                      //           autofocus: false,
                      //           textInputAction: TextInputAction.search,
                      //           decoration: InputDecoration(
                      //             filled: true,
                      //             fillColor: Colors.white,
                      //             enabledBorder: OutlineInputBorder(
                      //               borderRadius: BorderRadius.circular(10),
                      //               borderSide: BorderSide(
                      //                 color: Colors.white,
                      //               ),
                      //             ),
                      //             focusedBorder: OutlineInputBorder(
                      //               borderRadius: BorderRadius.circular(10),
                      //               borderSide: BorderSide(
                      //                 color: Colors.white,
                      //               ),
                      //             ),
                      //             prefixIcon: Icon(Icons.search),
                      //             hintText: 'Search...',
                      //             border: InputBorder.none,
                      //           ),
                      //           style: robotoRegular.copyWith(
                      //               fontSize: Dimensions.fontSizeLarge),
                      //           onSubmitted: (String query) =>
                      //               catController.searchData(
                      //             query,
                      //             catController.subCategoryIndex == 0
                      //                 ? widget.categoryID
                      //                 : catController
                      //                     .subCategoryList[
                      //                         catController.subCategoryIndex]
                      //                     .id,
                      //             catController.type,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     Container(
                      //       width: 80,
                      //       height: 80,
                      //       decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         shape: BoxShape.circle,
                      //         border: Border.all(
                      //           color: Theme.of(context).primaryColor,
                      //           width: 2,
                      //         ),
                      //       ),
                      //       child: IconButton(
                      //         icon: Icon(
                      //           Icons.shopping_cart_outlined,
                      //           size: 50,
                      //           color: Theme.of(context).primaryColor,
                      //         ),
                      //         onPressed: () =>
                      //             Get.toNamed(RouteHelper.getCartRoute()),
                      //       ),
                      //     )
                      //   ],
                      // ),
                      (catController.subCategoryList != null &&
                              !catController.isSearching)
                          ? Center(
                              child: SizedBox(
                              height: 50,
                              width: Dimensions.WEB_MAX_WIDTH,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: catController.subCategoryList.length,
                                padding: EdgeInsets.only(
                                    left: Dimensions.PADDING_SIZE_SMALL),
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () =>
                                        catController.setSubCategoryIndex(
                                            index, widget.categoryID, ""),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 60,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            border: Border.all(
                                                color: catController
                                                            .subCategoryIndex ==
                                                        index
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                    : Colors.white,
                                                width: 0.25),
                                            color: catController
                                                        .subCategoryIndex ==
                                                    index
                                                ? Color(0xffe1003c)
                                                : Theme.of(context)
                                                    .primaryColor),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              //  SizedBox(height: 3),
                                              Text(
                                                  catController
                                                      .subCategoryList[index]
                                                      .name,
                                                  style: TextStyle(
                                                      color: Colors.white)

                                                  //  index ==
                                                  //         catController
                                                  //             .subCategoryIndex
                                                  //     ? robotoMedium.copyWith(
                                                  //         fontSize: Dimensions
                                                  //             .fontSizeSmall,
                                                  //         color: Theme.of(context)
                                                  //             .primaryColor)
                                                  //     : robotoRegular.copyWith(
                                                  //         fontSize: Dimensions
                                                  //             .fontSizeSmall,
                                                  //         color: Theme.of(context)
                                                  //             .disabledColor),
                                                  ),

                                              //------------------------------------------------------------
                                              // index ==
                                              //         catController.subCategoryIndex
                                              //     ? Container(
                                              //         height: 5,
                                              //         width: 5,
                                              //         decoration: BoxDecoration(
                                              //             color: Theme.of(context)
                                              //                 .primaryColor,
                                              //             shape: BoxShape.circle),
                                              //       )
                                              //     : SizedBox(height: 5, width: 5),
                                            ]),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ))
                          : SizedBox(),
                    ],
                  ),
                ),
                Expanded(
                    child: NotificationListener(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollEndNotification) {
                      if ((_tabController.index == 1 &&
                              !catController.isRestaurant) ||
                          _tabController.index == 0 &&
                              catController.isRestaurant) {
                        catController.setRestaurant(_tabController.index == 1);
                        if (catController.isSearching) {
                          catController.searchData(
                            catController.searchText,
                            catController.subCategoryIndex == 0
                                ? widget.categoryID
                                : catController
                                    .subCategoryList[
                                        catController.subCategoryIndex]
                                    .id,
                            catController.type,
                          );
                        } else {
                          if (_tabController.index == 1) {
                            catController.getCategoryRestaurantList(
                              catController.subCategoryIndex == 0
                                  ? widget.categoryID
                                  : catController
                                      .subCategoryList[
                                          catController.subCategoryIndex]
                                      .id,
                              1,
                              catController.type,
                              false,
                            );
                          } else {
                            catController.getCategoryProductList(
                                catController.subCategoryIndex == 0
                                    ? widget.categoryID
                                    : catController
                                        .subCategoryList[
                                            catController.subCategoryIndex]
                                        .id,
                                Get.find<CategoryController>().shopId,
                                1,
                                catController.type,
                                false,
                                widget.brandId);
                          }
                        }
                      }
                    }
                    return false;
                  },
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child:
                        // child: (catController.brands != null &&
                        //         catController.brands.length != 0)
                        //     ? GridView.builder(
                        //         gridDelegate:
                        //             SliverGridDelegateWithFixedCrossAxisCount(
                        //           crossAxisSpacing: Dimensions.PADDING_SIZE_LARGE,
                        //           mainAxisSpacing:
                        //               ResponsiveHelper.isDesktop(context)
                        //                   ? Dimensions.PADDING_SIZE_LARGE
                        //                   : 0.01,
                        //           childAspectRatio:
                        //               ResponsiveHelper.isDesktop(context) ? 4 : 4,
                        //           crossAxisCount:
                        //               ResponsiveHelper.isMobile(context) ? 1 : 2,
                        //         ),
                        //         itemCount: catController.brands.length,
                        //         itemBuilder: (context, index) {
                        //           return Container(
                        //             height: 100,
                        //             width: 100,
                        //             color: Colors.red,
                        //           );
                        //         },
                        //       )
                        //     : CategoryShimmer(categoryController: catController),
                        CategoryView(
                      isRestaurant: false,
                      products: _products,
                      restaurants: null,
                      noDataText: 'no_category_food_found'.tr,
                    ),
                  ),
                )),
                catController.isLoading
                    ? Center(
                        child: Padding(
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor)),
                      ))
                    : SizedBox(),
              ]),
            )),
          ),
        ),
      );
    });
  }
}
