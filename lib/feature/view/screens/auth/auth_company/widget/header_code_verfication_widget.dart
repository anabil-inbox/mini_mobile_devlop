import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:inbox_clients/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

class HeaderCodeVerfication extends StatelessWidget {
  const HeaderCodeVerfication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeH200,
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
              top: padding30,
              start:padding6,
              child:
              IconButton(
            onPressed: () {
              Get.back();
            },
               iconSize: 48, icon: isArabicLang()?SvgPicture.asset("assets/svgs/back_arrow_ar.svg",width: 40,height: 40,)
                  :SvgPicture.asset("assets/svgs/back_arrow.svg",width: 40,height: 40,),
          )),
          PositionedDirectional(
            start: padding104,
            end: padding104,
            top: padding63,
            bottom: padding32,
            child: SvgPicture.asset("assets/svgs/logo_horizantal.svg",),
          ),
          
        ],
      ),
    );
  }
}
