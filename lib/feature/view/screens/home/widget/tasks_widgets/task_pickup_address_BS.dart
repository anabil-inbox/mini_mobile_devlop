import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/constance/constance.dart';

class TaskPickupAddressBS extends StatelessWidget {
  const TaskPickupAddressBS({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    if (task.id == LocalConstance.recallId) {
      return GetBuilder<ProfileViewModle>(
        init: ProfileViewModle(),
        initState: (_) {},
        builder: (profile) {

          return ListView(
              children: profile.userAddress.map((e) => Text("data")).toList(),
            ); 
        },
      
      );
    } else if (task.id == LocalConstance.pickupId) {
      return Text("WarHouses Address");
    } else {
      return Text("");
    }
  }
}
