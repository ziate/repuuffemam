import 'package:efood_multivendor/controller/banner_controller.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/web_menu_bar.dart';
import 'package:efood_multivendor/view/screens/event/widget/according_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EventScreen extends StatelessWidget {
  static Future<void> loadData(bool reload) async {
    Get.find<BannerController>().getBannerList(reload);
  }

  const EventScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ResponsiveHelper.isDesktop(context)
            ? WebMenuBar()
            : PreferredSize(
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
                      Text("event".tr,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w200)),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(Images.backSvg)),
                    ],
                  ),
                ),
              ),
        body: SingleChildScrollView(
          child: Column(children: [
            Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
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
                                  color:
                                      Colors.grey[Get.isDarkMode ? 800 : 200],
                                  spreadRadius: 1,
                                  blurRadius: 5)
                            ],
                          ),
                          child: Row(children: [
                            Icon(Icons.search,
                                size: 25,
                                color: Theme.of(context).primaryColor),
                            SizedBox(
                                width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
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
            ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: Accordion(
                      title: 'event_title'.tr,
                      content:
                          'It will be one of the Amazing Event including most of\nfamous Vape Branding that will rock the vape\ncommunity and u will get free giveaways\nand feel the real spirit of vapor family '
                              .tr,
                    ),
                  );
                }),
          ]),
        ),
      ),
    );
  }
}
