import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_button.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

import '../../../../../util/app_shaerd_data.dart';
import 'add_item_widget.dart';

/// BS => Bottom Sheet :

class ItemsOperationBS extends StatelessWidget {
  const ItemsOperationBS({Key? key, required this.boxItem, required this.box})
      : super(key: key);

  static ItemViewModle itemViewModle = Get.find<ItemViewModle>();

  final BoxItem boxItem;
  final Box box;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      decoration: containerBoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: sizeH20,
          ),
          SpacerdColor(),
          SizedBox(
            height: sizeH16,
          ),
          SeconderyButtom(
              textButton: "Update",
              onClicked: () async {
                await Get.bottomSheet(
                    AddItemWidget(
                      isUpdate: true,
                      box: box,
                      boxItem: boxItem,
                    ),
                    isScrollControlled: true);
                Get.back();
              }),
          SizedBox(
            height: sizeH10,
          ),
          SeconderyButtom(
              textButton: "Share",
              onClicked: () {
                itemViewModle.shareItem(boxItem: boxItem);
              }),
          SizedBox(
            height: sizeH10,
          ),
          SeconderyButtom(
              textButton: "Delete",
              onClicked: () async {
                await itemViewModle.showDeleteItemBottomSheet(
                  id: boxItem.id ?? "",
                  serialNo: box.serialNo ?? "",
                );
                box.items?.removeWhere(
                    (element) => element.itemName == boxItem.itemName);
                itemViewModle.update();
              }),
          SizedBox(
            height: sizeH10,
          ),
        ],
      ),
    );
  }
}
