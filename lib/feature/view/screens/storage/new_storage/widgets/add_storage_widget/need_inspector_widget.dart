import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

class NeedInspectorWidget extends StatelessWidget {
  const NeedInspectorWidget({Key? key , required this.storageCategoriesData}) : super(key: key);

 final StorageCategoriesData storageCategoriesData;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StorageViewModel>(
      init: StorageViewModel(),
      initState: (_) {},
      builder: (log) {
        return Container(
          decoration: BoxDecoration(
              border: Border.all(color: colorBorderContainer),
              borderRadius: BorderRadius.circular(padding6!)),
          child: InkWell(
            onTap: () {
              log.isNeedingAdviser = !log.isNeedingAdviser;
              log.onAddingAdviser(storageCategoriesData: storageCategoriesData);
              log.update();
            },
            child: Row(
              children: [
                SizedBox(
                  width: sizeW10,
                  height: sizeH50,
                ),
                log.isNeedingAdviser
                    ? SvgPicture.asset("assets/svgs/true.svg")
                    : SvgPicture.asset("assets/svgs/uncheck.svg"),
                SizedBox(
                  width: sizeW12,
                ),
                Text("${tr.need_inspectator}")
              ],
            ),
          ),
        );
      },
    );
  }
}
