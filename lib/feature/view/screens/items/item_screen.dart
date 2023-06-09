import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/view/screens/items/widgets/delete_or_terminate_bottom_sheer.dart';
import 'package:inbox_clients/feature/view/screens/items/widgets/empty_body_box_item.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/order_details_screen.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/btn_action_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/items_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/recent_item_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/text_with_contanier_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/widget/back_btn_widget.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/giveaway_box_process%20.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/recall_box_process%20.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';

import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../widgets/custom_text_filed.dart';
import 'filter_items/filter_item_screen.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen(
      {Key? key,
      required this.box,
      this.getBoxDataMethod,
      this.isEnabeld = true})
      : super(key: key);

  ItemViewModle get itemViewModle => Get.put(ItemViewModle(), permanent: true);

  HomeViewModel get homeViewModel => Get.put(HomeViewModel(), permanent: true);
  final Box box;
  final Function()? getBoxDataMethod;
  final bool isEnabeld;

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  ItemViewModle itemViewModle = Get.find<ItemViewModle>();

  HomeViewModel get homeViewModel => Get.find<HomeViewModel>();

  @override
  initState() {
    super.initState();
    Logger().d(widget.box.toJson());
    Logger().d(itemViewModle.operationsBox?.toJson());
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      // await widget.getBoxDataMethod!();
      // Get.delete<ItemViewModle>();
      await itemViewModle.getBoxBySerial(
          serial:
              "${widget.box.serialNo != null && widget.box.serialNo!.isNotEmpty ? widget.box.serialNo : widget.box.id ?? ""}");
    });
  }

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
          // if(itemViewModle.operationsBox!.allowed! /*&& itemViewModle.operationsBox?.storageStatus == LocalConstance.boxAtHome*/)
          TextButton(
              onPressed: () {
                itemViewModle.showAddItemBottomSheet(box: widget.box);
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/svgs/add_icons_orange.svg" /*red_add.svg*/,
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
              Get.delete<ItemViewModle>();
              Get.to(() => FilterItemScreen(
                  isEnable: widget.isEnabeld,
                  title: "${tr.filter_by_name}",
                  serail: widget.box.serialNo,
                  box: widget.box));
            },
            icon: TextContainerWidget(
              colorBackground: colorRedTrans,
              txt: tr.name,
            ),
          ),
        ],
      );

  PreferredSizeWidget get myAppbar => AppBar(
      backgroundColor: colorBackground,
      actions: [
        IconButton(
            onPressed: () {
              itemViewModle.isUpdateBoxDetails = true;
              if (!itemViewModle.isLoading) {
                itemViewModle.showUpdatBoxBottomSheet(
                    box: itemViewModle.operationsBox ?? widget.box,
                    isUpdate: true);
              }
            },
            icon: SvgPicture.asset(
                "assets/svgs/update_icon_orange.svg") /*update*/),
        (widget.box.storageStatus == LocalConstance.boxAtHome ||
                itemViewModle.operationsBox?.storageStatus ==
                    LocalConstance.boxAtHome ||
                !widget.box.allowed!)
            ? const SizedBox()
            : Center(
                child: InkWell(
                    onTap: () {
                      // itemViewModle.listIndexSelected.clear();
                      // itemViewModle.isSelectAllClick = false;
                      // itemViewModle.isSelectBtnClick = true;
                      // itemViewModle.search = "";
                      Get.delete<ItemViewModle>();
                      Get.to(/*() =>*/
                          FilterItemScreen(
                              title: "Select Items",
                              serail: widget.box.serialNo,
                              box: widget.box));
                    },
                    child: SvgPicture.asset(
                        "assets/svgs/select_all_no_background.svg")),
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
        autoRemove: false,
        initState: (_) {
          itemViewModle.operationsBox?.storageName = "";
          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
            itemViewModle.allowedClear = true;
            itemViewModle.update();
          });
        },
        builder: (build) {
          if (build.isLoading) {
            return const SizedBox();
          } else {
            return Text(
              "${build.operationsBox?.storageName ?? widget.box.storageName}",
              style: textStyleAppBarTitle(),
              maxLines: Constance.maxLineTwo,
              textAlign: TextAlign.center,
            );
          }

          // if (!_.isUpdateBoxDetails) {
          //   return Builder(
          //     builder: (_) {
          //       if (GetUtils.isNull(itemViewModle.operationsBox?.storageName )) {
          //         return Text(itemViewModle.operationsBox?.storageName ?? "");
          //       }
          //      else if (GetUtils.isNull(widget.box)) {
          //         return Text("");
          //       } else {
          //         return Text(
          //           "${widget.box.storageName!.isEmpty ? "" : widget.box.storageName}",
          //           style: textStyleAppBarTitle(),
          //           maxLines: Constance.maxLineTwo,
          //           textAlign: TextAlign.center,
          //         );
          //       }
          //     },
          //   );
          // } else if (GetUtils.isNull(itemViewModle.operationsBox)) {
          //   return Text("");
          // } else {
          //   return Text(
          //     "${itemViewModle.operationsBox!.storageName!.isEmpty ? "" : itemViewModle.operationsBox!.storageName}",
          //     style: textStyleAppBarTitle(),
          //     maxLines: Constance.maxLineTwo,
          //     textAlign: TextAlign.center,
          //   );
          // }
        },
      ));

  Widget get recentlyAddedWidget => Align(
        alignment:
            isArabicLang() ? Alignment.centerRight : Alignment.centerLeft,
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
              initState: (state) {},
              builder: (logi) {
                try {
                  if (itemViewModle.operationsBox?.items == null)
                    return const SizedBox.shrink();
                  return SizedBox(
                    height: sizeH180,
                    child: ListView.builder(
                      clipBehavior: Clip.none,
                      physics: customScrollViewIOS(),
                      itemCount: itemViewModle.operationsBox!.items!.length >= 5
                          ? 5
                          : itemViewModle.operationsBox?.items?.length,
                      shrinkWrap: true,
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        try {
                          if (itemViewModle.search.isEmpty) {
                            return RecentlyItemWidget(
                              box: itemViewModle.operationsBox!,
                              boxItem:
                                  itemViewModle.operationsBox!.items![index],
                            );
                          } else if (itemViewModle
                              .operationsBox!.items![index].itemName!
                              .toLowerCase()
                              .contains(itemViewModle.search)) {
                            return RecentlyItemWidget(
                              box: itemViewModle.operationsBox!,
                              boxItem:
                                  itemViewModle.operationsBox!.items![index],
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

  Widget get itemLVWidget => GetBuilder<ItemViewModle>(
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
                    } else if (itemViewModle
                        .operationsBox!.items![index].itemName!
                        .toLowerCase()
                        .contains(itemViewModle.search)) {
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
                    } else if (itemViewModle
                        .operationsBox!.items![index].itemName!
                        .toLowerCase()
                        .contains(itemViewModle.search.toLowerCase())) {
                      return Divider(
                        height: sizeH1,
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                  itemCount: itemViewModle.operationsBox!.items!.length),
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    Logger().d("test_${widget.box.storageStatus}");
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: myAppbar,
      body: GetBuilder<ItemViewModle>(
        autoRemove: false,
        initState: (_) async {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
            await itemViewModle.getBoxBySerial(
                serial: widget.box.serialNo ?? "");
            //itemViewModle.update();
          });
        },
        builder: (logic) {
          // homeViewModel.tasks.forEach((element) {
          //   Logger().w("${element.toJson() } \n${LocalConstance.giveawayId} \n${itemViewModle.operationsBox?.storageStatus}");
          // });

          if (logic.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (GetUtils.isNull(itemViewModle.operationsBox?.items) ||
              itemViewModle.operationsBox!.items!.isEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: padding20!),
              child: EmptyBodyBoxItem(
                isEnabel:
                    GetUtils.isNull(itemViewModle.operationsBox?.saleOrder),
                box: itemViewModle.operationsBox,
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
                  Row(
                    children: [
                      Expanded(child: searchWidget),
                      if (!(itemViewModle.operationsBox?.logSeals == null ||
                          itemViewModle.operationsBox!.logSeals!.isEmpty)) ...[
                        IconButton(
                            splashColor: colorTrans,
                            highlightColor: colorTrans,
                            onPressed: () {
                              itemViewModle.showSealssBottomSheet(
                                seals:
                                    itemViewModle.operationsBox!.logSeals ?? [],
                              );
                            },
                            icon: SvgPicture.asset(
                              "assets/svgs/seal.svg",
                              width: sizeW24,
                              height: sizeH22,
                            )),
                      ],
                      if (!(itemViewModle.operationsBox?.invoices == null ||
                          itemViewModle.operationsBox!.invoices!.isEmpty)) ...[
                        IconButton(
                            splashColor: colorTrans,
                            highlightColor: colorTrans,
                            onPressed: () {
                              itemViewModle.showInvoicesBottomSheet(
                                  operationsBox: itemViewModle.operationsBox,
                                  invoices:
                                      itemViewModle.operationsBox!.invoices ??
                                          []);
                            },
                            icon: SvgPicture.asset(
                              "assets/svgs/invoice.svg",
                              width: sizeW24,
                              height: sizeH22,
                            )),
                      ]
                    ],
                  ),
                  if(itemViewModle.operationsBox != null && itemViewModle.operationsBox!.subscription != null)...[
                    SizedBox(
                      height: sizeH20,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(sizeRadius16!),
                      margin: EdgeInsets.only(bottom: sizeH10!),
                      decoration: BoxDecoration(
                          color: colorBackground,
                          borderRadius: BorderRadius.circular(padding6!)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("${tr.subscriptions} : " , textAlign: TextAlign.start,),
                              Text("${itemViewModle.operationsBox!.subscription!.id}" , textAlign: TextAlign.start,),
                            ],
                          ),
                          SizedBox(
                            height: sizeH20,
                          ),
                          Text("${tr.duration_of_subscription} :"),
                          SizedBox(
                            height: sizeH12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("${tr.from} : ${DateFormat("yyyy-MM-dd").format(itemViewModle.operationsBox!.subscription!.startDate!)}  -  " , textAlign: TextAlign.center,),
                              Text("${tr.to} : ${DateFormat("yyyy-MM-dd").format(itemViewModle.operationsBox!.subscription!.latestInvoice!)}  " , textAlign: TextAlign.center,),
                            ],
                          ),
                          SizedBox(
                            height: sizeH20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("${tr.total_cost} :"),
                              Text("${formatStringWithCurrency(itemViewModle.operationsBox!.subscription!.total, "")}"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
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
                  (itemViewModle.operationsBox?.allowed ?? false)
                      ? BtnActionWidget(
                          isGaveAway:
                              (/*itemViewModle.operationsBox?.storageStatus == LocalConstance.giveawayId  &&*/
                                  /*itemViewModle.operationsBox?.storageStatus != LocalConstance.boxAtHome &&*/
                                  widget.homeViewModel.tasks
                                      .where((element) =>
                                          element.id ==
                                          LocalConstance.giveawayId)
                                      .isEmpty),
                          boxStatus:
                              itemViewModle.operationsBox!.storageStatus ?? "",
                          redBtnText: widget.box.storageStatus ==
                                  LocalConstance.boxAtHome
                              ? "${tr.pickup}"
                              : "${tr.recall}",
                          onShareBox: onShareBoxClick,
                          onGrayBtnClick: onGrayBtnClick,
                          onRedBtnClick: onRedBtnClick,
                          onDeleteBox: onDeleteBoxClick,
                        )
                      : itemViewModle.operationsBox?.saleOrder != null &&
                              itemViewModle.operationsBox!.saleOrder!.isNotEmpty
                          ? PrimaryButton(
                              textButton: tr.order_details,
                              isLoading: false,
                              onClicked: () {
                                Get.off(() => OrderDetailesScreen(
                                      orderId:
                                          "${itemViewModle.operationsBox?.saleOrder.toString()}",
                                      isFromPayment: false,
                                    ));
                              },
                              isExpanded: true)
                          : const SizedBox(),
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
    Get.bottomSheet(
        GiveawayBoxProcessSheet(
          box: itemViewModle.operationsBox ?? widget.box,
          boxes: [],
        ),
        isScrollControlled: true);
  }

  onRedBtnClick() {
    if (widget.box.storageStatus == LocalConstance.boxAtHome) {
      //todo this if pickup
      // to do get the Task and Show That VAS ::

      final Task enterdTask =
          widget.homeViewModel.searchTaskById(taskId: LocalConstance.pickupId);

      Get.bottomSheet(
          RecallBoxProcessSheet(
            boxes: [],
            isFirstPickUp: itemViewModle.operationsBox != null
                ? itemViewModle.operationsBox?.firstPickup
                : widget.box.firstPickup,
            box: itemViewModle.operationsBox ?? widget.box,
            task: enterdTask,
          ),
          isScrollControlled: true);
    } else {
      final Task enterdTask =
          widget.homeViewModel.searchTaskById(taskId: LocalConstance.recallId);

      Get.bottomSheet(
              RecallBoxProcessSheet(
                box: itemViewModle.operationsBox ?? widget.box,
                boxes: [],
                task: enterdTask,
                isFirstPickUp: itemViewModle.operationsBox != null
                    ? itemViewModle.operationsBox?.firstPickup
                    : widget.box.firstPickup,
              ),
              isScrollControlled: true)
          .whenComplete(() => homeViewModel.selectedAddres = null);

      // Get.bottomSheet(
      //     RecallBoxProcessSheet(
      //       boxes: [],
      //       isFirstPickUp: itemViewModle.operationsBox != null ?itemViewModle.operationsBox?.firstPickup :widget.box.firstPickup ,
      //       box: itemViewModle.operationsBox ?? widget.box,
      //       task: enterdTask,
      //     ),
      //     isScrollControlled: true);
    }
  }

  onDeleteBoxClick() {
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
