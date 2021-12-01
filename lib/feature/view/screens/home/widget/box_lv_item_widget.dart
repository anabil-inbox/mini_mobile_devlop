import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';

class HomeLVItemWidget extends StatelessWidget {
  const HomeLVItemWidget({Key? key, this.boxPath}) : super(key: key);
  final String? boxPath;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      width: double.infinity,
      height: sizeH75,
      padding: EdgeInsets.all(padding18!),
      margin: EdgeInsets.only(bottom: sizeH10!),
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: BorderRadius.circular(sizeRadius5!),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            boxPath??"assets/svgs/desable_box.svg",
            width: sizeW50,
            height: sizeH40,
          ),
          SizedBox(width: sizeW15,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize:MainAxisSize.min ,
              children: [
                CustomTextView(
                  txt: "New Box 01",
                  maxLine: Constance.maxLineOne,
                  textStyle: textStyleNormalBlack()?.copyWith(height: 1),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: sizeH2,),
                CustomTextView(
                  txt: "Yesterday",
                  maxLine: Constance.maxLineOne,
                  textStyle: textStyleNormal()?.copyWith(height: 1),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(
            width: sizeW40,
            child: TextButton(
              onPressed: () {},
              child: SvgPicture.asset("assets/svgs/InfoCircle.svg"),
            ),
          ),

        ],
      ),
    );
  
  }
}
