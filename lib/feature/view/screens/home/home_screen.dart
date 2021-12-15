import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/home/widget/box_gv_widget.dart';
import 'package:inbox_clients/feature/view/screens/home/widget/filter_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view/widgets/empty_state/home_empty_statte.dart';
import 'package:inbox_clients/feature/view/widgets/icon_btn.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';

import 'widget/box_lv_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

//todo this for search
  Widget get searchWidget => Container(
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
                fun: _goToFilterNameView,
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

  Widget get appBar => GetBuilder<StorageViewModel>(builder: (logic) {
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: sizeW20!, vertical: sizeH20!),
          child: SizedBox(
            height: sizeH50,
            child: CustomAppBarWidget(
              elevation: 0,
              appBarColor: (!logic.isStorageCategories.value &&
                      GetUtils.isNull(logic.storageCategoriesList) &&
                      logic.storageCategoriesList.length == 0)
                  ? scaffoldColor
                  : colorBackground,
              isCenterTitle: true,
              titleWidget: searchWidget,
              leadingWidget: IconBtn(
                iconColor: colorTextWhite,
                width: sizeW48,
                height: sizeH48,
                backgroundColor: colorRed,
                onPressed: () {},
                borderColor: colorTrans,
                icon: "assets/svgs/Scan.svg",
              ),
              leadingWidth: sizeW48,
              actionsWidgets: [
                IconBtn(
                  icon: "assets/svgs/Buy.svg",
                  iconColor: colorRed,
                  width: sizeW48,
                  height: sizeH48,
                  backgroundColor: colorRedTrans,
                  onPressed: () {},
                  borderColor: colorTrans,
                ),
              ],
            ),
          ),
        );
      });

  Widget textHintsWidget(text, color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.circle,
          size: sizeRadius16,
          color: color ?? boxColorGray,
        ),
        SizedBox(
          width: sizeW10,
        ),
        CustomTextView(
          txt: text ?? "${tr.on_the_way}",
          maxLine: Constance.maxLineOne,
          textStyle: textStyleNormal(),
          textOverflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          width: sizeW10,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: GetBuilder<StorageViewModel>(
        init: StorageViewModel(),
        assignId: true,
        builder: (logic) {
          if (logic.isStorageCategories.value) {
            return const SizedBox.shrink();
          } else if (!logic.isStorageCategories.value &&
              GetUtils.isNull(logic.storageCategoriesList) &&
              logic.storageCategoriesList.length == 0) {
            return SafeArea(
              child: Stack(
                children: [
                  EmptyHomeWidget(),
                  appBar,
                ],
              ),
            );
          } else {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizeW20!),
                    child: Column(
                      children: [
                        SizedBox(
                          height: sizeH150,
                        ),
                        const FilterWidget(),
                        SizedBox(
                          height: sizeH10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            textHintsWidget("${tr.on_the_way}", null),
                            textHintsWidget(
                                "${tr.in_warehouse}", boxColorOrange),
                            textHintsWidget("${tr.at_home}", boxColorRed),
                          ],
                        ),
                        if(!logic.isListView!)...[
                        GVWidget(),
                        ]else ...[
                          LVWidget(),
                        ],
                      ],
                    ),
                  ),
                ),
                Container(
                    width: double.infinity,
                    height: sizeH120,
                    // padding: EdgeInsets.all(padding10!),
                    decoration: BoxDecoration(
                      color: colorBackground,
                      borderRadius: BorderRadius.circular(sizeRadius5!),
                    ),
                    child: appBar),
              ],
            );
          }
        },
      ),
    );
  }

  void _goToFilterNameView() {}
}
