import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

import '../../../../../util/app_shaerd_data.dart';

class AvailableBalanceItem extends StatelessWidget {
  const AvailableBalanceItem({ Key? key , required this.availableBalance , required this.points }) : super(key: key);

  final String points;
  final String availableBalance;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      width: double.infinity,
    
      decoration: BoxDecoration(
        color: colorTextWhite,
        borderRadius: BorderRadius.circular(padding6!)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        SizedBox(height: sizeH16,),
        Text("$points" , style: textStyleBigPrimaryText(),),
        SizedBox(height: sizeH2,),
        Text("$availableBalance" , style: mediumHintTextStyle(),),
        SizedBox(height: sizeH16,),
      ],),
    );
  }
}