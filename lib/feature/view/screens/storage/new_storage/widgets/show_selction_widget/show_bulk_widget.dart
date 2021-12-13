import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/show_selction_widget/show_options_widget.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

import 'show_header_selection.dart';

class ShowBulkItem extends StatelessWidget {
  const ShowBulkItem(
      {Key? key,
      required this.storageItem,
      required this.index,
      required this.storageCategoriesData})
      : super(key: key);

  final StorageItem storageItem;
  final int index;
  final StorageCategoriesData storageCategoriesData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding16!),
      margin: EdgeInsets.only(bottom: padding10!),
      width: double.infinity,
      decoration: BoxDecoration(
          color: scaffoldColor, borderRadius: BorderRadius.circular(padding6!)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: sizeH22,
          ),
          ShowHeaderSelection(
            index: index,
            storageCategoriesData: storageCategoriesData,
            storageName: storageCategoriesData.storageName ?? "",
            quantityOrSpace: "",
          ),
          SizedBox(
            height: sizeH7,
          ),
          SizedBox(
            height: 30,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: storageCategoriesData.localBulk!.endStorageItem
                  .map((e) => Row(
                        children: [
                          Text(
                            "${e.item}",
                            style: textStyleNormalBlack(),
                          ),
                          SizedBox(
                            width: sizeW4,
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: padding10!, vertical: padding4!),
                              decoration: BoxDecoration(
                                  color: colorBackground,
                                  borderRadius:
                                      BorderRadius.circular(padding7!)),
                              child: Text("X ${e.quantity}")),
                          SizedBox(
                            width: sizeW7,
                          ),
                        ],
                      ))
                  .toList(),
            ),
          ),
          SizedBox(
            height: sizeH7,
          ),
          ShowOptionsWidget(
            storageCategoriesData: storageCategoriesData,
            localBulk: storageCategoriesData.localBulk!,
            storageItem: storageItem,
          ),
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
