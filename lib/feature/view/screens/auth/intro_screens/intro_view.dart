import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_company/register/register_company.dart';
import 'package:inbox_clients/feature/view/screens/auth/auth_user/register/user_register_view.dart';
import 'package:inbox_clients/feature/view/screens/auth/intro_screens/widget/intro_active_dot_widget.dart';
import 'package:inbox_clients/feature/view/screens/auth/splash/splash.dart';
import 'package:inbox_clients/feature/view/screens/auth/user&&company_auth/user_company/user_company_auth_view.dart';
import 'package:inbox_clients/feature/view/widgets/intro_body.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_button.dart';

import 'package:inbox_clients/feature/view_model/intro_view_modle/intro_view_modle.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';
import 'package:inbox_clients/util/sh_util.dart';

class IntroScreen extends GetWidget<IntroViewModle> {
  IntroScreen({Key? key , required this.type}) : super(key: key);

final String type;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: customScrollViewIOS(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            GetBuilder<IntroViewModle>(
              builder: (_) {
                return PageView(
                    onPageChanged: (index) {
                      controller.indexdPage = index;
                      controller.update();
                    },
                    children: controller.features != null
                        ? controller.features!
                            .map((e) => IntroBody(
                                  index: controller.indexdPage,
                                  imagePath: e.image.toString(),
                                  title: e.title.toString(),
                                  description: e.description.toString(),
                                ))
                            .toList()
                        : []);
              },
            ),
            PositionedDirectional(
              start: padding20,
              end: padding20,
              bottom: sizeH31,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryButton(
                    isLoading: false,
                    isExpanded: false,
                    textButton: "${tr.sign_in}",
                    onClicked: () {
                      Get.off(() => UserCompanyLoginScreen(type: SharedPref.instance.getUserType(),));
                      },
                  ),
                  SizedBox(
                    width: sizeH7,
                  ),
                  SeconderyButtom(
                      textButton:
                          "${tr.sign_up}",
                      onClicked: () {
                        if(type == "${ConstanceNetwork.userType}" || type == "${ConstanceNetwork.bothType}"){
                          Get.off(() => UserRegisterScreen());
                        }else if(type == "${ConstanceNetwork.companyType}"){
                          Get.off(() => RegisterCompanyScreen());  
                        }
                       
                      })
                ],
              ),
            ),
            // GetBuilder<IntroViewModle>(
            //   builder: (_) {
            //     return Positioned(
            //         right: padding0,
            //         left: padding0,
            //         bottom: padding160,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             controller.features != null
            //                 ? IntroActiveDot(
            //                     index: controller.indexdPage,
            //                     numberOfDots: controller.features!.length)
            //                 : const SizedBox()
            //           ],
            //         ));
            //   },
            // ),
            PositionedDirectional(
                top: padding57,
                start: padding12,
                end: padding12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset("assets/svgs/language_eye.svg"),
                      onPressed: () {
                        changeLanguageBottomSheet();
                      },
                    ),
                    TextButton(
                        style: textButtonStyle,
                        onPressed: () {
                         moveToIntro();
                        },
                        child: Text(
                          "${tr.skip}",
                          style: textStyleIntroBody()!.copyWith(fontSize: fontSize15),
                        )),

                  ],
                )),

          ],
        ),
      ),
    ));
  }

}
