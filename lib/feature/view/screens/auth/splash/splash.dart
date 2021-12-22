import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_company/register/register_company.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_company/verfication/company_verfication_code_view.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_user/register/user_register_view.dart';
import 'package:inbox_clients/feature/view/screens/auth/intro_screens/intro_view.dart';
import 'package:inbox_clients/feature/view/screens/auth/user&&company_auth/user_both_login/user_both_login_view.dart';
import 'package:inbox_clients/feature/view/screens/home/home_page_holder.dart';
import 'package:inbox_clients/feature/view/screens/home/home_screen.dart';
import 'package:inbox_clients/feature/view/screens/profile/profile_screen.dart';
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
        if(SharedPref.instance.getUserType() == "${ConstanceNetwork.userType}"){
            Get.off(() => UserRegisterScreen());
        }else if(SharedPref.instance.getUserType() == "${ConstanceNetwork.bothType}"){
            Get.off(() => UserBothLoginScreen());
        }else if(SharedPref.instance.getUserType() == "${ConstanceNetwork.companyType }"){
            Get.off(() => RegisterCompanyScreen());
        }
    
  }else if(state?.toLowerCase() == "${ConstanceNetwork.userLoginedState}"){
    Get.off(() => HomePageHolder());
  }else{
    Get.off(() => IntroScreen(type: SharedPref.instance.getUserType()));
  }
  
}