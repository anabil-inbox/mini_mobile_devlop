import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';

import '../../../../../../../util/app_shaerd_data.dart';

// ignore: must_be_immutable
class DurationWidget extends StatelessWidget {
  DurationWidget(
      {Key? key,
      required this.durationTitle,
      required this.storageCategoriesData})
      : super(key: key);

  final String durationTitle;
  final StorageCategoriesData storageCategoriesData;
  StorageViewModel storageViewModel = Get.find<StorageViewModel>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetBuilder<StorageViewModel>(
      init: StorageViewModel(),
      initState: (_) {},
      builder: (builder) {
        return InkWell(
          onTap: () {
            storageViewModel.numberOfDays = 1;
            storageViewModel.selectedDuration = durationTitle;
            if (storageCategoriesData.storageCategoryType ==
                ConstanceNetwork.itemCategoryType) {
              storageViewModel.onChangeBulkDuration(
                  newDuration: durationTitle,
                  storageCategoriesData: storageCategoriesData);
            } else if (storageCategoriesData.storageCategoryType ==
                    ConstanceNetwork.spaceCategoryType ||
                storageCategoriesData.storageCategoryType ==
                    ConstanceNetwork.driedCage) {
              storageViewModel.getSmallBalanceForCage(
                  newDuration: storageViewModel.selectedDuration,
                  storageItem: storageViewModel.lastStorageItem!);
            } else {
              storageViewModel.getBalanceFromDuration(
                  newDuration: durationTitle,
                  storageCategoriesData: storageCategoriesData);
            }

            storageViewModel.update();
          },
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(padding6!),
                  border: Border.all(
                      width: 0.5,
                      color: storageViewModel.selectedDuration != durationTitle
                          ? colorBorderContainer
                          : colorTrans),
                  color: storageViewModel.selectedDuration != durationTitle
                      ? colorTextWhite
                      : colorPrimary),
              padding: EdgeInsets.symmetric(
                  vertical: padding9!, horizontal: padding12!),
              child: Text(
                durationTitle,
                style: storageViewModel.selectedDuration == durationTitle
                    ? textStylebodyWhite()
                    : textStyleHints()!
                        .copyWith(fontSize: fontSize14, color: colorHint2),
              )),
        );
      },
    );
  }
}
