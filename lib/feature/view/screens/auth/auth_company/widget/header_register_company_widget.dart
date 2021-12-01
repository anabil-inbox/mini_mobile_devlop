
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view_model/intro_view_modle/intro_view_modle.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';



class HeaderRegisterCompany extends    GetWidget<IntroViewModle> {
  const HeaderRegisterCompany({Key? key , required this.onBackPressed, required this.height}) : super(key: key);
  final double height;
  final Function onBackPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
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
            top: padding40,
            child: IconButton(
              onPressed: (){
                changeLanguageBottomSheet();
              },
              icon: SvgPicture.asset("assets/svgs/language_eye.svg" ,)),
          ),
          PositionedDirectional(
              top: padding40,
              start:padding20,
              child: IconButton(
              onPressed: () {
                print("object");
                onBackPressed();
            },
            icon: SvgPicture.asset("assets/svgs/cross.svg"),
          )),
            height == 200 ?  PositionedDirectional(
              start: padding0,
              end: padding0,
              top: padding80,
              bottom: padding40,
            child: SvgPicture.asset("assets/svgs/logo_horizantal.svg",),
          ) :
            PositionedDirectional(
              start: padding0,
              end: padding0,
              top: padding69,
              bottom: padding12,
              child: SvgPicture.asset("assets/svgs/logo_horizantal.svg",),
            ),

          // PositionedDirectional(
            // start: padding0,
            // end: padding0,
            // top: padding45,
            // bottom: padding30,
            // child: Padding(
            //   padding:  EdgeInsets.all(sizeH20!),
            //   child: SvgPicture.asset("assets/svgs/logo_horizantal.svg"),
            // )),
        ],
      ),
    );
  
  }

}
