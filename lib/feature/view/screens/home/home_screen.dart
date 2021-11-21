import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_clients/feature/view/widgets/empty_state/home_empty_statte.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/constance.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);
//todo this for search
  Widget get searchWidget => Row(
    children: [
      Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: colorScaffoldRegistrationBody,
        ),
        padding: EdgeInsets.symmetric(horizontal: sizeH20!),
        child: SvgPicture.asset(
          "assets/svgs/search_icon.svg",
        ),
      ),
      SizedBox(height: sizeH16,),
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
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            EmptyHomeWidget(),
            CustomAppBarWidget(
              isCenterTitle: true,
              titleWidget: searchWidget,
              // titleWidget: ,
              // leadingWidget: ,
              // leadingWidth: ,
              actionsWidgets: [],
            ),
          ],
        ),
      ),
    );
  }

  void _goToFilterNameView() {
  }
}