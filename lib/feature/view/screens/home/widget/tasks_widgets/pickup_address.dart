import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

class PickupAdressTaskWidget extends StatelessWidget {
  const PickupAdressTaskWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: padding14!),
      decoration: BoxDecoration(
        border: Border.all(color: colorBorderContainer),
        borderRadius: BorderRadius.circular(padding6!)
      ),
      child: Row(
        children: [
          SizedBox(width: sizeW15!,),
          Text("Schedule Pickup" , style: textStyleHints(),),
          const Spacer(),
          SvgPicture.asset("assets/svgs/down_arrow.svg"),
          SizedBox(width: sizeW5!,),
          
        ],
      ),
    );
  }
}