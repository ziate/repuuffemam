import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:country_code_picker/country_code.dart';
import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/localization_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/data/model/body/social_log_in_body.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/theme/styles.dart';
import 'package:efood_multivendor/util/app_constants.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_button.dart';
import 'package:efood_multivendor/view/base/custom_snackbar.dart';
import 'package:efood_multivendor/view/base/custom_text_field.dart';
import 'package:efood_multivendor/view/base/web_menu_bar.dart';
import 'package:efood_multivendor/view/screens/auth/sign_up_screen.dart';
import 'package:efood_multivendor/view/screens/auth/widget/code_picker_widget.dart';
import 'package:efood_multivendor/view/screens/auth/widget/condition_check_box.dart';
import 'package:efood_multivendor/view/screens/auth/widget/guest_button.dart';
import 'package:efood_multivendor/view/screens/auth/widget/powered_by_widget.dart';
import 'package:efood_multivendor/view/screens/forget/forget_pass_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:phone_number/phone_number.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../select_login/auth_widget.dart';

class SignInScreen extends StatefulWidget {
  final bool exitFromApp;

  SignInScreen({@required this.exitFromApp});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _countryDialCode;
  bool _canExit = GetPlatform.isWeb ? true : false;

  @override
  void initState() {
    super.initState();

    _countryDialCode =
        Get.find<AuthController>().getUserCountryCode().isNotEmpty
            ? Get.find<AuthController>().getUserCountryCode()
            : CountryCode.fromCountryCode(
                    Get.find<SplashController>().configModel.country)
                .dialCode;
    _phoneController.text = Get.find<AuthController>().getUserNumber() ?? '';
    _passwordController.text =
        Get.find<AuthController>().getUserPassword() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: context.width > 700 ? 700 : context.width,
        padding: context.width > 700
            ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT)
            : null,
        decoration: context.width > 700
            ? BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[Get.isDarkMode ? 700 : 300],
                      blurRadius: 5,
                      spreadRadius: 1)
                ],
              )
            : null,
        child: GetBuilder<AuthController>(builder: (authController) {
          return Column(children: [
            // Image.asset(Images.logo, width: 100),
            // SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
            // Image.asset(Images.logo_name, width: 100),
            // SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),

            // RichText(
            //     text: TextSpan(children: [
            //   TextSpan(
            //       text: '${'If_you_do_not_have_an_account'.tr}؟',
            //       style: robotoRegular.copyWith(
            //           fontFamily: 'Roboto',
            //           fontWeight: FontWeight.w700,
            //           color: Theme.of(context).disabledColor)),
            //   TextSpan(
            //       recognizer: new TapGestureRecognizer()
            //         ..onTap = () => {
            //               Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => SignUpScreen(
            //                           exitFromApp: false,
            //                         )),
            //               )
            //             },
            //       text: 'Create_an_account_now'.tr,
            //       style: robotoMedium.copyWith(
            //           fontFamily: 'Roboto',
            //           fontWeight: FontWeight.w700,
            //           color: Theme.of(context).errorColor)),
            // ])),

            SizedBox(height: 20),
            SizedBox(
              child: CustomTextField(
                border: AppConstants.decorationSignInScreen,
                focusBorder: AppConstants.decorationSignInScreen,
                hintText: 'login_using_email_user_name_or_phone_number'.tr,
                controller: _phoneController,
                focusNode: _phoneFocus,
                nextFocus: _passwordFocus,
                inputType: TextInputType.emailAddress,
                divider: false,
              ),
            ),
            SizedBox(height: 25),
            SizedBox(
              // height: 30,
              child: CustomTextField(
                border: AppConstants.decorationSignInScreen,
                focusBorder: AppConstants.decorationSignInScreen,
                hintText: 'password'.tr,
                controller: _passwordController,
                focusNode: _passwordFocus,
                inputAction: TextInputAction.done,
                inputType: TextInputType.visiblePassword,
                // prefixIcon: Images.lock,
                isPassword: true,
                onSubmit: (text) =>
                    (GetPlatform.isWeb && authController.acceptTerms)
                        ? _login(authController, _countryDialCode)
                        : null,
              ),
            ),
            Column(children: [
              // Row(children: [
              //   CodePickerWidget(
              //     onChanged: (CountryCode countryCode) {
              //       _countryDialCode = countryCode.dialCode;
              //     },
              //     initialSelection: _countryDialCode != null
              //         ? _countryDialCode
              //         : Get.find<LocalizationController>()
              //             .locale
              //             .countryCode,
              //     favorite: [_countryDialCode],
              //     showDropDownButton: true,
              //     padding: EdgeInsets.zero,
              //     showFlagMain: true,
              //     flagWidth: 30,
              //     dialogBackgroundColor:
              //         Theme.of(context).cardColor,
              //     textStyle: robotoRegular.copyWith(
              //       fontSize: Dimensions.fontSizeLarge,
              //       color:
              //           Theme.of(context).textTheme.bodyText1.color,
              //     ),
              //   ),
              //   Expanded(
              //       flex: 1,
              //       child: CustomTextField(
              //         hintText: 'phone'.tr,
              //         controller: _phoneController,
              //         focusNode: _phoneFocus,
              //         nextFocus: _passwordFocus,
              //         inputType: TextInputType.phone,
              //         divider: false,
              //       )),
              // ]),
              // Padding(
              //     padding: EdgeInsets.symmetric(
              //         horizontal: Dimensions.PADDING_SIZE_LARGE),
              //     child: Divider(height: 1)),
            ]),
            SizedBox(height: 10),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15),
            //   child: Row(children: [
            //     Row(
            //       children: [
            //         Text('remember_me'.tr,
            //             style: TextStyle(
            //               color: Theme.of(context).errorColor,
            //               fontFamily: 'Roboto',
            //               fontWeight: FontWeight.w800,
            //               fontSize: Dimensions.fontSizeDefault,
            //             )),
            //         Checkbox(
            //           side: BorderSide(
            //               color: Theme.of(context).primaryColor, width: 1),
            //           activeColor: Theme.of(context).errorColor,
            //           value: authController.isActiveRememberMe,
            //           onChanged: (bool isChecked) =>
            //               authController.toggleRememberMe(),
            //         ),
            //       ],
            //     ),
            //     Spacer(),
            //     // Expanded(
            //     //   child: ListTile(
            //     //     onTap: () => authController.toggleRememberMe(),
            //     //     leading: Checkbox(
            //     //       activeColor: Theme.of(context).primaryColor,
            //     //       value: authController.isActiveRememberMe,
            //     //       onChanged: (bool isChecked) =>
            //     //           authController.toggleRememberMe(),
            //     //     ),
            //     //     title: Text('remember_me'.tr),
            //     //     contentPadding: EdgeInsets.zero,
            //     //     dense: true,
            //     //     horizontalTitleGap: 0,
            //     //   ),
            //     // ),
            //     TextButton(
            //       onPressed: () =>
            //           Get.toNamed(RouteHelper.getForgotPassRoute(false, null)),
            //       child: Text('${'forgot_password'.tr}؟',
            //           style: TextStyle(
            //             color: Theme.of(context).errorColor,
            //             fontFamily: 'Roboto',
            //             fontWeight: FontWeight.w800,
            //             fontSize: Dimensions.fontSizeDefault,
            //           )),
            //     ),
            //   ]),
            // ),
            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

            // ConditionCheckBox(authController: authController),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

            !authController.isLoading
                ? CustomButton(
                    color: Color(0x77E1003C),
                    radius: 15,
                    width: MediaQuery.of(context).size.width - 80,
                    buttonText: 'sign_in'.tr,
                    onPressed: authController.acceptTerms
                        ? () => _login(authController, _countryDialCode)
                        : null,
                  )
                : Center(child: CircularProgressIndicator()),
            Builder(builder: (context) {
              return TextButton(
                  onPressed: () => onForgetPressed(context),
                  child: Text(
                    '${'forgot_password'.tr}',
                    style: kTextStyleBold16.copyWith(color: Color(0xffE1003C)),
                  ));
            }),
            // SizedBox(height: 30),
            // Text('or_log_in_with'.tr,
            //     style: TextStyle(
            //       color: Theme.of(context).primaryColor,
            //       fontFamily: 'Roboto',
            //       fontWeight: FontWeight.w800,
            //       fontSize: Dimensions.fontSizeDefault,
            //     )),
            // SocialLoginWidget(),
            // SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 50),
            //   child: SocialLoginButton(
            //     borderRadius: 50,
            //     buttonType: SocialLoginButtonType.google,
            //     onPressed: () {},
            //   ),
            // )
            // GuestButton(),
          ]);
        }),
      ),
    );
  }

  void onForgetPressed(BuildContext context) {
    Get.back();
    showModalBottomSheet(
      backgroundColor: kPrimaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) => ForgetPassScreen(
        fromSocialLogin: false,
        socialLogInBody: SocialLogInBody(),
      ),
    );
  }

  void _login(AuthController authController, String countryDialCode) async {
    String _phone = _phoneController.text.trim();
    String _password = _passwordController.text.trim();
    // String _numberWithCountryCode = countryDialCode + _phone;
    // bool _isValid = GetPlatform.isWeb ? true : false;
    // if (!GetPlatform.isWeb) {
    //   try {
    //     PhoneNumber phoneNumber =
    //         await PhoneNumberUtil().parse(_numberWithCountryCode);
    //     _numberWithCountryCode =
    //         '+' + phoneNumber.countryCode + phoneNumber.nationalNumber;
    //     _isValid = true;
    //   } catch (e) {}
    // }
    if (_phone.isEmpty) {
      showCustomSnackBar('enter_phone_number'.tr);
    }
    // else if (!_isValid) {
    //   showCustomSnackBar('invalid_phone_number'.tr);
    // }
    else if (_password.isEmpty) {
      showCustomSnackBar('enter_password'.tr);
    } else if (_password.length < 6) {
      showCustomSnackBar('password_should_be'.tr);
    } else {
      authController.login(_phone, _password).then((status) async {
        if (status.isSuccess) {
          if (authController.isActiveRememberMe) {
            authController.saveUserNumberAndPassword(
                _phone, _password, countryDialCode);
          } else {
            authController.clearUserNumberAndPassword();
          }
          String _token = status.message.substring(1, status.message.length);
          if (Get.find<SplashController>().configModel.customerVerification &&
              int.parse(status.message[0]) == 0) {
            List<int> _encoded = utf8.encode(_password);
            String _data = base64Encode(_encoded);
            Get.toNamed(RouteHelper.getVerificationRoute(
                _phone, _token, RouteHelper.signUp, _data));
          } else {
            Get.toNamed(RouteHelper.getAccessLocationRoute('sign-in'));
          }
        } else {
          showCustomSnackBar(status.message);
        }
      });
    }
  }
}
