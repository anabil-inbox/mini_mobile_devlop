import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inbox_clients/util/app_dimen.dart';

import 'app_color.dart';
import 'constance.dart';
import 'font_dimne.dart';

SystemUiOverlayStyle? systemUiOverLayLight() {
  return SystemUiOverlayStyle.light.copyWith(
      statusBarColor: colorTextWhite, systemNavigationBarColor: colorTextWhite);
}

BoxDecoration containerBoxDecoration() {
  return BoxDecoration(
      color: colorBackground, borderRadius: BorderRadius.circular(padding6!));
}

TextStyle? textStyleMeduimPrimaryBold() {
  return TextStyle(
    color: colorPrimary,
    fontSize: fontSize20,
    fontWeight: FontWeight.bold,
  );
}

BoxDecoration containerBoxDecorationHardEdge() {
  return BoxDecoration(
      color: colorBackground,
      borderRadius: BorderRadius.vertical(top: Radius.circular(padding30!)));
}

TextStyle? textStyle() {
  return TextStyle(
      color: colorTextDark,
      height: 1.5,
      fontFamily: Constance.Font_regular,
      fontSize: fontSize14);
}

TextStyle? textStylebodyWhite() {
  return TextStyle(
      color: colorTextWhite,
      fontFamily: Constance.Font_regular,
      fontSize: fontSize14);
}

TextStyle? textStylebodyBlack() {
  return TextStyle(
      color: colorBlack,
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
      fontSize: fontSize14,
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
      color: colorBlack, fontSize: fontSize28, fontFamily: Constance.Font_bold);
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

TextStyle? textStyleBigPrimaryText() {
  return TextStyle(color: colorPrimary, fontSize: fontSize34);
}

TextStyle? textStyleBigPrimaryTextColorSeconderSize() {
  return TextStyle(
      color: colorPrimary,
      fontSize: fontSize30,
      fontFamily: Constance.Font_bold,
      fontWeight: FontWeight.bold);
}

TextStyle? textStyleBigPrimaryTextColorBigestSize() {
  return TextStyle(
      color: colorPrimary,
      fontSize: fontSize34,
      fontFamily: Constance.Font_bold,
      fontWeight: FontWeight.bold);
}

TextStyle? textStyleMeduimPrimaryText() {
  return TextStyle(color: colorPrimary, fontSize: fontSize13);
}

TextStyle? textStyleMeduimBlackText() {
  return TextStyle(color: colorBlack, fontSize: fontSize13);
}

TextStyle? textStyleSubTitle() {
  return TextStyle(
      color: colorTextBlack,
      fontSize: fontSize21,
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

TextStyle? textStylePrimaryFont() {
  return TextStyle(
      color: colorPrimary,
      height: 0.5,
      fontFamily: Constance.Font_regular,
      fontSize: fontSize18);
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

TextStyle? textStyleNormalBlack() {
  return textStyle()?.copyWith(
      color: colorBlack,
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

TextStyle? textStyleBorderButton() {
  return TextStyle(
      color: colorPrimary,
      fontSize: fontSize15,
      fontFamily: Constance.Font_regular);
}

// TextStyle? textStyleBorderButton() {
//   return TextStyle(
//       color: colorPrimary,
//       fontSize: fontSize15,
//       fontFamily: Constance.Font_regular);
// }

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

TextStyle? textStyleHint() {
  return TextStyle(
    fontSize: fontSize16,
    fontWeight: FontWeight.bold,
    color: colorTextHint1,
  );
}

TextStyle? smallHintTextStyle() {
  return TextStyle(
    fontSize: fontSize12,
    fontWeight: FontWeight.normal,
    color: colorTextHint1,
  );
}

TextStyle? mediumHintTextStyle() {
  return TextStyle(
    fontSize: fontSize15,
    fontWeight: FontWeight.normal,
    color: colorHint2,
  );
}

TextStyle? smallFontHint2TextStyle() {
  return TextStyle(
    fontSize: fontSize13,
    fontWeight: FontWeight.normal,
    color: colorHint3,
  );
}

TextStyle? textStyleUnSelectedButton() {
  return TextStyle(
      fontSize: fontSize16, color: colorTextDark, fontWeight: FontWeight.bold);
}

TextStyle? textStyleCardTitlePrice() {
  return textStyleBtnBlue()?.copyWith(
    color: colorPrimaryDark,
  );
}

TextStyle? textPrimaryButton() {
  return TextStyle(
      color: colorTextWhite, fontSize: fontSize15, fontWeight: FontWeight.bold);
}

TextStyle? textSeconderyButton() {
  return TextStyle(
      color: colorPrimary, fontSize: fontSize15, fontWeight: FontWeight.bold);
}

TextStyle? textStyleIntroTitle() {
  return TextStyle(
      color: Colors.black, fontSize: fontSize21, fontWeight: FontWeight.normal);
}

TextStyle? textStyleIntroBody() {
  return TextStyle(
      color: Colors.black,
      fontSize: fontSize14,
      fontFamily: Constance.Font_regular);
}

TextStyle? textStyleUnderLinePrimary() {
  return TextStyle(
      color: colorPrimary,
      fontSize: fontSize16,
      decoration: TextDecoration.underline,
      fontWeight: FontWeight.normal);
}

TextStyle? textStyleAppBarTitle() {
  return TextStyle(
      color: colorBlack,
      fontSize: fontSize17,
      fontFamily: Constance.Font_regular,
      fontWeight: FontWeight.normal);
}

TextStyle? textStylePrimary() {
  return TextStyle(
      color: colorPrimary, fontSize: fontSize16, fontWeight: FontWeight.normal);
}

TextStyle? textStylePrimarySmall() {
  return TextStyle(
      color: colorPrimary, fontSize: fontSize15, fontWeight: FontWeight.normal);
}

TextStyle? textSeconderyButtonUnBold() {
  return TextStyle(
      color: colorPrimary, fontSize: fontSize14, fontWeight: FontWeight.normal);
}

TextStyle? textStyleHints() {
  return TextStyle(
      color: colorHint, fontSize: fontSize15, fontWeight: FontWeight.normal);
}

TextStyle? textStyleSkipButton() {
  return TextStyle(
      color: Colors.black, fontSize: fontSize15, fontWeight: FontWeight.normal);
}

TextStyle? textHelp() {
  return TextStyle(
      color: colorBlack, fontSize: fontSize14, fontWeight: FontWeight.normal);
}

TextStyle? textHelpFollow() {
  return TextStyle(
      color: colorBlack, fontSize: fontSize14, fontWeight: FontWeight.normal);
}
TextStyle? textStyleSitting() {
  return TextStyle(
    color: colorTextDark,
    wordSpacing: 2.4,
    height: 2.2,
    fontFamily: Constance.Font_regular,
    fontSize: fontSize16,
  );
}
TextStyle textStyleCardPaymentTitle() {
  return TextStyle(
      color: colorTextHint1,
      fontSize: fontSize12,
      fontWeight: FontWeight.normal);
}

TextStyle textStyleCardPaymentBody() {
  return TextStyle(
      color: colorBlack, fontSize: fontSize15, fontWeight: FontWeight.normal);
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
    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 12)),
    backgroundColor: MaterialStateProperty.all(colorPrimaryDark),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))));

ButtonStyle get buttonStyleBackgroundClicable => ButtonStyle(
      backgroundColor: MaterialStateProperty.all(colorPrimary.withOpacity(0.1)),
    );

ButtonStyle get buttonStyleBackgroundGreen => ButtonStyle(
      backgroundColor: MaterialStateProperty.all(greenOpcityColor),
     // textStyle: textStyleHints()
    );

ButtonStyle? get primaryButtonStyle => ButtonStyle(
    padding:
        MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: padding12!)),
    backgroundColor: MaterialStateProperty.all(colorPrimary),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))));

