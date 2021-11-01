import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/auth/intro_screens/intro_view.dart';
import 'package:inbox_clients/feature/view_model/splash_view_modle/splash_view_modle.dart';
import 'package:inbox_clients/util/sh_util.dart';

class SplashScreen extends GetWidget<SplashViewModle> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3),(){
      moveToIntro();
    }); 
     return Scaffold(
       body: Center(
       child: SvgPicture.asset("assets/svgs/logo.svg")
    ));
  }
}

moveToIntro(){
  Get.off(() => IntroScreen(type: SharedPref.instance.getUserType()));
}