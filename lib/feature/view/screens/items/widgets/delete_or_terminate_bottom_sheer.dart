import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/bottom_sheet_payment_widaget.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/recall_box_process%20.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_button%20copy.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance/constance.dart';

class DeleteOrTirmnateBottomSheet extends StatelessWidget {
  const DeleteOrTirmnateBottomSheet({Key? key, required this.box})
      : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  static ItemViewModle itemViewModle = Get.find<ItemViewModle>();
  final Box box;

  Widget get destroyButton => SeconderyButtom(
        textButton: "${tr.destory}",
        onClicked: () {
          final enterdTask =
              homeViewModel.searchTaskById(taskId: LocalConstance.destroyId);
          if (box.storageStatus == LocalConstance.boxinWareHouse) {
            Get.bottomSheet(
                BottomSheetPaymentWidget(
                  beneficiaryId: "",
                  box: box,
                  boxes: [box],
                  task: enterdTask,
                ),
                isScrollControlled: true);
          } else {
            Get.bottomSheet(
                RecallBoxProcessSheet(
                  boxes: [itemViewModle.operationsBox!],
                  box: itemViewModle.operationsBox,
                  task: enterdTask,
                ),
                isScrollControlled: true);
          }
        },
        isExpanded: true,
      );

  Widget get terminatButton => SeconderyButtom(
        textButton: "${tr.terminate}",
        onClicked: () {
          final enterdTask = homeViewModel.searchTaskById(taskId: LocalConstance.terminateId);
          if (box.storageStatus == LocalConstance.boxinWareHouse) {
            Get.bottomSheet(
                BottomSheetPaymentWidget(
                  beneficiaryId: "",
                  box: box,
                  boxes: [box],
                  task: enterdTask,
                ),
                isScrollControlled: true);
          } else {
            Get.bottomSheet(
                RecallBoxProcessSheet(
                  boxes: [box],
                  box: box,
                  task: enterdTask,
                ),
                isScrollControlled: true);
          }
        },
        isExpanded: true,
      );

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      decoration: containerBoxDecoration(),
      padding: EdgeInsets.symmetric(horizontal: padding16!),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: sizeH10,
          ),
          SpacerdColor(),
          SizedBox(
            height: sizeH10,
          ),
          destroyButton,
          SizedBox(
            height: sizeH10,
          ),
          terminatButton,
          SizedBox(
            height: sizeH10,
          ),
        ],
      ),
    );
  }
}
