import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:inbox_clients/util/sh_util.dart';

class HeaderRegisterCompany extends StatelessWidget {
  const HeaderRegisterCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeH114,
      child: Stack(
        children: [
          PositionedDirectional(
            top: padding0,
            bottom: padding0,
            start: padding0,
            end: padding0,
            child: SvgPicture.asset(
              "assets/svgs/header_background.svg",
            ),
          ),
          PositionedDirectional(
            end: padding20,
            bottom: padding22,
            child: IconButton(
              onPressed: (){
                changeLanguageDialog();
              },
              icon: SvgPicture.asset("assets/svgs/language_.svg")),
          ),
          PositionedDirectional(
              top: padding40,
              start:padding20,
              child: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/svgs/cross.svg"),
          )),
          PositionedDirectional(
            start: padding0,
            end: padding0,
            bottom: padding20,
            child: SvgPicture.asset("assets/svgs/logo_horizantal.svg"),
          ),
          
        ],
      ),
    );
  }

  void changeLanguageDialog() {
    final List locale = [
      {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
      {'name': 'العربية', 'locale': Locale('ar', 'SA')},
    ];
    updateLanguage(Locale locale) {
      Get.updateLocale(locale);
    }

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


}
