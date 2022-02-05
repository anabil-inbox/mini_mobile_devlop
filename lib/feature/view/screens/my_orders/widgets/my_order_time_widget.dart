import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class OrderDateWidget extends StatelessWidget {
  const OrderDateWidget({Key? key , this.date}) : super(key: key);

  final String? date;
  @override
  Widget build(BuildContext context) {
  
    return Container(
      width: double.infinity,
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
              Text("${date.toString().split(" ")[0]}" , style: textStyleHints()!.copyWith(fontSize: fontSize13),),
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
