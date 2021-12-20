import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/widgets/icon_btn.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

import 'choice_shape_widget.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({Key? key}) : super(key: key);

  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetBuilder<StorageViewModel>(builder: (logic) {
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
                  GetBuilder<StorageViewModel>(
                    init: StorageViewModel(),
                    initState: (_) {},
                    builder: (logic) {
                      return Expanded(
                        child: SizedBox(
                          height: sizeH30,
                          child: ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: logic.tasks.length,
                            itemBuilder: (context, index) => ChoiceShapeWidget(
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
