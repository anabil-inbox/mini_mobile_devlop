import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/custom_space_widget.dart';
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

class SpaceStorageBottomSheet extends StatefulWidget {
  const SpaceStorageBottomSheet(
      {Key? key,
      required this.storageCategoriesData,
      this.isUpdate = false,
      required this.index})
      : super(key: key);

  final StorageCategoriesData storageCategoriesData;
  final bool isUpdate;
  final int index;
  @override
  State<SpaceStorageBottomSheet> createState() =>
      _SpaceStorageBottomSheetState();
}

class _SpaceStorageBottomSheetState extends State<SpaceStorageBottomSheet> {
  StorageViewModel storageViewModel = Get.find<StorageViewModel>();
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    //   storageViewModel.intialBalance(
    //       storageCategoriesData: widget.storageCategoriesData);
    // });
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
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
          initState: (state) {
            WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
              state.controller?.intialBalance(
                  storageCategoriesData: widget.storageCategoriesData);
            });
          },
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
                CustomSpaceWidget(
                  storageCategoriesData: widget.storageCategoriesData,
                ),
                SizedBox(
                  height: sizeH16,
                ),
                PeriodStorageWidget(
                  storageCategoriesData: widget.storageCategoriesData,
                ),
                if (storageViewModel.selectedDuration ==
                    ConstanceNetwork.dailyDurationType)
                  SizedBox(
                    height: sizeH16,
                  )
                else
                  const SizedBox(),
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
                    quantityTitle: "${tr.days}",
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
                      if (storageViewModel.tdX.text.isEmpty ||
                          storageViewModel.tdX.text == "0" ||
                          storageViewModel.tdY.text.isEmpty ||
                          storageViewModel.tdY.text == "0") {
                        snackError("${tr.error_occurred}",
                            "${tr.you_have_to_add_valid_space}");
                        return;
                      }
                      storageViewModel.saveStorageDataToArray(
                          updateIndex: widget.index,
                          isUpdate: widget.isUpdate,
                          storageCategoriesData: widget.storageCategoriesData);
                      storageViewModel.checkDaplication();
                      storageViewModel.update();
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
