import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/home/recived_order/widget/product_on_order_item.dart';
import 'dart:math' as math;
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

class ScanProducts extends StatelessWidget {
  const ScanProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sizeW15!, vertical: sizeH13!),
      decoration: BoxDecoration(
        color: colorTextWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: GetBuilder<HomeViewModel>(
        // assignId: true,
        builder: (home) {
          return ExpandablePanel(
            controller: home.expandableController,
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
                  txt: tr.scan_products,
                  textStyle: textStyleNormal()?.copyWith(color: colorBlack),
                ),
               
              ],
            ),
            collapsed: const SizedBox.shrink(),
            expanded: (home.operationTask.childOrder == null ||
                    home.operationTask.childOrder!.items!.isEmpty)
                ? const SizedBox()
                : ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: home.operationTask.childOrder!.items!
                        .map((e) => ProductOnOrderItem(
                              productModel: e,
                            ))
                        .toList(),
                  ),
            // Builder(
            //   builder: (context) {
            //     try {
            //       if (SharedPref.instance.getCurrentTaskResponse()!.childOrder!.items!.isEmpty) {
            //         return const SizedBox();
            //       } else {
            //         return ListView(
            //           shrinkWrap: true,
            //           primary: false,
            //           children: SharedPref.instance.getCurrentTaskResponse()!.childOrder
            //           !.items!.map((e) => ProductOnOrderItem(
            //                 productModel: e,
            //               ))
            //               .toList(),
            //         );
            //       }
            //     } catch (e) {
            //       return const SizedBox();
            //     }
            //   },
            // ),
          );
        },
      ),
    );
  }
}
