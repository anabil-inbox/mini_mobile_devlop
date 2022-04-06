import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'dart:math' as math;

import '../../../../../../util/app_color.dart';
import '../../../../../../util/app_dimen.dart';
import '../../../../../../util/app_shaerd_data.dart';
import '../../../../../../util/app_style.dart';
import '../../../../../view_model/home_view_model/home_view_model.dart';
import '../../../../widgets/custome_text_view.dart';

class FetchedItems extends StatelessWidget {
  const FetchedItems({Key? key}) : super(key: key);

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
              txt: "Items Fetched",
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
                  if (home.operationTask.items == null ||
                      home.operationTask.items!.isEmpty) {
                    return const SizedBox();
                  } else {
                    return SizedBox(
                      height: sizeH100,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 12,
                        ),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        primary: false,
                        itemCount: home.operationTask.items?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Column(children: [
                            Text(
                                "${home.operationTask.items![index].itemName}"),
                            SizedBox(
                              height: sizeH6,
                            ),
                            if (home.operationTask.items![index].itemGallery!
                                .isEmpty) ...[
                              imageNetwork(
                                  height: sizeH75,
                                  url: urlPlacholder,
                                  fit: BoxFit.cover)
                            ] else ...[
                              imageNetwork(
                                  height: sizeH75,
                                  url: (ConstanceNetwork.imageUrl) +
                                      home.operationTask.items![index]
                                          .itemGallery![0]["attachment"])
                            ]
                          ]);
                        },
                      ),
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
