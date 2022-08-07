import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

import '../../../../../../../util/app_shaerd_data.dart';

// ignore: must_be_immutable
class OptionItem extends StatelessWidget {
  OptionItem(
      {Key? key,
      required this.storageFeatures,
      required this.storageCategoriesData})
      : super(key: key);

  StorageViewModel storageViewModel = Get.find<StorageViewModel>();

  final StorageFeatures storageFeatures;
  final StorageCategoriesData storageCategoriesData;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetBuilder<StorageViewModel>(
      init: StorageViewModel(),
      initState: (_) {},
      builder: (_) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                if (storageCategoriesData.storageCategoryType ==
                        ConstanceNetwork.itemCategoryType &&
                    storageViewModel.isNeedingAdviser) {
                  return;
                }
                storageViewModel.doOnChooseNewFeatures(
                    storageCategoriesData: storageCategoriesData,
                    storageFeatures: storageFeatures);
                storageViewModel.update();
              },
              child: Row(
                children: [
                  storageViewModel.selectedFeaures.contains(storageFeatures)
                      ? SvgPicture.asset(/*"assets/svgs/true.svg"*/"assets/svgs/storage_check_active_orange.svg")//storage_check_active
                      : SvgPicture.asset(/*"assets/svgs/uncheck.svg"*/"assets/svgs/storage_check_deactive.svg"),
                  SizedBox(
                    width: sizeW10,
                  ),
                  Text(storageFeatures.storageFeature ?? ""),
                  const Spacer(),
                  // PopInfoDialog(
                  //   title: "${storageFeatures.addedPrice}",
                  // ),
                  
                   //${/*tr.price*/}
                  //SvgPicture.asset("assets/svgs/InfoCircle.svg"),
                ],
              ),
            ),
            Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: padding30!),
                child: Text(getText(),
                  style: textStyleSmall()?.copyWith(color: colorHint),
                )),
            SizedBox(
              height: sizeH25,
            ),
          ],
        );
      },
    );
  }

  String getText() {
    return tr.will_have+ " ${storageFeatures.addedPrice} " +tr.as_extra_fees;
  }
}
