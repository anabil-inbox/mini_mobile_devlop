import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class OrderAddressWidget extends StatelessWidget {
  const OrderAddressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: padding20!),
       decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(padding6!)),
      child: Row(
        children: [
         SizedBox(width: sizeW15,),
         Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: sizeH22,
              ),
              Text("Date"),
              SizedBox(height: sizeH4,),
              Text("Mar 13, 2018" , style: textStyleHints()!.copyWith(fontSize: fontSize13),),
              SizedBox(
                height: sizeH22,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
