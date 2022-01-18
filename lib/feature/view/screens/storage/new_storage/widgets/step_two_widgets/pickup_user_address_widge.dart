import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/address_modle.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_button.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';

import 'pickup_address_item.dart';

class PickupUserAddress extends StatelessWidget {
  const PickupUserAddress({Key? key}) : super(key: key);
  
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
              storageViewModel.getStoreAddress();
            });
          },
          builder: (_) {
            return storageViewModel.storeAddress.isNotEmpty
                ? ListView(
                    primary: false,
                    shrinkWrap: true,
                    children: storageViewModel.storeAddress
                        .map((e) => e.addresses!.isNotEmpty 
                            ? PickupAddressItem(
                                store: e,
                                address: e.addresses?[0] ??
                                    Address(title: e.addresses?[0].title ?? ""))
                            : const SizedBox())
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
