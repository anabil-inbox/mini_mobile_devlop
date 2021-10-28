import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/view/screens/intro_screens/language_item.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/intro_view_modle/intro_view_modle.dart';
import 'package:inbox_clients/feature/view_model/splash_view_modle/splash_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:inbox_clients/util/sh_util.dart';

class HeaderLogin extends GetWidget<IntroViewModle> {
  const HeaderLogin({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: sizeH174,
      child: Stack(
        children: [
          PositionedDirectional(
            top: padding0,
            bottom: padding0,
            start: padding0,
            end: padding0,
            child: SvgPicture.asset(
              "assets/svgs/header_background.svg",
               fit: BoxFit.cover
            ),
          ),
          PositionedDirectional(
            end: padding20,
            bottom: padding80,
            child: IconButton(
              onPressed: (){
                changeLanguageBottomSheet();
              },
              icon: SvgPicture.asset("assets/svgs/language_.svg" ,)),
          ),
          PositionedDirectional(
            start: padding0,
            end: padding0,
            top: padding63,
            bottom: padding32,
            child: SvgPicture.asset("assets/svgs/logo_horizantal.svg",),
          ),
          
          PositionedDirectional(
              top: padding40,
              start:padding20,
              child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset("assets/svgs/back.svg"),
          )),
        ],
      ),
    );
  
  }

}