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
  ItemViewModle itemViewModel = Get.put(ItemViewModle(), permanent: false);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Column(
      children: [
        GridView.builder(
          // controller: homeViewModel.scrollcontroller,
          physics: NeverScrollableScrollPhysics(),
          itemCount: homeViewModel.userBoxess.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: sizeW10!,
              crossAxisSpacing: sizeH10!,
              childAspectRatio: (sizeW150! / sizeH150)),
          itemBuilder: (context, index) => 
          
          (homeViewModel.userBoxess
                      .toList()[index]
                      .allowed ?? false)
              ? InkWell(
                  onTap: () async {
                    //Get.put(ItemViewModle());
                    Logger().d(homeViewModel.userBoxess.toList()[index].toString());
                    if (homeViewModel.userBoxess.toList()[index].storageStatus ==  LocalConstance.boxOnTheWay &&
                    !homeViewModel.userBoxess.toList()[index].isPickup!) {
                      Get.bottomSheet(
                          NotifayForNewStorage(
                              box: homeViewModel.userBoxess.toList()[index],
                              showQrScanner: true,
                              index: index),
                          isScrollControlled: true);
                      homeViewModel.update();
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
                      itemViewModel.update();
                    }

                    // Get.to(() =>
                    //     ItemScreen(box: homeViewModel.userBoxess.toList()[index]));
                    // homeViewModel.update();
                  },
                  child: HomeGVItemWidget(
                    box: homeViewModel.userBoxess.toList()[index],
                  ),
                )
             

              : InkWell(
                  onTap: () async {
                    //Get.put(ItemViewModle());
                    Logger()
                        .d(homeViewModel.userBoxess.toList()[index].toString());
                    if (homeViewModel.userBoxess.toList()[index].storageStatus ==  LocalConstance.boxOnTheWay &&
                        !homeViewModel.userBoxess.toList()[index].isPickup!) {
                      Get.bottomSheet(
                          NotifayForNewStorage(
                              box: homeViewModel.userBoxess.toList()[index],
                              showQrScanner: true,
                              index: index),
                          isScrollControlled: true);
                      homeViewModel.update();
                    } else {
                      Get.to(() => ItemScreen(
                            isEnabeld: false,
                            box: homeViewModel.userBoxess.toList()[index],
                            getBoxDataMethod: () async {
                              await itemViewModel.getBoxBySerial(
                                  serial: homeViewModel.userBoxess
                                      .toList()[index]
                                      .serialNo!);
                            },
                          ));
                      homeViewModel.update();
                      itemViewModel.update();
                    }

                    // Get.to(() =>
                    //     ItemScreen(box: homeViewModel.userBoxess.toList()[index]));
                    // homeViewModel.update();
                  },
                  child: HomeGVItemWidget(
                    isEnabeld: false,
                    box: homeViewModel.userBoxess.toList()[index],
                  ),
                ),
      
      
        ),
      ],
    );
  }
}
