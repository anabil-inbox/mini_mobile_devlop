import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_clients/feature/view/widgets/empty_state/home_empty_statte.dart';
import 'package:inbox_clients/feature/view/widgets/icon_btn.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/constance.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);
//todo this for search
  Widget get searchWidget => Container(
    height: sizeH50,
    clipBehavior: Clip.hardEdge,
    padding: EdgeInsets.symmetric(horizontal: sizeW13!),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(sizeRadius10!),
      color: colorTextWhite,
      border: Border.all(color: colorBorderContainer)
    ),
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
            fun:_goToFilterNameView ,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SafeArea(
        child: Stack(
          children: [
            EmptyHomeWidget(),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal:sizeW20! ,vertical:sizeH20! ),
              child: SizedBox(
                height: sizeH50,
                child: CustomAppBarWidget(
                  elevation: 0,
                  appBarColor: scaffoldColor,
                  isCenterTitle: true,
                  titleWidget: searchWidget,
                   leadingWidget:  IconBtn(iconColor:colorTextWhite ,width:sizeW48 ,height:sizeH48 ,backgroundColor: colorRed,onPressed: (){},borderColor:colorTrans ,icon: "assets/svgs/Scan.svg",),
                   leadingWidth: sizeW48,
                  actionsWidgets: [
                    IconBtn(iconColor:colorRed ,width:sizeW48 ,height:sizeH48 ,backgroundColor: colorRedTrans,onPressed: (){},borderColor:colorTrans ,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goToFilterNameView() {
  }
}
