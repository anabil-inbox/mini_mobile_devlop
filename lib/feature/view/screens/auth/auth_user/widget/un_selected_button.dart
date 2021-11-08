import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

class UnSelectedButton extends StatelessWidget {
  const UnSelectedButton({Key? key , required this.onClicked , required this.textButton}) : super(key: key);

  final String textButton;
  final Function onClicked;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: sizeH50,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4)
      ),
      child: MaterialButton(
      textColor: textStyleUnSelectedButton()!.color,
      color: colorUnSelectedWidget,
      onPressed: () {
        onClicked();
      },
      child: Text("$textButton")
      ));
  }
}
