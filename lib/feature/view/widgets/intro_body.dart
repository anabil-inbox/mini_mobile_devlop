import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';


class IntroBody extends StatelessWidget {
  const IntroBody({ Key? key ,
   required this.imagePath ,
   required this.title ,
   required this.description,
    required this.index
   }) : super(key: key);
  final String imagePath;
  final String title;
  final String description;
  final int index; 
  @override
  Widget build(BuildContext context) {
    print("msg_title $title");
    screenUtil(context);
    return Stack(
              children: [
          Positioned(
              top: index == 0 ? padding315 : padding222,
              left: padding0,
              right: padding0,
              bottom: paddingM_25,
            child: index == 0 ? 
            SvgPicture.asset("assets/svgs/intro_background.svg",fit: BoxFit.cover,):SvgPicture.asset("assets/svgs/intro_background2.svg",fit: BoxFit.cover,)) ,      
          Positioned(
              top: padding160,
              left: padding0,
              right: padding0,
              child: imageNetwork(
                height:sizeH300,
                url:"${ConstanceNetwork.imageUrl}$imagePath")),
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
                        txt: "$description",
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