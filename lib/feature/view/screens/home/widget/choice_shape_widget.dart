import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class ChoiceShapeWidget extends StatelessWidget {
  const ChoiceShapeWidget({Key? key , required this.task , required this.onClicked}) : super(key: key);

  final Task task;
  final Function onClicked;

  @override 
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onClicked();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: sizeW5!),
        clipBehavior: Clip.hardEdge,
        height: sizeH30,
        padding: EdgeInsets.all(padding7!),
        decoration: BoxDecoration(color: colorUnSelectedWidget, borderRadius: BorderRadius.circular(sizeRadius2!)),
        child: CustomTextView(
          maxLine: Constance.maxLineOne,
          txt: "${task.taskName}",
          textStyle: textStyleNormalBlack()?.copyWith(fontSize: fontSize13), textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
