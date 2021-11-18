import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/view/widgets/three_size_dot.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

// ignore: must_be_immutable
class PrimaryButtonFingerPinter extends StatelessWidget {
   PrimaryButtonFingerPinter({ Key? key ,
   required this.textButton,
   required this.isLoading,
   required this.onClicked,
   required this.isExpanded
   }) : super(key: key);
  final String textButton;
  final Function onClicked;
  bool isLoading;
  final bool isExpanded;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: !isExpanded ? sizeW290 : double.infinity,
      height: sizeH50,
      child: ElevatedButton(
        style: seconderyCustomButtonStyle,
        onPressed: !isLoading ? (){
            
            onClicked();
        } : (){},
        child: isLoading ? ThreeSizeDot() :
         Text("$textButton" , style: textStyleTitle()!.copyWith(fontSize:15,color: colorTextWhite , fontWeight: FontWeight.bold)),
      ),
    );
  }
}