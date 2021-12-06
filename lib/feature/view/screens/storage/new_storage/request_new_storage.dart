import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/price_bottom_sheet_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/show_selction_widget/show_bulk_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

import 'widgets/add_storage_widget/request_new_storage_header.dart';
import 'widgets/add_storage_widget/storage_size_type_widget.dart';
import 'widgets/show_selction_widget/show_space_and_quantity_widget.dart';

class RequestNewStorageScreen extends StatelessWidget {
  const RequestNewStorageScreen({Key? key}) : super(key: key);

  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: CustomAppBarWidget(
        isCenterTitle: true,
        titleWidget: Text(
          "${tr.request_new_storage}",
          style: textStyleAppBarTitle(),
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              primary: true,
              shrinkWrap: true,
              children: [
                GetBuilder<StorageViewModel>(
                  init: StorageViewModel(),
                  initState: (_) {},
                  builder: (val) {
                    return RequestNewStorageHeader(
                      currentLevel: val.currentLevel,
                    );
                  },
                ),
                GetBuilder<StorageViewModel>(
                  init: StorageViewModel(),
                  initState: (_) {},
                  builder: (builder) {
                    return StorageSizeType();
                  },
                ),
                SizedBox(
                  height: sizeH16,
                ),
                storageViewModel.userStorageCategoriesData.length > 0
                    ? GetBuilder<StorageViewModel>(
                        builder: (build) => Container(
                              color: colorTextWhite,
                              padding: EdgeInsets.all(20),
                              child: ListView(
                                shrinkWrap: true,
                                primary: false,
                                children: [
                                  Text("My List"),
                                  SizedBox(
                                    height: sizeH10,
                                  ),
                                  PriceBottomSheetWidget(
                                    priceTitle: "Total",
                                    isTotalPalnce: true,
                                  ),
                                  SizedBox(
                                    height: sizeH10,
                                  ),
                                  ListView(
                                    primary: false,
                                    shrinkWrap: true,
                                    children: build.userStorageCategoriesData
                                        .map((e) {
                                      if (build.checkCategoreyType(
                                              storageCategoreyType:
                                                  e.storageCategoryType!) ==
                                          ConstanceNetwork
                                              .quantityCategoryType) {
                                        return ShowSpaceAndQuantityWidget(
                                            storageItem: e.storageItem![0]);
                                      } else {
                                        return ShowBulkItem(
                                            storageItem: e.storageItem![0]);
                                      }
                                    }).toList(),
                                  )
                                ],
                              ),
                            ))
                    : const SizedBox(),
              ],
            ),
            Positioned(
              bottom: padding10,
              right: padding20,
              left: padding20,
              child: PrimaryButton(
                  textButton: "Next",
                  isLoading: false,
                  colorBtn:
                      storageViewModel.userStorageCategoriesData.length > 0
                          ? colorPrimary
                          : colorUnSelectedWidget,
                  onClicked: () {

                  },
                  isExpanded: true),
            )
          ],
        ),
      ),
    );
  }
}
