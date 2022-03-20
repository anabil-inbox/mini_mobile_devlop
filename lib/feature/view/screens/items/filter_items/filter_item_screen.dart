import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/view/screens/items/widgets/delete_or_terminate_bottom_sheer.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/btn_action_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/items_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/text_with_contanier_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/widget/back_btn_widget.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/giveaway_box_process%20.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/recall_box_process%20.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/recall_items_storage.dart';
import 'package:inbox_clients/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:logger/logger.dart';

// ignore: must_be_immutable
class FilterItemScreen extends StatefulWidget {
  const FilterItemScreen(
      {Key? key,
      required this.title,
      required this.serail,
      required this.box,
      this.isEnable = true})
      : super(key: key);

  final String title;
  final String? serail;
  final Box box;
  final bool isEnable;

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  State<FilterItemScreen> createState() => _FilterItemScreenState();
}

class _FilterItemScreenState extends State<FilterItemScreen> {
  // ItemViewModle itemViewModle = Get.put<ItemViewModle>(ItemViewModle());
  ItemViewModle itemViewModle = Get.find<ItemViewModle>();
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await itemViewModle.getBoxBySerial(serial: widget.serail!);
      itemViewModle.listIndexSelected.clear();
      itemViewModle.isSelectAllClick = false;
      itemViewModle.isSelectBtnClick = true;
      itemViewModle.search = "";
      itemViewModle.update();
    });
  }

  //todo this for appbar
  PreferredSizeWidget get appBar => CustomAppBarWidget(
        isCenterTitle: true,
        titleWidget: CustomTextView(
          txt: "${widget.title}",
          textStyle: textStyleNormal()?.copyWith(color: colorBlack),
          maxLine: Constance.maxLineOne,
        ),
        leadingWidget: GetBuilder<ItemViewModle>(
            // init: ItemViewModle(),
            // assignId: true,
            builder: (logic) {
          return BackBtnWidget(
            onTap: () {
              itemViewModle.isSelectAllClick =
                  !itemViewModle.isSelectAllClick /*false*/;
              itemViewModle.isSelectBtnClick =
                  !itemViewModle.isSelectBtnClick! /*false*/;
              itemViewModle.listIndexSelected.clear();
              itemViewModle.search = "";
              Get.back();
              itemViewModle.update();
            },
          );
        }),
        actionsWidgets: [
          widget.box.storageStatus != LocalConstance.boxAtHome
              ? GetBuilder<ItemViewModle>(
                  init: /*ItemViewModle()*/ itemViewModle,
                  // assignId: true,
                  builder: (logic) {
                    return TextButton(
                        onPressed: () {
                          // itemViewModle.updateSelectBtn();
                        },
                        child: SizedBox(
                          width: sizeW40,
                          child: TextButton(
                            onPressed: () {
                              Logger().d("onCheck all Selected");
                              itemViewModle.isSelectAllClick =
                                  !itemViewModle.isSelectAllClick;
                              if (!itemViewModle.isSelectAllClick) {
                                itemViewModle.listIndexSelected.clear();
                              } else {
                                if (itemViewModle.operationsBox?.items !=
                                    null) {
                                  itemViewModle.operationsBox?.items
                                      ?.forEach((element) {
                                    itemViewModle.listIndexSelected
                                        .add(element);
                                  });
                                }
                              }
                              itemViewModle.update();
                            },
                            child: (/* itemViewModle.isSelectAllClick || */
                                    (itemViewModle.listIndexSelected.length ==
                                        itemViewModle
                                            .operationsBox?.items?.length))
                                ? SvgPicture.asset(
                                    "assets/svgs/storage_check_active.svg")
                                : SvgPicture.asset(
                                    "assets/svgs/select_all_no_background.svg"),
                          ),
                        )
                        //   : CustomTextView(
                        // txt: "${tr.select}",
                        // textStyle:
                        // textStyleNormal()?.copyWith(color: colorRed),
                        // maxLine: Constance.maxLineOne,
                        // ),
                        );
                  })
              : const SizedBox(),
        ],
      );

  //todo this for search
  Widget get searchWidget => CustomTextFormFiled(
        iconSize: sizeRadius20,
        maxLine: Constance.maxLineOne,
        icon: Icons.search,
        iconColor: colorBlack,
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.text,
        onSubmitted: (_) {},
        onChange: (value) {
          itemViewModle.search = value;
          itemViewModle.update();
        },
        isSmallPadding: false,
        isSmallPaddingWidth: true,
        fillColor: colorBackground,
        isFill: true,
        isBorder: true,
        label: tr.search,
      );

  Widget get btnActionsWidget => widget.isEnable
      ? BtnActionWidget(
          isGaveAway: itemViewModle.operationsBox?.storageStatus ==
              LocalConstance.giveawayId,
          boxStatus: itemViewModle.operationsBox?.storageStatus ?? "",
          redBtnText: widget.box.storageStatus == LocalConstance.boxAtHome
              ? "${tr.pickup}"
              : "${tr.recall}",
          isShowingDeleteAndGivaway: (itemViewModle.listIndexSelected.length ==
              itemViewModle.operationsBox?.items?.length),
          onShareBox: onShareBoxClick,
          onGrayBtnClick: onGrayBtnClick,
          onRedBtnClick: onRedBtnClick,
          onDeleteBox: onDeleteBoxClick,
        )
      : const SizedBox();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      appBar: appBar,
      body: GetBuilder<ItemViewModle>(
          init: /*ItemViewModle()*/ itemViewModle,
          // assignId: true,
          initState: (state) {
            // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
            //   if(itemViewModle.operationsBox == null)
            //   itemViewModle.getBoxBySerial(serial: serail!);
            // });
          },
          builder: (logic) {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: sizeH20!, left: sizeW20!, right: sizeW20!),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        searchWidget,
                        SizedBox(
                          height: sizeH20,
                        ),
                        if (itemViewModle.operationsBox != null)
                          Expanded(
                            child: GroupedListView<BoxItem, String>(
                              elements: itemViewModle.operationsBox!.items!,
                              groupBy: (element) => element.itemName![0],
                              groupSeparatorBuilder: (String groupByValue) =>
                                  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: sizeH10,
                                  ),
                                  SizedBox(
                                    width: sizeW30,
                                    height: sizeH31,
                                    child: TextContainerWidget(
                                      colorBackground: colorRedTrans,
                                      txt: groupByValue,
                                    ),
                                  ),
                                  SizedBox(
                                    height: sizeH10,
                                  ),
                                ],
                              ) /*, Text(groupByValue , textAlign: TextAlign.start,)*/,
                              itemBuilder: (context, BoxItem element) {
                                if (itemViewModle.search.isEmpty) {
                                  return ItemsWidget(
                                    box: itemViewModle.operationsBox!,
                                    boxItem: element,
                                    isSelectedBtnClick:
                                        itemViewModle.isSelectBtnClick,
                                    onCheckItem: () {
                                      itemViewModle.addIndexToList(element);
                                    },
                                  );
                                } else if (element.itemName!
                                    .toLowerCase()
                                    .contains(
                                        itemViewModle.search.toLowerCase())) {
                                  return ItemsWidget(
                                    box: itemViewModle.operationsBox!,
                                    boxItem: element,
                                    isSelectedBtnClick:
                                        itemViewModle.isSelectBtnClick,
                                    onCheckItem: () {
                                      itemViewModle.addIndexToList(element);
                                    },
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                              itemComparator: (item1, item2) {
                                return item1.itemName![0]
                                    .compareTo(item2.itemName![0]);
                              },
                              // optional
                              useStickyGroupSeparators: false,
                              // optional
                              floatingHeader: false,
                              // optional
                              order: GroupedListOrder.ASC,
                              // optional
                              physics: customScrollViewIOS(),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                btnActionsWidget,
                SizedBox(
                  height: Platform.isIOS ? sizeH20 : sizeH10,
                ),
              ],
            );
          }),
    );
  }

  onGrayBtnClick() {
    Get.bottomSheet(
        GiveawayBoxProcessSheet(
          box: widget.box,
          boxes: [],
        ),
        isScrollControlled: true);
  }

  onRedBtnClick() {
    if (widget.box.storageStatus == LocalConstance.boxAtHome) {
      //todo this if pickup
      final Task enterdTask = FilterItemScreen.homeViewModel
          .searchTaskById(taskId: LocalConstance.pickupId);
      Get.bottomSheet(
          RecallBoxProcessSheet(
            boxes: [],
            task: enterdTask,
            box: widget.box,
          ),
          isScrollControlled: true);
    } else if (widget.box.storageStatus == LocalConstance.boxinWareHouse &&
        itemViewModle.listIndexSelected.isEmpty) {
      //todo this if recall
      final Task enterdTask = FilterItemScreen.homeViewModel
          .searchTaskById(taskId: LocalConstance.recallId);
      Get.bottomSheet(
          RecallBoxProcessSheet(
            boxes: [],
            task: enterdTask,
            box: widget.box,
          ),
          isScrollControlled: true);
      // Get.bottomSheet(RecallStorageSheet(box: widget.box),
      //     isScrollControlled: true);
    } else {
      //todo this if recall
      final Task enterdTask = FilterItemScreen.homeViewModel
          .searchTaskById(taskId: LocalConstance.recallId);
      Get.bottomSheet(
          RecallStorageSheet(
            task: enterdTask,
            box: itemViewModle.operationsBox ?? widget.box,
            isUserSelectItem:
                itemViewModle.listIndexSelected.isEmpty ? false : true,
          ),
          isScrollControlled: true);
      // Get.bottomSheet(RecallStorageSheet(box: widget.box),
      //     isScrollControlled: true);
    }
  }

  onDeleteBoxClick() {
    // Get.bottomSheet(BottomSheetPaymentWidget(),
    //     isScrollControlled: true);
    Get.bottomSheet(
        DeleteOrTirmnateBottomSheet(
          box: itemViewModle.operationsBox ?? widget.box,
        ),
        isScrollControlled: true);
  }

  onShareBoxClick() {
    itemViewModle.shareBox(box: itemViewModle.operationsBox ?? widget.box);
  }
}
