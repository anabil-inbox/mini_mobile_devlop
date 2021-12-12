import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';

// ignore: must_be_immutable
class PriceBottomSheetWidget extends StatelessWidget {
  PriceBottomSheetWidget(
      {Key? key,
      this.priceTitle,
      this.totalPalance,
      this.isTotalPalnce = false})
      : super(key: key);

  final String? priceTitle;
  final num? totalPalance;
  final bool isTotalPalnce;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: scaffoldColor, borderRadius: BorderRadius.circular(padding6!)),
      child: Column(
        children: [
          SizedBox(
            height: sizeH10,
          ),
          Text(
            priceTitle ?? "${tr.price}",
            style: textStyleSkipButton(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder<StorageViewModel>(
                init: StorageViewModel(),
                initState: (_) {},
                builder: (logic) {
                  return Text(
                    isTotalPalnce
                        ? "${logic.totalBalance}"
                        : "${logic.balance}",
                    style: textStyleBigPrimaryTextColorSeconderSize(),
                  );
                },
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
