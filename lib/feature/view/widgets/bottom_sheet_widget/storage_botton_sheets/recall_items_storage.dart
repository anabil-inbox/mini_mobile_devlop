// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/core/spacerd_color.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/model/home/task.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/recall_box_process%20.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_clients/feature/view_model/home_view_model/home_view_model.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';

import '../../custome_text_view.dart';
import 'selected_item_bottom_sheet.dart';

class RecallStorageSheet extends StatelessWidget {
  const RecallStorageSheet(
      {Key? key,
      required this.box,
      this.index,
      this.isUserSelectItem = false,
      required this.task})
      : super(key: key);

  final Box box;
  final int? index;
  final bool? isUserSelectItem;
  static HomeViewModel _homeViewModel = Get.find<HomeViewModel>();
  static StorageViewModel _storageViewModel = Get.find<StorageViewModel>();
  final Task task;

  ///   todo at home = pick up
  ///   todo at where house  = recall => fetch
  ///todo 1-	Pick up
  ///to do بيحدد الصندوق او الصناديق من ضمن الموجود في المنزل ثم
  ///to do يختار الوقت والتاريخ والعنوان والاضافات
  ///to do بعدها عملية الدفع
  ///to do
  ///todo 2-	Recall
  ///to do بيحدد الصندوق او الصناديق من ضمن الموجود في المخزن ثم
  ///to do يختار الوقت والتاريخ والعنوان والاضافات
  ///to do بعدها عملية الدفع
  ///to do
  ///todo 3-	Recall (Fetch item)
  ///to do  لما بيختار ايتم معينة بيجيه دايلوج شو بدك نجيب الصندوق كامل او نكسر القفل ونجيب الايتم لوقال
  ///to do Bring the box
  ///to do يعني هاي 2- عملية بيمشي
  ///todo لو اختار Break the seal  معناها fetch
  ///to do المفروض في خطوة هنا اتحليه بظهر ال
  ///to do items
  ///to do اللي عمل الها select
  ///to do ويظهر كم بدو كمية لو ضايف كمية ويختار صورة لكل ايتم من المتوفر ويحط ملاحظات في الاخر بعدها يمشي بسيناريو
  // يختار الوقت والتاريخ والعنوان والاضافات
  // بعدها عملية الدفع
  ///todo 4-Giveaway
  ///to do في ال
  ///giveaway
  ///to do بيختار اول خطوة لاي مؤسسة بدو يتبرع وبعدها لو الصندوق في البيت عندي باعمل خطوة بيختار وقت وتاريخ وعنوان وال
  ///option
  ///to do  وبعدها الدفع

  ///todo if !isUserSelectItem here we will show bottom sheet with  [bring the box , add to cart]
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
              textButton: !isUserSelectItem!
                  ? "${tr.bring_the_box}"
                  : "${tr.yes_break_the_seal}",
            ),
          ),
          SizedBox(
            width: sizeW10,
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: SeconderyFormButton(
                buttonText: !isUserSelectItem!
                    ? "${tr.add_to_cart}"
                    : "${tr.no_bring_the_box}",
                onClicked: onClickBringBox,
              ),
            ),
          ),
          SizedBox(
            width: sizeW10,
          ),
        ],
      );

  Widget get acceptTerms => GetBuilder<StorageViewModel>(
        builder: (value) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  value.isAccept = !value.isAccept;
                  value.update();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    value.isAccept
                        ? SvgPicture.asset("assets/svgs/check.svg")
                        : SvgPicture.asset(
                            "assets/svgs/uncheck.svg",
                            color: seconderyColor,
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
              ),
              InkWell(
                  onTap: () {
                    //Get.to(() => TermsScreen());
                  },
                  child: CustomTextView(
                    txt: "${tr.company_policy}",
                    textAlign: TextAlign.start,
                    textStyle: textStyleUnderLinePrimary()!
                        .copyWith(color: colorBlack, fontSize: fontSize14),
                  )),
            ],
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
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
            height: sizeH20,
          ),
          CustomTextView(
            txt: tr.recall_items,
            textStyle: textStyleNormalBlack()?.copyWith(fontSize: fontSize17),
          ),
          SizedBox(
            height: sizeH12,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeW10!),
            child: CustomTextView(
              txt: tr.are_break_sealing,
              textAlign: TextAlign.center,
              textStyle: textStyleNormalBlack()?.copyWith(fontSize: fontSize17),
            ),
          ),
          SizedBox(
            height: sizeH20,
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
                SvgPicture.asset("assets/svgs/folder_icon.svg"),
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
    );
  }

  onClickBreakSeal() {
    if (_storageViewModel.isAccept) {
      if (!isUserSelectItem!) {
        //todo  [bring the box ]
        Get.back();
        Get.bottomSheet(
            RecallBoxProcessSheet(
              box: box,
              task: task,
              boxes: [],
            ),
            isScrollControlled: true);
      } else {
        //todo  [BreakSeal ]
        Get.back();
        //todo change with bottom sheet item & qty
        Get.bottomSheet(SelectedItemBottomSheet(box: box),
            isScrollControlled: true);
        //Get.to(FilterItemScreen(title: "${tr.filter_by_name}", box: box,serail: box.serialNo,));
      }
    } else {
      snackError("${tr.error_occurred}", "${tr.you_have_to_accept_our_terms}");
    }
  }

  onClickBringBox() {
    if (!isUserSelectItem!) {
      //todo  [ add to cart ]
      Get.back();
    } else {
      //todo  [BringBox ]
      Get.back();
      Get.bottomSheet(
          RecallBoxProcessSheet(
            box: box,
            task: task,
            boxes: [],
          ),
          isScrollControlled: true);
    }
  }
}
