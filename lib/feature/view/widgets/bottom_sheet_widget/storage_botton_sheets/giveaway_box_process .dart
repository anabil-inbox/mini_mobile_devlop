// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/bottom_sheet_payment_widaget.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/recall_box_process%20.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/widget/bottom_sheet_beneficiary.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:inbox_clients/util/font_dimne.dart';

import '../../custome_text_view.dart';

class GiveawayBoxProcessSheet extends StatelessWidget {
  const GiveawayBoxProcessSheet(
      {Key? key, required this.box, this.index, required this.boxes})
      : super(key: key);

  final Box box;
  final int? index;
  final List<Box> boxes;
  static HomeViewModel _homeViewModel = Get.find<HomeViewModel>();
  static StorageViewModel _storageViewModel = Get.find<StorageViewModel>();

  Widget get actionBtn => Container(
        margin: EdgeInsets.symmetric(horizontal: sizeW10!),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PrimaryButton(
                isExpanded: true,
                isLoading: false,
                onClicked:  onClickGiveaway ,
                textButton: "${tr.giveaway}",
              ),
            ),
            SizedBox(
              width: sizeW10,
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: SeconderyFormButton(
                  buttonText: "${tr.add_to_cart}",
                  onClicked: onClickAddToCart,
                ),
              ),
            ),
          ],
        ),
      );

  Widget get selectCompany => Column(
        children: [
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: sizeH7!, vertical: sizeH7!),
            margin: EdgeInsets.symmetric(horizontal: sizeW10!),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(padding6!),
              boxShadow: [boxShadowLight()!],
              color: colorTextWhite,
            ),
            child: InkWell(
              onTap: () async {
                // storageViewModel.showDatePicker();
              },
              child: GetBuilder<StorageViewModel>(
                init: StorageViewModel(),
                initState: (_) {},
                builder: (_) {
                  return Row(
                    children: [
                      GetBuilder<HomeViewModel>(
                        init: HomeViewModel(),
                        initState: (_) {},
                        builder: (home) {
                          return Text(
                            home.selctedbeneficiary == null
                                ? "${tr.charity_name}"
                                : home.selctedbeneficiary?.name ?? "",
                            style: textStyleHints(),
                          );
                        },
                      ),
                      const Spacer(),
                      !GetUtils.isNull(_storageViewModel.selectedDateTime)
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizeH7!, vertical: sizeH7!),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(padding6!),
                                color: scaffoldSecondery,
                              ),
                              child: Row(
                                children: [
                                  CustomTextView(
                                    txt: "",
                                    textStyle: textStyleHints()!
                                        .copyWith(fontSize: fontSize13),
                                  ),
                                  SvgPicture.asset("assets/svgs/down_arrow.svg")
                                ],
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                Get.bottomSheet(BottomSheetBeneficairy(),
                                    isScrollControlled: true);
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: sizeH7!, vertical: sizeH7!),
                                  child: SvgPicture.asset(
                                      "assets/svgs/down_arrow.svg")),
                            ),
                    ],
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: sizeH16,
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sizeW15!),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(padding30!)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: sizeH30,
            ),
            Align(alignment: Alignment.center, child: SpacerdColor()),
            SizedBox(
              height: sizeH30,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: scaffoldColor,
                  borderRadius: BorderRadius.circular(padding6!)),
              margin: EdgeInsets.symmetric(horizontal: sizeH10!),
              padding: EdgeInsets.symmetric(horizontal: sizeH20!),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: sizeH22,
                  ),
                   SvgPicture.asset("assets/svgs/box_in_ware_house.svg" , width: sizeW40,),
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
            selectCompany,
            actionBtn,
            SizedBox(
              height: padding32,
            ),
          ],
        ),
      ),
    );
  }

  onClickAddToCart() {
    Get.back();
  }

  onClickGiveaway() {
    Get.back();
    if (_homeViewModel.selctedbeneficiary != null) {
      final interdTask =
          _homeViewModel.searchTaskById(taskId: LocalConstance.giveawayId);
      if (boxes.length == 0) {
        if (box.storageStatus == LocalConstance.boxinWareHouse) {
          Get.bottomSheet(
                  BottomSheetPaymentWidget(
                    beneficiaryId: _homeViewModel.selctedbeneficiary?.id ?? "",
                    box: box,
                    task: interdTask,
                    boxes: [box],
                  ),
                  isScrollControlled: true)
              .whenComplete(() => {_homeViewModel.selctedbeneficiary = null});
        } else {
          Get.bottomSheet(
              RecallBoxProcessSheet(

                boxes: [box],
                box: box,
                task: interdTask, isFirstPickUp: box.firstPickup! && interdTask.id == LocalConstance.pickupId,
              ),
              isScrollControlled: true);
        }
      } else {
        if (!(_storageViewModel.doseBoxInHome(
          boxess: _homeViewModel.selctedOperationsBoxess.toList(),
        ))) {
          Get.bottomSheet(
              BottomSheetPaymentWidget(
                beneficiaryId: _homeViewModel.selctedbeneficiary?.id ?? "",
                box: _homeViewModel.selctedOperationsBoxess.toList()[0],
                boxes: _homeViewModel.selctedOperationsBoxess.toList(),
                task: interdTask,
              ),
              isScrollControlled: true);
        } else {
          Get.bottomSheet(
              RecallBoxProcessSheet(
                  isFirstPickUp: box.firstPickup! && interdTask.id == LocalConstance.pickupId,
                  box: _homeViewModel.selctedOperationsBoxess.toList()[0],
                  boxes: _homeViewModel.selctedOperationsBoxess.toList(),
                  task: interdTask),
              isScrollControlled: true);
        }
      }
    } else {
      snackError(
          "${tr.error_occurred}", "${tr.you_have_to_select_beneficiary}");
    }
  }

}
