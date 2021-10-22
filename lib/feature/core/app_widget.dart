import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/view/screens/splash.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:inbox_clients/util/sh_util.dart';

import '../../main.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    print("msg_On_Main: ${SharedPref.instance.getAppLanguage()}");

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return ScreenUtilInit(
      designSize: Size(392.72727272727275, 803.6363636363636),
      builder: () => GetMaterialApp(
        title: 'Inbox Clients',
        locale: Locale(SharedPref.instance.getAppLanguage().split("_")[0]),
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
        defaultTransition: Transition.zoom,
        enableLog: true,
        themeMode: ThemeMode.system,
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20)),
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
        home: const SplashScreen(),
      ),
    );
  }
}
