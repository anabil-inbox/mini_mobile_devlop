import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_company/register/register_company.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_user/register/user_register_view.dart';
import 'package:inbox_clients/feature/view/screens/auth/intro_screens/intro_view.dart';
import 'package:inbox_clients/feature/view/screens/auth/user&&company_auth/user_both_login/user_both_login_view.dart';
import 'package:inbox_clients/feature/view/screens/home/home_page_holder.dart';
import 'package:inbox_clients/feature/view/widgets/viedo_player.dart';
import 'package:inbox_clients/feature/view_model/splash_view_modle/splash_view_modle.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/sh_util.dart';

import '../../../../../util/app_shaerd_data.dart';


class SplashScreen extends GetWidget<SplashViewModle> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    Future.delayed(Duration(seconds: 3), () => moveToIntro());
    return Scaffold(
        body: Center(child: /*VideoPlayer(assetsPath: "assets/video/splash.mp4",)*/SvgPicture.asset("assets/svgs/logo_new.svg"/*logo*/)));
  }
}

moveToIntro() async{
  String? state = SharedPref.instance.getUserLoginState();
  SharedPref.instance.getAppSettings();
  await FirebaseAuth.instance.signInAnonymously();
  try {
  if (state?.toLowerCase() == "${ConstanceNetwork.userEnterd}") {
    if (SharedPref.instance.getUserType() == "${ConstanceNetwork.userType}") {
      Get.off(() => UserRegisterScreen());
    } else if (SharedPref.instance.getUserType() ==
        "${ConstanceNetwork.bothType}") {
      Get.off(() => UserBothLoginScreen());
    } else if (SharedPref.instance.getUserType() ==
        "${ConstanceNetwork.companyType}") {
      Get.off(() => RegisterCompanyScreen());
    }
    Get.off(() => UserBothLoginScreen());
  } else if (state?.toLowerCase() == "${ConstanceNetwork.userLoginedState}") {
    Get.off(() => HomePageHolder());
  } else {
    Get.off(() => IntroScreen(type: SharedPref.instance.getUserType() ?? "both"));
  }
  } catch (e) {
     Get.off(() => IntroScreen(type: "both"));
  }
}
