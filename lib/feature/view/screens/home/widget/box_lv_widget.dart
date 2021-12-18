import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/details_storage_view.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

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
              itemBuilder: (context, index) => HomeLVItemWidget(
                box: homeViewModel.userBoxess.toList()[index],
              ),
            ),
          ],
        );
      },
    );
  }
}
