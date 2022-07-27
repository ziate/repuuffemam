import 'dart:convert';

import 'package:country_code_picker/country_code.dart';
import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/data/model/body/signup_body.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/app_constants.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_button.dart';
import 'package:efood_multivendor/view/base/custom_snackbar.dart';
import 'package:efood_multivendor/view/base/custom_text_field.dart';
import 'package:efood_multivendor/view/base/web_menu_bar.dart';
import 'package:efood_multivendor/view/screens/auth/widget/code_picker_widget.dart';
import 'package:efood_multivendor/view/screens/auth/widget/condition_check_box.dart';
import 'package:efood_multivendor/view/screens/auth/widget/guest_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phone_number/phone_number.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class SignUpScreen extends StatefulWidget {
  final bool exitFromApp;

  const SignUpScreen({Key key, this.exitFromApp}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _userFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _birthFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  int gender;
  String _countryDialCode;
  String dropdownvalue = 'male'.tr;
  String dateBirth;

  // List of items in our dropdown menu
  var items = [
    'male'.tr,
    'female'.tr,
  ];

  @override
  void initState() {
    super.initState();

    _countryDialCode = CountryCode.fromCountryCode(
            Get.find<SplashController>().configModel.country)
        .dialCode;
  }

  final dateTime = DateTime.now().obs;

  Future<DateTime> showCalender({BuildContext context}) async =>
      await showDatePicker(
        context: context,
        lastDate: DateTime(2100),
        firstDate: DateTime(1950),
        initialDate: dateTime.value,
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ResponsiveHelper.isDesktop(context)
            ? WebMenuBar()
            : !widget.exitFromApp
                ? PreferredSize(
                    preferredSize:
                        Size.fromHeight(60.0), // here the desired height
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: AppBar(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.RADIUS_EXTRA_LARGE)),
                            automaticallyImplyLeading: false,
                            centerTitle: true,
                            title: Text("register".tr,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 25,
                                )),
                            leading: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                  Icons.keyboard_double_arrow_left_outlined,
                                  size: 40),
                            ),
                            actions: [
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
                                      shape: BoxShape.circle,
                                      color: Colors.white)),
                              SizedBox(width: 30),
                            ],

                            // leading: IconButton(
                            //   onPressed: () => Get.back(),
                            //   icon: Icon(Icons.arrow_back_ios_rounded,
                            //       color: Theme.of(context).textTheme.bodyText1.color),
                            // ),
                            elevation: 0,
                            backgroundColor: Theme.of(context).primaryColor)))
                : null,
        body: SafeArea(
            child: Scrollbar(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            physics: BouncingScrollPhysics(),
            child: Center(
              child: Container(
                width: context.width > 700 ? 700 : context.width,
                padding: context.width > 700
                    ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT)
                    : null,
                decoration: context.width > 700
                    ? BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.RADIUS_SMALL),
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

                    // Text('sign_up'.tr.toUpperCase(), style: robotoBlack.copyWith(fontSize: 30)),
                    SizedBox(height: 50),

                    Column(children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text('first_name'.tr,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeLarge,
                                )),
                          ),
                          Expanded(
                            child: CustomTextField(
                              border: AppConstants.decorationSignUpScreen,
                              focusBorder: AppConstants.decorationSignUpScreen,
                              hintText: 'first_name'.tr,
                              controller: _firstNameController,
                              focusNode: _firstNameFocus,
                              nextFocus: _lastNameFocus,
                              inputType: TextInputType.name,
                              capitalization: TextCapitalization.words,
                              // prefixIcon: Images.user,
                              divider: true,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text('last_name'.tr,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeLarge,
                                )),
                          ),
                          Expanded(
                            child: CustomTextField(
                              border: AppConstants.decorationSignUpScreen,
                              focusBorder: AppConstants.decorationSignUpScreen,
                              hintText: 'last_name'.tr,
                              controller: _lastNameController,
                              focusNode: _lastNameFocus,
                              nextFocus: _userFocus,
                              // inputType: TextInputType.name,
                              capitalization: TextCapitalization.words,
                              prefixIcon: Images.user,
                              divider: true,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text('user'.tr,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeLarge,
                                )),
                          ),
                          Expanded(
                            child: CustomTextField(
                              border: AppConstants.decorationSignUpScreen,
                              focusBorder: AppConstants.decorationSignUpScreen,
                              hintText: 'enter_userName'.tr,
                              controller: _userNameController,
                              focusNode: _userFocus,
                              nextFocus: _emailFocus,
                              // inputType: TextInputType.name,
                              capitalization: TextCapitalization.words,
                              prefixIcon: Images.user,
                              divider: true,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text('email'.tr,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeLarge,
                                )),
                          ),
                          Expanded(
                            child: CustomTextField(
                              border: AppConstants.decorationSignUpScreen,
                              focusBorder: AppConstants.decorationSignUpScreen,
                              hintText: 'email'.tr,
                              controller: _emailController,
                              focusNode: _emailFocus,
                              nextFocus: _phoneFocus,
                              inputType: TextInputType.emailAddress,
                              // prefixIcon: Images.mail,
                              divider: true,
                            ),
                          ),
                        ],
                      ),
                      Row(children: [
                        CodePickerWidget(
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
                        Expanded(
                            child: CustomTextField(
                          border: AppConstants.decorationSignInScreen,
                          focusBorder: AppConstants.decorationSignInScreen,
                          hintText: 'phone'.tr,
                          controller: _phoneController,
                          focusNode: _phoneFocus,
                          nextFocus: _passwordFocus,
                          inputType: TextInputType.phone,
                          divider: true,
                        )),
                      ]),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text("gender".tr,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeLarge,
                                )),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(10.0),
                              padding: EdgeInsets.all(5.0),
                              width: MediaQuery.of(context).size.width * 0.30,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                        Dimensions.RADIUS_EXTRA_LARGE),
                                  )),
                              child: Center(
                                child: DropdownButton(
                                  underline:
                                      Container(color: Colors.transparent),
                                  iconDisabledColor: Color(0xFF0F4F80),
                                  iconSize: 35,
                                  iconEnabledColor: Color(0xFF0F4F80),
                                  isExpanded: true,

                                  borderRadius: BorderRadius.circular(
                                      Dimensions.RADIUS_EXTRA_LARGE),
                                  // Initial Value
                                  value: dropdownvalue,

                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),

                                  // Array list of items
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (newValue) {
                                    setState(() {
                                      dropdownvalue = newValue;
                                      if (dropdownvalue == 'Male') {
                                        gender = 0;
                                        print(gender);
                                      } else {
                                        gender = 1;
                                        print(gender);
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Text('date_birth'.tr,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: Dimensions.fontSizeLarge,
                                  )),
                              IconButton(
                                  onPressed: () async {
                                    final date =
                                        await showCalender(context: context);
                                    if (date == null) {
                                      return null;
                                    } else {
                                      print(date.toIso8601String());
                                      DateFormat dateFormat =
                                          DateFormat("yyyy-MM-dd");
                                      dateBirth = dateFormat.format(date);
                                      _birthController.text = dateBirth;
                                      print(dateBirth);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.date_range,
                                    color: Theme.of(context).primaryColor,
                                  ))
                            ],
                          ),
                          Expanded(
                            child: CustomTextField(
                              border: AppConstants.decorationSignUpScreen,
                              focusBorder: AppConstants.decorationSignUpScreen,
                              hintText: authController.birtDate.value.isEmpty
                                  ? 'date_birth'.tr
                                  : authController.birtDate.value,

                              controller: _birthController,
                              focusNode: _birthFocus,
                              nextFocus: _passwordFocus,
                              inputType: TextInputType.text,
                              // prefixIcon: Images.lock,
                              isPassword: false,
                              divider: true,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text('password'.tr,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeLarge,
                                )),
                          ),
                          Expanded(
                            child: CustomTextField(
                              border: AppConstants.decorationSignUpScreen,
                              focusBorder: AppConstants.decorationSignUpScreen,
                              hintText: 'password'.tr,
                              controller: _passwordController,
                              focusNode: _passwordFocus,
                              nextFocus: _confirmPasswordFocus,
                              inputType: TextInputType.visiblePassword,
                              // prefixIcon: Images.lock,
                              isPassword: true,
                              divider: true,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text('confirm_password'.tr,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeLarge,
                                )),
                          ),
                          Expanded(
                            child: CustomTextField(
                              border: AppConstants.decorationSignUpScreen,
                              focusBorder: AppConstants.decorationSignUpScreen,
                              hintText: 'confirm_password'.tr,
                              controller: _confirmPasswordController,
                              focusNode: _confirmPasswordFocus,
                              inputAction: TextInputAction.done,
                              inputType: TextInputType.visiblePassword,
                              // prefixIcon: Images.lock,
                              isPassword: true,
                              onSubmit: (text) => (GetPlatform.isWeb &&
                                      authController.acceptTerms)
                                  ? _register(authController, _countryDialCode)
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ]),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    Text("By_creating_an_account_you_agree_to_our".tr,
                        style: robotoMedium, textAlign: TextAlign.center),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                    Text(
                      "Terms_of_Service_and_Privace_Policey".tr,
                      style: robotoMedium.copyWith(
                          color: Color(0xffFF0000),
                          decoration: TextDecoration.underline),
                      textAlign: TextAlign.center,
                    ),
                    // ConditionCheckBox(authController: authController),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                    !authController.isLoading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                // Expanded(
                                //     child: CustomButton(
                                //   buttonText: 'sign_in'.tr,
                                //   transparent: true,
                                //   onPressed: () => Get.toNamed(
                                //       RouteHelper.getSignInRoute(RouteHelper.signUp)),
                                // )),
                                SizedBox(
                                  width: 250,
                                  child: CustomButton(
                                    radius: 50,
                                    buttonText: 'sign_up'.tr,
                                    onPressed: authController.acceptTerms
                                        ? () => _register(
                                            authController, _countryDialCode)
                                        : null,
                                  ),
                                ),
                              ])
                        : Center(child: CircularProgressIndicator()),
                    SizedBox(height: 30),
                    Row(children: <Widget>[
                      Expanded(
                          child: Divider(
                        color: Color(0xffFF0000).withOpacity(0.5),
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Text("or".tr),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Divider(
                        color: Color(0xffFF0000).withOpacity(0.5),
                      )),
                    ]),
                    SizedBox(height: 30),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: SocialLoginButton(
                        borderRadius: 50,
                        buttonType: SocialLoginButtonType.google,
                        onPressed: () {},
                      ),
                    )
                    // SocialLoginWidget(),

                    // GuestButton(),
                  ]);
                }),
              ),
            ),
          ),
        )),
      ),
    );
  }

  void _register(AuthController authController, String countryCode) async {
    String _firstName = _firstNameController.text.trim();
    String _lastName = _lastNameController.text.trim();
    String _email = _emailController.text.trim();
    String _number = _phoneController.text.trim();
    String _password = _passwordController.text.trim();
    String _confirmPassword = _confirmPasswordController.text.trim();
    String _birth = _birthController.text.trim().isEmpty
        ? authController.birtDate.value
        : _birthController.text.trim();
    String _user = _userNameController.text.trim();
    int Gender = gender;

    String _numberWithCountryCode = countryCode + _number;
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

    if (_firstName.isEmpty) {
      showCustomSnackBar('enter_your_first_name'.tr);
    } else if (_lastName.isEmpty) {
      showCustomSnackBar('enter_your_last_name'.tr);
    } else if (_email.isEmpty) {
      showCustomSnackBar('enter_email_address'.tr);
    } else if (!GetUtils.isEmail(_email)) {
      showCustomSnackBar('enter_a_valid_email_address'.tr);
    } else if (_number.isEmpty) {
      showCustomSnackBar('enter_phone_number'.tr);
    } else if (!_isValid) {
      showCustomSnackBar('invalid_phone_number'.tr);
    } else if (_password.isEmpty) {
      showCustomSnackBar('enter_password'.tr);
    } else if (_birth.isEmpty) {
      showCustomSnackBar('field_empty'.tr);
    } else if (_password.length < 6) {
      showCustomSnackBar('password_should_be'.tr);
    } else if (_password != _confirmPassword) {
      showCustomSnackBar('confirm_password_does_not_matched'.tr);
    } else if (_user.isEmpty) {
      showCustomSnackBar('enter_username'.tr);
    } else {
      SignUpBody signUpBody = SignUpBody(
          fName: _firstName,
          lName: _lastName,
          email: _email,
          phone: _numberWithCountryCode,
          birthDate: _birth,
          gender: Gender,
          user_name: _user,
          password: _password);
      authController.registration(signUpBody).then((status) async {
        if (status.isSuccess) {
          if (Get.find<SplashController>().configModel.customerVerification) {
            List<int> _encoded = utf8.encode(_password);
            String _data = base64Encode(_encoded);
            Get.toNamed(RouteHelper.getVerificationRoute(_numberWithCountryCode,
                status.message, RouteHelper.signUp, _data));
          } else {
            Get.toNamed(RouteHelper.getAccessLocationRoute(RouteHelper.signUp));
          }
        } else {
          showCustomSnackBar(status.message);
        }
      });
    }
  }
}
