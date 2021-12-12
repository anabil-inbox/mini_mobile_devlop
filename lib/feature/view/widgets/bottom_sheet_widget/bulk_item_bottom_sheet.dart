import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/utils.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

import '../secondery_button copy.dart';

class BulkItemButtomSheet extends StatelessWidget {
  const BulkItemButtomSheet({Key? key, required this.storageCategoriesData})
      : super(key: key);

  final StorageCategoriesData storageCategoriesData;
  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: true,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(padding30!)),
          color: colorTextWhite,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: sizeH20,
            ),
            TextFormField(
              controller: storageViewModel.tdSearch,
              onChanged: (e) {
                storageViewModel.update();
              },
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(padding6!)),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(18),
                    child: SvgPicture.asset("assets/svgs/search_icon.svg"),
                  ),
                  filled: true,
                  fillColor: scaffoldColor),
            ),
            SizedBox(
              height: sizeH25,
            ),
            !GetUtils.isNull(storageCategoriesData.items)
                ?
                GetBuilder<StorageViewModel>(
                    builder: (b) => ListView(
                          shrinkWrap: true,
                          primary: false,
                          children: storageCategoriesData.items!
                              .map((e) => e.storageType!.toLowerCase().contains(
                                          "${storageViewModel.tdSearch.text.toLowerCase()}") ||
                                      storageViewModel.tdSearch.text
                                          .trim()
                                          .isEmpty
                                  ? SeconderyButtom(
                                      onClicked: () {
                                        storageViewModel.selctedItem = e;
                                        storageViewModel.update();
                                        Get.back();
                                      },
                                      textButton: "${e.storageType}",
                                    )
                                  : const SizedBox())
                              .toList(),
                        ))
                : const SizedBox(),
            SizedBox(
              height: sizeH25,
            ),
          ],
        ),
      ),
    );
  }
}
