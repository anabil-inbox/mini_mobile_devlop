import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';

class GlobalBottomSheet extends StatelessWidget {
  const GlobalBottomSheet(
      {Key? key,
      this.title,
      this.subTitle,
      this.isTwoBtn = true,
      this.onOkBtnClick,
      this.onCancelBtnClick,  required this.isDelete, })
      : super(key: key);
  final String? title, subTitle;
  final bool? isTwoBtn;
  final Function()?
  onOkBtnClick,
  onCancelBtnClick;
  final bool isDelete;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
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
          if (subTitle.toString().isNotEmpty && subTitle != null ) ...[
            SizedBox(height: sizeH25),
            CustomTextView(
              txt: "$subTitle",
              textStyle: textStyleTitle(),
            ),
          ],
          SizedBox(
            height: sizeH28,
          ),
             Row(
               children: [
                 !isTwoBtn! ? const SizedBox.shrink(): Expanded(
                   child: PrimaryButton(
                       isLoading: false,
                       textButton:isDelete ?tr.no : "${tr.cancle}",
                       width: double.infinity ,
                       onClicked: onCancelBtnClick??(){},
                       colorBtn: colorBtnGray,
                       colorText: colorTextDark,
                       isExpanded: false),
                 ),
                 SizedBox(
                   width: sizeW18,
                 ),
                 Expanded(
                   child: PrimaryButton(
                       isLoading: false,
                       textButton:isDelete ? tr.yes :  "${tr.ok}",
                       width: double.infinity ,
                       onClicked: onOkBtnClick??(){},
                       isExpanded: false),
                 ),
               ],
             ),
          SizedBox(
            height: sizeH34,
          )
        ],
      ),
    );
  }
}
