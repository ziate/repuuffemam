import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/order_controller.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/theme/styles.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_app_bar.dart';
import 'package:efood_multivendor/view/base/not_logged_in_screen.dart';
import 'package:efood_multivendor/view/screens/order/widget/order_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../util/images.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with TickerProviderStateMixin {
  TabController _tabController;
  bool _isLoggedIn;

  @override
  void initState() {
    super.initState();

    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if (_isLoggedIn) {
      _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
      Get.find<OrderController>().getRunningOrders(1);
      Get.find<OrderController>().getHistoryOrders(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarColor: kPrimaryColor,
        titleWidget: Column(
          children: [
            SizedBox(height: 5),
            SvgPicture.asset(Images.cart, width: 43, height: 43),
            Text('my_orders'.tr, style: kTextStyleBold15),
            SizedBox(height: 10),
          ],
        ),
        title: 'my_orders'.tr,
        isBackButtonExist: true,
      ),
      body: _isLoggedIn
          ? GetBuilder<OrderController>(
              builder: (orderController) {
                return Column(children: [
                  SizedBox(height: 10),
                  Center(
                    child: Container(
                      width: Dimensions.WEB_MAX_WIDTH,
                      color: kBackgroundColor,
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
                          Tab(text: 'running'.tr),
                          Tab(text: 'history'.tr),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: TabBarView(
                    controller: _tabController,
                    children: [
                      OrderView(isRunning: true),
                      OrderView(isRunning: false),
                    ],
                  )),
                ]);
              },
            )
          : NotLoggedInScreen(),
    );
  }
}
