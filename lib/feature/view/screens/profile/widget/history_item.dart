import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

import '../../../../../util/app_shaerd_data.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({ Key? key , required this.date , required this.points , required this.title}) : super(key: key);

  final String title;
  final String date;
  final String points;
  
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      height: sizeH65,
      decoration: BoxDecoration(
              color: colorTextWhite,
        borderRadius: BorderRadius.circular(padding6!)
      ),
      margin: EdgeInsets.symmetric(vertical: padding6!),
      child: ListTile(
        
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children : [
            SizedBox(height: sizeH10,),
            Text("$points",style: points.contains("-") ? textStylePrimaryFont()?.copyWith(color: errorColor):textStylePrimaryFont(),),
          ] 
        ),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: sizeH10,),
            Text("$title" ,style: textStyleIntroBody(),),
            SizedBox(height: sizeH4,),
            Text("$date" , style: smallFontHint2TextStyle(),)
          ],
          
        ),
      ),
    );
  }
}