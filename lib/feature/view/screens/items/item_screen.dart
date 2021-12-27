import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/utils.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/screens/items/widgets/empty_body_box_item.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/items_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/text_with_contanier_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/filter_storage/filter_storage_name_view.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/widget/back_btn_widget.dart';

import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({Key? key, required this.box}) : super(key: key);

  //todo this for item titles
  Widget get headItemWidget => Row(
        children: [
          TextButton(
              onPressed: () {
                itemViewModle.showAddItemBottomSheet(box: box);
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/svgs/red_add.svg",
                  ),
                  SizedBox(
                    width: sizeW5,
                  ),
                  Text(
                    "${tr.items}",
                    style: textStyleNormal()?.copyWith(color: colorBlack),
                  ),
                ],
              )),
          const Spacer(),
          TextContainerWidget(
            colorBackground: colorRedTrans,
            txt: tr.name,
          ),
        ],
      );

  final Box box;
  static ItemViewModle itemViewModle = Get.find<ItemViewModle>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: colorBackground,
        actions: [
          IconButton(
              onPressed: () {
                itemViewModle.showUpdatBoxBottomSheet(box: box , isUpdate: true);
              },
              icon: SvgPicture.asset("assets/svgs/update.svg")),
          IconButton(
              onPressed: () {
                // itemViewModle.showAddItemBottomSheet(box: box);
                Get.to(() => FilterStorageNameView());
              },
              icon: SvgPicture.asset("assets/svgs/storage_check_deactive.svg")),
          SizedBox(
            width: sizeW10,
          ),
        ],
        leading: BackBtnWidget(),
        centerTitle: true,
        title: GetBuilder<ItemViewModle>(
          init: ItemViewModle(),
          initState: (_) {},
          builder: (_) {
            return Text(
              "${itemViewModle.operationsBox?.storageName ?? ""}",
              style: textStyleAppBarTitle(),
            );
          },
        ),
      ),
      body: GetBuilder<ItemViewModle>(
        init: ItemViewModle(),
        initState: (_) async {
          await itemViewModle.getBoxBySerial(serial: box.serialNo ?? "");
          itemViewModle.update();
        },
        builder: (logic) {
          if (logic.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (GetUtils.isNull(itemViewModle.operationsBox?.items) ||
              itemViewModle.operationsBox!.items!.isEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: padding20!),
              child: EmptyBodyBoxItem(
                box: itemViewModle.operationsBox!,
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: padding20!),
              child: Column(
                children: [
                  SizedBox(
                    height: sizeH20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(padding16!),
                          child: SvgPicture.asset(
                            "assets/svgs/search_icon.svg",
                          ),
                        ),
                        hintText: "Search"),
                  ),
                  SizedBox(
                    height: sizeH10,
                  ),
                  headItemWidget,
                  SizedBox(
                    height: sizeH10,
                  ),
                  GetBuilder<ItemViewModle>(
                    builder: (_) {
                      return Expanded(
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(sizeRadius10!),
                          ),
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: customScrollViewIOS(),
                              clipBehavior: Clip.antiAlias,
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              itemBuilder: (context, index) => ItemsWidget(
                                   // itemIndex: index,
                                    box: itemViewModle.operationsBox!,
                                    boxItem: itemViewModle
                                        .operationsBox!.items![index],
                                  ),
                              separatorBuilder: (context, index) => Divider(
                                    height: sizeH1,
                                  ),
                              itemCount:
                                  itemViewModle.operationsBox!.items!.length),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
