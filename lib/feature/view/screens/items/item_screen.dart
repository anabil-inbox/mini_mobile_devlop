import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/utils.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/screens/items/widgets/empty_body_box_item.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/btn_action_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/items_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/text_with_contanier_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/widget/back_btn_widget.dart';
import 'package:inbox_clients/feature/view/widgets/custom_text_filed.dart';

import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/constance/constance.dart';

import 'filter_items/filter_item_screen.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({Key? key, required this.box}) : super(key: key);

  // Search Widget =>
  Widget get searchWidget => CustomTextFormFiled(
        iconSize: sizeRadius20,
        maxLine: Constance.maxLineOne,
        icon: Icons.search,
        iconColor: colorBlack,
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.text,
        onSubmitted: (_) {},
        onChange: (value) {
          itemViewModle.search = value.toString();
          itemViewModle.update();
        },
        isSmallPadding: false,
        isSmallPaddingWidth: true,
        fillColor: colorBackground,
        isFill: true,
        isBorder: true,
        label: tr.search,
      );

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
          IconButton(
            padding: const EdgeInsets.all(0),
            onPressed: (){
              Get.to(() =>  FilterItemScreen(
                title: "Filter By Name",
              ));
            },
            icon: TextContainerWidget(
              colorBackground: colorRedTrans,
              txt: tr.name,
            ),
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
                if (itemViewModle.isLoading) {
                } else {
                  itemViewModle.showUpdatBoxBottomSheet(
                      box: box, isUpdate: true);
                }
              },
              icon: SvgPicture.asset("assets/svgs/update.svg")),
          Center(
            child: InkWell(
                onTap: () {
                  itemViewModle.listIndexSelected.clear();
                  itemViewModle.isSelectAllClick = false;
                  itemViewModle.isSelectBtnClick = true;
                  itemViewModle.search = "";
                  Get.to(() => FilterItemScreen(
                    title: "Select Items",
                  ));
                },
                child: Text(
                  "Select",
                  style: textStyleNormal()?.copyWith(color: colorRed),
                  maxLines: Constance.maxLineOne,
                )),
          ),
          SizedBox(
            width: sizeW10,
          ),
        ],
        leading: BackBtnWidget(
          onTap: () {
            Get.back(result: true);
          },
        ),
        centerTitle: true,
        title: GetBuilder<ItemViewModle>(
          init: ItemViewModle(),
          initState: (_) {
            itemViewModle.operationsBox?.storageName = "";
          },
          builder: (_) {
            if (GetUtils.isNull(itemViewModle.operationsBox)) {
              return Text("");
            } else {
              return  Text(
                  "${itemViewModle.operationsBox!.storageName!.isEmpty ? "" : itemViewModle.operationsBox!.storageName}",
                  style: textStyleAppBarTitle(),
                  maxLines: Constance.maxLineTwo,
                  textAlign: TextAlign.center,
                );
              
            }
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
                  searchWidget,
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
                              itemBuilder: (context, index) {
                                if (itemViewModle.search.isEmpty) {
                                  return ItemsWidget(
                                    box: itemViewModle.operationsBox!,
                                    boxItem: itemViewModle
                                        .operationsBox!.items![index],
                                  );
                                } else if (itemViewModle
                                    .operationsBox!.items![index].itemName!
                                    .toLowerCase()
                                    .contains(itemViewModle.search)) {
                                  return ItemsWidget(
                                    box: itemViewModle.operationsBox!,
                                    boxItem: itemViewModle
                                        .operationsBox!.items![index],
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                              separatorBuilder: (context, index) {
                                if (itemViewModle.search.isEmpty) {
                                  return Divider(
                                    height: sizeH1,
                                  );
                                } else if (itemViewModle
                                    .operationsBox!.items![index].itemName!
                                    .toLowerCase()
                                    .contains(
                                        itemViewModle.search.toLowerCase())) {
                                  return Divider(
                                    height: sizeH1,
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                              itemCount:
                                  itemViewModle.operationsBox!.items!.length),
                        ),
                      );
                    },
                  ),
                  BtnActionWidget(
                    redBtnText: box.storageStatus == LocalConstance.boxAtHome
                        ? "Pickup"
                        : "${tr.recall}",
                    onShareBox: () {
                      itemViewModle.shareBox(box: box);
                    },
                    onDeleteBox: () {},
                  ),
                  SizedBox(
                    height: sizeH10,
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
