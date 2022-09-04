import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/show_selction_widget/show_options_widget.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/constance/constance.dart';

import 'show_header_selection.dart';

class ShowSpaceAndQuantityWidget extends StatelessWidget {
  const ShowSpaceAndQuantityWidget(
      {Key? key,
      required this.storageItem,
      required this.storageCategoriesData,
      required this.index})
      : super(key: key);

  final StorageItem storageItem;
  final StorageCategoriesData storageCategoriesData;
  final int index;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding16!),
      margin: EdgeInsets.only(bottom: padding10!),
      decoration: BoxDecoration(
          color: scaffoldColor, borderRadius: BorderRadius.circular(padding6!)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: sizeH22,
          ),
          !GetUtils.isNull(storageItem.from)
              ? ShowHeaderSelection(
                  index: index,
                  storageCategoriesData: storageCategoriesData,
                  storageName: storageCategoriesData.storageName ?? "",
                  quantityOrSpace:
                      " ${storageCategoriesData.x ?? 1} X ${storageCategoriesData.y ?? 1}",
                )
              : ShowHeaderSelection(
                  index: index,
                  storageCategoriesData: storageCategoriesData,
                  storageName: storageCategoriesData.storageName ?? "",
                  quantityOrSpace: "X ${storageCategoriesData.quantity ?? 1}",
                ),
          SizedBox(
            height: sizeH18,
          ),
           storageCategoriesData.selectedItem!.options!.isEmpty
              ? const SizedBox()
              : ShowOptionsWidget(
                  storageCategoriesData: storageCategoriesData,
                  localBulk: storageCategoriesData.localBulk,
                  storageItem: storageCategoriesData.selectedItem!,
                ),
          // SizedBox(
          //   height: sizeH9,
          // ),
          Row(
            children: [
              Text(
                tr.subscriptions + " : ",
                textAlign: TextAlign.start,
                style: textStyleNormalBlack(),
              ),
              SizedBox(width: sizeW5,),
              Expanded(
                child: Text(
                  storageCategoriesData.selectedDuration.toString() ,
                  textAlign: TextAlign.start,
                  style: textStyleNormalBlack(),
                ),
              ),
              Text(
                "(${handlerQtySubscriptions()}${storageCategoriesData.numberOfDays})",
                textAlign: TextAlign.start,
                style: textStyleNormalBlack(),
              ),
            ],
          ),
          SizedBox(
            height: sizeH12,
          ),
          Row(
            children: [
              Text(
                tr.total,
                style: textStyleNormalBlack(),
              ),
              const Spacer(),
              Text("${calculateBalance(balance: storageCategoriesData.userPrice ?? 0)}",
                  style: textStylePrimaryFont()
                      ?.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(
                width: sizeW2,
              ),
              Text("QR",
                  style: textStylePrimaryFont()
                      ?.copyWith(fontWeight: FontWeight.bold))
            ],
          ),
          SizedBox(
            height: sizeH9,
          ),
        ],
      ),
    );
  }

  String handlerQtySubscriptions() {
    return storageCategoriesData.selectedDuration.toString() == LocalConstance.dailySubscriptions ?" ${tr.daily} " : "".trim();
  }
}
