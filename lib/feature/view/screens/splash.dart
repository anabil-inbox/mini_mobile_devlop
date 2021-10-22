import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/intro_screens/intro_screen.dart';
import 'package:inbox_clients/feature/view_model/splash_view_modle/splash_view_modle.dart';

class SplashScreen extends GetWidget<SplashViewModle> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     print("${Get.locale.toString().split("_")[0]}");
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
Get.off(() => IntroScreen());
}