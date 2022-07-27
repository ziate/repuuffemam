import 'package:efood_multivendor/controller/category_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:efood_multivendor/view/base/title_widget.dart';
import 'package:efood_multivendor/view/screens/home/widget/category_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:get/get.dart';

class CategoryView extends StatelessWidget {
  final CategoryController categoryController;

  CategoryView({@required this.categoryController});

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();

    return Column(
      children: [
        // Padding(
        //   padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        //   child: TitleWidget(title: 'categories'.tr, onTap: () => Get.toNamed(RouteHelper.getCategoryRoute())),
        // ),
        categoryController.categoryList != null
            ? GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 3 / 3.4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                controller: _scrollController,
                itemCount: categoryController.categoryList.length > 15
                    ? 15
                    : categoryController.categoryList.length,
                padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () =>
                        Get.toNamed(RouteHelper.getCategoryProductRoute(
                      categoryController.categoryList[index].id,
                      categoryController.categoryList[index].name,
                    )),
                    child: Column(children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                          ),
                        ),
                        child: CustomImage(
                          width: 100,
                          height: 100,
                          image:
                              '${Get.find<SplashController>().configModel.baseUrls.categoryImageUrl}/${categoryController.categoryList[index].image}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      Padding(
                        padding: EdgeInsets.only(
                            right: index == 0
                                ? Dimensions.PADDING_SIZE_EXTRA_SMALL
                                : 0),
                        child: Text(
                          categoryController.categoryList[index].name,
                          style: robotoMedium.copyWith(
                              fontSize: 14,
                              color: Theme.of(context).primaryColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
                  );
                },
              )
            : CategoryShimmer(categoryController: categoryController),
        ResponsiveHelper.isMobile(context)
            ? SizedBox()
            : categoryController.categoryList != null
                ? Column(
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (con) => Dialog(
                                  child: Container(
                                      height: 550,
                                      width: 600,
                                      child: CategoryPopUp(
                                        categoryController: categoryController,
                                      ))));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: Dimensions.PADDING_SIZE_SMALL),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Text('view_all'.tr,
                                style: TextStyle(
                                    fontSize: Dimensions.PADDING_SIZE_DEFAULT,
                                    color: Theme.of(context).cardColor)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  )
                : CategoryAllShimmer(categoryController: categoryController),
      ],
    );
  }
}

class CategoryShimmer extends StatelessWidget {
  final CategoryController categoryController;

  CategoryShimmer({@required this.categoryController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: ListView.builder(
        itemCount: 14,
        padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
            child: Shimmer(
              duration: Duration(seconds: 2),
              enabled: categoryController.categoryList == null,
              child: Column(children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius:
                        BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  ),
                ),
                SizedBox(height: 5),
                Container(height: 10, width: 50, color: Colors.grey[300]),
              ]),
            ),
          );
        },
      ),
    );
  }
}

class CategoryAllShimmer extends StatelessWidget {
  final CategoryController categoryController;

  CategoryAllShimmer({@required this.categoryController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Padding(
        padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
        child: Shimmer(
          duration: Duration(seconds: 2),
          enabled: categoryController.categoryList == null,
          child: Column(children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              ),
            ),
            SizedBox(height: 5),
            Container(height: 10, width: 50, color: Colors.grey[300]),
          ]),
        ),
      ),
    );
  }
}
