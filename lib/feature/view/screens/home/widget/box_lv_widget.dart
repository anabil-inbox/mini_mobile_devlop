import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/details_storage_view.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

import 'box_gv_item_widget.dart';
import 'box_lv_item_widget.dart';

class LVWidget extends StatelessWidget {
  const LVWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Column(
      children: [
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: 4,
          shrinkWrap: true,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              Get.to(StorageDetailsView());
            },
            child: HomeLVItemWidget(
              boxPath: index == 2
                  ? "assets/svgs/home_box_red.svg"
                  : (index == 1 || index == 3)
                      ? "assets/svgs/enable_box.svg"
                      : "assets/svgs/desable_box.svg",
            ),
          ),
        ),
      ],
    );
  }
}
