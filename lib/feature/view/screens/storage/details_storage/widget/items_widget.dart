import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      height: sizeH75,
      width: double.infinity,
      padding: EdgeInsets.all(padding16!),
      decoration: BoxDecoration(
        color: colorBackground,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(sizeRadius16!),
            child: imageNetwork(
                url: urlProduct, height: sizeH48, width: sizeW45),
          ),
          SizedBox(
            width: sizeW10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: CustomTextView(
                    txt: "Early morning thoughts",
                    textStyle:
                    textStyleNormal()?.copyWith(color: colorBlack),
                    maxLine: Constance.maxLineTwo,
                  ),
                ),
                SizedBox(
                  height: sizeH4,
                ),
                CustomTextView(
                  txt: "Mar 13, 2018",
                  textStyle: textStyleHint()?.copyWith(
                      fontSize: fontSize12,
                      fontFamily: Constance.Font_regular,
                      fontWeight: FontWeight.normal),
                  maxLine: Constance.maxLineOne,
                ),
              ],
            ),
          ),
          SizedBox(
            width: sizeW40,
            child: TextButton(
              onPressed: () {},
              child: SvgPicture.asset("assets/svgs/three_dot_widget.svg"),
            ),
          ),
        ],
      ),
    );
  }
}