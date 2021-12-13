import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/address_modle.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_button.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

import 'pickup_address_item.dart';

class PickupAddress extends StatelessWidget {
  const PickupAddress({Key? key}) : super(key: key);
  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Pickup Address"),
        SizedBox(
          height: sizeH10,
        ),
        GetBuilder<StorageViewModel>(
          init: StorageViewModel(),
          initState: (_) {
            WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
              if (storageViewModel
                          .userStorageCategoriesData[0].storageCategoryType ==
                      ConstanceNetwork.itemCategoryType ||
                  storageViewModel
                          .userStorageCategoriesData[0].storageCategoryType ==
                      ConstanceNetwork.quantityCategoryType) {
                storageViewModel.getUserAddress();
              } else {
                storageViewModel.getStoreAddress();
              }
            });
          },
          builder: (_) {
            return storageViewModel.userAddress.isNotEmpty
                ? ListView(
                    primary: false,
                    shrinkWrap: true,
                    children: storageViewModel.userAddress
                        .map((e) => PickupAddressItem(address: e))
                        .toList(),
                  )
                : const SizedBox();
          },
        ),
        SizedBox(
          height: sizeH10,
        ),
        SeconderyButtom(textButton: "${tr.add_new_address}", onClicked: () {}),
      ],
    );
  }
}
