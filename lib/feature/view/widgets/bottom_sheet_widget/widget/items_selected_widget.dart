import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/home/Box_modle.dart';
import 'package:inbox_clients/feature/view/screens/items/widgets/qty_widget.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/item_view_modle/item_view_modle.dart';
import 'package:inbox_clients/network/utils/constance_netwoek.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';

class ItemsSelectedWidget extends StatelessWidget {
  const ItemsSelectedWidget({
    Key? key,
    this.onCheckItem,
    this.boxItem,
  }) : super(key: key);

  final Function()? onCheckItem;
  final BoxItem? boxItem;
  static ItemViewModle itemViewModle = Get.find<ItemViewModle>();

  Widget get itemSelectedName => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GetBuilder<ItemViewModle>(
            builder: (logic) {
              return SizedBox(
                width: sizeW40,
                child: TextButton(
                  onPressed: onCheckItem,
                  child: logic.listIndexSelected.contains(boxItem)
                      ? SvgPicture.asset("assets/svgs/storage_check_active.svg")
                      : SvgPicture.asset("assets/svgs/storage_check_deactive.svg"),
                ),
              );
            },
          ),
          SizedBox(
            width: sizeW10,
          ),
          Expanded(
            child: CustomTextView(
              txt: "${boxItem?.itemName ?? ""}",
              textStyle:
                  textStyleNormal()?.copyWith(color: colorBlack, height: 1),
              maxLine: Constance.maxLineTwo,
            ),
          ),
        ],
      );
  Widget get lvImageSelected => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (boxItem?.itemGallery != null &&
              boxItem?.itemGallery?.length != 0) ...[
            CustomTextView(
              txt: "${tr.item_photos}",
              textStyle: textStyleNormal()?.copyWith(color: colorBlack),
              maxLine: Constance.maxLineTwo,
            ),
            SizedBox(
              height: sizeH10,
            ),
            SizedBox(
              height: sizeH85,
              child: ListView.builder(
                physics: customScrollViewIOS(),
                itemCount: boxItem?.itemGallery?.length,
                shrinkWrap: true,
                clipBehavior: Clip.hardEdge,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ImageSelectedItem(
                      itemGallery: boxItem?.itemGallery?[index]);
                },
              ),
            ),
          ]
        ],
      );

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    screenUtil(context);
    return GetBuilder<ItemViewModle>(builder: (logic) {
      return Container(
        // height: sizeH200,
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.only(left: sizeW4!, right: sizeW4!, top: sizeH10!),
        width: double.infinity,
        padding: EdgeInsets.all(padding16!),
        decoration: BoxDecoration(
            color: colorBackground,
            boxShadow: [boxShadowLight()!],
            borderRadius: BorderRadius.circular(sizeRadius10!)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            itemSelectedName,
            SizedBox(
              height: sizeH10,
            ),
            QtyWidget(
              isItemQuantity: true,
              boxItem: boxItem,
            ),
            SizedBox(
              height: sizeH10,
            ),
            lvImageSelected,
            SizedBox(
              height: sizeH10,
            ),
          ],
        ),
      );
    });
  }
}

class ImageSelectedItem extends StatelessWidget {
  const ImageSelectedItem({Key? key, this.itemGallery}) : super(key: key);
  final Attachment? itemGallery;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: sizeW5!),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(sizeRadius16!),
          color: scaffoldColor),
      child: Stack(
        children: [
          imageNetwork(
              url:
                  "${ConstanceNetwork.imageUrl}${itemGallery?.attachment ?? urlPlacholder}",
              height: sizeH80,
              width: sizeW80,
              fit: BoxFit.cover),
          GetBuilder<ItemViewModle>(
            builder: (builder) {
              return PositionedDirectional(
                top: sizeH5,
                end: sizeW5,
                width: sizeW36,
                height: sizeH34,
                child: TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero)),
                  onPressed: /*onCheckItem */ () {
                    if (builder.selectedItmePhotos
                        .contains(itemGallery?.attachment)) {
                      builder.selectedItmePhotos.removeWhere(
                          (element) => element == itemGallery?.attachment);
                    } else {
                      builder.selectedItmePhotos.add(itemGallery?.attachment ?? "");
                    }
                    builder.update();
                 },
                  child: builder.selectedItmePhotos.contains(itemGallery?.attachment)
                      ? SvgPicture.asset("assets/svgs/storage_check_active.svg")
                      : SvgPicture.asset("assets/svgs/storage_check_deactive.svg"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
