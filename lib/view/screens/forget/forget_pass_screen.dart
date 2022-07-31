import 'package:country_code_picker/country_code.dart';
import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/data/model/body/social_log_in_body.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_app_bar.dart';
import 'package:efood_multivendor/view/base/custom_button.dart';
import 'package:efood_multivendor/view/base/custom_snackbar.dart';
import 'package:efood_multivendor/view/base/custom_text_field.dart';
import 'package:efood_multivendor/view/screens/auth/widget/code_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_number/phone_number.dart';

import '../../../theme/styles.dart';
import '../../../util/app_constants.dart';

class ForgetPassScreen extends StatefulWidget {
  final bool fromSocialLogin;
  final SocialLogInBody socialLogInBody;
  ForgetPassScreen(
      {@required this.fromSocialLogin, @required this.socialLogInBody});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final TextEditingController _numberController = TextEditingController();

  final FocusNode _phoneFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    String _countryDialCode = CountryCode.fromCountryCode(
            Get.find<SplashController>().configModel.country)
        .dialCode;

    return FractionallySizedBox(
      heightFactor: 0.6,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 10),
              Container(
                width: 48,
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  color: Color(0xff515C6F),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "reset_password".tr,
                style: kTextStyleBold16.copyWith(color: Colors.white),
              ),
              SizedBox(height: 3),
              Container(
                width: 77,
                height: 2,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  color: Color(0xffE1003C),
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 10, end: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: CodePickerWidget(
                        onChanged: (CountryCode countryCode) {
                          _countryDialCode = countryCode.dialCode;
                        },
                        initialSelection: _countryDialCode,
                        favorite: [_countryDialCode],
                        showDropDownButton: true,
                        padding: EdgeInsets.zero,
                        showFlagMain: true,
                        dialogBackgroundColor: Theme.of(context).cardColor,
                        textStyle: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).textTheme.bodyText1.color,
                        ),
                      ),
                    ),
                    SizedBox(width: 7),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 12,
                          ),
                          border: AppConstants.decorationSignInScreen,
                          focusedBorder: AppConstants.decorationSignInScreen,
                          hintText: 'phone'.tr,
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        controller: _numberController,
                        focusNode: _phoneFocus,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              GetBuilder<AuthController>(
                builder: (authController) {
                  return !authController.isLoading
                      ? CustomButton(
                          radius: 10,
                          width: 210,
                          buttonText: 'next'.tr,
                          onPressed: () => _forgetPass(_countryDialCode),
                          color: Color(0xffE1003C),
                        )
                      : Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _forgetPass(String countryCode) async {
    String _phone = _numberController.text.trim();

    String _numberWithCountryCode = countryCode + _phone;
    bool _isValid = GetPlatform.isWeb ? true : false;
    if (!GetPlatform.isWeb) {
      try {
        PhoneNumber phoneNumber =
            await PhoneNumberUtil().parse(_numberWithCountryCode);
        _numberWithCountryCode =
            '+' + phoneNumber.countryCode + phoneNumber.nationalNumber;
        _isValid = true;
      } catch (e) {}
    }

    if (_phone.isEmpty) {
      showCustomSnackBar('enter_phone_number'.tr);
    } else if (!_isValid) {
      showCustomSnackBar('invalid_phone_number'.tr);
    } else {
      if (widget.fromSocialLogin) {
        widget.socialLogInBody.phone = _numberWithCountryCode;
        Get.find<AuthController>()
            .registerWithSocialMedia(widget.socialLogInBody);
      } else {
        Get.find<AuthController>()
            .forgetPassword(_numberWithCountryCode)
            .then((status) async {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getVerificationRoute(
                _numberWithCountryCode, '', RouteHelper.forgotPassword, ''));
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }
  }
}
