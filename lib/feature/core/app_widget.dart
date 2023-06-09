import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:inbox_clients/fcm/app_fcm.dart';
import 'package:inbox_clients/feature/view/screens/auth/splash/splash.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/network/api/feature/splash_feature_helper.dart';
import 'package:inbox_clients/util/app_color.dart';

import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logger/logger.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../main.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    await SplashHelper.getInstance.getAppSettings().then((value) =>{
      if(!GetUtils.isNull(value)){
        // apiSettings = value,
        // Logger().i(value.workingHours,),
        SharedPref.instance.setUserType(value.customerType!),
        // update()
      }
    });
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {

      Logger().d("remote message $initialMessage");
      _handleMessage(initialMessage);
    }
    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    print("MSG_BUG _handleMessage");
    AppFcm.goToOrderPage(message.data , isFromTerminate : true);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      setupInteractedMessage();
    });
  }

  @override
  Widget build(BuildContext context) {
    // screenUtil(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return ScreenUtilInit(
      designSize: Size(392.72727272727275, 803.6363636363636),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , widget) {
        //ScreenUtil.setContext(context);
        return DismissKeyboard(
          child: GetMaterialApp(
            smartManagement: SmartManagement.keepFactory,
            title: 'Inbox Mini',
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

            home:  SplashScreen(),

            // home: ReciverOrderScreen()
            ),
        );
      },
    );
  }
}
