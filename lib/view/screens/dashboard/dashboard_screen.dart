import 'dart:async';
import 'package:badges/badges.dart';
import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/cart_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/controller/user_controller.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/view/base/cart_widget.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:efood_multivendor/view/screens/cart/cart_screen.dart';
import 'package:efood_multivendor/view/screens/dashboard/widget/bottom_nav_item.dart';
import 'package:efood_multivendor/view/screens/event/event_screen.dart';
import 'package:efood_multivendor/view/screens/favourite/favourite_screen.dart';
import 'package:efood_multivendor/view/screens/home/home.dart';
import 'package:efood_multivendor/view/screens/home/home_screen.dart';
import 'package:efood_multivendor/view/screens/order/order_screen.dart';
import 'package:efood_multivendor/view/screens/profile/profile_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'widget/app_drawer.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;

  DashboardScreen({@required this.pageIndex});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PageController _pageController;
  int _pageIndex = 0;
  List<Widget> _screens;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  bool _canExit = GetPlatform.isWeb ? true : false;

  @override
  void initState() {
    super.initState();

    _pageIndex = widget.pageIndex;

    _pageController = PageController(initialPage: widget.pageIndex);

    _screens = [
      Home(),
      FavouriteScreen(),
      ProfileScreen(),
      OrderScreen(),
      // CartScreen(fromNav: true),
      // FavouriteScreen(),

      // CartScreen(fromNav: true),
      EventScreen(),

      // Container(),
    ];

    Future.delayed(Duration(seconds: 1), () {
      setState(() {});
    });

    /*if(GetPlatform.isMobile) {
      NetworkInfo.checkConnectivity(_scaffoldKey.currentContext);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if (_isLoggedIn && Get.find<UserController>().userInfoModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    Color iconColor = Colors.white;
    Color selected = Color(0xffe1003c);
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          if (_canExit) {
            return true;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('back_press_again_to_exit'.tr,
                  style: TextStyle(color: Colors.white)),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            ));
            _canExit = true;
            Timer(Duration(seconds: 2), () {
              _canExit = false;
            });
            return false;
          }
        }
      },
      child: SafeArea(
        child: Scaffold(
          // floatingActionButton: FloatingActionButton(
          //   backgroundColor: Theme.of(context).primaryColor,
          //   child: Icon(Icons.shopping_cart),
          //   onPressed: () {
          //     Get.to(CartScreen(fromNav: false));
          //   },
          // ),
          // drawerScrimColor: Colors.transparent,
          drawer: AppDrawer(),
          drawerScrimColor: Colors.transparent,

          key: _scaffoldKey,
          // floatingActionButton: ResponsiveHelper.isDesktop(context)
          //     ? null
          //     : FloatingActionButton(
          //         elevation: 5,
          //         backgroundColor: _pageIndex == 2
          //             ? Theme.of(context).primaryColor
          //             : Theme.of(context).cardColor,
          //         onPressed: () => _setPage(2),
          //         child: CartWidget(
          //             color: _pageIndex == 2
          //                 ? Theme.of(context).cardColor
          //                 : Theme.of(context).disabledColor,
          //             size: 30),
          //       ),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: ResponsiveHelper.isDesktop(context)
              ? SizedBox()
              : SingleChildScrollView(
                  child: Stack(clipBehavior: Clip.none, children: [
                    Positioned(
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                                enableFeedback: false,
                                onPressed: () {
                                  setState(() {
                                    _pageIndex = 0;
                                  });
                                },
                                icon: _pageIndex == 0
                                    ? SvgPicture.asset(
                                        Images.home_icon,
                                        color: selected,
                                      )
                                    : SvgPicture.asset(
                                        Images.home_icon,
                                        color: iconColor,
                                      )),
                            IconButton(
                                enableFeedback: false,
                                onPressed: () {
                                  setState(() {
                                    _pageIndex = 1;
                                  });
                                },
                                icon: _pageIndex == 1
                                    ? SvgPicture.asset(
                                        Images.favorite,
                                        color: selected,
                                      )
                                    : SvgPicture.asset(
                                        Images.favorite,
                                        color: iconColor,
                                      )),
                            SizedBox(
                              width: 50,
                            ),
                            IconButton(
                              enableFeedback: false,
                              onPressed: () {
                                setState(() {
                                  _pageIndex = 3;
                                });
                              },
                              icon: _pageIndex == 3
                                  ? SvgPicture.asset(
                                      Images.cart,
                                      color: selected,
                                    )
                                  : SvgPicture.asset(
                                      Images.cart,
                                      color: iconColor,
                                    ),
                            ),
                            IconButton(
                              enableFeedback: false,
                              onPressed: () {
                                setState(() {
                                  _pageIndex = 4;
                                });
                              },
                              icon: _pageIndex == 4
                                  ? SvgPicture.asset(
                                      Images.inbox,
                                      color: selected,
                                    )
                                  : SvgPicture.asset(
                                      Images.inbox,
                                      color: iconColor,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Builder(builder: (context) {
                      return Center(
                        child: GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                            // setState(() {
                            //   _pageIndex = 2;
                            // });
                          },
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              GetBuilder<UserController>(
                                  builder: (userController) {
                                return (_isLoggedIn &&
                                        userController.userInfoModel == null)
                                    ? Center(child: CircularProgressIndicator())
                                    : Container(
                                        decoration: BoxDecoration(
                                          // border: Border.all(
                                          //     width: 2,
                                          //     color: Theme.of(context).cardColor),
                                          shape: BoxShape.circle,
                                        ),
                                        alignment: Alignment.center,
                                        child: ClipOval(
                                          child: CustomImage(
                                            image:
                                                '${Get.find<SplashController>().configModel.baseUrls.customerImageUrl}'
                                                '/${(userController.userInfoModel != null && _isLoggedIn) ? userController.userInfoModel.image : ''}',
                                            height: 75,
                                            width: 75,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                              }),
                            ],
                          ),
                        ),
                      );
                    })
                  ]),
                ),

          //-------------------------------------------------------------------------
          //-------------------------------------------------------------------------
          // Padding(
          //     padding: const EdgeInsets.only(bottom: 5),
          //     child: BottomAppBar(
          //       elevation: 5,
          //       // notchMargin: 5,
          //       clipBehavior: Clip.antiAlias,
          //       shape: CircularNotchedRectangle(),
          //       child: Padding(
          //         padding: const EdgeInsets.symmetric(
          //             horizontal: 10, vertical: 5),
          //         child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               BottomNavItem(
          //                   iconData: Images.home_icon,
          //                   isSelected: _pageIndex == 0,
          //                   onTap: () => _setPage(0)),

          //               GetBuilder<CartController>(
          //                   builder: (cartController) {
          //                 return Badge(
          //                     badgeColor: cartController.cartList.length > 0
          //                         ? Colors.white
          //                         : Colors.white,
          //                     elevation: 0,
          //                     badgeContent: Text(
          //                         cartController.cartList.length > 0
          //                             ? cartController.cartList.length
          //                                 .toString()
          //                             : '',
          //                         style: TextStyle(
          //                           fontSize: 15,
          //                           color:
          //                               cartController.cartList.length > 0
          //                                   ? Theme.of(context).primaryColor
          //                                   : Theme.of(context).cardColor,
          //                         )),
          //                     child: BottomNavItem(
          //                         iconData: Images.shopping_icon,
          //                         isSelected: _pageIndex == 1,
          //                         onTap: () => _setPage(1)));
          //               }),
          //               SizedBox(width: 50),
          //               BottomNavItem(
          //                   iconData: Images.comment_icon,
          //                   isSelected: _pageIndex == 3,
          //                   onTap: () => _setPage(3)),
          //               BottomNavItem(
          //                   iconData: Images.fav_icon,
          //                   isSelected: _pageIndex == 4,
          //                   onTap: () {
          //                     _setPage(4);
          //                   })
          //               //   Get.bottomSheet(MenuScreen(),
          //               //       backgroundColor: Colors.transparent,
          //               //       isScrollControlled: true);
          //               // }),
          //             ]),
          //       ),
          //     ),
          //   ),
          body: PageView.builder(
            controller: _pageController,
            itemCount: _screens.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _screens[_pageIndex];
            },
          ),
        ),
      ),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
