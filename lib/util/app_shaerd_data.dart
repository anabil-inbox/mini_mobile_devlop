import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as Math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as Img;
import 'package:inbox_clients/feature/core/dialog_loading.dart';
import 'package:inbox_clients/feature/view/screens/auth/intro_screens/widget/language_item_widget.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/bulk_item_bottom_sheet.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_button.dart';
import 'package:inbox_clients/feature/view_model/intro_view_modle/intro_view_modle.dart';
import 'package:inbox_clients/feature/view_model/splash_view_modle/splash_view_modle.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'app_color.dart';
import 'app_style.dart';
import 'constance.dart';
import 'string.dart';
import 'package:collection/collection.dart';


String? urlPlacholder =
    "https://user-images.githubusercontent.com/194400/49531010-48dad180-f8b1-11e8-8d89-1e61320e1d82.png";
String? urlUserPlacholder =
    "https://jenalk.ahdtech.com/dev/assets/img/no-user.png";

screenUtil(BuildContext context) {
  ScreenUtil.init(
      BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height),
      designSize: Size(392.72727272727275, 803.6363636363636),
      orientation: Orientation.portrait);
}

var safeAreaLight =
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
  systemNavigationBarColor: colorBackground,
  statusBarColor: scaffoldColor,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarIconBrightness: Brightness.dark,
));

var safeAreaDark =
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
  systemNavigationBarColor: colorBackground,
  statusBarColor: colorTrans,
  statusBarIconBrightness: Brightness.light,
  systemNavigationBarIconBrightness: Brightness.dark,
));

var bottomNavDark =
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
  systemNavigationBarColor: colorPrimary,
  statusBarColor: colorPrimary,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarIconBrightness: Brightness.light,
));

// var hideStatusBar =
//     SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
// var hideBottomBar =
//     SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
// var hideAllBar = SystemChrome.setEnabledSystemUIOverlays([]);

void portraitOrientation() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
}

passwordValid(String val) {
  if (val.length < 6) {
    return errorPasswordLength; //key67
  } else {
    return null;
  }
}

phoneVaild(String value) {
  if (value == null || value.isEmpty) {
    return tr.fill_your_phone_number;
  } else if (value.length > 10 || value.length < 8) {
    return tr.fill_your_phone_number;
  }
  return null;
}

phoneVaildAlternativeContact(String value) {
  if (value.length > 10 || value.length < 8) {
    return tr.fill_your_phone_number;
  } else {
    return;
  }
}

emailValid(String val) {
  if (!GetUtils.isEmail(val)) {
    return messageMatcherEmail;
  } else {
    return;
  }
}

Widget simplePopup() => PopupMenuButton<int>(
      initialValue: 1,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text("First"),
        ),
        PopupMenuItem(
          value: 2,
          child: Text("Second"),
        ),
      ],
    );

String getDeviceLang() {
  Locale myLocale = Localizations.localeOf(Get.context!);
  String languageCode = myLocale.languageCode;
  return languageCode;
}

bool isVideo({required String path}) {
  if (path.toLowerCase().substring(path.lastIndexOf(".")) == ".mp4") {
    return true;
  } else if (path.toLowerCase().substring(path.lastIndexOf(".")) == ".mov") {
    return true;
  } else {
    return false;
  }
}

int getPageCount({required List<String> array}) {
  int count = 0;
  array.forEach((element) {
    if (element.isNotEmpty && !GetUtils.isNull(element)) {
      count++;
    }
  });
  print("number of pages $count");
  return count;
}

bool areArraysEquales(List<String> listOne, List<String> listTwo) {
  if (listOne.length != listTwo.length) {
    return false;
  }
  listOne.sort();
  listTwo.sort();
  Function eq = const ListEquality().equals;
  return eq(listOne , listTwo);
}

snackSuccess(String title, String body) {
  Future.delayed(Duration(seconds: 0)).then((value) {
    Get.snackbar("$title", "$body",
        colorText: Colors.white,
        margin: EdgeInsets.all(8),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color(0xFF10C995));
  });
}

snackError(String title, String body) {
  Future.delayed(Duration(seconds: 0)).then((value) {
    Get.snackbar("$title", "$body",
        colorText: Colors.white,
        margin: EdgeInsets.all(8),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color(0xFFF2AE56).withAlpha(150));
  });
}

