import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/screens/add_item/widgets/tag_widget.dart';
import 'package:inbox_clients/feature/view/screens/not_allowed/not_allowed_screen.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

class CheckInBoxWidget extends StatelessWidget {
  const CheckInBoxWidget({Key? key, this.box}) : super(key: key);

  final Box? box;
  static ItemViewModle itemViewModle = Get.put(ItemViewModle());

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
                  height: sizeH5!,
                ),
                Text(
                  "Deliverd",
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
          GetBuilder<ItemViewModle>(
            init: ItemViewModle(),
            initState: (_) {
              itemViewModle.tdName.text = box?.storageName ?? "";
            },
            builder: (_) {
              return TextFormField(
                controller: itemViewModle.tdName,
                decoration: InputDecoration(
                    focusColor: colorTrans,
                    focusedBorder: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colorBorderContainer),
                    ),
                    hintText: "Box Name"),
              );
            },
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
                  
                  Get.to(() => NotAllowedScreen(
                        box: box!,
                      ));
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
