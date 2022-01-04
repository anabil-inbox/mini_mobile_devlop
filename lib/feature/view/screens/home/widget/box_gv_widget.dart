import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:inbox_clients/feature/view/screens/items/item_screen.dart';
import 'package:inbox_clients/feature/view/screens/items/widgets/notifay_for_new_storage.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:logger/logger.dart';

import 'box_gv_item_widget.dart';

// ignore: must_be_immutable
class GVWidget extends StatelessWidget {
  GVWidget({Key? key}) : super(key: key);

  HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Column(
      children: [
        GridView.builder(
          controller: homeViewModel.scrollcontroller,
          physics: NeverScrollableScrollPhysics(),
          itemCount: homeViewModel.userBoxess.toList().length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: sizeW10!,
              crossAxisSpacing: sizeH10!,
              childAspectRatio: (sizeW165! / sizeH150)),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              Get.put(ItemViewModle());
              Logger().d(homeViewModel.userBoxess.toList()[index].toString());
              if (homeViewModel.userBoxess.toList()[index].storageStatus == LocalConstance.boxOnTheWay) {
                  Get.bottomSheet(
                    NotifayForNewStorage(box: homeViewModel.userBoxess.toList()[index],showQrScanner: true, index:index ),
                    isScrollControlled: true
                  );
              }else{
                Get.to(() =>
                    ItemScreen(box: homeViewModel.userBoxess.toList()[index]));
                homeViewModel.update();
              }
              
              // Get.to(() =>
              //     ItemScreen(box: homeViewModel.userBoxess.toList()[index]));
              // homeViewModel.update();
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
