import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/bottom_sheet_payment_widaget.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/giveaway_box_process%20.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/recall_box_process%20.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:logger/logger.dart';

import '../../../../../../util/app_shaerd_data.dart';
import '../box_in_task_widget.dart';

class TaskWidgetBS extends StatelessWidget {
  const TaskWidgetBS({Key? key, required this.task}) : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();
  static ItemViewModle itemViewModle = Get.find<ItemViewModle>();

  final Task task;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    Logger().d(homeViewModel.userBoxess);
    return Container(
      margin: EdgeInsets.only(top: sizeH50!),
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      decoration: containerBoxDecoration().copyWith(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(padding30!))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: sizeH20,
          ),
          SpacerdColor(),
          SizedBox(
            height: sizeH14,
          ),
          Text(
            "${task.taskName}",
            style: textStyleAppBarTitle(),
          ),
          SizedBox(
            height: sizeH14,
          ),
          Expanded(child: getListViewByBoxStatus()),
          SizedBox(
            height: sizeH9,
          ),
          GetBuilder<HomeViewModel>(
            init: HomeViewModel(),
            initState: (_) {},
            builder: (_) {
              return PrimaryButton(
                  colorBtn: homeViewModel.selctedOperationsBoxess.length > 0
                      ? colorPrimary
                      : colorUnSelectedWidget,
                  textButton: tr.next,
                  isLoading: false,
                  onClicked: homeViewModel.selctedOperationsBoxess.length > 0
                      ? () {
                          if (task.id == LocalConstance.giveawayId) {
                            Get.bottomSheet(
                                    GiveawayBoxProcessSheet(
                                      box: homeViewModel.selctedOperationsBoxess
                                          .toList()[0],
                                      boxes: homeViewModel
                                          .selctedOperationsBoxess
                                          .toList(),
                                    ),
                                    isScrollControlled: true)
                                .whenComplete(() {
                              storageViewModel.imageBankTransfer = null;
                              storageViewModel.update();
                            });
                          } else if ((task.id == LocalConstance.destroyId ||
                                  task.id == LocalConstance.terminateId) &&
                              !(storageViewModel.doseBoxInHome(
                                boxess: homeViewModel.selctedOperationsBoxess
                                    .toList(),
                              ))) {
                            Get.bottomSheet(
                                BottomSheetPaymentWidget(
                                  beneficiaryId: "",
                                  box: homeViewModel.selctedOperationsBoxess
                                      .toList()[0],
                                  boxes: homeViewModel.selctedOperationsBoxess
                                      .toList(),
                                  task: task,
                                ),
                                isScrollControlled: true);
                          } else {
                            Get.bottomSheet(
                                    RecallBoxProcessSheet(
                                      box: homeViewModel.selctedOperationsBoxess.toList()[0],
                                      boxes: homeViewModel.selctedOperationsBoxess.toList(),
                                      task: task,
                                      isFirstPickUp: homeViewModel.selctedOperationsBoxess.toList()[0].firstPickup! && task.id == LocalConstance.pickupId,
                                    ),
                                    isScrollControlled: true)
                                .whenComplete(
                                    () => homeViewModel.selectedAddres = null);
                          }
                        }
                      : () {},
                  isExpanded: true);
            },
          ),
          SizedBox(
            height: sizeH9,
          ),
        ],
      ),
    );
  }

  Widget getListViewByBoxStatus() {
    if (task.id == LocalConstance.destroyId ||
        task.id == LocalConstance.terminateId) {
      return ListView(
          primary: false,
          shrinkWrap: true,
          physics: customScrollViewIOS(),
          children: homeViewModel.userBoxess
              .map((e) => e.allowed ?? false
                  ? BoxInTaskWidget(
                      box: e,
                    )
                  : const SizedBox())
              .toList());
    } else if (task.id == LocalConstance.recallId) {
      return ListView(
          primary: false,
          shrinkWrap: true,
          physics: customScrollViewIOS(),
          children: homeViewModel.userBoxess
              .map((e) => (e.storageStatus == LocalConstance.boxinWareHouse &&
                      e.allowed!)
                  ? BoxInTaskWidget(
                      box: e,
                    )
                  : const SizedBox())
              .toList());
    } else if (task.id == LocalConstance.pickupId) {
      return ListView(
          primary: false,
          shrinkWrap: true,
          physics: customScrollViewIOS(),
          children: homeViewModel.userBoxess
              .map((e) =>
                  (e.storageStatus == LocalConstance.boxAtHome && e.allowed!)
                      ? BoxInTaskWidget(
                          box: e,
                        )
                      : const SizedBox())
              .toList());
    } else if (task.id == LocalConstance.giveawayId) {
      return ListView(
          primary: false,
          shrinkWrap: true,
          physics: customScrollViewIOS(),
          children: homeViewModel.userBoxess
              .map((e) =>
                  (e.storageStatus != LocalConstance.boxAtHome && e.allowed!)
                      ? BoxInTaskWidget(
                          box: e,
                        )
                      : const SizedBox())
              .toList());
    } else {
      return Text("");
    }
  }
}
// if sales Order is == null : enable Operations
