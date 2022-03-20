import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/price_bottom_sheet_widget.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

import 'show_space_and_quantity_widget.dart';
import 'show_bulk_widget.dart';

class MyListWidget extends StatelessWidget {
  const MyListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetBuilder<StorageViewModel>(
        builder: (build) => build.userStorageCategoriesData.isEmpty
            ? const SizedBox()
            : Container(
                padding: EdgeInsets.all(padding20!),
                decoration: BoxDecoration(
                    color: colorTextWhite,
                    borderRadius: BorderRadius.circular(padding6!)),
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  children: [
                    Text("${tr.my_list}"),
                    SizedBox(
                      height: sizeH10,
                    ),
                    PriceBottomSheetWidget(
                      priceTitle: "${tr.total}",
                      isTotalPalnce: true,
                    ),
                    SizedBox(
                      height: sizeH10,
                    ),
                    ListView(
                        primary: false,
                        shrinkWrap: true,
                        children: build.userStorageCategoriesData
                            .asMap()
                            .map((index, value) => MapEntry(
                                  index,
                                  build.checkCategoreyType(
                                                  storageCategoreyType: value
                                                      .storageCategoryType!) ==
                                              ConstanceNetwork
                                                  .quantityCategoryType ||
                                          build.checkCategoreyType(
                                                  storageCategoreyType: value
                                                      .storageCategoryType!) ==
                                              ConstanceNetwork.spaceCategoryType
                                      ? ShowSpaceAndQuantityWidget(
                                          index: index,
                                          storageCategoriesData: value,
                                          storageItem: value.storageItem![0])
                                      : ShowBulkItem(
                                          storageCategoriesData: value,
                                          index: index,
                                          storageItem: value.storageItem![0]),
                                ))
                            .values
                            .toList()),
                  ],
                ),
              ));
  }
}
