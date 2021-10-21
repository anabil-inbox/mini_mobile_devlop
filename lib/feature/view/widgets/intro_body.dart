import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class IntroBody extends StatelessWidget {
  const IntroBody({ Key? key , required this.imagePath , required this.title}) : super(key: key);
  final String imagePath;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Stack(
              children: [
          Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: SvgPicture.asset(
                imagePath,
                fit: BoxFit.fill,
              )),
          Positioned.fill(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     SizedBox(
                      height: sizeH300,
                    ),
                    Text(
                      "$title",
                      style: textStyleIntroTitle(),
                    ),
                     SizedBox(
                      height: sizeH7,
                    ),
                    Padding(
                      
                      padding: EdgeInsets.symmetric(horizontal: sizeW12!),
                      child: CustomTextView(
                        txt: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
                        textAlign: TextAlign.center,
                        textStyle: textStyleIntroBody()!.copyWith(height:1.5),
                      ),
                    ),
                    SizedBox(height: sizeH28,),
                  ],
                )),
          ),
        
              ],
            );
  }
}