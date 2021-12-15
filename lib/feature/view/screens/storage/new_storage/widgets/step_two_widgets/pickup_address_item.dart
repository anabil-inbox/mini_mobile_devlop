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

class PickupAddressItem extends StatelessWidget {
  const PickupAddressItem({Key? key, required this.address, this.store})
      : super(key: key);

  final Address address;
  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();
  final Store? store;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (store != null) {
          storageViewModel.selectedStore = store;
        } else {
          storageViewModel.selectedAddress = address;
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
              height: sizeH22,
            ),
            GetBuilder<StorageViewModel>(
              init: StorageViewModel(),
              initState: (_) {},
              builder: (_) {
                return Row(
                  children: [
                    storageViewModel.selectedAddress == address
                        ? SvgPicture.asset("assets/svgs/rec_true.svg")
                        : SvgPicture.asset("assets/svgs/rec_empty.svg"),
                    SizedBox(
                      width: sizeW10,
                    ),
                    Text("${address.title ?? address.addressTitle ?? ""}"),
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
                  width: sizeW20,
                ),
                Text("${address.streat ?? ""}" , style: textStyleHints()!.copyWith(fontSize: fontSize14),)
              ],
            ),
            SizedBox(
              height: sizeH17,
            ),
            const Divider()
          ],
        ),
      ),
    );
  }
}
