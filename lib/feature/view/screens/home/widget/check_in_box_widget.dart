import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/screens/items/widgets/tag_box_widget.dart';
import 'package:inbox_clients/feature/view/screens/not_allowed/not_allowed_screen.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:logger/logger.dart';

import '../../../../../util/app_shaerd_data.dart';

class CheckInBoxWidget extends StatelessWidget {
  const CheckInBoxWidget({Key? key, this.box, required this.isUpdate})
      : super(key: key);

  final Box? box;
  static ItemViewModle itemViewModle = Get.put(ItemViewModle());
  HomeViewModel get homeViewModel => Get.find<HomeViewModel>();
  final bool isUpdate;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
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
                 SvgPicture.asset("assets/svgs/box_in_ware_house.svg" , width: sizeW40,),
                SizedBox(
                  height: sizeH5!,
                ),
                Text(
                  tr.delivered,
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
            assignId: true,
            autoRemove: false,
            // init: ItemViewModle(),
            // initState: (_) {
            //   itemViewModle.tdName.text =
            //       itemViewModle.operationsBox?.storageName ?? "";
            // },
            builder: (_) {
              return TextFormField(
                controller: itemViewModle.tdName,
                decoration: InputDecoration(
                  label: Text(tr.box_name),
                    focusColor: colorTrans,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colorBorderContainer),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colorBorderContainer),
                    ),
                    hintText:tr.box_name ),
              );
            },
          ),
          SizedBox(
            height: sizeH20!,
          ),
          TagBoxWidget(),
          SizedBox(
            height: sizeH20!,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder<ItemViewModle>(
                // init: ItemViewModle(),
                autoRemove: false,
                // initState: (_) {},
                builder: (log) {
                  return PrimaryButton(
                    isExpanded: false,
                    isLoading: log.isLoading,
                    onClicked: () async {
                      if (isUpdate) {
                        homeViewModel.userBoxess.toList().removeAt(
                            homeViewModel.userBoxess.toList().indexOf(box!));

                        await itemViewModle.updateBox(
                            box: box!,
                            index: homeViewModel.userBoxess
                                .toList()
                                .indexOf(box!));

                        // itemViewModle.tdName.text = box?.storageName ?? "";
                        // itemViewModle.update();
                      } else {
                        Get.back();
                        homeViewModel.userBoxess.toList().removeAt(
                            homeViewModel.userBoxess.toList().indexOf(box!));
                        Logger().e(itemViewModle.tdName.text);
                        await itemViewModle
                            .updateBox(
                                box: box!,
                                index: homeViewModel.userBoxess
                                    .toList()
                                    .indexOf(box!))
                            .whenComplete(() => {
                                  itemViewModle.tdName.clear(),
                                });
                        Get.to(NotAllowedScreen(
                          box: box!,
                        ));
                      }
                    },
                    textButton: isUpdate ? tr.update_box/*"Update-Box"*/ : tr.check_in_box/*"Check-in Box"*/,
                  );
                },
              ),
              SizedBox(
                width: sizeW12,
              ),
              SizedBox(
                width: sizeW150,
                child: SeconderyFormButton(
                  buttonText: tr.cancle,
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
