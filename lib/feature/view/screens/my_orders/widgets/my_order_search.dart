import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_clients/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/constance.dart';

class MyOrderSearch extends StatelessWidget {
  const MyOrderSearch({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        height: sizeH50,
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.symmetric(horizontal: sizeW13!),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(sizeRadius10!),
            color: colorTextWhite,
            border: Border.all(color: colorBorderContainer)),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/svgs/search_icon.svg",
            ),
            Expanded(
              child: CustomTextFormFiled(
                maxLine: Constance.maxLineOne,
                textInputAction: TextInputAction.search,
                keyboardType: TextInputType.text,
                onSubmitted: (_) {},
                onChange: (_) {},
                fun: (){},
                isReadOnly: true,
                isSmallPadding: false,
                isSmallPaddingWidth: true,
                fillColor: colorBackground,
                isFill: true,
                isBorder: true,
              ),
            ),
            SvgPicture.asset(
              "assets/svgs/Filter.svg",
            ),
          ],
        ),
      );

;
  }
}