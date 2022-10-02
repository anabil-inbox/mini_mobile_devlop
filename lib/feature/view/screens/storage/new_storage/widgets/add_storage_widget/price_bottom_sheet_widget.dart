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
      this.backGroundColor,
      this.isTotalPalnce = false})
      : super(key: key);

  final String? priceTitle;
  final num? totalPalance;
  final bool isTotalPalnce;
  Color? backGroundColor;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return
     Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: backGroundColor ?? scaffoldColor,
          borderRadius: BorderRadius.circular(padding6!)),
      child: Column(
        children: [
          SizedBox(
            height: sizeH10,
          ),
          Text(
              priceTitle ?? "${tr.total_price}",
            style: textStyleSkipButton(),
          ),
          FittedBox(
            clipBehavior: Clip.hardEdge,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GetBuilder<StorageViewModel>(
                  init: StorageViewModel(),
                  initState: (_) {},
                  builder: (logic) {
                    return totalPalance == null
                        ? Text(
                            isTotalPalnce
                                ? "${formatStringWithCurrency(logic.totalBalance , "")}"
                                : "${formatStringWithCurrency(logic.balance, "")}",
                            style: textStyleBigPrimaryTextColorSeconderSize(),
                          )
                        : Text("${formatStringWithCurrency(totalPalance, "")}",
                            style: textStyleBigPrimaryTextColorSeconderSize());
                  },
                ),
                // SizedBox(
                //   width: sizeW4,
                // ),
                // Text(
                //   "QR",
                //   style: textStyleBigPrimaryTextColorSeconderSize()!
                //       .copyWith(fontSize: fontSize21),
                // )
              ],
            ),
          ),
          SizedBox(
            height: sizeH10,
          ),
        ],
      ),
    );
  
  }
}


// ignore: must_be_immutable
class PriceWidget extends StatelessWidget {
  PriceWidget(
      {Key? key,
      this.priceTitle,
      this.totalPalance,
      this.backGroundColor,
      this.isTotalPalnce = false})
      : super(key: key);

  final String? priceTitle;
  final num? totalPalance;
  final bool isTotalPalnce;
  Color? backGroundColor;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return
     Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: BorderRadius.circular(padding6!)),
      child: Column(
        children: [
          SizedBox(
            height: sizeH16,
          ),
          Text( "${tr.total}",
            style: textStyleSkipButton(),
          ),
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GetBuilder<StorageViewModel>(
                  init: StorageViewModel(),
                  initState: (_) {},
                  builder: (logic) {
                    return totalPalance == null
                        ? Text(
                            isTotalPalnce
                                ? "${logic.totalBalance}"
                                : "${logic.balance}",
                            style: textStyleBigPrimaryTextColorSeconderSize(),
                          )
                        : Text("$totalPalance",
                            style: textStyleBigPrimaryText());
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
          ),
          SizedBox(
            height: sizeH16,
          ),
        ],
      ),
    );
  
  }
}