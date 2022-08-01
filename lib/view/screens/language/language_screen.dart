import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/view/base/custom_app_bar.dart';
import 'package:efood_multivendor/view/screens/auth/widget/powered_by_widget.dart';
import 'package:efood_multivendor/view/screens/language/widget/language_widget.dart';
import 'package:flutter/material.dart';
import 'package:efood_multivendor/controller/localization_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChooseLanguageScreen extends StatelessWidget {
  final bool fromMenu;

  ChooseLanguageScreen({this.fromMenu = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (fromMenu || ResponsiveHelper.isDesktop(context))
          ? CustomAppBar(title: 'language'.tr, isBackButtonExist: true)
          : null,
      body: SafeArea(
        child: GetBuilder<LocalizationController>(
            builder: (localizationController) {
          return SingleChildScrollView(
            child: Column(children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  SvgPicture.asset("assets/image/re.svg"),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: SvgPicture.asset("assets/image/Puff.svg"),
                  ),
                ],
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: localizationController.languages.length,
                  itemBuilder: (context, index) => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16).copyWith(
                      bottom: 20,
                    ),
                    child: LanguageWidget(
                      color: localizationController.check == index
                          ? Color(0xFF0F4F80)
                          : Color(0xFFDB0013),
                      image: localizationController.images[index],
                      languageModel: localizationController.languages[index],
                      localizationController: localizationController,
                      index: index,
                    ),
                  ),
                ),
              ),
              // CustomButton(
              //   buttonText: 'save'.tr,
              //   margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              //   onPressed: () {
              //     if (localizationController.languages.length > 0 &&
              //         localizationController.selectedIndex != -1) {
              //       localizationController.setLanguage(Locale(
              //         AppConstants.languages[localizationController.selectedIndex]
              //             .languageCode,
              //         AppConstants.languages[localizationController.selectedIndex]
              //             .countryCode,
              //       ));
              //       if (fromMenu) {
              //         Navigator.pop(context);
              //       } else {
              //         Get.offNamed(RouteHelper.getOnBoardingRoute());
              //       }
              //     } else {
              //       showCustomSnackBar('select_a_language'.tr);
              //     }
              //   },
              // ),
            ]),
          );
        }),
      ),
      bottomNavigationBar: const PoweredByWidget(),
    );
  }
}
