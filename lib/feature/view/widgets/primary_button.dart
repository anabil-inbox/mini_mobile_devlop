import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/view/widgets/three_size_dot.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

// ignore: must_be_immutable
class PrimaryButton extends StatelessWidget {
   PrimaryButton({ Key? key ,
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
        
        style: primaryButtonStyle,
        onPressed: !isLoading ? (){
            onClicked();
        } : (){
          print("msg Blocked Button");
        },
        child: isLoading ? ThreeSizeDot() : Text("$textButton" , style: textStylePrimary()!.copyWith(fontWeight: FontWeight.bold , fontSize: 16 , color: colorTextWhite),),
      ),
    );
  }
}