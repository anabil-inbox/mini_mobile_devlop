import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/auth_company/register_company.dart';
import 'package:inbox_clients/feature/view/screens/auth_user/user_register_screen.dart';
import 'package:inbox_clients/feature/view/screens/intro_screens/intro_active_dot.dart';
import 'package:inbox_clients/feature/view/screens/user&&company_auth/user_company_auth_screen.dart';
import 'package:inbox_clients/feature/view/widgets/intro_body.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/feature/view_model/intro_view_modle/intro_view_modle.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
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
            Positioned(
              right: padding20,
              left: padding20,
              bottom: padding60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryButton(
                    isLoading: false,
                    isExpanded: false,
                    textButton: "${AppLocalizations.of(Get.context!)!.sign_in}",
                    onClicked: () {
                      Get.to(() => UserCompanyLoginScreen(type: SharedPref.instance.getUserType(),));
                      },
                  ),
                  SizedBox(
                    width: sizeH7,
                  ),
                  SeconderyButtom(
                      textButton:
                          "${AppLocalizations.of(Get.context!)!.sign_up}",
                      onClicked: () {
                        if(type == "user" || type == "both"){
                          Get.to(() => UserRegisterScreen());
                        }else if(type == "company"){
                          Get.to(() => RegisterCompanyScreen());  
                        }
                       
                      })
                ],
              ),
            ),
            GetBuilder<IntroViewModle>(
              builder: (_) {
                return Positioned(
                    right: padding0,
                    left: padding0,
                    bottom: padding160,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        controller.features != null
                            ? IntroActiveDot(
                                index: controller.indexdPage,
                                numberOfDots: controller.features!.length)
                            : const SizedBox()
                      ],
                    ));
              },
            ),
            PositionedDirectional(
                top: padding52,
                start: padding306,
                child: TextButton(
                    style: textButtonStyle,
                    onPressed: () {
                      print("Skip >>");
                    },
                    child: Text(
                      "${AppLocalizations.of(Get.context!)!.skip}",
                      style: textStyleIntroBody(),
                    ))),
            PositionedDirectional(
                top: padding52,
                start: padding20,
                end: padding315,
                child: IconButton(
                  icon: SvgPicture.asset("assets/svgs/language_.svg"),
                  onPressed: () {
                    changeLanguageBottomSheet();
                  },
                )),
          ],
        ),
      ),
    ));
  }

}
