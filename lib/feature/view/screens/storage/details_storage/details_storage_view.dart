import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/btn_action_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/items_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/recent_item_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/details_storage/widget/text_with_contanier_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/filter_storage/filter_storage_name_view.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view/widgets/icon_btn.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_button.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance.dart';
import 'package:inbox_clients/util/font_dimne.dart';

class StorageDetailsView extends StatelessWidget {
  const StorageDetailsView({Key? key}) : super(key: key);

  //todo this for appbar
  PreferredSizeWidget get appBar => CustomAppBarWidget(
        isCenterTitle: true,
        titleWidget: CustomTextView(
          txt: "New Box 01",
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
        fun:_goToFilterNameView ,
        isReadOnly: true,
        isSmallPadding: false,
        isSmallPaddingWidth: true,
        fillColor: colorBackground,
        isFill: true,
        isBorder: true,
        label: tr.search,
      );

  //todo this for item titles
  Widget get headItemWidget => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextView(
            txt: "${tr.items}",
            textStyle: textStyleNormal()?.copyWith(color: colorBlack),
            maxLine: Constance.maxLineOne,
          ),
          TextContainerWidget(colorBackground: colorRedTrans,txt: tr.name,),
        ],
      );

  Widget get btnActionsWidget => BtnActionWidget();


  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  top: sizeH20!, left: sizeW20!, right: sizeW20!),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  searchWidget,
                  SizedBox(
                    height: sizeH20,
                  ),
                  CustomTextView(
                    txt: "${tr.recently_added}",
                    textStyle: textStyleNormal()?.copyWith(color: colorBlack),
                    maxLine: Constance.maxLineOne,
                  ),
                  SizedBox(
                    height: sizeH10,
                  ),
                  SizedBox(
                    height: sizeH180,
                    child: ListView.builder(
                      clipBehavior: Clip.none,
                      physics: customScrollViewIOS(),
                      itemCount: 10,
                      shrinkWrap: true,
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return const RecentlyItemWidget();
                      },
                    ),
                  ),
                  SizedBox(
                    height: sizeH20,
                  ),
                  headItemWidget,
                  SizedBox(
                    height: sizeH10,
                  ),
                  Expanded(
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(sizeRadius10!),
                      ),
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: customScrollViewIOS(),
                          clipBehavior: Clip.antiAlias,
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          itemBuilder: (context, index) => const ItemsWidget(),
                          separatorBuilder: (context, index) => Divider(
                                height: sizeH1,
                              ),
                          itemCount: 10),
                    ),
                  ),
                  SizedBox(
                    height: sizeH20,
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



  void _goToFilterNameView() {
    Get.to(()=> FilterStorageNameView());
  }
}
