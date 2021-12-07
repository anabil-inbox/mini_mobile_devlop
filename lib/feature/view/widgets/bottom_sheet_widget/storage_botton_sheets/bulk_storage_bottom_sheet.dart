import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/add_item_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/need_inspector_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/options_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/period_storage_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/price_bottom_sheet_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/quantity_widget.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

import '../../primary_button.dart';

class ItemStorageBottomSheet extends StatefulWidget {
  const ItemStorageBottomSheet({Key? key, required this.storageCategoriesData})
      : super(key: key);

  final StorageCategoriesData storageCategoriesData;

  @override
  State<ItemStorageBottomSheet> createState() => _ItemStorageBottomSheetState();
}

class _ItemStorageBottomSheetState extends State<ItemStorageBottomSheet> {
  StorageViewModel storageViewModel = Get.find<StorageViewModel>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      storageViewModel.intialBalance(
          storageCategoriesData: widget.storageCategoriesData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: true,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(padding30!)),
          color: colorTextWhite,
        ),
        child: GetBuilder<StorageViewModel>(
          init: StorageViewModel(),
          initState: (_) {},
          builder: (builder) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: sizeH20,
                ),
                Container(
                  height: sizeH5,
                  width: sizeW50,
                  decoration: BoxDecoration(
                      color: colorSpacer,
                      borderRadius: BorderRadius.circular(padding3)),
                ),
                SizedBox(
                  height: sizeH20,
                ),
                Text(widget.storageCategoriesData.storageName ?? ""),
                SizedBox(
                  height: sizeH20,
                ),
                PriceBottomSheetWidget(),
                SizedBox(
                  height: sizeH16,
                ),
                NeedInspectorWidget(),
                SizedBox(
                  height: sizeH16,
                ),
                builder.isNeedingAdviser
                    ? const SizedBox()
                    : AddItemWidget(
                        storageCategoriesData: widget.storageCategoriesData,
                      ),
                builder.isNeedingAdviser
                    ? const SizedBox()
                    : SizedBox(
                        height: sizeH16,
                      ),
                PeriodStorageWidget(
                  storageCategoriesData: widget.storageCategoriesData,
                ),
                SizedBox(
                  height: sizeH16,
                ),
                if (storageViewModel.selectedDuration ==
                    ConstanceNetwork.dailyDurationType)
                  QuantityWidget(
                    value: storageViewModel.numberOfDays,
                    increasingFunction: () {
                      builder.increaseDaysDurations(
                          storageCategoriesData: widget.storageCategoriesData);
                    },
                    mineassingFunction: () {
                      builder.minasDaysDurations(
                          storageCategoriesData: widget.storageCategoriesData);
                    },
                    quantityTitle: "Days",
                    storageCategoriesData: widget.storageCategoriesData,
                  )
                else
                  const SizedBox(),
                SizedBox(
                  height: sizeH16,
                ),
                OptionWidget(
                  storageCategoriesData: widget.storageCategoriesData,
                ),
                SizedBox(
                  height: sizeH16,
                ),
                PrimaryButton(
                    textButton: "${tr.next}",
                    isLoading: false,
                    onClicked: () {
                      storageViewModel.saveStorageDataToArray(
                          storageCategoriesData: widget.storageCategoriesData);
                    },
                    isExpanded: true),
                SizedBox(
                  height: sizeH16,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
