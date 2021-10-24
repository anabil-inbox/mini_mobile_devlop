import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({ Key? key ,
   required this.textButton,
   required this.onClicked,
   required this.isExpanded
   }) : super(key: key);
  final String textButton;
  final Function onClicked;
  final bool isExpanded;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: isExpanded ? double.infinity : sizeW165,
      height: sizeH50,
      child: ElevatedButton(
        style: primaryButtonStyle,
        onPressed: (){
            onClicked();
        },
        child: Text("$textButton"),
      ),
    );
  }
}