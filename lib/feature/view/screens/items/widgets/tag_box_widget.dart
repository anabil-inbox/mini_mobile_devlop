import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/view/screens/items/widgets/tag_item.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class TagBoxWidget extends StatelessWidget {
  const TagBoxWidget({Key? key}) : super(key: key);

  static ItemViewModle itemViewModle = Get.find<ItemViewModle>();

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
            Set<String> localSet = {};
            for (var item in itemViewModle.operationsBox!.tags!) {
              localSet.add(item.tag!);
            }
            itemViewModle.usesBoxTags = localSet;
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
                      logic.usesBoxTags.add(e);
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
                  child: logic.usesBoxTags.isNotEmpty
                      ? ListView(
                          scrollDirection: Axis.horizontal,
                          children: logic.usesBoxTags
                              .map((e) => TagItem(
                                    text: e,
                                    onTap: () {
                                      logic.usesBoxTags.remove(e);
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
