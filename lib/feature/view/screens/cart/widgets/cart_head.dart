import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class CartHead extends StatelessWidget {
  const CartHead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(padding6!)),
      child: Column(
        children: [
           SizedBox(height: sizeH16,),
           Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset("assets/svgs/folder_icon.svg"),
              SizedBox(
                width: sizeW10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Recall"),
                      SizedBox(width: sizeW5),
                      Text("100 QR",style: textStylePrimarySmall(),),
                      
                    ],
                  ),
                  Text(
                    "Wadi Alsail, 950, Building 5",
                    style: textStyleHints()!.copyWith(fontSize: fontSize13),
                  ),
                  Text(
                    "Mar 13, 2018",
                    style: textStyleHints()!.copyWith(fontSize: fontSize13),
                  ),
                ],
              )
            ],
          ),
           SizedBox(height: sizeH18,),
        ],
      ),
    );
  }
}
