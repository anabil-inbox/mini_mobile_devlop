import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/fcm/app_fcm.dart';
import 'package:inbox_clients/feature/core/app_widget.dart';
import 'package:inbox_clients/feature/view_model/intro_view_modle/intro_view_modle.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/local_database/sql_helper.dart';
import 'package:inbox_clients/network/api/dio_manager/dio_manage_class.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/sh_util.dart';

import 'feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'feature/view_model/home_view_model/home_view_model.dart';
import 'feature/view_model/my_order_view_modle/my_order_view_modle.dart';
import 'feature/view_model/splash_view_modle/splash_view_modle.dart';
import 'feature/view_model/storage_view_model/storage_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppFcm.fcmInstance.init();
  await SharedPref.instance.init();
  // FirebaseCrashlytics.instance.crash();
  portraitOrientation();
  HttpOverrides.global = MyHttpOverrides();
  DioManagerClass.getInstance.init();
  runApp(const AppWidget());
}

  // to do this for handShiking Cetificate :: 
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
    Get.lazyPut(() => ProfileViewModle());
    Get.lazyPut(() => StorageViewModel(), fenix: true);
    Get.lazyPut(() => HomeViewModel());
    Get.lazyPut(() => MyOrderViewModle());
    Get.lazyPut<ItemViewModle>(
      () => ItemViewModle(),
      fenix: true,
    );
  }
}

// hide selection on At Home: <=
// increase the qty off : 
// show photos and selections :: 
// dont hide deselected Items from the Bottom Sheet :