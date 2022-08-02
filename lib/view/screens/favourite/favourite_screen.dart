import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/theme/styles.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/view/base/custom_app_bar.dart';
import 'package:efood_multivendor/view/base/not_logged_in_screen.dart';
import 'package:efood_multivendor/view/screens/favourite/widget/fav_item_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        titleWidget: Text(
          "favorite".tr,
          style: TextStyle(color: Colors.white),
        ),
        isBackButtonExist: false,
        isSmallAppBar: true,
      ),
      body: Get.find<AuthController>().isLoggedIn()
          ? SafeArea(
              child: Column(
                children: [
                  Container(
                    width: Dimensions.WEB_MAX_WIDTH,
                    //  color: Theme.of(context).cardColor,
                    child: Container(
                      // color: Theme.of(context).primaryColor,
                      child: TabBar(
                        indicatorColor: Color(0xffE1003C),
                        padding: const EdgeInsets.all(0),
                        labelPadding: const EdgeInsets.all(0),
                        indicatorPadding: const EdgeInsets.symmetric(
                          horizontal: 55,
                        ),
                        labelColor: Color(0xffF5F6F8),
                        unselectedLabelColor: const Color(0xff8D8E91),
                        labelStyle: kTextStyleReg16.copyWith(fontSize: 21),
                        unselectedLabelStyle:
                            kTextStyleReg16.copyWith(fontSize: 21),
                        controller: _tabController,
                        indicatorWeight: 3,
                        tabs: [
                          Tab(text: 'food'.tr),
                          Tab(text: 'restaurants'.tr),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          FavItemView(isRestaurant: false),
                          FavItemView(isRestaurant: true),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : NotLoggedInScreen(),
    );
  }
}
