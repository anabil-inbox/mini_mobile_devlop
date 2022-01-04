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



class RecallStorage extends StatelessWidget {
  const RecallStorage({Key? key, required this.box,this.index }) : super(key: key);

  final Box box;
  final int? index;
  static HomeViewModel _homeViewModel = Get.find<HomeViewModel>();
  static StorageViewModel _storageViewModel = Get.find<StorageViewModel>();

  @override
  Widget build(BuildContext context) {
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
                SvgPicture.asset("assets/svgs/folder_icon.svg"),
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
                Text("Order Summary:"),
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
                SizedBox(
                  height: sizeH22,
                ),
                Text("${DateUtility.getChatTime(box.modified.toString())}"),
                SizedBox(
                  height: sizeH22,
                ),
                Text(
                    '${box.address?.zone} , ${box.address?.streat} , ${box.address?.buildingNo}'),
                SizedBox(
                  height: sizeH4,
                ),
                Text("Doha, Qatar"),
                SizedBox(
                  height: sizeH22,
                ),
              ],
            ),
          ),
          SizedBox(
            height: sizeH20,
          ),
          // if(showQrScanner!)...[
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       PrimaryButton(
          //         isExpanded: false,
          //         isLoading: false,
          //         onClicked: () {
          //           // Get.put(ItemViewModle());
          //           Get.to(() => QrScreen(isFromAtHome:true ,index:index , storageViewModel:storageViewModel));
          //           // homeViewModel.startScan();
          //         },
          //         textButton: "Scan QR Key",
          //       ),
          //       SizedBox(
          //         width: sizeW12,
          //       ),
          //   SizedBox(
          //     width: sizeW150,
          //     child: SeconderyFormButton(
          //       buttonText: "${tr.cancle}",
          //       onClicked: () {
          //         Get.back();
          //       },
          //     ),
          //   ),
          //     ],
          //   ),
          // ]else ...[
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: sizeH20!),
          //   child: SeconderyFormButton(
          //     buttonText: "${tr.cancle}",
          //     onClicked: () {
          //       Get.back();
          //     },
          //   ),
          // ),
          // ],
          SizedBox(
            height: sizeH20,
          ),
        ],
      ),
    );
  }
}
