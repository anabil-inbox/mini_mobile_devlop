import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:logger/logger.dart';

import '../../../../../../../util/app_shaerd_data.dart';

// ignore: must_be_immutable
class SizeTypeItem extends StatelessWidget {
  SizeTypeItem(
      {Key? key, required this.storageCategoriesData, required this.media, this.isFromEditClick = false, })
      : super(key: key);
  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();
  final StorageCategoriesData storageCategoriesData;
  final List<String> media;
  bool isEnable = true;
  final bool? isFromEditClick;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorBorderContainer),
        color: colorBackground,
        borderRadius: BorderRadius.circular(sizeRadius5!),
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            top: padding0,
            bottom: padding0,
            start: padding0,
            end: padding0,
            child: TextButton(
              onPressed:isFromEditClick! ? null: () {
                if (isEnable) {
                  storageViewModel.showMainStorageBottomSheet(
                      storageCategoriesData: storageCategoriesData);
                } else {}
              },
              child: FittedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    getWidget(),
                    SizedBox(
                      height: sizeH10,
                    ),
                    CustomTextView(
                      txt: storageCategoriesData.storageName,
                      maxLine: Constance.maxLineTwo,
                      textStyle: textStyleNormalBlack(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          PositionedDirectional(
            end: padding0,
            top: padding10! * -1,
            child: SizedBox(
              width: sizeW40,
              child: TextButton(
                onPressed: () {
                  storageViewModel.detaielsBottomSheet(
                      media: media,
                      storageCategoriesData: storageCategoriesData);
                },
                child: SvgPicture.asset("assets/svgs/InfoCircle.svg"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getWidget() {
    if (storageViewModel.isShowAll) {
      return storageCategoriesData.defaultImage != null ?imageNetwork(
          height: sizeW50,
          width: sizeW40,
          url: ConstanceNetwork.imageUrl + storageCategoriesData.defaultImage.toString(),
          fit: BoxFit.cover
      ): SvgPicture.asset(ConstanceNetwork.enableFolder);
    } else if (((storageCategoriesData.storageCategoryType ==
            ConstanceNetwork.quantityCategoryType) &&
        storageViewModel.isShowQuantity)) {
      return storageCategoriesData.defaultImage != null ?imageNetwork(
        height: sizeW50,
        width: sizeW40,
        url: ConstanceNetwork.imageUrl + storageCategoriesData.defaultImage.toString(),
        fit: BoxFit.cover
      ): SvgPicture.asset(ConstanceNetwork.enableFolder);
    } else if (((storageCategoriesData.storageCategoryType ==
            ConstanceNetwork.itemCategoryType) &&
        storageViewModel.isShowItem)) {
      return storageCategoriesData.defaultImage != null ?imageNetwork(
          height: sizeW50,
          width: sizeW40,
          url: ConstanceNetwork.imageUrl + storageCategoriesData.defaultImage.toString(),
          fit: BoxFit.cover
      ):SvgPicture.asset(
        ConstanceNetwork.enableFolder,
        width: sizeW50,
        height: sizeH40,
      );
    } else if (((storageCategoriesData.storageCategoryType ==
                ConstanceNetwork.spaceCategoryType ||
            storageCategoriesData.storageCategoryType!.contains("Space")) &&
        storageViewModel.isShowSpaces)) {
      return storageCategoriesData.defaultImage != null ?imageNetwork(
          height: sizeW50,
          width: sizeW40,
          url: ConstanceNetwork.imageUrl + storageCategoriesData.defaultImage.toString(),
          fit: BoxFit.cover
      ):SvgPicture.asset(
        ConstanceNetwork.enableFolder,
        width: sizeW50,
        height: sizeH40,
      );
    } else {
      isEnable = false;
      return SvgPicture.asset(
        ConstanceNetwork.disableFolder,
        width: sizeW50,
        height: sizeH40,
      );
    }
  }
}
