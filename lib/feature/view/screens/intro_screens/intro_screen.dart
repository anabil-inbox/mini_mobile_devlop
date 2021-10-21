import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/intro_screens/intro_active_dot.dart';
import 'package:inbox_clients/feature/view/screens/intro_screens/intro_unactive_dot.dart';
import 'package:inbox_clients/feature/view/widgets/intro_body.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:inbox_clients/feature/view_model/intro_view_modle/intro_view_modle.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

// ignore: must_be_immutable
class IntroScreen extends GetWidget<IntroViewModle> {
  IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          physics: customScrollViewIOS(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child:
              Stack(
                fit: StackFit.expand,
                  children: [
              PageView(
                onPageChanged: (index) {
                  controller.indexdPage = index;
                  controller.update();
                },
                children: [
                  IntroBody(imagePath: "assets/svgs/intro_photo_1.svg" , title: "${AppLocalizations.of(Get.context!)!.no_mininus}",),
                  IntroBody(imagePath: "assets/svgs/intro_photo_2.svg" , title: "${AppLocalizations.of(Get.context!)!.save_time}"),
                  IntroBody(imagePath: "assets/svgs/intro_photo_3.svg" , title: "${AppLocalizations.of(Get.context!)!.inbox_third_partey}"),
                ],
              ),
              Positioned(
                right: stack0,
                left: stack0,
                bottom: padding60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryButton(
                      textButton: "${AppLocalizations.of(Get.context!)!.sign_in}",
                      onClicked: () {
        
                      },
                    ),
                     SizedBox(
                      width: sizeH16,
                    ),
                    SeconderyButtom(
                        textButton: "${AppLocalizations.of(Get.context!)!.sign_up}",
                        onClicked: () {
                          
                        })
                  ],
                ),
              ),
              GetBuilder<IntroViewModle>(
                builder: (_) {
                  return Positioned(
                      right: 0,
                      left: 0,
                      bottom: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          controller.indexdPage == 0 ? IntroActiveDot() : IntroUnActiveDot(),
                          const SizedBox(
                            width: 4,
                          ),
                          controller.indexdPage == 1 ? IntroActiveDot() : IntroUnActiveDot(),
                          const SizedBox(
                            width: 4,
                          ),
                          controller.indexdPage == 2 ? IntroActiveDot() : IntroUnActiveDot(),
                           ],
                      ));
                },
              ),
                  ],
                ),
            
          ),
        ));
  }
}
