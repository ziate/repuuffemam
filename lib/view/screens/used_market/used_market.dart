import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/view/base/web_menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UsedMarket extends StatelessWidget {
  const UsedMarket({Key key}) : super(key: key);

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
                      Text("used_market".tr,
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('/used_market_Screen');
          },
          child: Icon(Icons.add, color: Colors.white, size: 30),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: GridView.builder(
          physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
            itemCount: 20,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(Images.storespng),
                        fit: BoxFit.cover)),
              );
            }),
      ),
    );
  }
}
