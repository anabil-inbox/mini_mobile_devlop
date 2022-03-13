import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/scan_recived_order_screen.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/box_on_order_item.dart';
import 'dart:math' as math;
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

class ScanBoxInstantOrder extends StatelessWidget {
  const ScanBoxInstantOrder({Key? key, required this.homeViewModel})
      : super(key: key);

  final HomeViewModel homeViewModel;
  // static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sizeW15!, vertical: sizeH13!),
      decoration: BoxDecoration(
        color: colorTextWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpandablePanel(
        theme: const ExpandableThemeData(
          hasIcon: false,
          alignment: Alignment.topLeft,
          tapHeaderToExpand: true,
        ),
        header: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: colorBtnGray.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(padding4!),
              child: Transform.rotate(
                angle: 180 * math.pi / 180,
                child: Icon(
                  Icons.keyboard_arrow_up,
                  color: colorBlack,
                  size: 20,
                ),
              ),
            ),
            SizedBox(width: sizeW10),
            CustomTextView(
              txt: tr.scan_box,
              textStyle: textStyleNormal()?.copyWith(color: colorBlack),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Get.to(() => ScanRecivedOrderScreen(
                      isBox: true,
                      isProduct: false,
                      isScanDeliverdBoxes: false,
                    ));
              },
              child: SvgPicture.asset("assets/svgs/Scan.svg",
                  color: colorRed, width: sizeW20, height: sizeH17),
            ),
          ],
        ),
        collapsed: const SizedBox.shrink(),
        expanded: (homeViewModel.operationTask.customerScanned == null ||
                homeViewModel.operationTask.customerScanned!.isEmpty)
            ? const SizedBox()
            : Column(
                children: [
                  SizedBox(height: sizeH14),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: sizeW20!, vertical: sizeH17!),
                    decoration: BoxDecoration(
                      color: colorSearchBox,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GetBuilder<HomeViewModel>(
                      init: homeViewModel,
                      builder: (home) {
                        if (homeViewModel.operationTask.customerScanned ==
                                null ||
                            homeViewModel
                                .operationTask.customerScanned!.isEmpty) {
                          return const SizedBox();
                        } else {
                          return ListView(
                              shrinkWrap: true,
                              primary: false,
                              children:
                                  homeViewModel.operationTask.customerScanned!
                                      .map((e) => BoxOnOrderItem(
                                            boxModel: e,
                                          ))
                                      .toList());
                        }
                      },
                    ),
                  ),
                  SizedBox(height: sizeH10),
                ],
              ),
      ),
    );
  }
}
