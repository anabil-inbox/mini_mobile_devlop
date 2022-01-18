import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/model/app_setting_modle.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/screens/items/item_screen.dart';
import 'package:inbox_clients/feature/view/screens/not_allowed/widgets/not_allowed_item.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/sh_util.dart';

class NotAllowedScreen extends StatelessWidget {
  const NotAllowedScreen({Key? key, required this.box}) : super(key: key);

  static List<NotAllowed>? notAlwoed;
  final Box box;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizeH16!),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: sizeH40,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: sizeW20,
                    ),
                    IconButton(
                        onPressed: () {
                          Get.close(1);
                        },
                        icon: SvgPicture.asset("assets/svgs/cross.svg")),
                    SizedBox(
                      width: sizeW50,
                    ),
                    Text(
                      "Not allowed Content",
                      style: textStyleAppBarTitle(),
                    ),
                    const Spacer()
                  ],
                ),
                GetBuilder<StorageViewModel>(
                  init: StorageViewModel(),
                  initState: (_) {
                    notAlwoed = ApiSettings.fromJson(
                            jsonDecode(SharedPref.instance.getAppSetting()))
                        .notAllowed;
                  },
                  builder: (_) {
                    return Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: sizeW10!,
                                  crossAxisSpacing: sizeH10!,
                                  childAspectRatio: (sizeW165! / sizeH150)),
                          itemCount: notAlwoed?.length,
                          itemBuilder: (context, index) => NotAllowedItem(
                                notAllowed: notAlwoed?[index],
                              )),
                    );
                  },
                )
              ],
            ),
            Positioned(
                bottom: padding20,
                right: padding10,
                left: padding10,
                child: GetBuilder<ItemViewModle>(
                  init: ItemViewModle(),
                  initState: (_) {},
                  builder: (logic) {
                    return PrimaryButton(
                        textButton: "Accept",
                        isLoading: logic.isLoading,
                        onClicked: () async {
                         // await logic.updateBox(box: box);
                          box.storageName = logic.tdName.text;
                          Get.off(ItemScreen(box: box,getBoxDataMethod: () async{
                          await logic.getBoxBySerial(serial: box.serialNo!);
                          },));
                        }, 
                        isExpanded: true);
                  },
                ))
          ],
        ),
      ),
    );
  }
}
