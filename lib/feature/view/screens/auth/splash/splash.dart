import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/auth/intro_screens/intro_view.dart';
import 'package:inbox_clients/feature/view/screens/auth/user&&company_auth/user_both_login/user_both_login_view.dart';
import 'package:inbox_clients/feature/view/screens/home/home_screen.dart';
import 'package:inbox_clients/feature/view_model/splash_view_modle/splash_view_modle.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/sh_util.dart';

class SplashScreen extends GetWidget<SplashViewModle> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3),() => moveToIntro()); 
     return Scaffold(
       body: Center(
       child: SvgPicture.asset("assets/svgs/logo.svg")
    ));
  }
}

moveToIntro(){
  String? state = SharedPref.instance.getUserLoginState();
  if (state?.toLowerCase() == "${ConstanceNetwork.userEnterd}") {
    Get.off(() => UserBothLoginScreen());
  }else if(state?.toLowerCase() == "${ConstanceNetwork.userLoginedState}"){
    Get.off(() => HomeScreen());
  }else{
    Get.off(() => IntroScreen(type: SharedPref.instance.getUserType()));
  }
  
}