ButtonStyle? get primaryButtonOpacityStyle => ButtonStyle(
    padding:
        MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: padding12!)),
    backgroundColor: MaterialStateProperty.all(colorPrimaryOpcaityColor),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))));

ButtonStyle? get seconderyCustomButtonStyle => ButtonStyle(
    textStyle: MaterialStateProperty.all(textPrimaryButton()),
    padding:
        MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: padding12!)),
    backgroundColor: MaterialStateProperty.all(colorPrimary),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))));

ButtonStyle? get seconderyButtonBothFormStyle => ButtonStyle(
    textStyle: MaterialStateProperty.all(TextStyle(color: Colors.black)),
    padding:
        MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: padding12!)),
    backgroundColor: MaterialStateProperty.all(colorUnSelectedWidget),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))));

ButtonStyle? get seconderyButtonStyle => ButtonStyle(
    textStyle: MaterialStateProperty.all(
        textSeconderyButton()!.copyWith(color: Colors.black)),
    padding:
        MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: padding12!)),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))));

ButtonStyle? get borderPrimaryButtonStyle => ButtonStyle(
      overlayColor: MaterialStateProperty.all(colorPrimary.withOpacity(0.3)),
    );

ButtonStyle? get textButtonStyle => ButtonStyle(
    textStyle: MaterialStateProperty.all(textSeconderyButton()),
    overlayColor: MaterialStateProperty.all(seconderyColor),
    padding:
        MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: padding12!)),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))));

ScrollPhysics? customScrollViewIOS() =>
    BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());

BoxShadow? boxShadowAppTheme() {
  return BoxShadow(
      color: colorPrimary.withOpacity(.3),
      blurRadius: 5.0, // soften the shadow
      spreadRadius: 3.0, //extend the shadow
      offset: Offset(
        0.0, // Move to right 10  horizontally
        0.10, // Move to bottom 10 Vertically
      ));
}
