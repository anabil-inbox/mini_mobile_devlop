import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/screens/items/widgets/schedule_widget.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

class EmptyBodyBoxItem extends StatelessWidget {
  const EmptyBodyBoxItem({Key? key, required this.box}) : super(key: key);

  static ItemViewModle itemViewModle = Get.find<ItemViewModle>();

  final Box? box;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Stack(
        children: [
          PositionedDirectional(
              top: padding0,
              bottom: padding0,
              start: padding0,
              end: padding0,
              child: SvgPicture.asset("assets/svgs/empty_icon.svg")),
          Column(
            children: [
              SizedBox(
                height: sizeH20,
              ),
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(padding16!),
                      child: SvgPicture.asset(
                        "assets/svgs/search_icon.svg",
                      ),
                    ),
                    hintText: "Search"),
              ),
            ],
          ),
          PositionedDirectional(
            bottom: padding32,
            start: 0,
            end: 0,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    itemViewModle.showAddItemBottomSheet(
                        box: box!,);
                    // Get.bottomSheet(
                    //     AddItemWidget(
                    //       box: box,
                    //     ),
                    //     isScrollControlled: true);
                  },
                  backgroundColor: colorPrimary,
                  child: Icon(
                    Icons.add,
                    color: colorBackground,
                  ),
                ),
                SizedBox(
                  height: sizeH12,
                ),
                Text(
                  "Add you item  in box",
                  style: textStyleHints(),
                ),
                SizedBox(
                  height: sizeH50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryButton(
                      isExpanded: false,
                      isLoading: false,
                      onClicked: () {
                        Get.bottomSheet(SchedualWidget());
                      },
                      textButton: "Schedule Pickup",
                    ),
                    SizedBox(
                      width: sizeW12,
                    ),
                    SizedBox(
                      width: sizeW150,
                      child: SeconderyFormButton(
                        buttonText: "Ready to pickup",
                        onClicked: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
