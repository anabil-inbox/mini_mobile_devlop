import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_color.dart';
import 'constance.dart';
import 'font_dimne.dart';

SystemUiOverlayStyle? systemUiOverLayLight() {
  return SystemUiOverlayStyle.light.copyWith(
      statusBarColor: colorTextWhite,
      systemNavigationBarColor: colorTextWhite);
}

TextStyle? textStyle() {
  return TextStyle(
      color: colorTextBlack,
      height: 1,
      fontFamily: Constance.Font_regular,
      fontSize: fontSize14);
}

TextStyle? textStyleBottomNavSelected() {
  return TextStyle(
      color: colorPrimaryDark,
      height: 1,
      fontFamily: Constance.Font_bold,
      fontSize: fontSize14);
}

TextStyle? textStyleBottomNavUnSelected() {
  return textStyleBottomNavSelected()?.copyWith(
      color: colorBlack,
      height: 1,
      fontFamily: Constance.Font_regular,
      fontSize: fontSize14);
}

TextStyle? textInputFiled() {
  return TextStyle(
      color: colorTextBlack,
      fontSize: fontSize16,
      letterSpacing: 0.23,
      fontFamily: Constance.Font_regular);
}

TextStyle? textInputFiledHint() {
  return TextStyle(
      color: colorTextHint,
      fontSize: fontSize16,
      letterSpacing: 0.23,
      fontFamily: Constance.Font_regular);
}

TextStyle? textStyleBtnBlue() {
  return textStyle()?.copyWith(
      color: scaffoldColor,
      fontSize: fontSize16,
      fontFamily: Constance.Font_bold);
}

TextStyle? textStyleLoginPage() {
  return textStyle()?.copyWith(
      color: colorBlack,
      fontSize: fontSize28,
      fontFamily: Constance.Font_bold);
}

TextStyle? textStyleDrawerHeader() {
  return textStyle()?.copyWith(
      color: colorTextWhite,
      fontSize: fontSize20,
      fontFamily: Constance.Font_bold);
}

TextStyle? textStyleAppbar() {
  return textStyle()?.copyWith(
      color: colorTextBlack,
      fontSize: fontSize24,
      fontFamily: Constance.Font_regular);
}

TextStyle? textStyleLargeText() {
  return textStyle()?.copyWith(
      color: colorTextBlack,
      fontSize: fontSize30,
      fontFamily: Constance.Font_bold);
}

TextStyle? textStyleTitle() {
  return textStyle()?.copyWith(
      color: colorPrimaryDark,
      fontSize: fontSize18,
      fontFamily: Constance.Font_regular);
}

TextStyle? textStyleTitleBold() {
  return textStyleTitle()?.copyWith(fontFamily: Constance.Font_bold);
}

TextStyle? textStyleNormal() {
  return textStyle()?.copyWith(
      color: colorTextHint,
      fontSize: fontSize14,
      height: 1.5,
      fontFamily: Constance.Font_regular);
}

TextStyle? textStyleSmall() {
  return textStyleNormal()?.copyWith(
      color: colorBlack,
      fontSize: fontSize12,
      fontFamily: Constance.Font_regular);
}

TextStyle? textStyleBtn() {
  return textStyle()?.copyWith(
      color: colorTextWhite,
      fontSize: fontSize16,
      fontFamily: Constance.Font_regular);
}

TextStyle? textStyleCardTitle() {
  return textStyleBtnBlue()?.copyWith(
    color: colorBlack,
  );
}

TextStyle? textStyleCardTitlePrice() {
  return textStyleBtnBlue()?.copyWith(
    color: colorPrimaryDark,
  );
}

BoxShadow? boxShadow() {
  return BoxShadow(
      color: Colors.grey.withOpacity(.3),
      blurRadius: 5.0, // soften the shadow
      spreadRadius: 3.0, //extend the shadow
      offset: Offset(
        0.0, // Move to right 10  horizontally
        0.10, // Move to bottom 10 Vertically
      ));
}

BoxShadow? boxShadowLight() {
  return BoxShadow(
      color: Colors.grey.withOpacity(.15),
      blurRadius: 5.0, // soften the shadow
      spreadRadius: 0.0, //extend the shadow
      offset: Offset(
        0.0, // Move to right 10  horizontally
        0.10, // Move to bottom 10 Vertically
      ));
}

ButtonStyle? get buttonStyle => ButtonStyle(
    padding:MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 12)) ,
    backgroundColor: MaterialStateProperty.all(colorPrimaryDark),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))));

ScrollPhysics? customScrollViewIOS() =>
    BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
