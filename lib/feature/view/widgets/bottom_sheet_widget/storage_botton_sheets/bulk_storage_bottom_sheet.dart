import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/utils.dart';
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
  const ItemStorageBottomSheet(
      {Key? key,
      required this.storageCategoriesData,
      this.isUpdate = false,
      required this.index})
      : super(key: key);

  final StorageCategoriesData storageCategoriesData;
  final bool isUpdate;
  final int index;
  @override
  State<ItemStorageBottomSheet> createState() => _ItemStorageBottomSheetState();
}

class _ItemStorageBottomSheetState extends State<ItemStorageBottomSheet> {
  static StorageViewModel get storageViewModel => Get.put(StorageViewModel() , permanent: true);
  
  @override
  void initState() {
    super.initState();
    if (!GetUtils.isNull(widget.storageCategoriesData.localBulk)) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        storageViewModel.getBulksBalance(
            localBulk: widget.storageCategoriesData.localBulk!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return SingleChildScrollView(
      primary: true,
      child: Container(
        margin: EdgeInsets.only(top: 40),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(onTap:()=> Get.back(),child: Icon(Icons.close , color: colorBlack,),),
                    Container(
                      height: sizeH5,
                      width: sizeW50,
                      decoration: BoxDecoration(
                          color: colorSpacer,
                          borderRadius: BorderRadius.circular(padding3)),
                    ),
                    InkWell(onTap:()=> Get.back(),child: Icon(Icons.close , color: colorTrans,),),
                  ],
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
                NeedInspectorWidget(
                  storageCategoriesData: widget.storageCategoriesData,
                ),
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
                    quantityTitle: "${tr.days}",
                    storageCategoriesData: widget.storageCategoriesData,
                  )
                else
                  const SizedBox(),
                if(widget.storageCategoriesData.storageFeatures != null && widget.storageCategoriesData.storageFeatures!.isNotEmpty)...[
                  SizedBox(
                    height: sizeH16,
                  ),
                  OptionWidget(
                    storageCategoriesData: widget.storageCategoriesData,
                  ),
                ],
                SizedBox(
                  height: sizeH16,
                ),
                PrimaryButton(
                    textButton: "${tr.next}",
                    isLoading: false,
                    onClicked: () {
                      if(storageViewModel.localBulk.endStorageItem.isNotEmpty) {
                        storageViewModel.saveStorageDataToArray(
                          updateIndex: widget.index,
                          isUpdate: widget.isUpdate,
                          storageCategoriesData: widget.storageCategoriesData);
                        storageViewModel.checkDaplication();
                      }else{
                        snackError("", tr.must_add_item);
                      }

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
