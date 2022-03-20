import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/screens/items/widgets/tag_item.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class TagBoxItemWidget extends StatelessWidget {
  const TagBoxItemWidget(
      {Key? key, required this.isUpdate, required this.boxItem})
      : super(key: key);

  /// still connect item update with design
  static ItemViewModle itemViewModle = Get.find<ItemViewModle>();
  final bool isUpdate;
  final BoxItem boxItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: colorBackground,
          border: Border.all(color: colorBorderContainer),
          borderRadius: BorderRadius.vertical(top: Radius.circular(padding6!))),
      child: Form(
        child: GetBuilder<ItemViewModle>(
          init: ItemViewModle(),
          initState: (_) {
            if (isUpdate) {
              Set<String> localSet = {};
              itemViewModle.usesBoxItemsTags.clear();
              localSet.clear();
              for (var item in boxItem.itemTags!) {
                localSet.add(item.tag!);
              }
              // itemViewModle.tdName.text =
              // for (var item in itemViewModle.operationsBox!.items!) {
              //   for (var i in item.itemTags!) {
              //     localSet.add(i.tag!);
              //   }
              // }
              WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                itemViewModle.tdName.text = boxItem.itemName ?? "";
                itemViewModle.itemQuantity =
                    int.parse(boxItem.itemQuantity ?? "1");
                itemViewModle.update();
              });
              itemViewModle.usesBoxItemsTags = localSet;
            } else {
              itemViewModle.usesBoxItemsTags.clear();
              WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                
              });
              itemViewModle.usesBoxItemsTags.clear();
            }
          },
          builder: (logic) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: logic.tdTag,
                  decoration: InputDecoration(
                      focusColor: colorTrans,
                      focusedBorder: InputBorder.none,
                      hintText: "Tag"),
                  textInputAction: TextInputAction.go,
                  onFieldSubmitted: (e) {
                    if (e.trim().isNotEmpty) {
                      logic.usesBoxItemsTags.add(e);
                      logic.tdTag.clear();
                      logic.update();
                    }
                  },
                ),
                SizedBox(
                  height: sizeH16,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: padding6!),
                  height: sizeH30,
                  child: logic.usesBoxItemsTags.isNotEmpty
                      ? ListView(
                          scrollDirection: Axis.horizontal,
                          children: logic.usesBoxItemsTags
                              .map((e) => TagItem(
                                    text: e,
                                    onTap: () {
                                      logic.usesBoxItemsTags.remove(e);
                                      logic.update();
                                    },
                                  ))
                              .toList(),
                        )
                      : const SizedBox(),
                ),
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
