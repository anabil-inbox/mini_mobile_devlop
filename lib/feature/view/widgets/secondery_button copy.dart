import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';

// ignore: must_be_immutable
class SeconderyButtom extends StatelessWidget {
  SeconderyButtom(
      {Key? key,
      required this.textButton,
      required this.onClicked,
      this.isExpanded = false,
      this.buttonTextStyle})
      : super(key: key);
  final String textButton;
  final Function onClicked;
  bool isExpanded;
  TextStyle? buttonTextStyle;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: isExpanded ? double.infinity : sizeW165,
      height: sizeH50,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: colorUnSelectedWidget,
          blurRadius: 1,
          offset: const Offset(0, 2),
        ),
      ], borderRadius: BorderRadius.circular(6)),
      child: MaterialButton(
        color: colorBackground,
        textColor: colorPrimary,
        onPressed: () {
          onClicked();
        },
        child: Text(
          textButton,
          style: buttonTextStyle ??
              textStylePrimary()!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: fontSize16),
        ),
      ),
    );
  }
}
