import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class TransferPointsItem extends StatelessWidget {
  const TransferPointsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: colorTextWhite,
          borderRadius: BorderRadius.circular(padding6!)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: sizeH16,
          ),
          IconButton(
              onPressed: () {
              },
              icon: SvgPicture.asset("assets/svgs/up_arrow.svg")),
          SizedBox(
            height: sizeH16,
          ),
          Text(
            "Transfer points",
          ),
           SizedBox(
            height: sizeH22,
          ),

        ],
      ),
    );
  }
}
