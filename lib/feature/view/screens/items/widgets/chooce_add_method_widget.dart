import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_button%20copy.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

import '../../../../../util/app_shaerd_data.dart';
import 'add_item_widget.dart';

class ChooseAddMethodWidget extends StatelessWidget {
  const ChooseAddMethodWidget({Key? key, required this.box , required this.isUpdate}) : super(key: key);

  final Box box;
  static ItemViewModle itemViewModle = Get.find<ItemViewModle>();
  final bool isUpdate;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      decoration: containerBoxDecoration().copyWith(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(padding30!))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: sizeH20,
          ),
          SpacerdColor(),
          SizedBox(
            height: sizeH20,
          ),
          SeconderyButtom(
            buttonTextStyle: textSeconderyButtonUnBold(),
            textButton: "Add Item",
            onClicked: () async {
              Get.bottomSheet(
                  AddItemWidget(
                    boxItem: BoxItem(),
                    isUpdate: isUpdate,
                    box: box,
                  ),
                  isScrollControlled: true).whenComplete(() {
                    if(isUpdate){
                      itemViewModle.clearBottomSheetItem();
                    }
              });
            },
            isExpanded: true,
          ),
          SizedBox(
            height: sizeH20,
          ),
          SeconderyButtom(
            buttonTextStyle: textSeconderyButtonUnBold(),
            textButton: "Add From Gallery",
            onClicked: () async {
              await itemViewModle.getItemImage(serialNo: box.serialNo ?? "");
            },
            isExpanded: true,
          ),
          SizedBox(
            height: sizeH20,
          ),
        ],
      ),
    );
  }
}
