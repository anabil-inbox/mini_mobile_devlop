import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/utils.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/screens/items/widgets/empty_body_box_item.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/btn_action_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/items_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/recent_item_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/text_with_contanier_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/widget/back_btn_widget.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/bottom_sheet_payment_widaget.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/giveaway_box_process%20.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/recall_box_process%20.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/recall_items_storage.dart';
import 'package:inbox_clients/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';

import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:logger/logger.dart';

import 'filter_items/filter_item_screen.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({Key? key,required this.box, this.getBoxDataMethod}) : super(key: key);

  //ItemViewModle get itemViewModle => Get.put(ItemViewModle());
  final Box box;
  final Function()? getBoxDataMethod;

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
   ItemViewModle itemViewModle = Get.find<ItemViewModle>();

   @override
   initState(){
   super.initState();
   WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
     widget.getBoxDataMethod!();
   });
 }
  // Search Widget =>
  Widget get searchWidget =>
      CustomTextFormFiled(
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
  Widget get headItemWidget =>
      Row(
        children: [
          TextButton(
              onPressed: () {
                itemViewModle.showAddItemBottomSheet(box: widget.box);
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
            onPressed: () {
              // itemViewModle.listIndexSelected.clear();
              // itemViewModle.isSelectAllClick = false;
              // itemViewModle.isSelectBtnClick = true;
              // itemViewModle.search = "";
              Get.delete<ItemViewModle>( );
              Get.to(() =>
                  FilterItemScreen(
                    title: "${tr.filter_by_name}",
                    serail: widget.box.serialNo,
                      box:widget.box
                  ));
            },
            icon: TextContainerWidget(
              colorBackground: colorRedTrans,
              txt: tr.name,
            ),
          ),
        ],
      );

  PreferredSizeWidget get myAppbar =>
      AppBar(
        backgroundColor: colorBackground,
        actions: [
          IconButton(
              onPressed: () {
                itemViewModle.isUpdateBoxDetails = true;
                if (itemViewModle.isLoading) {

                } else {
                  itemViewModle.showUpdatBoxBottomSheet(
                      box: widget.box, isUpdate: true);
                }
              },
              icon: SvgPicture.asset("assets/svgs/update.svg")),
          Center(
            child:InkWell(
                onTap: () {
                  // itemViewModle.listIndexSelected.clear();
                  // itemViewModle.isSelectAllClick = false;
                  // itemViewModle.isSelectBtnClick = true;
                  // itemViewModle.search = "";
                  Get.delete<ItemViewModle>( );
                  Get.to(/*() =>*/
                      FilterItemScreen(
                        title: "Select Items",
                        serail: widget.box.serialNo,
                          box:widget.box
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
          // init: ItemViewModle(),
          initState: (_) {
            itemViewModle.operationsBox?.storageName = "";
          },
          builder: (_) {
            if(!_.isUpdateBoxDetails){
              return Builder(
                builder: (_) {
                  if (GetUtils.isNull(widget.box)) {
                    return Text("");
                  } else {
                    return Text(
                      "${widget.box.storageName!.isEmpty
                          ? ""
                          : widget.box.storageName}",
                      style: textStyleAppBarTitle(),
                      maxLines: Constance.maxLineTwo,
                      textAlign: TextAlign.center,
                    );
                  }
                },
              );
            }else if (GetUtils.isNull(itemViewModle.operationsBox)) {
              return Text("");
            } else {
              return Text(
                "${itemViewModle.operationsBox!.storageName!.isEmpty
                    ? ""
                    : itemViewModle.operationsBox!.storageName}",
                style: textStyleAppBarTitle(),
                maxLines: Constance.maxLineTwo,
                textAlign: TextAlign.center,
              );
            }
          },
        )
      );

  Widget get recentlyAddedWidget => Align(
    alignment: isArabicLang() ? Alignment.centerRight:Alignment.centerLeft,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextView(
          txt: "${tr.recently_added}",
          textStyle: textStyleNormal()?.copyWith(color: colorBlack),
          maxLine: Constance.maxLineOne,
        ),
        SizedBox(
          height: sizeH10,
        ),
        GetBuilder<ItemViewModle>(
          //assignId: true,
          //init: controller,
          initState: (state) {

          },
          builder: (logi) {
            try {
              if (itemViewModle.operationsBox?.items == null)
                return const SizedBox.shrink();
              return SizedBox(
                height: sizeH180,
                child: ListView.builder(
                  clipBehavior: Clip.none,
                  physics: customScrollViewIOS(),
                  itemCount: itemViewModle.operationsBox!.items!.length >= 5 ? 5 : itemViewModle
                      .operationsBox?.items?.length,
                  shrinkWrap: true,
                  keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    try {
                      if (itemViewModle.search.isEmpty) {
                        return RecentlyItemWidget(
                          box: itemViewModle.operationsBox!,
                          boxItem: itemViewModle.operationsBox!.items![index],
                        );
                      } else if (itemViewModle.operationsBox!.items![index].itemName!
                          .toLowerCase().contains(itemViewModle.search)) {
                        return RecentlyItemWidget(
                          box: itemViewModle.operationsBox!,
                          boxItem: itemViewModle.operationsBox!.items![index],
                        );
                      } else {
                        return const SizedBox();
                      }
                    } catch (e) {
                      print(e);
                      Logger().d(e);
                      return const SizedBox.shrink();
                    }
                  },
                ),
              );
            } catch (e) {
              print(e);
              Logger().e(e);
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    ),
  );

  Widget get itemLVWidget =>
      GetBuilder<ItemViewModle>(
        builder: (logic) {
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
                        boxItem: itemViewModle.operationsBox!.items![index],
                      );
                    } else
                    if (itemViewModle.operationsBox!.items![index].itemName!
                        .toLowerCase().contains(itemViewModle.search)) {
                      return ItemsWidget(
                        box: itemViewModle.operationsBox!,
                        boxItem: itemViewModle.operationsBox!.items![index],
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
                    } else
                    if (itemViewModle.operationsBox!.items![index].itemName!
                        .toLowerCase().contains(
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
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: myAppbar,
      body: GetBuilder<ItemViewModle>(
        init: ItemViewModle(),
        initState: (_) async {
          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
            await itemViewModle.getBoxBySerial(serial: widget.box.serialNo ?? "");
            //itemViewModle.update();
          });
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
                    height: sizeH20,
                  ),
                  recentlyAddedWidget,
                  SizedBox(
                    height: sizeH20,
                  ),
                  headItemWidget,
                  SizedBox(
                    height: sizeH10,
                  ),
                  itemLVWidget,
                  BtnActionWidget(
                    redBtnText: widget.box.storageStatus == LocalConstance.boxAtHome
                        ? "${tr.pickup}"
                        : "${tr.recall}",
                    onShareBox: onShareBoxClick,
                    onGrayBtnClick: onGrayBtnClick,
                    onRedBtnClick: onRedBtnClick,
                    onDeleteBox: onDeleteBoxClick,
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

  onGrayBtnClick() {
    Get.bottomSheet(GiveawayBoxProcessSheet(box: widget.box),
        isScrollControlled: true);
  }

  onRedBtnClick() {
    if (widget.box.storageStatus == LocalConstance.boxAtHome) {
      //todo this if pickup
      Get.bottomSheet(RecallBoxProcessSheet(box: widget.box),
          isScrollControlled: true);
    } else {
      //todo this if recall
      // Get.bottomSheet(RecallBoxProcessSheet(box: widget.box),
      //     isScrollControlled: true);
      Get.bottomSheet(RecallStorageSheet(box: widget.box),
          isScrollControlled: true);
    }
  }

  onDeleteBoxClick() {
    // Get.bottomSheet(BottomSheetPaymentWidget(),
    //     isScrollControlled: true);
  }

  onShareBoxClick() {
    itemViewModle.shareBox(box: widget.box);
  }
}

