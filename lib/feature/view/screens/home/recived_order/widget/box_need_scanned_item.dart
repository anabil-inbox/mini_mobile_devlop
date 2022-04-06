import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

import 'box_on_order_item.dart';

class BoxNeedScannedItem extends StatelessWidget {
  const BoxNeedScannedItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
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
          children: [
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
              txt: "Boxes Need Scan",
              textStyle: textStyleNormal()?.copyWith(color: colorBlack),
            ),
          ],
        ),
        collapsed: const SizedBox.shrink(),
        expanded: Column(
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
                builder: (home) {
                  if (home.operationTask.boxes == null ||
                      home.operationTask.boxes!.isEmpty) {
                    return const SizedBox();
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: home.operationTask.boxes?.length,
                      itemBuilder: (context, index) {
                        return BoxOnOrderItem(
                          boxModel: home.operationTask.boxes![index],
                        );
                      },
                    );
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
