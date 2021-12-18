import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';


class SeconderyFormButton extends StatelessWidget {
  final Function onClicked;

  final Color? color;

  const SeconderyFormButton({ Key? key , required this.buttonText, required this.onClicked,this.color , this.buttonTextStyle}) : super(key: key);
  final String buttonText;
  final TextStyle? buttonTextStyle;
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
        color: color??seconderyButton,
        onPressed:  (){
          onClicked();
        },
        child: Text("$buttonText" , style: buttonTextStyle ?? textStyleHint()!.copyWith(color: colorHint , fontWeight: FontWeight.bold,fontSize: 15),),
      ),
    );
  }
}

