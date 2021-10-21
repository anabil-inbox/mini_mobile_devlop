import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class SeconderyButtom extends StatelessWidget {
  const SeconderyButtom({ Key? key , required this.textButton,required this.onClicked}) : super(key: key);
  final String textButton;
  final Function onClicked;
  @override
  Widget build(BuildContext context) {
    return Container(
     width: sizeW165,
      height: sizeH50,
      child: MaterialButton(
        color: colorBackground,
        textColor: colorPrimary,
        onPressed: (){
            onClicked();
        },
        child: Text("$textButton"),
      ),
    );
  }
}