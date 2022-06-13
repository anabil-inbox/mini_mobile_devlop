import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/recall_box_process%20.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/widget/items_selected_widget.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:inbox_clients/util/font_dimne.dart';
import 'package:logger/logger.dart';

import '../../../screens/auth/terms/terms_view.dart';
import '../../custome_text_view.dart';

class SelectedItemBottomSheet extends StatelessWidget {
  const SelectedItemBottomSheet({Key? key, required this.box})
      : super(key: key);

  final Box box;

  Widget get actionBtn => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: sizeW10,
          ),
          Expanded(
            child: PrimaryButton(
              isExpanded: true,
              isLoading: false,
              onClicked: onClickBreakSeal,
              textButton: "${tr.ok}",
            ),
          ),
          SizedBox(
            width: sizeW10,
          ),
          // Expanded(
          //   child: SizedBox(
          //     width: double.infinity,
          //     child: SeconderyFormButton(
          //       buttonText:!isUserSelectItem!? "${tr.add_to_cart}":"${tr.no_bring_the_box}",
          //       onClicked: onClickBringBox,
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   width: sizeW10,
          // ),
        ],
      );

  Widget get acceptTerms => GetBuilder<StorageViewModel>(
        builder: (value) {
          return TextButton(
            style: TextButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
            ),
            onPressed: () {
              Get.to(() => TermsScreen());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        value.isAccept = !value.isAccept;
                        value.update();
                      },
                      child: value.isAccept
                          ? SvgPicture.asset("assets/svgs/check.svg" ,color: colorPrimary,)
                          : SvgPicture.asset(
                              "assets/svgs/uncheck.svg",
                              color: seconderyColor,
                            ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CustomTextView(
                      txt: "${tr.accept_our} ",
                      textStyle: textStyle(),
                    )
                  ],
                ),
                CustomTextView(
                  txt: "${tr.company_policy}",
                  textAlign: TextAlign.start,
                  textStyle: textStyleUnderLinePrimary()!
                      .copyWith(color: colorBlack, fontSize: fontSize14),
                ),
              ],
            ),
          );
        },
      );

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  static ItemViewModle itemViewModle = Get.find<ItemViewModle>();
  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetBuilder<ItemViewModle>(
        init: ItemViewModle(),
        builder: (logic) {
          Logger().i(logic.listIndexSelected);
          return Container(
            decoration: BoxDecoration(
              color: colorBackground,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(padding30!)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: sizeH30,
                  ),
                  SpacerdColor(),
                  SizedBox(
                    height: sizeH20,
                  ),
                  CustomTextView(
                    txt: "${tr.fetch_item}",
                    textStyle:
                        textStyleNormalBlack()?.copyWith(fontSize: fontSize17),
                  ),
                  SizedBox(
                    height: sizeH12,
                  ),
                  if (box.items != null && box.items?.length != 0)
                    SizedBox(
                      height: MediaQuery.of(Get.context!).size.height / 1.8,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: sizeW10!),
                        child: ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: box.items?.length,
                            itemBuilder: (context, index) {
                              return ItemsSelectedWidget(
                                boxItem: box.items?[index],
                                onCheckItem: () {
                                  bool isFound = logic.listIndexSelected
                                      .contains(box.items?[index]);
                                  if (isFound) {
                                    logic.listIndexSelected.removeWhere(
                                        (element) =>
                                            element == box.items?[index]);
                                  } else {
                                    logic.listIndexSelected
                                        .add(box.items![index]);
                                  }
                                  logic.update();
                                },
                              );
                            }),
                        // itemBuilder: (context, index) {
                        //   var where = box.items
                        //       ?.where((element) => logic.listIndexSelected
                        //           .contains(element.itemName))
                        //       .toList();
                        //   return ItemsSelectedWidget(
                        //     boxItem: where?[index],
                        //     onCheckItem: () {
                        //       var i = logic.listIndexSelected.indexOf(
                        //           "${where?[index].itemName.toString()}");
                        //       logic.listIndexSelected
                        //           .removeAt(i == -1 ? 0 : i);
                        //       if (logic.listIndexSelected.isEmpty) {
                        //         Get.back();
                        //       }
                        //       logic.update();
                        //     },
                        //   );
                        // }),
                      ),
                    ),
                  SizedBox(
                    height: sizeH16,
                  ),
                  actionBtn,
                  SizedBox(
                    height: sizeH20,
                  ),
                  acceptTerms,
                  SizedBox(
                    height: padding32,
                  ),
                ],
              ),
            ),
          );
        });
  }

  onClickBreakSeal() {
    final Task enterdTask =
        homeViewModel.searchTaskById(taskId: LocalConstance.fetchId);
    Get.back();
    storageViewModel.isAccept = false;
    Get.bottomSheet(
        RecallBoxProcessSheet(
          items: itemViewModle.listIndexSelected,
          box: box,
          task: enterdTask,
          boxes: [box],
          isFetchTask: true,
        ),
        isScrollControlled: true);
  }

  onClickBringBox() {
    // if(!isUserSelectItem!){
    //   //todo  [ add to cart ]
    //   Get.back();
    // }else {
    //   //todo  [BringBox ]
    //   final Task enterdTask = homeViewModel.searchTaskById(taskId: LocalConstance.recallId);
    //   Get.back();
    //   Get.bottomSheet(RecallBoxProcessSheet(box: box , boxes: [box],task: ,), isScrollControlled: true);
    // }
    final Task enterdTask =
        homeViewModel.searchTaskById(taskId: LocalConstance.recallId);
    Get.back();
    Get.bottomSheet(
        RecallBoxProcessSheet(
          box: box,
          boxes: [box],
          task: enterdTask,
        ),
        isScrollControlled: true);
  }
}
