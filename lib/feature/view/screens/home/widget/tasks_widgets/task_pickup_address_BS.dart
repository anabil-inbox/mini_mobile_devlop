import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/view/screens/home/widget/tasks_widgets/pickup_address_item.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/step_two_widgets/pickup_address_item.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/constance/constance.dart';

class TaskPickupAddressBS extends StatelessWidget {
  const TaskPickupAddressBS({Key? key, required this.task}) : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  final Task task;

  @override
  Widget build(BuildContext context) {
    if (task.id == LocalConstance.recallId) {
      return GetBuilder<ProfileViewModle>(
        init: ProfileViewModle(),
        initState: (_) {},
        builder: (profile) {
          return Container(
            decoration: BoxDecoration(
                border: Border.all(color: colorContainerGray),
                borderRadius: BorderRadius.circular(padding6!)
              ),
            child: ListView(
              shrinkWrap: true,
              primary: false,
              children: profile.userAddress
                  .map((e) => PickupAddressItem(
                        address: e,
                      ))
                  .toList(),
            ),
          );
        },
      );
    } else if (task.id == LocalConstance.pickupId) {
      return GetBuilder<HomeViewModel>(
        init: HomeViewModel(),
        initState: (_) {
          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
            await homeViewModel.getStoreAddress();
          });
        },
        builder: (home) {
          if (home.isLoadingGetAddress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: colorContainerGray),
                borderRadius: BorderRadius.circular(padding6!)
              ),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                children: home.storeAddress
                    .map((e) => (GetUtils.isNull(e.addresses) || e.addresses!.isEmpty)
                        ? const SizedBox()
                        : TaskPickupAddress(
                            address: e.addresses![0],
                          ))
                    .toList(),
              ),
            );
          }
        },
      );
    } else {
      return Text("");
    }
  }
}
