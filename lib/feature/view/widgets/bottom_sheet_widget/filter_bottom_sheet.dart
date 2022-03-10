import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet(
      {Key? key,
      this.title, this.onQtyBtnClick, this.onSpaceBtnClick, this.onItemBtnClick, this.onClearBtnClick,
      })
      : super(key: key);
  final String? title;
  final Function()? 
  onQtyBtnClick,
  onSpaceBtnClick,
  onClearBtnClick,
  onItemBtnClick;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      // height: sizeH300,
      decoration: BoxDecoration(
          color: colorTextWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      padding: EdgeInsets.symmetric(horizontal: sizeH20!),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: sizeH25),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: sizeH5,
              width: sizeW50,
              decoration: BoxDecoration(
                  color: colorContainerGrayLight,
                  borderRadius: BorderRadius.circular(sizeRadius5!)),
            ),
          ),
          if (title.toString().isNotEmpty) ...[
            SizedBox(height: sizeH25),
            CustomTextView(
              txt: "$title",
              textAlign: TextAlign.center,
              textStyle: textStyleTitle(),
            ),
          ],
          SizedBox(
            height: sizeH28,
          ),
          PrimaryButton(
              isLoading: false,
              colorBtn: colorTextWhite,
              colorText: colorBlack,
              textButton: "${tr.quantity}",
              width: double.infinity ,
              onClicked: ()=> onQtyBtnClick!(),
              isExpanded: true),
          SizedBox(
            height: sizeH10,
          ),
          PrimaryButton(
              isLoading: false,
              colorBtn: colorTextWhite,
              colorText: colorBlack,
              textButton: "${tr.space}",
              width: double.infinity ,
              onClicked: ()=> onSpaceBtnClick!(),
              isExpanded: true),
          SizedBox(
            height: sizeH10,
          ),
          PrimaryButton(
              isLoading: false,
              colorBtn: colorTextWhite,
              colorText: colorBlack,
              textButton: "${tr.items}",
              width: double.infinity ,
              onClicked: ()=> onItemBtnClick!(),
              isExpanded: true),
          SizedBox(
            height: sizeH10,
          ),
          PrimaryButton(
              isLoading: false,
              colorBtn: colorTextWhite,
              colorText: colorPrimary,
              textButton: "${tr.clear}",
              width: double.infinity ,
              onClicked: ()=> onClearBtnClick!(),
              isExpanded: true),
          SizedBox(
            height: sizeH10,
          ),
          SizedBox(
            height: sizeH34,
          )
        ],
      ),
    );
  }
}
