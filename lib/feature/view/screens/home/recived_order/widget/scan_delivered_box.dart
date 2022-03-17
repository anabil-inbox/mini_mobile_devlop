import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/scan_recived_order_screen.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

import 'box_on_order_item.dart';

class ScanDeliveredBox extends StatelessWidget {
  const ScanDeliveredBox({Key? key}) : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetBuilder<HomeViewModel>(
      builder: (_) {
        return Container(
          padding:
              EdgeInsets.symmetric(horizontal: sizeW15!, vertical: sizeH13!),
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
                  txt: "Scan Delivered Box",
                  textStyle: textStyleNormal()?.copyWith(color: colorBlack),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    if (homeViewModel.operationTask.boxes?.length ==
                        homeViewModel.operationTask.customerDelivered?.length) {
                      snackError("", "You Scaned All Boxess Recived");
                    } else {
                      Get.to(() => ScanRecivedOrderScreen(
                            isScanDeliverdBoxes: true,
                            isBox: true,
                            isProduct: false,
                          ));
                    }
                  },
                  child: SvgPicture.asset("assets/svgs/Scan.svg",
                      color: colorRed, width: sizeW20, height: sizeH17),
                ),
              ],
            ),
            collapsed: const SizedBox.shrink(),
            expanded: (homeViewModel.operationTask.customerDelivered == null ||
                    homeViewModel.operationTask.customerDelivered!.isEmpty)
                ? const SizedBox()
                : Column(
                    children: [
                      SizedBox(height: sizeH14),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: sizeW20!, vertical: sizeH17!),
                        decoration: BoxDecoration(
                            color: colorSearchBox,
                            borderRadius: BorderRadius.circular(10)),
                        child: GetBuilder<HomeViewModel>(
                          builder: (home) {
                            if (home.operationTask.customerDelivered == null ||
                                home.operationTask.customerDelivered!.isEmpty) {
                              return const SizedBox();
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount: home
                                    .operationTask.customerDelivered?.length,
                                itemBuilder: (context, index) {
                                  return BoxOnOrderItem(
                                    boxModel: home.operationTask
                                        .customerDelivered![index],
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(height: sizeH14),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