snackConnection() {
  Future.delayed(Duration(seconds: 0)).then((value) {
    Get.snackbar("$txtConnection", "$txtConnectionNote",
        colorText: Colors.white,
        duration: Duration(seconds: 7),
        margin: EdgeInsets.all(8),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color(0xFF000000).withAlpha(150));
  });
}

showAnimatedDialog(dialog) {
  showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 700),
    context: Get.context!,
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: dialog,
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
  );
}

var urlProduct =
    "https://images.unsplash.com/photo-1613177794106-be20802b11d3?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y2xvY2slMjBoYW5kc3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80";
Widget imageNetwork({double? width, double? height, String? url, BoxFit? fit}) {
  return CachedNetworkImage(
    imageBuilder: (context, imageProvider) {
      return Container(
        decoration: BoxDecoration(
          // border: Border.all(color: colorBorderLight),
          image: DecorationImage(
            image: CachedNetworkImageProvider(url ?? urlUserPlacholder!),
            fit: BoxFit.contain,
          ),
        ),
      );
    },
    imageUrl: urlUserPlacholder!,
    errorWidget: (context, url, error) {
      return CachedNetworkImage(
          imageUrl: urlUserPlacholder!, fit: BoxFit.contain);
    },
    width: width ?? 74,
    height: height ?? 74,
    fit: BoxFit.cover,
    placeholder: (context, String? url) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/gif/loading_shimmer.gif") /* CachedNetworkImageProvider(url ?? urlUserPlacholder!)*/,
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              )),
        ),
      );
    },
  );
}

Future<void> askOnWhatsApp(String? phoneNumber) async {
  final u =
      "https://api.whatsapp.com/send?phone=+972${phoneNumber.toString().replaceFirst(RegExp(r'^0+'), "")}&text=";

  final uri = Uri.encodeFull(u);
  if (await canLaunch(uri)) {
    try {
      await launch(uri);
    } catch (e) {
      //Crashlytics.instance.recordError('Manuel Reporting Crash $e', s);
      snackError(
          "خطا",
          'لم نتمكن من فتح الواتساب في جهازك، برجاء التأكد من تنصيبه او ارسل لنا استفسارك علي'
              '\n'
              '$phoneNumber'
              '\n'
              'مع الرقم المرجعي للمنتج');
    }
  } else {
    final u =
        "whatsapp://send?phone=+972${phoneNumber.toString().replaceFirst(RegExp(r'^0+'), "")}&text=";

    final uri = Uri.encodeFull(u);
    try {
      await launch(uri);
    } catch (e) {
      //Crashlytics.instance.recordError('Manuel Reporting Crash $e', s);
      snackError(
          "خطا",
          'لم نتمكن من فتح الواتساب في جهازك، برجاء التأكد من تنصيبه او ارسل لنا استفسارك علي'
              '\n'
              '$phoneNumber'
              '\n'
              'مع الرقم المرجعي للمنتج');
    }
  }
}

Future<void> makePhoneCall(String? phone) async {
  try {
    await launch(
        "tel://+972${phone.toString().replaceFirst(RegExp(r'^0+'), "")}");
  } catch (e) {
    print(e);
  }
}

void launchWaze(double lat, double lng) async {
  var url = 'waze://?ll=${lat.toString()},${lng.toString()}&navigate=yes';
  var fallbackUrl =
      'https://waze.com/ul?ll=${lat.toString()},${lng.toString()}&navigate=yes';
  try {
    bool launched =
        await launch(url, forceSafariVC: false, forceWebView: false);
    if (!launched) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    } else {
      //launchGoogleMaps(lat, lng);
    }
  } catch (e) {
    await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    Logger().d(e);
  }
}

launchGoogleMaps(var lat, var lng) async {
  var url = 'google.navigation:q=${lat.toString()},${lng.toString()}';
  var fallbackUrl =
      'https://www.google.com/maps/search/?api=1&query=${lat.toString()},${lng.toString()}';
  try {
    bool launched =
        await launch(url, forceSafariVC: false, forceWebView: false);
    if (!launched) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  } catch (e) {
    await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
  }
}

hideFocus(context) {
  FocusScopeNode currentFocus = FocusScope.of(context ?? Get.context!);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    currentFocus.focusedChild!.unfocus();
    FocusManager.instance.primaryFocus!.unfocus();
  }
}

