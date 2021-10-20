import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'util/app_color.dart';
import 'util/constance.dart';
import 'util/sh_util.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.instance.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize:  Size(392.72727272727275, 803.6363636363636),
        builder: () =>  GetMaterialApp(
        title: 'Inbox Clients',
          initialBinding: BindingsController(),
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.zoom,
          enableLog: true,
          // locale: LocalizationService.locale,
          // translations: LocalizationService(),
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: Constance.Font_regular,
            primaryColor: colorPrimaryDark,
            accentColor: colorAccent,
            backgroundColor: scaffoldColor,
            scaffoldBackgroundColor: scaffoldColor,
            colorScheme: ColorScheme.light(primary: colorPrimaryDark, secondary: colorPrimaryDark),
            appBarTheme: AppBarTheme(color: colorTextWhite.withOpacity(0.5), elevation: 0),
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            }),
          ),
        home: const SizedBox.shrink(),
      ),

    );
  }
}
class BindingsController extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
  }

}

