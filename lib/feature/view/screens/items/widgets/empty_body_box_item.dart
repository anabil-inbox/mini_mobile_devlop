import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/bottom_sheet_payment_widaget.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/recall_box_process%20.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:logger/logger.dart';

class EmptyBodyBoxItem extends StatelessWidget {
  const EmptyBodyBoxItem({Key? key, required this.box, required this.isEnabel})
      : super(key: key);

  static ItemViewModle itemViewModle = Get.find<ItemViewModle>();
  static HomeViewModel _homeViewModel = Get.find<HomeViewModel>();

  final Box? box;
  final bool isEnabel;

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
            child: GetBuilder<ItemViewModle>(
              builder: (item) {
                return Column(
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        itemViewModle.showAddItemBottomSheet(
                          box: box!,
                        );
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
                      "${tr.add_your_item_in_box}",
                      style: textStyleHints(),
                    ),
                    SizedBox(
                      height: sizeH50,
                    ),
                    item.operationsBox?.saleOrder == null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PrimaryButton(
                                isExpanded: false,
                                isLoading: false,
                                onClicked: () {
                                  final interdTask =
                                      _homeViewModel.searchTaskById(
                                          taskId: LocalConstance.pickupId);
                                  Get.bottomSheet(
                                      RecallBoxProcessSheet(
                                          task: interdTask,
                                          box: itemViewModle.operationsBox ??
                                              box!,
                                          boxes: [box!]),
                                      isScrollControlled: true);
                                },
                                textButton: tr.schedule_pickup,
                              ),
                              SizedBox(
                                width: sizeW12,
                              ),
                              SizedBox(
                                width: sizeW150,
                                child: SeconderyFormButton(
                                  buttonText: "${tr.ready_to_pickup}",
                                  onClicked: () {
                                    final interdTask =
                                        _homeViewModel.searchTaskById(
                                            taskId: LocalConstance.pickupId);
                                    Get.bottomSheet(
                                        BottomSheetPaymentWidget(
                                            beneficiaryId: "",
                                            task: interdTask,
                                            box: itemViewModle.operationsBox ??
                                                box!,
                                            boxes: [box!]),
                                        isScrollControlled: true);
                                  },
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
