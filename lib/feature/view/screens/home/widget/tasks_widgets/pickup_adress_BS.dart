import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/view/screens/home/widget/tasks_widgets/pickup_address.dart';
import 'package:inbox_clients/feature/view/screens/home/widget/tasks_widgets/task_pickup_address_BS.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

import 'box_header_widget.dart';

class PickupAddressBSWidget extends StatelessWidget {
  const PickupAddressBSWidget({Key? key , required this.task}) : super(key: key);
final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(padding30!)),
          color: colorBackground),
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: sizeH20,
          ),
          SpacerdColor(),
          SizedBox(
            height: sizeH20,
          ),
          BoxHeaderWidget(boxTitle: "Work Meeting Notes"),
          SizedBox(
            height: sizeH16,
          ),
          PickupAdressTaskWidget(),
          SizedBox(
            height: sizeH16,
          ),
          Text("PickUp Adress"),
          SizedBox(
            height: sizeH16,
          ),
          TaskPickupAddressBS(task: task,)
        ],
      ),
    );
  }
}
