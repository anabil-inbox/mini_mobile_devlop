import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class PickupAddressItem extends StatelessWidget {
  const PickupAddressItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorTextWhite,
        borderRadius: BorderRadius.circular(padding6!)
      ),
      padding: EdgeInsets.symmetric(horizontal: padding16!),
      child: Column(
        children: [
          SizedBox(
            height: sizeH22,
          ),
          Row(
            children: [
              SvgPicture.asset("assets/svgs/rec_true.svg"),
              SizedBox(
                width: sizeW10,
              ),
              Text("Work"),
            ],
          ),
          SizedBox(
            height: sizeH6,
          ),
          Row(
            children: [
              SizedBox(
                width: sizeW20,
              ),
              Text("Wadi Alsail, 950 Jamea St., Building 5")
            ],
          ),
          SizedBox(
            height: sizeH17,
          ),
          const Divider()
        ],
      ),
    );
  }
}
