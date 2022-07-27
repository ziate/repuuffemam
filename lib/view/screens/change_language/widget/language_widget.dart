import 'package:efood_multivendor/controller/localization_controller.dart';
import 'package:efood_multivendor/data/model/response/language_model.dart';
import 'package:efood_multivendor/util/app_constants.dart';
import 'package:flutter/material.dart';

class ChangeLanguageWidget extends StatelessWidget {
  final LanguageModel languageModel;
  final LocalizationController localizationController;
  final int index;
  final String image;

  ChangeLanguageWidget(
      {@required this.languageModel,
      @required this.localizationController,
      @required this.index,
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
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Text(languageModel.languageName,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                  )),
            ),
            Checkbox(
              value: true,
              onChanged: (value) {},
              activeColor: Colors.grey[200],
              checkColor: Colors.red,
            ),
            Expanded(child: SizedBox())
          ],
        ),
      ),
    );
  }
}
