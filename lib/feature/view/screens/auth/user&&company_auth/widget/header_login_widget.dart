import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:inbox_clients/feature/view_model/intro_view_modle/intro_view_modle.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

class HeaderLogin extends GetWidget<IntroViewModle> {
  const HeaderLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      height: sizeH200,
      child: Stack(
        children: [
          PositionedDirectional(
            top: padding0,
            bottom: padding0,
            start: padding0,
            end: padding0,
            child: SvgPicture.asset("assets/svgs/header_background.svg",
                fit: BoxFit.cover),
          ),
          PositionedDirectional(
            end: padding20,
            top: padding45,
            child: IconButton(
                onPressed: () {
                  changeLanguageBottomSheet(isFromINtro: true);
                },
                icon: isArabicLang()
                    ? SvgPicture.asset(
                        "assets/svgs/lang_engl_orange.svg"/*language_en*/,
                      )
                    : SvgPicture.asset("assets/svgs/lang_ar_ornage.svg")/*language_eye*/
                    
                    ),
          ),
          PositionedDirectional(
            start: padding0,
            end: padding0,
            top: padding80,
            bottom: padding40,
            child: SvgPicture.asset(
              "assets/svgs/inbox_mini_logo.svg"/*logo_horizantal*/,
            ),
          ),

          // PositionedDirectional(
          //     top: padding40,
          //     start:padding20,
          //     child: IconButton(
          //   onPressed: () {
          //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          //   },
          //   icon: SvgPicture.asset("assets/svgs/back.svg"),
          // )),
        ],
      ),
    );
  }
}
