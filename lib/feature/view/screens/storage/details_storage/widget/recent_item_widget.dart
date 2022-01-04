import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class RecentlyItemWidget extends StatelessWidget {
  const RecentlyItemWidget({
    Key? key,
    this.box,
    this.boxItem,
    this.isSelectedBtnClick = false,
    this.onCheckItem,
  }) : super(key: key);

  final Box? box;
  final BoxItem? boxItem;
  final bool? isSelectedBtnClick;
  final Function()? onCheckItem;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetBuilder<ItemViewModle>(
      assignId: true,
      builder: (logic) {
        return Stack(
          children: [
            Container(
              height: sizeH180,
              width: sizeW150,
              margin: EdgeInsets.symmetric(horizontal: sizeW5!),
              alignment: Alignment.center,
              clipBehavior: Clip.hardEdge,
              padding:
                  EdgeInsets.symmetric(horizontal: sizeW24!, vertical: sizeH14!),
              decoration: BoxDecoration(
                color: colorBackground,
                borderRadius: BorderRadius.circular(sizeRadius5!),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(sizeRadius16!),
                    child: imageNetwork(
                        url: (GetUtils.isNull(boxItem!.itemGallery) || boxItem!.itemGallery!.isEmpty)
                            ? urlPlacholder
                            : ConstanceNetwork.imageUrl + boxItem?.itemGallery?[0]["attachment"],
                        height: sizeH85,
                        width: sizeW85,
                        fit: BoxFit.contain),
                  ),
                  SizedBox(
                    height: sizeH10,
                  ),
                  Flexible(
                    child: CustomTextView(
                      txt: "${boxItem?.itemName ?? "Item Name"}",
                      textAlign: TextAlign.center,
                      textStyle: textStyleNormal()?.copyWith(color: colorBlack),
                      maxLine: Constance.maxLineTwo,
                    ),
                  ),
                  SizedBox(
                    height: sizeH4,
                  ),
                  CustomTextView(
                    txt: "Mar 13, 2018",
                    textAlign: TextAlign.center,
                    textStyle: textStyleHint()?.copyWith(
                        fontSize: fontSize12,
                        fontFamily: Constance.Font_regular,
                        fontWeight: FontWeight.normal),
                    maxLine: Constance.maxLineOne,
                  ),
                ],
              ),
            ),
            PositionedDirectional(
              top: 0,
               end: 0,
              child: IconButton(
                color: colorContainerGray,
                onPressed: () {
                  logic.showOptionOperationBottomSheet(box: box!, boxItem: boxItem!);
                },
                icon: SvgPicture.asset("assets/svgs/three_dot_widget.svg"),
              ),),
          ],
        );
      },
    );
  }
}
