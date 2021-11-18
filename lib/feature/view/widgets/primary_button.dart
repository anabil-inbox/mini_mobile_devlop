import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/view/widgets/three_size_dot.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

// ignore: must_be_immutable
class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    Key? key,
    required this.textButton,
    required this.isLoading,
    required this.onClicked,
    required this.isExpanded, this.colorBtn, this.colorText, this.width, this.height,
  }) : super(key: key);
  final String textButton;
  final Function onClicked;
  final bool isExpanded;
  bool isLoading = false;
  final Color? colorBtn , colorText;
  final double? width , height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isExpanded ? double.infinity : width??sizeW165,
      height: height??sizeH50,
      child: ElevatedButton(
        style: primaryButtonStyle?.copyWith(backgroundColor:MaterialStateProperty.all(colorBtn??colorPrimary) ),
        onPressed: !isLoading
            ? () {
                onClicked();
              }
            : () {},
        child: isLoading
            ? ThreeSizeDot()
            : Text(
                "$textButton",
                style: textStylePrimary()!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: colorText??colorTextWhite),
              ),
      ),
    );
  }
}


// ignore: must_be_immutable
class PrimaryButtonOpacityColor extends StatelessWidget {
  PrimaryButtonOpacityColor({
    Key? key,
    required this.textButton,
    required this.isLoading,
    required this.onClicked,
    required this.isExpanded,
  }) : super(key: key);
  final String textButton;
  final Function onClicked;
  final bool isExpanded;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isExpanded ? double.infinity : sizeW165,
      height: sizeH50,
      child: ElevatedButton(
        style: primaryButtonOpacityStyle,
        onPressed: !isLoading
            ? () {
                onClicked();
              }
            : () {},
        child: isLoading
            ? ThreeSizeDot()
            : Text(
                "$textButton",
                style: textStylePrimary()!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: colorPrimary),
              ),
      ),
    );
  }
}
