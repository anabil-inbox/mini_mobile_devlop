import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_dimen.dart';

// ignore: must_be_immutable
class OptionItem extends StatelessWidget {
  OptionItem(
      {Key? key,
      required this.optionTitle,
      required this.storageFeatures,
      required this.storageCategoriesData})
      : super(key: key);

  StorageViewModel storageViewModel = Get.find<StorageViewModel>();

  final StorageFeatures storageFeatures;
  final String optionTitle;
  bool isSelcted = false;
  final StorageCategoriesData storageCategoriesData;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StorageViewModel>(
      init: StorageViewModel(),
      initState: (_) {},
      builder: (_) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                storageViewModel.doOnChooseNewFeatures(
                    storageCategoriesData: storageCategoriesData,
                    storageFeatures: storageFeatures);
                storageViewModel.update();
              },
              child: Row(
                children: [
                  storageViewModel.selectedFeaures.contains(storageFeatures.id)
                      ? SvgPicture.asset("assets/svgs/true.svg")
                      : SvgPicture.asset("assets/svgs/uncheck.svg"),
                  SizedBox(
                    width: sizeW10,
                  ),
                  Text(storageFeatures.storageFeature ?? ""),
                  const Spacer(),
                  SvgPicture.asset("assets/svgs/InfoCircle.svg"),
                ],
              ),
            ),
            SizedBox(
              height: sizeH25,
            ),
          ],
        );
      },
    );
  }
}
