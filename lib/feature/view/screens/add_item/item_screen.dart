import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/utils.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/screens/add_item/widgets/schedule_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/details_storage_view.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/widget/back_btn_widget.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({Key? key, required this.box}) : super(key: key);

  final Box box;
  static ItemViewModle itemViewModle = Get.find<ItemViewModle>();
  static Box? returendBox;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: colorBackground,
        actions: [
          IconButton(
              onPressed: () {
                itemViewModle.showAddItemBottomSheet(box: box);
              },
              icon: SvgPicture.asset("assets/svgs/add_no_background.svg")),
          SizedBox(
            width: sizeW10,
          ),
        ],
        leading: BackBtnWidget(),
        centerTitle: true,
        title: Text(
          "${box.storageName}",
          style: textStyleAppBarTitle(),
        ),
      ),
      body: GetBuilder<ItemViewModle>(
        init: ItemViewModle(),
        initState: (_) async {
          returendBox =
              await itemViewModle.getBoxBySerial(serial: box.serialNo ?? "");
          itemViewModle.update();
        },
        builder: (_) {
          return  Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding20!),
                  child: Stack(
                    children: [
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
                                itemViewModle.showAddItemBottomSheet(box: box);
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
              
        },
      ),
    );
  }
}
