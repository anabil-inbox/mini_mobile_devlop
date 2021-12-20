import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:inbox_clients/feature/view/screens/add_item/item_screen.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/details_storage_view.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

import 'box_gv_item_widget.dart';

class GVWidget extends StatelessWidget {
  const GVWidget({Key? key}) : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Column(
      children: [
        GridView.builder(
          controller: homeViewModel.scrollcontroller,
          physics: NeverScrollableScrollPhysics(),
          itemCount: homeViewModel.userBoxess.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: sizeW10!,
              crossAxisSpacing: sizeH10!,
              childAspectRatio: (sizeW165! / sizeH150)),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              Get.put(ItemViewModle());
              Get.to(() => ItemScreen(box: homeViewModel.userBoxess.toList()[index],));
            },
            child: HomeGVItemWidget(
              box: homeViewModel.userBoxess.toList()[index],
            ),
          ),
        ),
      ],
    );
  }
}
