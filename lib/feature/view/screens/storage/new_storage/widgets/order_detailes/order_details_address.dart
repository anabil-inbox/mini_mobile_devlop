import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class OrderDetailsAddress extends StatelessWidget {
  const OrderDetailsAddress({Key? key , required this.deliveryAddress , required this.title}) : super(key: key);

  final String deliveryAddress;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding16!),
      width: double.infinity,
      decoration: BoxDecoration(
          color: colorTextWhite,
          borderRadius: BorderRadius.circular(padding6!)),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: sizeH12,),
          Text("$title"),
           SizedBox(height: sizeH4,),
           Text("$deliveryAddress" , style: textStyleHints()!.copyWith(fontSize: fontSize13),),
           SizedBox(height: sizeH12,),
        ],
      ),    
    );
  }
}
