// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:inbox_clients/feature/model/storage/local_bulk_modle.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

import 'show_option_item.dart';

class ShowOptionsWidget extends StatelessWidget {
  ShowOptionsWidget(
      {Key? key,
      required this.storageItem,
      this.localBulk,
      required this.storageCategoriesData})
      : super(key: key);

  final StorageItem storageItem;
  LocalBulk? localBulk;

  final StorageCategoriesData storageCategoriesData;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Options",
          textAlign: TextAlign.start,
          style: textStyleNormalBlack(),
        ),
        SizedBox(
          height: sizeH7,
        ),
        storageCategoriesData.storageCategoryType ==
                    ConstanceNetwork.itemCategoryType &&
                !GetUtils.isNull(localBulk!.optionStorageItem?.options)
            ? localBulk!.optionStorageItem!.options!.isNotEmpty
                ? ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: localBulk!.optionStorageItem!.options!
                        .map((e) => ShowOptionItem(
                              optionTitle: e,
                            ))
                        .toList(),
                  )
                : const SizedBox()
            : ListView(
                shrinkWrap: true,
                primary: false,
                children: storageItem.options!
                    .map((e) => ShowOptionItem(
                          optionTitle: e,
                        ))
                    .toList(),
              ),
      ],
    );
  }
}
