import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/intro_screens/intro_screen.dart';

class SplashScreen extends StatelessWidget {
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
Get.off(() => IntroScreen());
}