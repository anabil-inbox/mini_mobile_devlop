import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/show_selction_widget/show_options_widget.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

import 'show_header_selection.dart';

class ShowSpaceAndQuantityWidget extends StatelessWidget {
  const ShowSpaceAndQuantityWidget(
      {Key? key,
      required this.storageItem,
      required this.storageCategoriesData
      })
      : super(key: key);

  final StorageItem storageItem;
  final StorageCategoriesData storageCategoriesData;

  @override
  Widget build(BuildContext context) {
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
           !GetUtils.isNull(storageItem.from) ? 
           ShowHeaderSelection(
            storageName: storageCategoriesData.storageName ?? "",
            quantityOrSpace: " ${storageItem.from} X ${storageItem.to}",
          ) : 
          ShowHeaderSelection(
            storageName: storageCategoriesData.storageName ?? "",
            quantityOrSpace: "X ${storageCategoriesData.quantity ?? 1}",
          ),
          SizedBox(
            height: sizeH18,
          ),
          ShowOptionsWidget(storageItemOptions: storageItem.options ?? []),
          SizedBox(
            height: sizeH9,
          ),
          Row(
            children: [
              Text(
                "Total",
                style: textStyleNormalBlack(),
              ),
              const Spacer(),
              Text("${storageCategoriesData.userPrice}",
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
}
