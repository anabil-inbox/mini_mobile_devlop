import 'package:flutter/material.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class PriceBottomSheetWidget extends StatelessWidget {
  const PriceBottomSheetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
              color: scaffoldColor,
        borderRadius: BorderRadius.circular(padding6!)
      ),
      child: Column(
        children: [
          SizedBox(
            height: sizeH10,
          ),
          Text(
            "Price",
            style: textStyleSkipButton(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "100.00",
                style: textStyleBigPrimaryTextColorSeconderSize(),
              ),
              SizedBox(
                width: sizeW4,
              ),
              Text(
                "QR",
                style: textStyleBigPrimaryTextColorSeconderSize()!
                    .copyWith(fontSize: fontSize21),
              )
            ],
          ),
          SizedBox(
            height: sizeH10,
          ),
        ],
      ),
    );
  }
}
