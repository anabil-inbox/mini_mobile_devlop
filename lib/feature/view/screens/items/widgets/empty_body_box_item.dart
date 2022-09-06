import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/view/screens/items/widgets/delete_or_terminate_bottom_sheer.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/order_details_screen.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/btn_action_widget.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/giveaway_box_process%20.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/recall_box_process%20.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:logger/logger.dart';

import '../../../../../util/constance.dart';
import '../../../widgets/custom_text_filed.dart';

class EmptyBodyBoxItem extends StatelessWidget {
  const EmptyBodyBoxItem({Key? key, required this.box, required this.isEnabel})
      : super(key: key);

  static ItemViewModle itemViewModle = Get.find<ItemViewModle>();
  static HomeViewModel _homeViewModel = Get.find<HomeViewModel>();

  final Box? box;
  final bool isEnabel;

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

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    Logger().w((itemViewModle.operationsBox?.allowed ?? false));
    Logger().w( box?.saleOrder != null );
     Logger().w(  box?.toJson());
    Logger().w( box?.serialNo != null && box!.serialNo!.isNotEmpty);
    return Padding(
      padding: EdgeInsets.all(0),
      child: Stack(
        children: [
          PositionedDirectional(
              top: padding0,
              bottom: padding0,
              start: padding0,
              end: padding0,
              child: SvgPicture.asset("assets/svgs/box_empty.svg" ,)),
          Column(
            children: [
              SizedBox(
                height: sizeH16,
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
                            seals: itemViewModle.operationsBox!.logSeals ?? [],
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
                              invoices: itemViewModle.operationsBox!.invoices ?? [],
                              operationsBox: itemViewModle.operationsBox);
                        },
                        icon: SvgPicture.asset(
                          "assets/svgs/invoice.svg",
                          width: sizeW24,
                          height: sizeH22,
                        )),
                  ]
                ],
              ),
            ],
          ),
          // if(itemViewModle.operationsBox!.allowed! /*&& itemViewModle.operationsBox?.storageStatus == LocalConstance.boxAtHome*/)
            PositionedDirectional(
            bottom: padding32,
            start: 0,
            end: 0,
            child: GetBuilder<ItemViewModle>(
              builder: (item) {
                if (item.operationsBox == null) {
                  return const SizedBox();
                }
                return Column(
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        itemViewModle.showAddItemBottomSheet(
                          box: box!,
                        );
                        // Get.bottomSheet(
                        //     AddItemWidget(
                        //       box: box,
                        //     ),
                        //     isScrollControlled: true);
                      },
                      backgroundColor: colorPrimary,
                      child: Icon(
                        Icons.add,
                        color: colorBackground,
                      ),
                    ),
                    SizedBox(
                      height: sizeH12,
                    ),
                    Text(
                      "${tr.add_your_item_in_box}",
                      style: textStyleHints(),
                    ),
                    SizedBox(
                      height: sizeH50,
                    ),


                    (itemViewModle.operationsBox?.allowed ?? false)
                        ? BtnActionWidget(
                      isGaveAway:
                      (/*itemViewModle.operationsBox?.storageStatus == LocalConstance.giveawayId  &&*/
                          /*itemViewModle.operationsBox?.storageStatus != LocalConstance.boxAtHome &&*/
                          _homeViewModel.tasks.where((element) => element.id == LocalConstance.giveawayId).isEmpty),
                      boxStatus: itemViewModle.operationsBox!.storageStatus ?? "",
                      redBtnText: box?.storageStatus == LocalConstance.boxAtHome
                          ? "${tr.pickup}"
                          : "${tr.recall}",
                      onShareBox: onShareBoxClick,
                      onGrayBtnClick: onGrayBtnClick,
                      onRedBtnClick: onRedBtnClick,
                      onDeleteBox: onDeleteBoxClick,
                    )
                        : box?.saleOrder != null && box!.saleOrder!.isNotEmpty ?PrimaryButton(textButton: tr.order_details,
                        isLoading: false,
                        onClicked: (){
                          Get.off(() => OrderDetailesScreen(
                            orderId: "${itemViewModle.operationsBox?.saleOrder.toString()}",
                            isFromPayment: false,
                          ));
                        },
                        isExpanded: true):const SizedBox(),
                    /*item.operationsBox?.saleOrder == null ||*/ /*(item
                        .operationsBox!.allowed! && item.operationsBox?.storageStatus == LocalConstance.boxAtHome) ? */
                   /* item.operationsBox!.allowed!?
                         PrimaryButton(
                            isExpanded: false,
                            isLoading: false,
                            onClicked: () {
                              final interdTask = _homeViewModel.searchTaskById(
                                  taskId: LocalConstance.pickupId);
                              Get.bottomSheet(
                                  RecallBoxProcessSheet(
                                      isFirstPickUp:box!.firstPickup! && interdTask.id == LocalConstance.pickupId,
                                      task: interdTask,
                                      box: itemViewModle.operationsBox ?? box!,
                                      boxes: [box!]),
                                  isScrollControlled: true);
                            },
                            textButton: tr.schedule_pickup,
                          )*//*,*/
                        //  Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        // PrimaryButton(
                        //   isExpanded: false,
                        //   isLoading: false,
                        //   onClicked: () {
                        //     final interdTask =
                        //         _homeViewModel.searchTaskById(
                        //             taskId: LocalConstance.pickupId);
                        //     Get.bottomSheet(
                        //         RecallBoxProcessSheet(
                        //             task: interdTask,
                        //             box: itemViewModle.operationsBox ??
                        //                 box!,
                        //             boxes: [box!]),
                        //         isScrollControlled: true);
                        //   },
                        //   textButton: tr.schedule_pickup,
                        // ),
                        //       SizedBox(
                        //         width: sizeW12,
                        //       ),
                        //       SizedBox(
                        //         width: sizeW150,
                        //         child: SeconderyFormButton(
                        //           buttonText: "${tr.ready_to_pickup}",
                        //           onClicked: () {
                        //             final interdTask =
                        //                 _homeViewModel.searchTaskById(
                        //                     taskId: LocalConstance.pickupId);
                        //             Get.bottomSheet(
                        //                 BottomSheetPaymentWidget(
                        //                     beneficiaryId: "",
                        //                     task: interdTask,
                        //                     box: itemViewModle.operationsBox ??
                        //                         box!,
                        //                     boxes: [box!]),
                        //                 isScrollControlled: true);
                        //           },
                        //         ),
                        //       ),
                        //     ],
                        //   )
                        /*: const SizedBox(),*/
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  onGrayBtnClick() {
    Get.bottomSheet(
        GiveawayBoxProcessSheet(
          box: itemViewModle.operationsBox ?? box!,
          boxes: [],
        ),
        isScrollControlled: true);
  }

  onRedBtnClick() {
    if (box?.storageStatus == LocalConstance.boxAtHome) {
      //todo this if pickup
      // to do get the Task and Show That VAS ::

      final Task enterdTask =
      _homeViewModel.searchTaskById(taskId: LocalConstance.pickupId);

      Get.bottomSheet(
          RecallBoxProcessSheet(
            boxes: [],
            isFirstPickUp: itemViewModle.operationsBox != null ?itemViewModle.operationsBox?.firstPickup :box?.firstPickup ,
            box: itemViewModle.operationsBox ?? box,
            task: enterdTask,
          ),
          isScrollControlled: true);
    } else {
      final Task enterdTask =
      _homeViewModel.searchTaskById(taskId: LocalConstance.recallId);


      Get.bottomSheet(
          RecallBoxProcessSheet(
            box: itemViewModle.operationsBox ?? box,
            boxes: [],
            task: enterdTask,
            isFirstPickUp: itemViewModle.operationsBox != null ?itemViewModle.operationsBox?.firstPickup :box?.firstPickup,
          ),
          isScrollControlled: true)
          .whenComplete(
              () => _homeViewModel.selectedAddres = null);

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
          box: itemViewModle.operationsBox ?? box!,
        ),
        isScrollControlled: true);
  }

  onShareBoxClick() {
    itemViewModle.shareBox(box: itemViewModle.operationsBox ?? box!);
  }

}
