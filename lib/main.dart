import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/core/app_widget.dart';

import 'feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'feature/view_model/splash_view_modle/splash_view_modle.dart';
import 'util/sh_util.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.instance.init();
  
  runApp(const AppWidget());
}

class BindingsController extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => SplashViewModle());
   Get.lazyPut(() => AuthViewModle());

  }

}

