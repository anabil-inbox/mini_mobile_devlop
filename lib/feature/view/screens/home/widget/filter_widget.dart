import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/widgets/icon_btn.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/constance/constance.dart';

import 'choice_shape_widget.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetBuilder<HomeViewModel>(builder: (logic) {
      return Container(
        width: double.infinity,
        height: sizeH50,
        decoration: BoxDecoration(
            color: colorTextWhite,
            borderRadius: BorderRadius.circular(sizeRadius5!)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: sizeW5,
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GetBuilder<HomeViewModel>(
                    init: HomeViewModel(),
                    initState: (_) {},
                    builder: (logic) {
                      return Expanded(
                        child: SizedBox(
                          height: sizeH30,
                          child: ListView.builder(
                            shrinkWrap: true,
                            //reverse: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: logic.tasks.length,
                            itemBuilder: (context, index) => logic.tasks
                                            .toList()[index]
                                            .id ==
                                        LocalConstance.fetchId ||
                                    (logic.tasks.toList()[index].id ==
                                        LocalConstance.newNewStorageSpaceSv) ||
                                    (logic.tasks.toList()[index].id ==
                                        LocalConstance.newStorageItemSv)
                                ? const SizedBox()
                                : ChoiceShapeWidget(
                                    onClicked: () {
                                      logic.showTaskBottomSheet(
                                          task: logic.tasks.toList()[index]);
                                    },
                                    task: logic.tasks.toList()[index],
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              width: sizeW5,
            ),
            VerticalDivider(),
            IconBtn(
              onPressed: () {
                logic.changeTypeViewLVGV();
              },
              icon: !logic.isListView!
                  ? "assets/svgs/list.svg"
                  : "assets/svgs/grid.svg",
              height: sizeH30,
              width: sizeW30,
              backgroundColor: colorTextWhite,
              borderColor: colorTextWhite,
              iconColor: colorBlack,
            ),
          ],
        ),
      );
    });
  }
}
