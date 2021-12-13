import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

// ignore: must_be_immutable
class SeconderyButtom extends StatelessWidget {
   SeconderyButtom(
      {Key? key, required this.textButton, required this.onClicked , this.height})
      : super(key: key);
  final String textButton;
  final Function onClicked;
  double? height;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height??sizeH55,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border.all(color: colorBorderContainer),
        borderRadius: BorderRadius.circular(padding6!)),
      child: MaterialButton(
        elevation: 0,
        color: colorBackground,
        textColor: colorPrimary,
        onPressed: () {
          onClicked();
        },
        child: Text("$textButton" , style: textStyleBorderButton(),),
      ),
    );
  }
}
