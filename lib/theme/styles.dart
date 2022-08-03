import 'package:flutter/material.dart';

const Map<int, Color> kPrimaryColorMap = {
  50: kPrimaryColor,
  100: kPrimaryColor,
  200: kPrimaryColor,
  300: kPrimaryColor,
  400: kPrimaryColor,
  500: kPrimaryColor,
  600: kPrimaryColor,
  700: kPrimaryColor,
  800: kPrimaryColor,
  900: kPrimaryColor,
};
//Colors
const kPrimaryColor = Color(0xFF6A0320);
const kTextColor = Color(0xFF727C8E);

var kPrimaryLightColor = const Color(0xFFF05124).withAlpha(50);
const kBackgroundColor = Color(0xFF20242A);
const kGeryColor = Color(0xff707070);
const kDeepGeryColor = Color(0xff7A7D80);
const kDisabledButtonColor = Color.fromARGB(255, 165, 163, 163);
const kGreyLightColor = Color(0xFFF7F7F7);
const kGreenColor = Color(0xFF48BB78);
const Color kIconColor = const Color(0xff727C8E);
//Text Styles

//First: Regular styles
const kTextStyleReg12 = TextStyle(fontSize: 12, color: kTextColor);
const kTextStyleReg13 = TextStyle(fontSize: 13, color: kTextColor);
const kTextStyleReg14 = TextStyle(fontSize: 14, color: kTextColor);
const kTextStyleReg16 = TextStyle(fontSize: 16, color: kTextColor);
const kTextStyleRegPrim12 = TextStyle(fontSize: 12, color: kPrimaryColor);
const kTextStyleRegPrim14 = TextStyle(fontSize: 14, color: kPrimaryColor);
const kTextStyleRegPrim16 = TextStyle(fontSize: 16, color: kPrimaryColor);

//Medium fonts
const kTextStyleMedium13 = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w500,
);
const kTextStyleMedium14 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
);
const kTextStyleMediumPrim14 = TextStyle(
  fontSize: 14,
  color: kPrimaryColor,
  fontWeight: FontWeight.w500,
);

//Second: Semi-Bold Styles
const kTextStyleSemiBold12 = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w600,
);
const kTextStyleSemiBold14 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
);
const kTextStyleSemiBold16 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
);
const kTextStyleSemiBold15 = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w600,
);
const kTextStyleSemiBoldPrim12 = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w600,
  color: kPrimaryColor,
);
const kTextStyleSemiBoldPrim14 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: kPrimaryColor,
);
const kTextStyleSemiBoldPrim16 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: kPrimaryColor,
);

//Third: Bold Styles
const kTextStyleBold12 = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.bold,
);
const kTextStyleBold14 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
);
const kTextStyleBold16 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: kTextColor,
);
const kTextStyleBold15 = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
);
const kTextStyleBlackBold16 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
const kTextStyleBold18 = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);
const kTextStyleBold24 = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: kTextColor,
);
const kTextStyleBoldPrim12 = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,
);
const kTextStyleBoldPrim14 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,
);
const kTextStyleBoldPrim16 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,
);
const kTextStyleBoldPrim18 = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,
);

//Fourth: Gery Text Styels
const kTextStyleRegGrey12 = TextStyle(fontSize: 12, color: kDeepGeryColor);
const kTextStyleRegGrey14 = TextStyle(fontSize: 14, color: kDeepGeryColor);
const kTextStyleRegGrey16 = TextStyle(fontSize: 16, color: kDeepGeryColor);
const kTextStyleSemiBoldGrey14 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: kDeepGeryColor,
);

//Fifth: Other styels
const kTextStyleBoldWhite16 = TextStyle(
  fontSize: 16,
  color: Colors.white,
  fontWeight: FontWeight.w800,
);
const kTextStyleRegRed14 = TextStyle(
  fontSize: 14,
  color: Colors.red,
  // fontWeight: FontWeight.bold,
);
const kTextStyleGreyCourseDetails14 = TextStyle(
  fontSize: 14,
  color: Color(0xff8D8E91),
  // fontWeight: FontWeight.bold,
);
var kGreyTextFieldBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5),
  borderSide: const BorderSide(color: kGeryColor),
);
