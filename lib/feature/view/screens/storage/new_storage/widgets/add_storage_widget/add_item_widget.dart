import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/bulk_item_bottom_sheet.dart';
import 'package:inbox_clients/feature/view/widgets/primary_border_button.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

import 'bulk_item_widget.dart';

class AddItemWidget extends StatelessWidget {
  const AddItemWidget({Key? key, required this.storageCategoriesData})
      : super(key: key);

  final StorageCategoriesData storageCategoriesData;
  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${tr.add_all_items}"),
          SizedBox(
            height: sizeH16,
          ),
          storageViewModel.localBulk.endStorageItem.length != 0
              ? GetBuilder<StorageViewModel>(builder: 
              (logical) {
                  return SizedBox(
                    height: sizeH40,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: storageViewModel.localBulk.endStorageItem
                            .map((e) => BulkItemWidget(
                                  title: e.item ?? "",
                                  quantity: e.quantity ?? 0,
                                  deleteFunction: () {
                                    storageViewModel.removeFromBulk(e);
                                  },
                                ))
                            .toList()),
                  );
                })
              : const SizedBox(),
          SizedBox(
            height: sizeH16,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(padding6!),
                border: Border.all(color: colorBorderContainer)),
            height: sizeH50,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Get.bottomSheet(
                          BulkItemButtomSheet(
                            storageCategoriesData: storageCategoriesData,
                          ),
                          isScrollControlled: true);
                    },
                    icon: SvgPicture.asset("assets/svgs/down_arrow.svg")),
                SizedBox(
                  width: sizeW5,
                ),
                GetBuilder<StorageViewModel>(
                  init: StorageViewModel(),
                  initState: (_) {},
                  builder: (build) {
                    return Text(
                        "${build.selctedItem?.storageType ?? "${tr.choose_from_below}"}");
                  },
                ),
                const Spacer(),
                Container(
                  width: sizeH100,
                  height: sizeH30,
                  child: Stack(
                    children: [
                      PositionedDirectional(
                          bottom: -5,
                          start: 30,
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: scaffoldColor,
                            ),
                            height: sizeH40,
                            width: sizeW40,
                            child: GetBuilder<StorageViewModel>(
                              init: StorageViewModel(),
                              initState: (_) {},
                              builder: (logic) {
                                return Text(
                                  "${logic.quantity}",
                                  textAlign: TextAlign.center,
                                );
                              },
                            ),
                          )),
                      PositionedDirectional(
                          bottom: -10,
                          end: 1,
                          child: GetBuilder<StorageViewModel>(
                            init: StorageViewModel(),
                            initState: (_) {},
                            builder: (builder) {
                              return IconButton(
                                icon: SvgPicture.asset(
                                    "assets/svgs/circle_mines.svg"),
                                onPressed: () {
                                  builder.minesQuantityForBulks(
                                      storageCategoriesData:
                                          storageCategoriesData);
                                },
                              );
                            },
                          )),
                      PositionedDirectional(
                          bottom: -10,
                          end: 50,
                          child: GetBuilder<StorageViewModel>(
                            init: StorageViewModel(),
                            initState: (_) {},
                            builder: (value) {
                              return IconButton(
                                icon: SvgPicture.asset(
                                    "assets/svgs/circle_add.svg"),
                                onPressed: () {
                                  value.increaseQuantityForBulks(
                                      storageCategoriesData:
                                          storageCategoriesData);
                                },
                              );
                            },
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: sizeH16,
          ),
          PrimaryBorderButton(
            buttonText: "${tr.add}",
            function: () {
              if (storageViewModel.selctedItem != null) {
                // storageCategoriesData.quantity = storageViewModel.quantity;
                storageViewModel.selctedItem?.quantity =
                    storageViewModel.quantity;
                // storageViewModel.allItems.add(storageViewModel.selctedItem!);
                // storageViewModel.addNewBulk(newValue: storageCategoriesData);
                storageViewModel.addNewBulk(
                    storageCategoriesData: storageCategoriesData,
                    item: storageViewModel.selctedItem!);
              }
            },
          )
        ],
      ),
    );
  }
}
