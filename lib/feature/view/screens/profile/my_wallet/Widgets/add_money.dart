import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

class AddMoneyItem extends StatelessWidget {
  const AddMoneyItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
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
          SvgPicture.asset("assets/svgs/credit-card.svg"),
          SizedBox(
            height: sizeH16,
          ),
          Text(
            "${tr.add_money}",
          ),
          SizedBox(
            height: sizeH22,
          ),
        ],
      ),
    );
  }
}
