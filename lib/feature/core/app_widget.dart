import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/view/screens/auth/splash/splash.dart';
import 'package:inbox_clients/util/app_color.dart';

import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../main.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return ScreenUtilInit(
      designSize: Size(392.72727272727275, 803.6363636363636),
      builder: () => GetMaterialApp(
        smartManagement: SmartManagement.keepFactory,
        title: 'Inbox Clients',
        locale: Locale(SharedPref.instance.getAppLanguageMain().split("_")[0]),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', ''),
          Locale('ar', ''),
        ],
        initialBinding: BindingsController(),
        debugShowCheckedModeBanner: false,
        enableLog: true,
        themeMode: ThemeMode.system,
        theme: ThemeData(
          colorScheme: ColorScheme.light(primary: colorPrimary),
          fontFamily: Constance.Font_regular,
          cupertinoOverrideTheme: CupertinoThemeData(
            primaryColor: colorPrimary,
          ),
          backgroundColor: scaffoldColor,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: colorPrimary,
            selectionColor: colorPrimary,
            selectionHandleColor: colorPrimary,
          ),
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: textStyleHints(),
            filled: true,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorTrans),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorPrimary),
            ),
            fillColor: colorTextWhite,
            contentPadding: EdgeInsets.symmetric(
                horizontal: padding18!, vertical: padding16!),
            border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(padding4!)),
          ),
          primaryColor: colorPrimary,
          secondaryHeaderColor: seconderyColor,
          scaffoldBackgroundColor: scaffoldColor,
          appBarTheme: AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          )),
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          }),
        ),
         home: const SplashScreen()
       //  home: HomeScreen(),
      ),
    );
  }
}
