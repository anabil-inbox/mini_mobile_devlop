import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance/constance.dart';

import 'box_in_task_widget.dart';

class TaskWidgetBS extends StatelessWidget {
  const TaskWidgetBS({Key? key, required this.task}) : super(key: key);
  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          getListViewByBoxStatus(),
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
                  textButton: "Next",
                  isLoading: false,
                  onClicked: () {
                    
                  },
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
        task.id == LocalConstance.giveawayId ||
        task.id == LocalConstance.terminateId) {
      return ListView(
          primary: false,
          shrinkWrap: true,
          children: homeViewModel.userBoxess
              .map((e) => BoxInTaskWidget(
                    box: e,
                  ))
              .toList());
    } else if (task.id == LocalConstance.recallId) {
      return ListView(
          primary: false,
          shrinkWrap: true,
          children: homeViewModel.userBoxess
              .map((e) => e.storageStatus == LocalConstance.boxinWareHouse
                  ? BoxInTaskWidget(
                      box: e,
                    )
                  : const SizedBox())
              .toList());
    } else if (task.id == LocalConstance.pickupId) {
      return ListView(
          primary: false,
          shrinkWrap: true,
          children: homeViewModel.userBoxess
              .map((e) => e.storageStatus == LocalConstance.boxAtHome
                  ? BoxInTaskWidget(
                      box: e,
                    )
                  : const SizedBox())
              .toList());
    } else {
      return Text("data");
    }
  }
}
