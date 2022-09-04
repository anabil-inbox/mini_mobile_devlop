import 'dart:async';
import 'dart:io';

// import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/fcm/app_fcm.dart';
import 'package:inbox_clients/feature/core/app_widget.dart';
import 'package:inbox_clients/feature/view_model/intro_view_modle/intro_view_modle.dart';
import 'package:inbox_clients/network/api/dio_manager/dio_manage_class.dart';
import 'package:inbox_clients/network/firebase/firebase_utils.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/sh_util.dart';

import 'feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'feature/view_model/splash_view_modle/splash_view_modle.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await SharedPref.instance.init();
  // await AppFcm.fcmInstance.init();
  // var bool = await FirebaseUtils.instance.isHideWallet();
  // await SharedPref.instance.setIsHideSubscriptions(bool);
  // portraitOrientation();
  // HttpOverrides.global = MyHttpOverrides();
  // DioManagerClass.getInstance.init();
  // runApp(const AppWidget());

  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await SharedPref.instance.init();
    await AppFcm.fcmInstance.init();
    var bool = await FirebaseUtils.instance.isHideWallet();
    await SharedPref.instance.setIsHideSubscriptions(bool);
    portraitOrientation();
    HttpOverrides.global = MyHttpOverrides();
    DioManagerClass.getInstance.init();
    // The following lines are the same as previously explained in "Handling uncaught errors"
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;




    runApp(const AppWidget());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

// to do this for handShaking Certificate ::
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class BindingsController extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashViewModle());
    Get.lazyPut(() => IntroViewModle());
    Get.lazyPut(() => AuthViewModle());
    // Get.lazyPut(() => ProfileViewModle());
    // Get.lazyPut(() => HomeViewModel());
    // Get.lazyPut(() => MyOrderViewModle());
    // Get.lazyPut(() => MyOrderDetailViewModle());
    // Get.lazyPut(() => MyOrderDetailViewModle());
    // Get.lazyPut<ItemViewModle>(
    //   () => ItemViewModle(),
    //   fenix: true,
    // );
  }
}
// start when task operations isnt done :
// notification on customer scan product and scan box ::