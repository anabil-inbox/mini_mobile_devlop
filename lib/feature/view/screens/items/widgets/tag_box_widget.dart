import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/view/screens/items/widgets/tag_item.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

import '../../../../../util/app_shaerd_data.dart';

class TagBoxWidget extends StatelessWidget {
  const TagBoxWidget({Key? key}) : super(key: key);

  static ItemViewModle itemViewModle = Get.find<ItemViewModle>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      decoration: BoxDecoration(
          color: colorBackground,
          border: Border.all(color: colorBorderContainer),
          borderRadius: BorderRadius.vertical(top: Radius.circular(padding6!))),
      child: Form(
        child: GetBuilder<ItemViewModle>(
          autoRemove: false,
          initState: (_) {
            Set<String> localSet = {};
            if (itemViewModle.operationsBox != null) {
              for (var item in itemViewModle.operationsBox!.tags!) {
                localSet.add(item.tag!);
              }
              itemViewModle.usesBoxTags = localSet;
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
                      logic.usesBoxTags.add(e);
                      logic.tdTag.clear();
                      logic.update();
                    }
                  },
                ),
                SizedBox(
                  height: sizeH16,
                ),
                GetBuilder<ItemViewModle>(
                  autoRemove: false,
                  builder: (item) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: padding6!),
                      height: sizeH30,
                      child: item.usesBoxTags.isNotEmpty
                          ? ListView(
                              scrollDirection: Axis.horizontal,
                              children: item.usesBoxTags
                                  .map((e) => TagItem(
                                        text: e,
                                        onTap: () {
                                          item.usesBoxTags.remove(e);
                                          item.update();
                                        },
                                      ))
                                  .toList(),
                            )
                          : const SizedBox(),
                    );
                  },
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
