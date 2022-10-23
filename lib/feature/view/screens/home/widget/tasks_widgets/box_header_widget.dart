import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

import '../../../../../../util/app_shaerd_data.dart';

class BoxHeaderWidget extends StatelessWidget {
  const BoxHeaderWidget({ Key? key , required this.boxTitle}) : super(key: key);
final String boxTitle;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: padding20! , vertical: padding20!),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(padding6!),
        color: scaffoldColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: sizeH4,),
           SvgPicture.asset("assets/svgs/box_in_ware_house.svg" , width: sizeW40,),
          SizedBox(height: sizeH9,),
          Text("$boxTitle" , style: textStyleAppBarTitle(),),
          SizedBox(height: sizeH4,),
          Text("Stored box" , style: textStyleHints(),),
        ],
      ),
    );
  }
}