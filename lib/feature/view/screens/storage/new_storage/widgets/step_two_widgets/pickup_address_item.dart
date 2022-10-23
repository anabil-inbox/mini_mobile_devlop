import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/address_modle.dart';
import 'package:inbox_clients/feature/model/storage/store_modle.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';
import 'package:logger/logger.dart';

import '../../../../../../../util/app_shaerd_data.dart';

class PickupAddressItem extends StatelessWidget {
  const PickupAddressItem({Key? key, required this.address, this.store})
      : super(key: key);

  final Address address;
  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();
  final Store? store;

  Widget get addressText {
    String fullAddress = "";
    if (address.streat != null) {
      fullAddress =
          "BN.${address.buildingNo ?? ""} - UN.${address.unitNo ?? ""} - St.${address.streat ?? ""}";
    } else {
      fullAddress =
          "BN.${address.buildingNo ?? ""} - UN.${address.unitNo ?? ""} ";
    }

    return Expanded(
      child: Text(
        fullAddress,
        style: textStyleHints()!.copyWith(fontSize: fontSize14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetUtils.isNull(address.id)
        ? const SizedBox()
        : InkWell(
            onTap: () {
              Logger().d(
                  "onAddressClick \n${address.toJson()}\n${store?.toJson()}");
              if (store != null) {
                storageViewModel.selectedStore = store;
                Logger().d("onAddressClick 1");
              } else {
                storageViewModel.selectedAddress = address;
                Logger().d("onAddressClick 2");
              }
              storageViewModel.update();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: colorTextWhite,
                  borderRadius: BorderRadius.circular(padding6!)),
              padding: EdgeInsets.symmetric(horizontal: padding16!),
              child: Column(
                children: [
                  SizedBox(
                    height: sizeH20,
                  ),
                  GetBuilder<StorageViewModel>(
                    init: StorageViewModel(),
                    initState: (_) {},
                    builder: (_) {
                      return Row(
                        children: [
                          (store != null &&
                                  storageViewModel.selectedStore == store)
                              ? SvgPicture.asset(/*"assets/svgs/rec_true.svg"*/"assets/svgs/true_orange.svg")//true
                              : storageViewModel.selectedAddress == address
                                  ? SvgPicture.asset(/*"assets/svgs/rec_true.svg"*/"assets/svgs/true_orange.svg")//true
                                  : SvgPicture.asset(
                                      /*"assets/svgs/rec_empty.svg"*/"assets/svgs/uncheck.svg"),
                          SizedBox(
                            width: sizeW10,
                          ),
                          Text(
                              "${address.title ?? address.addressTitle ?? ""}"),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: sizeH6,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: sizeW36,
                      ),
                      addressText
                    ],
                  ),
                  SizedBox(
                    height: sizeH10,
                  ),
                  const Divider()
                ],
              ),
            ),
          );
  }
}
