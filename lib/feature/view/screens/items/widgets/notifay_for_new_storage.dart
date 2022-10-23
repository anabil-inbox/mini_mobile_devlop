import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/date_time_util.dart';
import 'package:inbox_clients/util/font_dimne.dart';
import 'package:logger/logger.dart';

import '../qr_screen.dart';

class NotifayForNewStorage extends StatelessWidget {
  const NotifayForNewStorage(
      {Key? key, required this.box, this.showQrScanner = false, this.index = 1})
      : super(key: key);

  final Box box;
  final bool? showQrScanner;
  final int? index;
  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(padding30!)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: sizeH30,
          ),
          SpacerdColor(),
          SizedBox(
            height: sizeH30,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: scaffoldColor,
                borderRadius: BorderRadius.circular(padding6!)),
            margin: EdgeInsets.symmetric(horizontal: sizeH20!),
            padding: EdgeInsets.symmetric(horizontal: sizeH20!),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: sizeH22,
                ),
                 SvgPicture.asset("assets/svgs/box_in_ware_house.svg" , width: sizeW40,),
                SizedBox(
                  height: sizeH6,
                ),
                Text("${box.storageName}"),
                SizedBox(
                  height: sizeH2,
                ),
                Text(
                  "${box.storageStatus}",
                  style: textStyleHints()!.copyWith(fontSize: fontSize13),
                ),
                SizedBox(
                  height: sizeH20,
                ),
              ],
            ),
          ),
          SizedBox(
            height: sizeH16,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: scaffoldColor,
                borderRadius: BorderRadius.circular(padding6!)),
            margin: EdgeInsets.symmetric(horizontal: sizeH20!),
            padding: EdgeInsets.symmetric(horizontal: sizeH20!),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: sizeH22,
                ),
                Text(tr.order_summary),
                if(box.saleOrder != null)...[
                  SizedBox(
                    height: sizeH10,
                  ),
                  Text("${box.saleOrder}"),
                  SizedBox(
                    height: sizeH10,
                  ),
                ],
                if((GetUtils.isNull(box.options) || box.options!.isEmpty))...[
                !(GetUtils.isNull(box.options) || box.options!.isEmpty)
                    ? SizedBox(
                        height: sizeH16,
                      )
                    : const SizedBox(),
                !(GetUtils.isNull(box.options) || box.options!.isEmpty)
                    ? Text("${tr.options} :")
                    : const SizedBox(),
                !(GetUtils.isNull(box.options) || box.options!.isEmpty)
                    ? SizedBox(
                        height: sizeH10,
                      )
                    : const SizedBox(),
                !(GetUtils.isNull(box.options) || box.options!.isEmpty)
                    ? ListView(
                        padding: EdgeInsets.symmetric(horizontal: padding10!),
                        shrinkWrap: true,
                        children: box.options!.map((e) => Text("$e")).toList(),
                      )
                    : const SizedBox(),
                ],
                SizedBox(
                  height: sizeH22,
                ),
                Text("${DateUtility.getChatTime(box.modified.toString())}"),
                SizedBox(
                  height: sizeH22,
                ),
                GetUtils.isNull(box.address)
                    ? Text(
                        '${box.address?.zone} , ${box.address?.streat} , ${box.address?.buildingNo}')
                    : const SizedBox(),
                SizedBox(
                  height: sizeH4,
                ),
              ],
            ),
          ),
          SizedBox(
            height: sizeH20,
          ),
          if (showQrScanner!) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimaryButton(
                  isExpanded: false,
                  isLoading: false,
                  onClicked: () {
                    // Get.put(ItemViewModle());
                    Get.to(() => QrScreen(
                      code: box.serialNo,
                        index: index ?? 1,
                        isFromAtHome: true,
                        storageViewModel: storageViewModel));
                    // homeViewModel.startScan();
                  },
                  textButton: tr.scan_qr_key,
                ),
                SizedBox(
                  width: sizeW12,
                ),
                SizedBox(
                  width: sizeW150,
                  child: SeconderyFormButton(
                    buttonText: "${tr.cancle}",
                    onClicked: () {
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          ] else ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeH20!),
              child: SeconderyFormButton(
                buttonText: "${tr.cancle}",
                onClicked: () {
                  Get.back();
                },
              ),
            ),
          ],
          SizedBox(
            height: sizeH20,
          ),
        ],
      ),
    );
  }
}
