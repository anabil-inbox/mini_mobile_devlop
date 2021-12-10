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
            storageName: storageCategoriesData.name ?? "",
            quantityOrSpace: "X ${storageCategoriesData.quantity}",
          ),
          SizedBox(
            height: sizeH7,
          ),
          Text("${storageItem.item}",
            style: textStyleNormalBlack(),
          ),
          SizedBox(
            height: sizeH7,
          ),
          ShowOptionsWidget(
            storageItem: storageItem,
            ),
          SizedBox(
            height: sizeH9,
          ),
        ],
      ),
    );
  }
}
