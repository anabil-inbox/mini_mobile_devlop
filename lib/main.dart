import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/core/app_widget.dart';
import 'package:inbox_clients/feature/view_model/intro_view_modle/intro_view_modle.dart';
import 'package:inbox_clients/network/api/dio_manager/dio_manage_class.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

import 'feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'feature/view_model/splash_view_modle/splash_view_modle.dart';
import 'util/sh_util.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.instance.init();
  portraitOrientation();
  DioManagerClass.getInstance.init();
  runApp(const AppWidget());
}

class BindingsController extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => SplashViewModle());
   Get.lazyPut(() => IntroViewModle());
   Get.lazyPut(() => AuthViewModle());
  }

}

