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
  // static StorageViewModel storageViewModel = Get.find<StorageViewModel>();
  static ProfileViewModle profileViewModle = Get.find<ProfileViewModle>();
  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();

  Widget get addressTitle {
    try {
      if (storageViewModel.userStorageCategoriesData.isNotEmpty){
        return Text(
          (storageViewModel.userStorageCategoriesData[0].storageCategoryType ==
                      ConstanceNetwork.itemCategoryType ||
                  storageViewModel
                          .userStorageCategoriesData[0].storageCategoryType ==
                      ConstanceNetwork.quantityCategoryType)
              ? "${tr.pickup_address}"
              : "${tr.warehouse_address}");
      }else{
        return const SizedBox();
      }
      
    } catch (e) {
      return const SizedBox();
    }
  }

  //  if (storageViewModel.userStorageCategoriesData[0]
  //                               .storageCategoryType ==
  //                           ConstanceNetwork.itemCategoryType ||
  //                       storageViewModel.userStorageCategoriesData[0]
  //                               .storageCategoryType ==
  //                           ConstanceNetwork.quantityCategoryType) {
  //                   return ;
  //                   } else {
  //                   return Text("${tr.pickup_address}");
  //                   }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StorageViewModel>(
      init: StorageViewModel(),
      initState: (_) {},
      builder: (storageViewModel) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addressTitle,
            SizedBox(
              height: sizeH10,
            ),
              if (storageViewModel.userStorageCategoriesData.isNotEmpty)
            if (storageViewModel.userStorageCategoriesData[0].storageCategoryType ==
                    ConstanceNetwork.itemCategoryType ||
                storageViewModel.userStorageCategoriesData[0].storageCategoryType ==
                    ConstanceNetwork.quantityCategoryType)

              GetBuilder<ProfileViewModle>(
                initState: (_) {
                  WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                    if (storageViewModel.userStorageCategoriesData[0]
                                .storageCategoryType ==
                            ConstanceNetwork.itemCategoryType ||
                        storageViewModel.userStorageCategoriesData[0]
                                .storageCategoryType ==
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
                initState: (_) {
                  WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                    if (storageViewModel.userStorageCategoriesData[0]
                                .storageCategoryType ==
                            ConstanceNetwork.itemCategoryType ||
                        storageViewModel.userStorageCategoriesData[0]
                                .storageCategoryType ==
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
                                  address: e.addresses!.isNotEmpty ||
                                          e.addresses!.length > 1
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
            if (storageViewModel.userStorageCategoriesData.isNotEmpty)
              if (storageViewModel
                          .userStorageCategoriesData[0].storageCategoryType ==
                      ConstanceNetwork.itemCategoryType ||
                  storageViewModel
                          .userStorageCategoriesData[0].storageCategoryType ==
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
      },
    );
  }
}
