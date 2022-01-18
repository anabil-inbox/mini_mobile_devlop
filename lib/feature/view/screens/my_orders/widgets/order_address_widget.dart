import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/date_time_util.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class OrderAddressWidget extends StatelessWidget {
  const OrderAddressWidget({Key? key , this.date}) : super(key: key);

  final String? date;
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
              Text("${tr.date}"),
              SizedBox(height: sizeH4,),
              Text("${DateUtility.getChatTime(date.toString())}" , style: textStyleHints()!.copyWith(fontSize: fontSize13),),
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
