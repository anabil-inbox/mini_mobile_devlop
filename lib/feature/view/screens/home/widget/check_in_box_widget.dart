import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/screens/add_item/widgets/tag_widget.dart';
import 'package:inbox_clients/feature/view/screens/not_allowed/not_allowed_screen.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

class CheckInBoxWidget extends StatelessWidget {
  const CheckInBoxWidget({Key? key , this.box}) : super(key: key);

  final Box? box;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      decoration: containerBoxDecorationHardEdge(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: sizeH20!,
          ),
          SpacerdColor(),
          SizedBox(
            height: sizeH20!,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: padding16!),
            decoration: containerBoxDecoration().copyWith(color: scaffoldColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: sizeH20!,
                ),
                SvgPicture.asset("assets/svgs/folder_icon.svg"),
                SizedBox(
                  height: sizeH9!,
                ),
                Text("New Box Check In"),
                SizedBox(
                  height: sizeH5!,
                ),
                Text(
                  "${box?.storageStatus ?? ""}",
                  style: textStyleHints(),
                ),
                SizedBox(
                  height: sizeH6!,
                ),
                Text("${box?.serialNo ?? ""}"),
                SizedBox(
                  height: sizeH9!,
                ),
              ],
            ),
          ),
          SizedBox(
            height: sizeH20!,
          ),
          TextFormField(
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorBorderContainer),
                ),
                hintText: "Name"),
          ),
          SizedBox(
            height: sizeH20!,
          ),
          TagWidget(),
          SizedBox(
            height: sizeH20!,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimaryButton(
                isExpanded: false,
                isLoading: false,
                onClicked: () {
                  Get.to(() => NotAllowedScreen());
                },
                textButton: "Check-in Box",
              ),
              SizedBox(
                width: sizeW12,
              ),
              SizedBox(
                width: sizeW150,
                child: SeconderyFormButton(
                  buttonText: "Cancel",
                  onClicked: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: sizeH20!,
          ),
        ],
      ),
    );
  }
}
