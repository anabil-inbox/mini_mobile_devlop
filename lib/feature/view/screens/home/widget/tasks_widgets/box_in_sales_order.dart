// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/util/app_dimen.dart';

import '../../../../../../util/app_shaerd_data.dart';

class BoxInSalesOrder extends StatelessWidget {
   BoxInSalesOrder({Key? key, required this.box, required this.boxess})
      : super(key: key);

  final Box box;
  final List<Box> boxess;
  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      initState: (_) {},
      builder: (_) {
        return InkWell(
          onTap: () {
            homeViewModel.selctedOperationsBoxess.remove(box);
            boxess.remove(box);
            if (homeViewModel.selctedOperationsBoxess.length == 0) {
              Get.back();
            }
            homeViewModel.update();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: sizeH22,
                ),
                Stack(
                  children: [
                    SvgPicture.asset("assets/svgs/folder_icon.svg"),
                    PositionedDirectional(
                        top: padding4,
                        end: padding4,
                        start: padding4,
                        bottom: padding4,
                        child: SvgPicture.asset(
                                "assets/svgs/delete_cross.svg"))
                  ],
                ),
                SizedBox(
                  height: sizeH6,
                ),
                Text("${box.storageName}"),
                SizedBox(
                  height: sizeH2,
                ),
                SizedBox(
                  height: sizeH16,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
