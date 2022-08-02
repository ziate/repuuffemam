import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/theme/styles.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/cart_widget.dart';
import 'package:efood_multivendor/view/base/web_menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../util/images.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget titleWidget;
  final bool isBackButtonExist;
  final Function onBackPressed;
  final bool showCart;
  final Color appBarColor;
  final bool isSmallAppBar;

  CustomAppBar(
      {@required this.title,
      this.isBackButtonExist = true,
      this.onBackPressed,
      this.showCart = false,
      this.titleWidget,
      this.appBarColor,
      this.isSmallAppBar = false});

  @override
  Widget build(BuildContext context) {
    return GetPlatform.isDesktop
        ? WebMenuBar()
        : AppBar(
            toolbarHeight: 80,
            title: titleWidget ??
                Text(title,
                    style: robotoRegular.copyWith(
                        fontSize: Dimensions.fontSizeLarge,
                        color: Theme.of(context).textTheme.bodyText1.color)),
            centerTitle: true,
            actions: isBackButtonExist
                ? [
                    IconButton(
                      icon: SvgPicture.asset("assets/image/back_arrow.svg"),
                      color: Colors.white,
                      onPressed: () => onBackPressed != null
                          ? onBackPressed()
                          : Navigator.pop(context),
                    )
                  ]
                : [SizedBox()],
            backgroundColor: appBarColor ?? kPrimaryColor,
            elevation: 0,
            leadingWidth: 100,
            leading: showCart
                ? IconButton(
                    onPressed: () => Get.toNamed(RouteHelper.getCartRoute()),
                    icon: CartWidget(
                        color: Theme.of(context).textTheme.bodyText1.color,
                        size: 25),
                  )
                : Image(
                    image: AssetImage(Images.logopng),
                  ),
          );
  }

  @override
  Size get preferredSize => Size(Dimensions.WEB_MAX_WIDTH,
      GetPlatform.isDesktop ? 70 : (isSmallAppBar ? 60 : 75));
}
