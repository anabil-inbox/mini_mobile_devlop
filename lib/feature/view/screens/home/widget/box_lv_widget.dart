import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/constance/constance.dart';

import 'box_lv_item_widget.dart';

class LVWidget extends StatelessWidget {
  const LVWidget({Key? key}) : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      initState: (_) {},
      builder: (_) {
        return Column(
          children: [
            ListView.builder(
              controller: homeViewModel.scrollcontroller,
              physics: NeverScrollableScrollPhysics(),
              itemCount: homeViewModel.userBoxess.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Get.put(ItemViewModle());
                  if (homeViewModel.userBoxess.toList()[index].storageStatus ==
                      LocalConstance.boxOnTheWay) {
                    // Get.to(() => ItemScreen(box: homeViewModel.userBoxess.toList()[index],));
                    print("object");
                  }
                  //   Get.to(() => ItemScreen(box: homeViewModel.userBoxess.toList()[index],));
                },
                child: HomeLVItemWidget(
                  box: homeViewModel.userBoxess.toList()[index],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
