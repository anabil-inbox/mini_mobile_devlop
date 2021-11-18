import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class RecentlyItemWidget extends StatelessWidget {
  const RecentlyItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      height: sizeH180,
      width: sizeW150,
      margin: EdgeInsets.symmetric(horizontal: sizeW5!),
      alignment: Alignment.center,
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.symmetric(horizontal: sizeW24! ,vertical: sizeH14!),
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: BorderRadius.circular(sizeRadius5!),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(sizeRadius16!),child: imageNetwork(url: urlProduct ,height:sizeH85 , width:sizeW85 ),),
          SizedBox(height: sizeH10,),
          Flexible(
            child: CustomTextView(
              txt: "Early morning thoughts",
              textAlign:TextAlign.center ,
              textStyle: textStyleNormal()?.copyWith(color: colorBlack),
              maxLine: Constance.maxLineTwo,
            ),
          ),
          SizedBox(height: sizeH4,),
          CustomTextView(
            txt: "Mar 13, 2018",
            textAlign:TextAlign.center ,
            textStyle: textStyleHint()?.copyWith(fontSize: fontSize12 , fontFamily: Constance.Font_regular ,fontWeight:FontWeight.normal ),
            maxLine: Constance.maxLineOne,
          ),
        ],
      ),
    );
  }
}
