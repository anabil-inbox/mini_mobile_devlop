import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class SeconderyButtom extends StatelessWidget {
  const SeconderyButtom(
      {Key? key, required this.textButton, required this.onClicked})
      : super(key: key);
  final String textButton;
  final Function onClicked;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeW165,
      height: sizeH50,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: colorUnSelectedWidget,
          blurRadius: 1,
          offset: Offset(0, 2),
        ),
      ], borderRadius: BorderRadius.circular(6)),
      child: MaterialButton(
        color: colorBackground,
        textColor: colorPrimary,
        onPressed: () {
          onClicked();
        },
        child: Text("$textButton" , style: textStylePrimary()!.copyWith(fontWeight: FontWeight.bold , fontSize: fontSize16),),
      ),
    );
  }
}
