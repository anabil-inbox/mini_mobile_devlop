import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/view/screens/items/item_screen.dart';
import 'package:inbox_clients/feature/view/screens/items/widgets/notifay_for_new_storage.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/constance/constance.dart';

import 'box_lv_item_widget.dart';

class LVWidget extends StatelessWidget {
  const LVWidget({Key? key}) : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  static ItemViewModle itemViewModel = Get.find<ItemViewModle>();

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
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: homeViewModel.userBoxess.length,
              itemBuilder: (context, index) => homeViewModel.userBoxess
                          .toList()[index]
                          .saleOrder ==
                      null
                  ? InkWell(
                      highlightColor: colorTrans,
                      splashColor: colorTrans,
                      focusColor: colorTrans,
                      onTap: () {
                        Get.put(ItemViewModle());
                        // if (homeViewModel.userBoxess.toList()[index].storageStatus == LocalConstance.boxOnTheWay) {
                        //     Get.bottomSheet(
                        //       NotifayForNewStorage(box: homeViewModel.userBoxess.toList()[index],),
                        //       isScrollControlled: true
                        //     );
                        // }else{
                        //   Get.to(() => ItemScreen(box: homeViewModel.userBoxess.toList()[index]));
                        // }
                        if (homeViewModel.userBoxess
                                .toList()[index]
                                .storageStatus ==
                            LocalConstance.boxOnTheWay) {
                          Get.bottomSheet(
                              NotifayForNewStorage(
                                  box: homeViewModel.userBoxess.toList()[index],
                                  showQrScanner: true,
                                  index: index),
                              isScrollControlled: true);
                        } else {
                          Get.to(() => ItemScreen(
                                box: homeViewModel.userBoxess.toList()[index],
                                getBoxDataMethod: () async {
                                  await itemViewModel.getBoxBySerial(
                                      serial: homeViewModel.userBoxess
                                          .toList()[index]
                                          .serialNo!);
                                },
                              ));
                          homeViewModel.update();
                        }
                        // Get.to(() => ItemScreen(
                        //     box: homeViewModel.userBoxess.toList()[index]));
                        // homeViewModel.update();

                        // if (homeViewModel.userBoxess.toList()[index].storageStatus ==
                        //     LocalConstance.boxOnTheWay) {
                        //   // Get.to(() => ItemScreen(box: homeViewModel.userBoxess.toList()[index],));
                        //   print("object");
                        // }
                        // //   Get.to(() => ItemScreen(box: homeViewModel.userBoxess.toList()[index],));
                      },
                      child: HomeLVItemWidget(
                        box: homeViewModel.userBoxess.toList()[index],
                      ),
                    )
                  : HomeLVItemWidget(
                      isEnabeld: false,
                      box: homeViewModel.userBoxess.toList()[index],
                    ),
            ),
          ],
        );
      },
    );
  }
}
