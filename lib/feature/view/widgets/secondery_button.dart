import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:logger/logger.dart';

import '../../../util/app_shaerd_data.dart';

// ignore: must_be_immutable
class SeconderyButtom extends StatelessWidget {
  SeconderyButtom(
      {Key? key,
      required this.textButton,
      required this.onClicked,
      this.height,
      this.width,
      this.isEnable = true})
      : super(key: key);
  final String textButton;
  final Function onClicked;
  double? height;
  final double? width;
  final bool isEnable;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      width: width ?? double.infinity,
      height: height ?? sizeH55,
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
        child: Text(
          "${textHandel()}",
          style: isEnable
              ? textStyleBorderButton()
              : textStyleBottomNavUnSelected(),
        ),
      ),
    );
  }

  String textHandel() {
    return textButton
        .toString()
        .replaceAll("٠", "0")
        .toString()
        .replaceAll("١", "1")
        .toString()
        .replaceAll("٢", "2")
        .toString()
        .replaceAll("٣", "3")
        .toString()
        .replaceAll("٤", "4")
        .toString()
        .replaceAll("٥", "5")
        .toString()
        .toString()
        .replaceAll("٦", "6")
        .replaceAll("٠", "0")
        .toString()
        .replaceAll("٧", "7")
        .toString()
        .replaceAll("٩", "9")
        .toString()
        .replaceAll("٨", "8");
  }
}
