import 'dart:io';

import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/controller/user_controller.dart';
import 'package:efood_multivendor/data/model/response/response_model.dart';
import 'package:efood_multivendor/data/model/response/userinfo_model.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/view/base/custom_button.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:efood_multivendor/view/base/custom_snackbar.dart';
import 'package:efood_multivendor/view/base/not_logged_in_screen.dart';
import 'package:efood_multivendor/view/screens/change_password/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/styles.dart';

class UpdateProfileScreen extends StatefulWidget {
  UpdateProfileScreen({this.image});
  final String image;
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  // final FocusNode _firstNameFocus = FocusNode();
  // final FocusNode _lastNameFocus = FocusNode();
  // final FocusNode _emailFocus = FocusNode();
  // final FocusNode _phoneFocus = FocusNode();
  final TextStyle fontStyle = kTextStyleBold18.copyWith(
    color: Colors.white,
    fontSize: 20,
  );
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateOfBirth = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  bool _isLoggedIn;
  String dropdownvalue = 'male'.tr;
  int gender;

  // List of items in our dropdown menu
  var items = [
    'male'.tr,
    'female'.tr,
  ];

  @override
  void initState() {
    super.initState();

    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if (_isLoggedIn && Get.find<UserController>().userInfoModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    Get.find<UserController>().initData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 8,
      ),
      child: FractionallySizedBox(
        heightFactor: 0.8,
        child: GetBuilder<UserController>(builder: (userController) {
          if (userController.userInfoModel != null &&
              _phoneController.text.isEmpty) {
            _userNameController.text = userController.userInfoModel.user_name;
            _firstNameController.text =
                userController.userInfoModel.fName ?? '';
            _lastNameController.text = userController.userInfoModel.lName ?? '';
            _phoneController.text = userController.userInfoModel.phone ?? '';
            _emailController.text = userController.userInfoModel.email ?? '';
            _dateOfBirth.text =
                userController.userInfoModel.date_of_birth ?? '';
            _addressController.text =
                userController.userInfoModel.address ?? '';
            _countryController.text =
                userController.userInfoModel.country ?? '';
            _cityController.text = userController.userInfoModel.city ?? '';
            _facebookController.text =
                userController.userInfoModel.facebook ?? '';
            gender = userController.userInfoModel.gender;
          }
          return Stack(
            children: [
              Column(
                children: [
                  Container(
                    color: Colors.transparent,
                    height: 55,
                  ),
                  Expanded(
                    child: Container(
                      color: kPrimaryColor,
                      width: double.infinity,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Center(
                    child: Stack(children: [
                      ClipOval(
                          child: userController.pickedFile != null
                              ? GetPlatform.isWeb
                                  ? Image.network(
                                      userController.pickedFile.path,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(
                                        userController.pickedFile.path,
                                      ),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                              : CustomImage(
                                  image:
                                      '${Get.find<SplashController>().configModel.baseUrls.customerImageUrl}/${userController.userInfoModel.image}',
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                )),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: InkWell(
                          onTap: () => userController.pickImage(),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                    child: _isLoggedIn
                        ? userController.userInfoModel != null
                            ? SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 10, left: 5),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.person_pin,
                                            color: kTextColor,
                                          ),
                                          SizedBox(width: 7),
                                          Text("My Profile",
                                              style: kTextStyleBold18.copyWith(
                                                color: Colors.white,
                                              )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                        start: 37,
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    "name".tr + " : ",
                                                    style: fontStyle,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: FixedTextField(
                                                    controller:
                                                        _firstNameController,
                                                    // onChanged: (v) {
                                                    //   _firstNameController.text = v;
                                                    // },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    "last_name".tr + " : ",
                                                    style: fontStyle,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: FixedTextField(
                                                    controller:
                                                        _lastNameController,
                                                    // onChanged: (v) {
                                                    //   _lastNameController.text = v;
                                                    // },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    "user".tr + " : ",
                                                    style: fontStyle,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: FixedTextField(
                                                    controller:
                                                        _userNameController,
                                                    // onChanged: (v) {
                                                    //   _userNameController.text = v;
                                                    // },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    "date_birth".tr + " : ",
                                                    style: fontStyle,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: FixedTextField(
                                                    controller: _dateOfBirth,
                                                    // onChanged: (v) {
                                                    //   _dateOfBirth.text = v;
                                                    //   print(_dateOfBirth.text);
                                                    // },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    "email".tr + " : ",
                                                    style: fontStyle,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: FixedTextField(
                                                    controller:
                                                        _emailController,
                                                    // onChanged: (v) {
                                                    //   _emailController.text = v;
                                                    // },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    "phone".tr + " : ",
                                                    style: fontStyle,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: FixedTextField(
                                                    controller:
                                                        _phoneController,
                                                    // onChanged: (v) {
                                                    //   _phoneController.text = v;
                                                    // },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Padding(
                                          //   padding:
                                          //       const EdgeInsets.symmetric(),
                                          //   child: Row(
                                          //     children: [
                                          //       Expanded(
                                          //         flex: 2,
                                          //         child: Text(
                                          //           "gender".tr + " : ",
                                          //           style: fontStyle,
                                          //         ),
                                          //       ),
                                          //       Expanded(
                                          //         flex: 4,
                                          //         child: Container(
                                          //           margin:
                                          //               EdgeInsets.all(10.0),
                                          //           padding:
                                          //               EdgeInsets.all(5.0),
                                          //           height: 50,
                                          //           decoration: BoxDecoration(
                                          //               color:
                                          //                   Color(0xFFE1E1E1),
                                          //               border: Border.all(
                                          //                   color: Theme.of(
                                          //                           context)
                                          //                       .primaryColor,
                                          //                   width: 1),
                                          //               borderRadius:
                                          //                   BorderRadius.all(
                                          //                 Radius.circular(10),
                                          //               )),
                                          //           child: Center(
                                          //             child: DropdownButton(
                                          //               // style: fontStyle,
                                          //               underline: Container(
                                          //                   color: Colors
                                          //                       .transparent),
                                          //               iconDisabledColor:
                                          //                   Color(0xFF0F4F80),
                                          //               iconSize: 35,
                                          //               iconEnabledColor:
                                          //                   Color(0xFF0F4F80),
                                          //               isExpanded: true,

                                          //               borderRadius:
                                          //                   BorderRadius
                                          //                       .circular(15),
                                          //               // Initial Value
                                          //               value: dropdownvalue,

                                          //               // Down Arrow Icon
                                          //               icon: const Icon(Icons
                                          //                   .keyboard_arrow_down),

                                          //               // Array list of items
                                          //               items: items.map(
                                          //                   (String items) {
                                          //                 return DropdownMenuItem(
                                          //                   value: items,
                                          //                   child: Text(items),
                                          //                 );
                                          //               }).toList(),
                                          //               // After selecting the desired option,it will
                                          //               // change button value to selected value
                                          //               onChanged: (newValue) {
                                          //                 setState(() {
                                          //                   dropdownvalue =
                                          //                       newValue;
                                          //                   if (dropdownvalue ==
                                          //                       'Male') {
                                          //                     gender = 0;
                                          //                     print(gender);
                                          //                   } else {
                                          //                     gender = 1;
                                          //                     print(gender);
                                          //                   }
                                          //                 });
                                          //               },
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       ),
                                          //       SizedBox(width: 10),
                                          //     ],
                                          //   ),
                                          // ),
                                          // Padding(
                                          //   padding: const EdgeInsets.symmetric(
                                          //       vertical: 5),
                                          //   child: Row(
                                          //     children: [
                                          //       Expanded(
                                          //         flex: 2,
                                          //         child: Text(
                                          //           "address".tr + " : ",
                                          //           style: fontStyle,
                                          //         ),
                                          //       ),
                                          //       Expanded(
                                          //         flex: 5,
                                          //         child: FixedTextField(
                                          //           controller:
                                          //               _addressController,
                                          //           // onChanged: (v) {
                                          //           //   _addressController.text = v;
                                          //           // },
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                          // Padding(
                                          //   padding: const EdgeInsets.symmetric(
                                          //       vertical: 5),
                                          //   child: Row(
                                          //     children: [
                                          //       Expanded(
                                          //         flex: 2,
                                          //         child: Text(
                                          //           "country".tr + " : ",
                                          //           style: fontStyle,
                                          //         ),
                                          //       ),
                                          //       Expanded(
                                          //         flex: 5,
                                          //         child: FixedTextField(
                                          //           controller:
                                          //               _countryController,
                                          //           // onChanged: (v) {
                                          //           //   _countryController.text = v;
                                          //           // },
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                          // Padding(
                                          //   padding: const EdgeInsets.symmetric(
                                          //       vertical: 5),
                                          //   child: Row(
                                          //     children: [
                                          //       Expanded(
                                          //         flex: 2,
                                          //         child: Text(
                                          //           "city".tr + " : ",
                                          //           style: fontStyle,
                                          //         ),
                                          //       ),
                                          //       Expanded(
                                          //         flex: 5,
                                          //         child: FixedTextField(
                                          //           controller: _cityController,
                                          //           // onChanged: (v) {
                                          //           //   _cityController.text = v;
                                          //           // },
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                          // Padding(
                                          //   padding: const EdgeInsets.symmetric(
                                          //       vertical: 5),
                                          //   child: Row(
                                          //     children: [
                                          //       Expanded(
                                          //         flex: 2,
                                          //         child: Text(
                                          //           "facebook".tr + " : ",
                                          //           style: fontStyle,
                                          //         ),
                                          //       ),
                                          //       Expanded(
                                          //         flex: 5,
                                          //         child: FixedTextField(
                                          //           controller:
                                          //               _facebookController,
                                          //           // onChanged: (v) {
                                          //           //   _facebookController.text = v;
                                          //           // },
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                          SizedBox(height: 10),
                                          !userController.isLoading
                                              ? CustomButton(
                                                  color: Color(0xff20242A),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      100,
                                                  radius: 25,
                                                  onPressed: () =>
                                                      _updateProfile(
                                                          userController),
                                                  margin: EdgeInsets.all(
                                                      Dimensions
                                                          .PADDING_SIZE_SMALL),
                                                  buttonText: 'save'.tr,
                                                )
                                              : Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Center(child: CircularProgressIndicator())
                        : NotLoggedInScreen(),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }

  void _updateProfile(UserController userController) async {
    String _username = _userNameController.text.trim();
    String _firstName = _firstNameController.text.trim();
    String _lastName = _lastNameController.text.trim();
    String _email = _emailController.text.trim();
    String _phoneNumber = _phoneController.text.trim();
    String _dateofBirth = _dateOfBirth.text.trim();
    String _address = _addressController.text.trim();
    String _country = _countryController.text.trim();
    String _city = _cityController.text.trim();
    String _facebook = _facebookController.text.trim();
    int Gender = gender;
    if (userController.userInfoModel.fName == _firstName &&
        userController.userInfoModel.lName == _lastName &&
        userController.userInfoModel.phone == _phoneNumber &&
        userController.userInfoModel.email == _email &&
        userController.userInfoModel.address == _address &&
        userController.userInfoModel.city == _city &&
        userController.userInfoModel.country == _country &&
        userController.userInfoModel.facebook == _facebook &&
        userController.userInfoModel.date_of_birth == _dateofBirth &&
        userController.userInfoModel.user_name == _username &&
        userController.userInfoModel.gender == Gender &&
        userController.pickedFile == null) {
      showCustomSnackBar('change_something_to_update'.tr);
    } else if (_firstName.isEmpty) {
      showCustomSnackBar('enter_your_first_name'.tr);
    } else if (_lastName.isEmpty) {
      showCustomSnackBar('enter_your_last_name'.tr);
    } else if (_email.isEmpty) {
      showCustomSnackBar('enter_email_address'.tr);
    } else if (!GetUtils.isEmail(_email)) {
      showCustomSnackBar('enter_a_valid_email_address'.tr);
    } else if (_phoneNumber.isEmpty) {
      showCustomSnackBar('enter_phone_number'.tr);
    } else if (_phoneNumber.length < 6) {
      showCustomSnackBar('enter_a_valid_phone_number'.tr);
    } else if (_dateofBirth.isEmpty) {
      showCustomSnackBar('enter_date'.tr);
    } else if (_username.isEmpty) {
      showCustomSnackBar('enter_userName'.tr);
    } else {
      UserInfoModel _updatedUser = UserInfoModel(
          fName: _firstName,
          lName: _lastName,
          email: _email,
          phone: _phoneNumber,
          user_name: _username,
          address: _address,
          city: _city,
          date_of_birth: _dateofBirth,
          country: _country,
          facebook: _facebook,
          gender: Gender);
      ResponseModel _responseModel = await userController.updateUserInfo(
        _updatedUser,
        Get.find<AuthController>().getUserToken(),
      );
      if (_responseModel.isSuccess) {
        showCustomSnackBar('profile_updated_successfully'.tr, isError: false);
      } else {
        showCustomSnackBar(_responseModel.message);
      }
      Navigator.of(context).pop();
    }
  }
}
