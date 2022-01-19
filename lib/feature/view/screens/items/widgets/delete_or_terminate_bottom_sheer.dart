import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/recall_box_process%20.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_button%20copy.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance/constance.dart';

class DeleteOrTirmnateBottomSheet extends StatelessWidget {
  const DeleteOrTirmnateBottomSheet({Key? key}) : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  static ItemViewModle itemViewModle = Get.find<ItemViewModle>();

  @override
  Widget build(BuildContext context) {
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
          SeconderyButtom(
            textButton: "${tr.destory}",
            onClicked: () {
              final enterdTask = homeViewModel.searchTaskById(
                  taskId: LocalConstance.destroyId);
              Get.bottomSheet(
                  RecallBoxProcessSheet(
                    boxes: [itemViewModle.operationsBox!],
                    box: itemViewModle.operationsBox,
                    task: enterdTask,
                  ),
                  isScrollControlled: true);
            },
            isExpanded: true,
          ),
          SizedBox(
            height: sizeH10,
          ),
          SeconderyButtom(
            textButton: "${tr.terminate}",
            onClicked: () {
              final enterdTask = homeViewModel.searchTaskById(
                  taskId: LocalConstance.terminateId);
              Get.bottomSheet(
                  RecallBoxProcessSheet(
                    boxes: [itemViewModle.operationsBox!],
                    box: itemViewModle.operationsBox,
                    task: enterdTask,
                  ),
                  isScrollControlled: true);
            },
            isExpanded: true,
          ),
          SizedBox(
            height: sizeH10,
          ),
        ],
      ),
    );
  }
}
