import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/storage/storage_categories_data.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

import '../../../../../../../util/app_shaerd_data.dart';

class ShowHeaderSelection extends StatelessWidget {
  const ShowHeaderSelection(
      {Key? key,
      required this.storageName,
      required this.quantityOrSpace,
      required this.index,
      required this.storageCategoriesData})
      : super(key: key);

  final String storageName;
  final String quantityOrSpace;
  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();
  final StorageCategoriesData storageCategoriesData;
  final int index;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Row(
      children: [
        storageCategoriesData.defaultImage != null ?imageNetwork(
            height: sizeW50,
            width: sizeW40,
            url: ConstanceNetwork.imageUrl + storageCategoriesData.defaultImage.toString(),
            fit: BoxFit.cover
        ): SvgPicture.asset("assets/svgs/folder_icon.svg"),
        SizedBox(
          width: sizeW5,
        ),
        Text(
          "$storageName",
          style: textStyleNormalBlack(),
        ),
        const Spacer(),
        quantityOrSpace.trim().isNotEmpty
            ? Container(
                decoration: BoxDecoration(
                    color: colorTextWhite,
                    borderRadius: BorderRadius.circular(padding9!)),
                padding: EdgeInsets.symmetric(
                    vertical: padding9!, horizontal: padding4!),
                child: Text("$quantityOrSpace"))
            : const SizedBox(),
        SizedBox(
          width: sizeW20,
        ),
        InkWell(
            onTap: () => storageViewModel.deleteCategoreyDataBottomSheet(
                storageCategoriesData: storageCategoriesData),
            child: SvgPicture.asset("assets/svgs/delete_ornage.svg")),//delete
        SizedBox(
          width: sizeW10,
        ),
        InkWell(
            onTap: () {
//              Get.put(StorageViewModel());
              storageViewModel.showMainStorageBottomSheet(
                  index: index,
                  isUpdate: true,
                  storageCategoriesData: storageCategoriesData);
            },
            child: SvgPicture.asset("assets/svgs/update_icon_orange.svg")),//update_icon
      ],
    );
  }
}
