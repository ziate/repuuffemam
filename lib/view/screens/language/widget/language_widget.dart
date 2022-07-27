import 'package:efood_multivendor/controller/localization_controller.dart';
import 'package:efood_multivendor/data/model/response/language_model.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/app_constants.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageWidget extends StatelessWidget {
  final LanguageModel languageModel;
  final LocalizationController localizationController;
  final int index;
  final String image;
  final Color color;

  LanguageWidget(
      {@required this.languageModel,
      @required this.localizationController,
      @required this.index,
      @required this.color,
      @required this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        localizationController.setLanguage(Locale(
          AppConstants.languages[index].languageCode,
          AppConstants.languages[index].countryCode,
        ));
        localizationController.setSelectIndex(index);
        Get.toNamed(RouteHelper.calenderScreen);
      },
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[Get.isDarkMode ? 800 : 200],
                blurRadius: 5,
                spreadRadius: 1)
          ],
        ),
        child: Center(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            // Container(
            //   height: 65, width: 65,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            //     border: Border.all(color: Theme.of(context).textTheme.bodyText1.color, width: 1),
            //   ),
            //   alignment: Alignment.center,
            //   child: Image.asset(
            //     languageModel.imageUrl, width: 36, height: 36,
            //     color: languageModel.languageCode == 'en' || languageModel.languageCode == 'ar'
            //         ? Theme.of(context).textTheme.bodyText1.color : null,
            //   ),
            // ),
            // SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
            Container(
              clipBehavior: Clip.antiAlias,
              width: 55,
              height: 55,
              child: Image.asset(image, fit: BoxFit.cover),
              decoration: BoxDecoration(shape: BoxShape.circle),
            ),
            Text(languageModel.languageName,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 18,
                )),
            SizedBox.shrink()
          ]),
        ),
      ),
    );
  }
}
