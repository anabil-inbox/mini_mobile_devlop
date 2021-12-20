import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/view/screens/add_item/widgets/photo_item_widget.dart';
import 'package:inbox_clients/feature/view/screens/add_item/widgets/tag_item.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class TagWidget extends StatelessWidget {
  const TagWidget({Key? key}) : super(key: key);

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
          initState: (_) {},
          builder: (logic) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: logic.tdTag,
                  textInputAction: TextInputAction.go,
                  onFieldSubmitted: (e) {
                    if (e.trim().isNotEmpty) {
                      logic.usetTags.add(e);
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
                  child: logic.usetTags.isNotEmpty
                      ? ListView(
                          scrollDirection: Axis.horizontal,
                          children: logic.usetTags
                              .map((e) => TagItem(
                                    text: e,
                                    onTap: () {
                                      logic.usetTags.remove(e);
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
