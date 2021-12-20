import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/view/screens/add_item/qr_screen.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class NotifayForNewStorage extends StatelessWidget {
  const NotifayForNewStorage({Key? key}) : super(key: key);

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
                Text("New Box 01"),
                SizedBox(
                  height: sizeH2,
                ),
                Text(
                  "Not Delivered",
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
                SizedBox(
                  height: sizeH2,
                ),
                Text(
                  "1 Box",
                ),
                SizedBox(
                  height: sizeH20,
                ),
                Text("6:43 PM"),
                SizedBox(
                  height: sizeH4,
                ),
                Text("Monday, June 7, 2021 (GMT+3)"),
                SizedBox(
                  height: sizeH4,
                ),
                Text("Time in West Bay, Doha"),
                SizedBox(
                  height: sizeH20,
                ),
                Text('Zone 20, St. 913, B. 6/10'),
                SizedBox(
                  height: sizeH4,
                ),
                Text("Doha, Qatar"),
                SizedBox(
                  height: sizeH4,
                ),
                Text("+974 7070 1221"),
                SizedBox(
                  height: sizeH16,
                ),
              ],
            ),
          ),
          SizedBox(
            height: sizeH20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimaryButton(
                isExpanded: false,
                isLoading: false,
                onClicked: () {
                  Get.put(ItemViewModle());
                 // Get.to(() => QrScreen());
                },
                textButton: "Scan QR Key",
              ),
              SizedBox(width: sizeW12,),
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
          SizedBox(
            height: sizeH20,
          ),
        ],
      ),
    );
  }
}
