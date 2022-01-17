import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

class LogItem extends StatelessWidget {
  const LogItem({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: BorderRadius.circular(padding16!)
        ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: sizeH22,
          ),
          Row(
            children: [
              SvgPicture.asset("assets/svgs/folder_icon.svg"),
              SizedBox(
                width: sizeW7,
              ),
              SvgPicture.asset("assets/svgs/right_arrow.svg"),
              SizedBox(
                width: sizeW7,
              ),
              SvgPicture.asset("assets/svgs/folder_shared.svg")
            ],
          ),
          SizedBox(
            height: sizeH12,
          ),
           RichText(
            text: TextSpan(
              style: textStyleNormal(),
              children: [
                TextSpan(
                  text: 'You stored Meeting Notes in ',
                ),
                TextSpan(
                  text: ' New Box 01 ',
                  style: textStylebodyBlack()
                ),
              ],
            ),
          ),
         // Text("You stored Meeting Notes in New Box 01"),
          SizedBox(
            height: sizeH5,
          ),
          Text("Yesterday at 3:31pm" , style: textStyleHints(),),
          SizedBox(
            height: sizeH22,
          ),
        ],
      ),
    );
  
  
  }
}
