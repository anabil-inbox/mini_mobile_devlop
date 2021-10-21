import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({ Key? key , required this.textButton,required this.onClicked}) : super(key: key);
  final String textButton;
  final Function onClicked;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeW165,
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