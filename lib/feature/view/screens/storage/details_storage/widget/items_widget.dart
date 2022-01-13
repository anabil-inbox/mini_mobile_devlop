import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/screens/items/widgets/add_item_widget.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view/widgets/icon_btn.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({
    Key? key,
    required this.box,
    this.isSelectedBtnClick = false,
    this.onCheckItem,
    this.boxItem,
//      required this.itemIndex
  }) : super(key: key);
  final bool? isSelectedBtnClick;
  final Function()? onCheckItem;
  final BoxItem? boxItem;
  final Box box;
  // final int itemIndex;

  static ItemViewModle itemViewModle = Get.find<ItemViewModle>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetBuilder<ItemViewModle>(builder: (logic) {
      return Container(
        height: sizeH75,
        width: double.infinity,
        padding: EdgeInsets.all(padding16!),
        decoration: BoxDecoration(
          color: colorBackground,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isSelectedBtnClick!)
              SizedBox(
                width: sizeW40,
                child: TextButton(
                  onPressed: onCheckItem ?? () {},
                  child: logic.listIndexSelected
                              .contains(boxItem?.itemName ?? "")/* ||
                          logic.isSelectAllClick*/
                      ? SvgPicture.asset("assets/svgs/storage_check_active.svg")
                      : SvgPicture.asset(
                          "assets/svgs/storage_check_deactive.svg"),
                ),
              )
            else
              const SizedBox(),
            ClipRRect(
              borderRadius: BorderRadius.circular(sizeRadius16!),
              child: imageNetwork(
                  url: (GetUtils.isNull(boxItem!.itemGallery) ||
                          boxItem!.itemGallery!.isEmpty)
                      ? urlPlacholder
                      : "${ConstanceNetwork.imageUrl}${(boxItem?.itemGallery?[0].attachment ?? urlPlacholder)}",
                  height: sizeH48,
                  width: sizeW45,
                  fit: BoxFit.contain),
            ),
            SizedBox(
              width: sizeW10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: CustomTextView(
                      txt: "${boxItem?.itemName ?? "Item Name"}",
                      textStyle: textStyleNormal()?.copyWith(color: colorBlack),
                      maxLine: Constance.maxLineTwo,
                    ),
                  ),
                  SizedBox(
                    height: sizeH4,
                  ),
                  CustomTextView(
                    txt: "Mar 13, 2012",
                    textStyle: textStyleHint()?.copyWith(
                        fontSize: fontSize12,
                        fontFamily: Constance.Font_regular,
                        fontWeight: FontWeight.normal),
                    maxLine: Constance.maxLineOne,
                  ),
                ],
              ),
            ),
            logic.isSelectBtnClick!
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      itemViewModle.showOptionOperationBottomSheet(
                          box: box, boxItem: boxItem!);
                    },
                    icon: SvgPicture.asset("assets/svgs/three_dot_widget.svg"),
                  )

            // PopupMenuButton<int>(
            //     icon: SvgPicture.asset("assets/svgs/three_dot_widget.svg"),
            //     itemBuilder: (BuildContext context) => [
            //           PopupMenuItem<int>(value: 1, child: Text('Delete')),
            //           PopupMenuItem<int>(value: 2, child: Text('Update')),
            //           PopupMenuItem<int>(value: 3, child: Text('Share')),
            //         ],
            //     onSelected: (int value) {
            //       switch (value) {
            //         case 1:
            //           {
            // itemViewModle.deleteItem(
            //   id: boxItem?.id ?? "",
            //   serialNo: box.serialNo ?? "",
            // );
            // box.items?.removeWhere((element) =>
            //     element.itemName == boxItem?.itemName);
            // itemViewModle.update();
            //             return;
            //           }
            //         case 2:
            //           {
                        // Get.bottomSheet(
                        //     AddItemWidget(
                        //       isUpdate: true,
                        //       box: box,
                        //       boxItem: boxItem!,
                        //     ),
                        //     isScrollControlled: true);
            //             return;
            //           }
            //         case 3:
                      // {
                      //   itemViewModle.shareItem(boxItem: boxItem!);
                      // }
            //           return;
            //       }
            //     })
          ],
        ),
      );
    });
  }
}
