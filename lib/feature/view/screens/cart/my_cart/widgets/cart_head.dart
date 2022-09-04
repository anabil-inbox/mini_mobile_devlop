import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/gloable_bottom_sheet.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/storage_botton_sheets/recall_box_process%20.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view_model/cart_view_model/cart_view_model.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/local_database/model/cart_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/date_time_util.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class CartHead extends StatelessWidget {
  const CartHead({
    Key? key,
    this.cartModel,
    this.cartViewModel,
  }) : super(key: key);
  final CartModel? cartModel;
  final CartViewModel? cartViewModel;

  StorageViewModel get storageViewModel => Get.find<StorageViewModel>();

  Widget get lvBoxes => ListView.builder(
        itemCount: cartModel?.box?.length,
        padding: EdgeInsets.symmetric(horizontal: sizeW10!),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          // here we will show to item [one for list of box , two for list of items]
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextView(
                txt: "${cartModel?.box?[index].storageName}",
                maxLine: Constance.maxLineOne,
                textStyle: textStyleNormalBlack(),
              ),
              if (cartModel?.box?[index].items != null &&
                  cartModel?.box?[index].items?.length != 0)
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: sizeW10!, vertical: sizeH2!),
                  decoration: BoxDecoration(
                      color: seconderyButton,
                      borderRadius: BorderRadius.circular(sizeRadius5!)),
                  child: CustomTextView(
                    txt: "${cartModel?.box?[index].items?.length ?? ""}",
                    maxLine: Constance.maxLineOne,
                    textStyle: textStyleNormalBlack(),
                  ),
                ),
              // CustomTextView(
              //   txt:
              //       "${storageViewModel.calculateTaskPriceOnceBox(task: cartModel!.task!)}",
              //   maxLine: Constance.maxLineOne,
              //   textStyle: textStyleNormalBlack()?.copyWith(color: colorRed),
              // ),
            ],
          );
        },
      );

  Widget get lvBoxItems => ListView.builder(
        itemCount: cartModel?.boxItem?.length,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: sizeW10!),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          // here we will show to item [one for list of box , two for list of items]
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextView(
                txt: "${cartModel?.boxItem?[index].itemName}",
                maxLine: Constance.maxLineOne,
                textStyle: textStyleNormalBlack(),
              ),
              CustomTextView(
                txt: "${cartModel?.boxItem?[index].itemQuantity ?? ""}",
                maxLine: Constance.maxLineOne,
                textStyle: textStyleNormalBlack()?.copyWith(color: colorRed),
              ),
            ],
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(padding6!)),
      child: Column(
        children: [
          SizedBox(
            height: sizeH16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: sizeW10,
              ),
              SvgPicture.asset("assets/svgs/folder_icon.svg"),
              SizedBox(
                width: sizeW10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("${cartModel?.title}"),
                      SizedBox(width: sizeW5),
                      Text(
                        "${storageViewModel.calculateTaskPriceLotBoxess(task: cartModel!.task!, boxess: cartModel?.box ?? [], isFromCart: true, myAddresss: cartModel?.address, isFirstPickUp: cartModel!.isFirstPickUp!)}",
                        style: textStylePrimarySmall(),
                      ),
                    ],
                  ),
                  if (cartModel?.box != null && cartModel!.box!.isNotEmpty)
                    Text(
                      "${cartModel?.box != null && cartModel!.box!.isNotEmpty ? "${cartModel!.box!.first.id}" : ""}",
                      style: textStylePrimarySmall(),
                    ),
                  if (cartModel?.address?.addressTitle != null)
                    Text(
                      "${cartModel?.address?.addressTitle}",
                      style: textStyleHints()!.copyWith(fontSize: fontSize13),
                    ),
                  if (cartModel?.orderTime?.delivery != null)
                    Text(
                      "${DateUtility.dateFormatNamed(txtDate: "${cartModel?.orderTime?.delivery.toString()}")}",
                      style: textStyleHints()!.copyWith(fontSize: fontSize13),
                    ),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: _updateCartItem,
                child: ClipOval(
                  child: SvgPicture.asset(
                    "assets/svgs/edit_btn.svg",
                    fit: BoxFit.cover,
                    width: sizeW36,
                  ),
                ),
              ),
              SizedBox(
                width: sizeW5,
              ),
              InkWell(
                onTap: _deleteCartItem,
                child: ClipOval(
                  child: SvgPicture.asset(
                    "assets/svgs/delete_box_widget_orange.svg" /*delete_box_widget*/,
                    fit: BoxFit.cover,
                    width: sizeW36,
                  ),
                ),
              ),
              SizedBox(
                width: sizeW10,
              ),
            ],
          ),
          // SizedBox(height: sizeH18,),
          if ((cartModel?.box != null && cartModel?.box?.length != 0) ||
              (cartModel?.boxItem != null && cartModel?.boxItem?.length != 0))
            ExpandablePanel(
              header: const SizedBox.shrink(),
              collapsed: const SizedBox.shrink(),
              expanded: (cartModel?.box != null && cartModel?.box?.length != 0)
                  ? lvBoxes
                  : lvBoxItems,
              theme: ExpandableThemeData(
                tapHeaderToExpand: true,
                hasIcon: true,
              ),
            ),
          SizedBox(
            height: sizeH10,
          ),
        ],
      ),
    );
  }

  void _deleteCartItem() {
    Get.bottomSheet(GlobalBottomSheet(
      title: tr.are_you_sure_you_want_to_delete_cart_item,
      isTwoBtn: true,
      onCancelBtnClick: () {
        Get.back();
      },
      onOkBtnClick: () {
        cartViewModel?.deleteItemCart(cartModel!);
        cartViewModel?.cartList.remove(cartModel);
        cartViewModel?.update();
        Get.back();
      },
      isDelete: true,
    ));
  }

  void _updateCartItem() {
    Get.bottomSheet(
        RecallBoxProcessSheet(
          isFirstPickUp: false,
          boxes: cartModel?.box ?? [],
          task: cartModel!.task!,
          box: null,
          isFromCart: true,
          cartModel: cartModel,
          items: cartModel?.boxItem ?? [],
        ),
        isScrollControlled: true);
  }
}