showProgress() async {
  await SharedPref.instance.isShowProgress(true);
  Future.delayed(Duration(seconds: 0)).then((value) {
    showDialog(
      context: Get.context!,
      builder: (context) => DialogLoading(),
    );
  });
}

mainShowProgress() {
  showDialog(
    context: Get.context!,
    builder: (context) => DialogLoading(),
  );
}

hideProgress() async {
  if (await SharedPref.instance.getShowProgress()) {
    Future.delayed(Duration.zero).then((value) => Get.back());
  }
}

mainHideProgress() {
  Get.back();
}

//todo this is second
Future<String>? convertToBase64(File file) async {
  List<int> imageBytes = file.readAsBytesSync();
  print(imageBytes);
  String base64Image = base64Encode(imageBytes);
  return base64Image;
}

//todo this is first
Future<File>? compressImage(File file) async {
  final tempDir = await getTemporaryDirectory();
  final path = tempDir.path;
  int rand = new Math.Random().nextInt(10000);

  Img.Image? images = Img.decodeImage(file.readAsBytesSync());
  Img.Image? smallerImage = Img.copyResize(images!,
      width: 500,
      height: 500); // choose the size here, it will maintain aspect ratio

  var compressedImage = File('$path/img_$rand.jpg')
    ..writeAsBytesSync(Img.encodeJpg(/*image*/ smallerImage, quality: 85));
  return compressedImage;
}

DateTime convertStringToDate(DateTime? date) {
  Logger().d("date befor ${date.toString()}");
  var stringDate = date.toString();
  Logger().d("date after $stringDate");
  return DateFormat("yyyy-MM-dd T hh:mm a").parse(stringDate);
}

compareToTime(TimeOfDay oneVal, TimeOfDay twoVal) {
  var format = DateFormat("HH:mm a");
  var one = format.parse(oneVal.format(Get.context!));
  var two = format.parse(twoVal.format(Get.context!));
  return one.isBefore(two);
}

double convertStringToDouble(String value) {
  return double.tryParse(value)!.toDouble();
}

double sumStringVal(String? valOne, String? valTwo) {
  return (convertStringToDouble("${valOne.toString()}") +
      convertStringToDouble("${valTwo.toString()}"));
}

updateLanguage(Locale locale) {
  Get.updateLocale(locale);
}

void changeLanguageBottomSheet() {
  Get.bottomSheet(Container(
    height: sizeH350,
    decoration: BoxDecoration(
        color: colorTextWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    padding: EdgeInsets.symmetric(horizontal: sizeH20!),
    child: GetBuilder<IntroViewModle>(
      init: IntroViewModle(),
      builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: sizeH42),
            Text(
              "${tr.language}",
              style: textStyleTitle(),
            ),
            SizedBox(height: sizeH25),
            Expanded(
              child: ListView.builder(
                itemCount: SharedPref.instance.getAppLanguage()!.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    InkWell(
                      onTap: () {
                        controller.selectedIndex = index;
                        controller.temproreySelectedLang =
                            SharedPref.instance.getAppLanguage()![index].name;
                        controller.update();
                      },
                      child: LanguageItem(
                          selectedIndex: controller.selectedIndex,
                          cellIndex: index,
                          name:
                              "${SharedPref.instance.getAppLanguage()![index].languageName}"),
                    ),
                    SizedBox(
                      height: sizeH12,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: sizeH18,
            ),
            PrimaryButton(
                isLoading: false,
                textButton: "${tr.select}",
                onClicked: () {
                  try {
                    controller.selectedLang = controller.temproreySelectedLang;
                    updateLanguage(Locale(controller.selectedLang!));
                    SharedPref.instance
                        .setAppLanguage(Locale(controller.selectedLang!));
                    Get.back();
                    SplashViewModle().getAppSetting();
                    controller.update();
                  } catch (e) {}
                },
                isExpanded: true),
            SizedBox(
              height: sizeH34,
            )
          ],
        );
      },
    ),
  ));
}

class CustomMaterialPageRoute extends MaterialPageRoute {
  @protected
  bool get hasScopedWillPopCallback {
    return false;
  }

  CustomMaterialPageRoute({
    @required WidgetBuilder? builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
          builder: builder!,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        );
}

bool isArabicLang() {
  return (SharedPref.instance.getAppLanguageMain() == "ar" ? true : false);
  // return isRTL;
}

AppLocalizations get tr => AppLocalizations.of(Get.context!)!;
