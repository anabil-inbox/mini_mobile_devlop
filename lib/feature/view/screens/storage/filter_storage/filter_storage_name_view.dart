import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/btn_action_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/items_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/text_with_contanier_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';

class FilterStorageNameView extends StatelessWidget {
  FilterStorageNameView({Key? key}) : super(key: key);

  List<String> list = [
    "A firstItem",
    "B Secound Item",
    "A firstItem",
    "B Secound Item",
    "A firstItem",
    "B Secound Item",
    "A firstItem",
    "B Secound Item",
  ];

  //todo this for appbar
  PreferredSizeWidget get appBar => CustomAppBarWidget(
        isCenterTitle: true,
        titleWidget: CustomTextView(
          txt: "${tr.filter_by_name}",
          textStyle: textStyleNormal()?.copyWith(color: colorBlack),
          maxLine: Constance.maxLineOne,
        ),
        actionsWidgets: [
          TextButton(
            onPressed: () {},
            child: CustomTextView(
              txt: "${tr.select}",
              textStyle: textStyleNormal()?.copyWith(color: colorRed),
              maxLine: Constance.maxLineOne,
            ),
          ),
        ],
      );

  //todo this for search
  Widget get searchWidget => CustomTextFormFiled(
        iconSize: sizeRadius20,
        maxLine: Constance.maxLineOne,
        icon: Icons.search,
        iconColor: colorBlack,
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.text,
        onSubmitted: (_) {},
        onChange: (_) {},
        isSmallPadding: false,
        isSmallPaddingWidth: true,
        fillColor: colorBackground,
        isFill: true,
        isBorder: true,
        label: tr.search,
      );
  Widget get btnActionsWidget => BtnActionWidget();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.only(top: sizeH20!, left: sizeW20!, right: sizeW20!),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  searchWidget,
                  SizedBox(
                    height: sizeH20,
                  ),
                  // Expanded(
                  //   child: Container(
                  //     clipBehavior: Clip.hardEdge,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(sizeRadius10!),
                  //     ),
                  //     child: ListView.separated(
                  //         shrinkWrap: true,
                  //         physics: customScrollViewIOS(),
                  //         clipBehavior: Clip.antiAlias,
                  //         keyboardDismissBehavior:
                  //         ScrollViewKeyboardDismissBehavior.onDrag,
                  //         itemBuilder: (context, index) => const ItemsWidget(),
                  //         separatorBuilder: (context, index) => Divider(
                  //           height: sizeH1,
                  //         ),
                  //         itemCount: list.length),
                  //   ),
                  // )
                  Expanded(
                    child: GroupedListView<dynamic, String>(
                      elements: list,
                      groupBy: (element) => element[0] /*['group']*/,
                      groupSeparatorBuilder: (String groupByValue) => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: sizeH10,),
                          SizedBox(
                              width: sizeW30,
                              height: sizeH31,
                              child: TextContainerWidget(
                                colorBackground: colorRedTrans,
                                txt: groupByValue,
                              ),),
                          SizedBox(height: sizeH10,),
                        ],
                      ) /*, Text(groupByValue , textAlign: TextAlign.start,)*/,
                      itemBuilder: (context, dynamic element) =>
                          ItemsWidget(),
                      itemComparator: (item1, item2) =>
                          item1[0] /*['name']*/ .compareTo(item2[0] /*['name']*/),
                      // optional
                      useStickyGroupSeparators: false,
                      // optional
                      floatingHeader: false,
                      // optional
                      order: GroupedListOrder.ASC,
                      // optional
                      physics: customScrollViewIOS(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          btnActionsWidget,
          SizedBox(
            height: Platform.isIOS ? sizeH20:sizeH10,
          ),
        ],
      ),
    );
  }
}
