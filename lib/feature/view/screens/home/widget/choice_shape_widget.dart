import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class ChoiceShapeWidget extends StatelessWidget {
  const ChoiceShapeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: sizeW5!),
      clipBehavior: Clip.hardEdge,
      height: sizeH30,
      padding: EdgeInsets.all(padding7!),
      decoration: BoxDecoration(color: colorUnSelectedWidget, borderRadius: BorderRadius.circular(sizeRadius2!)),
      child: CustomTextView(
        maxLine: Constance.maxLineOne,
        txt: "Giveaway",
        textStyle: textStyleNormalBlack()?.copyWith(fontSize: fontSize13), textAlign: TextAlign.center,
      ),
    );
  }
}
