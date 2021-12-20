import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/address_modle.dart';
import 'package:inbox_clients/feature/view/screens/profile/address/add_address.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_button.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

import 'pickup_address_item.dart';

class PickupAddress extends StatelessWidget {
  const PickupAddress({Key? key}) : super(key: key);
  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();
  static ProfileViewModle profileViewModle = Get.find<ProfileViewModle>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${tr.pickup_address}"),
        SizedBox(
          height: sizeH10,
        ),
        
        if (storageViewModel.userStorageCategoriesData[0].storageCategoryType ==
                ConstanceNetwork.itemCategoryType ||
            storageViewModel.userStorageCategoriesData[0].storageCategoryType ==
                ConstanceNetwork.quantityCategoryType)
          GetBuilder<ProfileViewModle>(
            init: ProfileViewModle(),
            initState: (_) {
              WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                if (storageViewModel
                            .userStorageCategoriesData[0].storageCategoryType ==
                        ConstanceNetwork.itemCategoryType ||
                    storageViewModel
                            .userStorageCategoriesData[0].storageCategoryType ==
                        ConstanceNetwork.quantityCategoryType) {
                  profileViewModle.getMyAddress();
                } else {
                  storageViewModel.getStoreAddress();
                }
              });
            },
            builder: (_) {
              return profileViewModle.userAddress.isNotEmpty
                  ? ListView(
                      primary: false,
                      shrinkWrap: true,
                      children: profileViewModle.userAddress
                          .map((e) => PickupAddressItem(address: e))
                          .toList(),
                    )
                  : const SizedBox();
            },
          )
        else
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
                  profileViewModle.getMyAddress();
                } else {
                  storageViewModel.getStoreAddress();
                }
              });
            },
            builder: (_) {
              return storageViewModel.storeAddress.isNotEmpty
                  ? ListView(
                      primary: false,
                      shrinkWrap: true,
                      children: storageViewModel.storeAddress
                          .map((e) => PickupAddressItem(
                              address: e.addresses!.isNotEmpty
                                  ? e.addresses![0]
                                  : Address()))
                          .toList(),
                    )
                  : const SizedBox();
            },
          ),
        SizedBox(
          height: sizeH10,
        ),
        if (storageViewModel.userStorageCategoriesData[0].storageCategoryType ==
                ConstanceNetwork.itemCategoryType ||
            storageViewModel.userStorageCategoriesData[0].storageCategoryType ==
                ConstanceNetwork.quantityCategoryType)
          SeconderyButtom(
              textButton: "${tr.add_new_address}",
              onClicked: () async {
                Get.to(() => AddAddressScreen());
              })
        else
          const SizedBox(),
        SizedBox(
          height: sizeH100,
        )
      ],
    );
  }
}
