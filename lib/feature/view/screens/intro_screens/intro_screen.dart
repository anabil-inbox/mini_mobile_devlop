import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/intro_screens/intro_active_dot.dart';
import 'package:inbox_clients/feature/view/screens/intro_screens/language_item.dart';
import 'package:inbox_clients/feature/view/screens/user_auth/user_register_screen.dart';
import 'package:inbox_clients/feature/view/widgets/intro_body.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:inbox_clients/feature/view_model/intro_view_modle/intro_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/sh_util.dart';


class IntroScreen extends GetWidget<IntroViewModle> {
   IntroScreen({Key? key}) : super(key: key);

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
                    isExpanded: false,
                    textButton: "${AppLocalizations.of(Get.context!)!.sign_in}",
                    onClicked: () {},
                  ),
                  SizedBox(
                    width: sizeH7,
                  ),
                  SeconderyButtom(
                      textButton:
                          "${AppLocalizations.of(Get.context!)!.sign_up}",
                      onClicked: () {
                        Get.to(()=> UserRegisterScreen());
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
                   // changeLanguageDialog();
                      changeLanguageBottomSheet();
                  },
                )),
          ],
        ),
      ),
    ));
  }

updateLanguage(Locale locale) {
      Get.updateLocale(locale);
    }

     final List locale = [
      {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
      {'name': 'العربية', 'locale': Locale('ar', 'SA')},
    ];
    

  void changeLanguageDialog() {
   
    Get.defaultDialog(
        title: "${AppLocalizations.of(Get.context!)!.choose_language}",
        content: Column(
          children: [
            ListTile(
              title: Text("${AppLocalizations.of(Get.context!)!.english}"),
              onTap: () {
                updateLanguage(locale[0]['locale']);
                SharedPref.instance.setAppLanguage(locale[0]['locale']);
                Navigator.pop(Get.context!);
              },
            ),
            ListTile(
              title: Text("${AppLocalizations.of(Get.context!)!.arabic}"),
              onTap: () {
                
                updateLanguage(locale[1]['locale']);
                SharedPref.instance.setAppLanguage(locale[1]['locale']);
                Navigator.pop(Get.context!);
              },
            )
          ],
        ));
  }
  
  void changeLanguageBottomSheet(){
    Get.bottomSheet(
      
      Container(
        decoration: BoxDecoration(
          color: colorTextWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
        ),
        padding: EdgeInsets.symmetric(horizontal: sizeH20!),
        
        child: Column(
          mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height:sizeH40),
              Text("${AppLocalizations.of(Get.context!)!.language}" , style: textStyleTitle(),),
              SizedBox(height:sizeH22),
              LanguageItem(textLanguage: "${AppLocalizations.of(Get.context!)!.english_us}",),
              SizedBox(height: sizeH12,),
              LanguageItem(textLanguage: "${AppLocalizations.of(Get.context!)!.arabic_ar}",),
              SizedBox(height: sizeH18,),
              PrimaryButton(textButton: "${AppLocalizations.of(Get.context!)!.select}",
               onClicked: (){
                 
              },
              isExpanded: true),
              SizedBox(height: sizeH34,)
            ],
        ),
      )
    );
  }

}
