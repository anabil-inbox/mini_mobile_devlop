import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class TextContainerWidget extends StatelessWidget {
  const TextContainerWidget({Key? key, this.txt, this.colorBackground, }) : super(key: key);
  final String? txt;
  final Color? colorBackground;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      height: sizeH20,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 0, right: 0, bottom: sizeH2!),
      decoration: BoxDecoration(
        color: colorBackground??colorRedTrans,
        borderRadius: BorderRadius.circular(sizeRadius10!),
      ),
      child: CustomTextView(
        txt: txt??"${tr.name}",
        textAlign: TextAlign.center,
        textStyle: textStyleNormal()
            ?.copyWith(color: colorRed, fontSize: fontSize13!),
        maxLine: Constance.maxLineOne,
      ),
    );
  }
}
