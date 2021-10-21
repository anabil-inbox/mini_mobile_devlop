import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class IntroScreen extends StatelessWidget {
  IntroScreen({Key? key}) : super(key: key);
  List<PageViewModel> arrIntro = [
    PageViewModel(
        title: "${AppLocalizations.of(Get.context!)!.no_mininus}",
        body: "${AppLocalizations.of(Get.context!)!.no_mininus}",
        image: SvgPicture.asset("assets/svgs/intro_photo_1.svg")),
    PageViewModel(
        title: "${AppLocalizations.of(Get.context!)!.no_mininus}",
        body: "${AppLocalizations.of(Get.context!)!.no_mininus}",
        image: SvgPicture.asset("assets/svgs/intro_photo_2.svg")),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: SvgPicture.asset(
              "assets/svgs/intro_photo_1.svg",
              fit: BoxFit.fill,
            )),
        Positioned.fill(
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 500,
                  ),
                  Text(
                    "${AppLocalizations.of(Get.context!)!.no_mininus}",
                    style: textStyleIntroTitle(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${AppLocalizations.of(Get.context!)!.no_mininus}",
                    style: textStyleIntroTitle(),
                  ),
                   
                ],
              )),
        ),
      ],
    ));
  }
}
