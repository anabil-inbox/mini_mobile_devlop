import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/profile/subscriptions/widget/my_subscription_item.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/filter_bottom_sheet.dart';
import 'package:inbox_clients/feature/view/widgets/icon_btn.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:logger/logger.dart';

class MySubscriptionsView extends StatelessWidget {
  const MySubscriptionsView({Key? key}) : super(key: key);

  PreferredSizeWidget get myAppbar =>
      AppBar(
        automaticallyImplyLeading: true,
        elevation: 1,
        title: Text(
          "${tr.my_subscriptions}",
          style: textStyleAppBarTitle(),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(Get.context!);
          },
          icon: isArabicLang()
              ? SvgPicture.asset("assets/svgs/back_arrow_ar.svg")
              : SvgPicture.asset("assets/svgs/back_arrow.svg"),
        ),
        centerTitle: true,
        backgroundColor: colorBackground,
        actions: [
          GetBuilder<ProfileViewModle>(
              builder: (logic) {
                return IconBtn(
                  onPressed: () {
                    Get.bottomSheet(FilterBottomSheet(title: tr.filter_by_type,
                      onItemBtnClick: ()=> _onItemBtnClick(logic),
                      onQtyBtnClick: ()=> _onQtyBtnClick(logic),
                      onClearBtnClick: ()=> _onClearBtnClick(logic),
                      onSpaceBtnClick: () => _onSpaceBtnClick(logic),));
                  },
                  icon: "assets/svgs/Filter.svg",
                  height: sizeH30,
                  width: sizeW30,
                  backgroundColor: colorTextWhite,
                  borderColor: colorTextWhite,
                  iconColor: colorBlack,
                );
              })
        ],
      );

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: myAppbar,
      body: GetBuilder<ProfileViewModle>(builder: (logic) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(logic.isLoading)...[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 3,),
                  Center(child: CircularProgressIndicator(),),
                ],
              ),
            ] else
              if (!logic.isLoading && (logic.subscriptions != null &&
                  logic.subscriptions!.isEmpty))...[
                RefreshIndicator(
                  onRefresh:()=> _onRefresh(logic),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                         SizedBox(height: MediaQuery.of(context).size.height / 3,),
                      Center(child: Text(tr.empty_subscriptions),),
                      SizedBox(height: MediaQuery.of(context).size.height / 3,),
                    ],
                  ),
                ),
              ] else
                ...[
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh:()=> _onRefresh(logic),
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: sizeH20!, bottom: sizeH58!),
                        itemCount: logic.subscriptions?.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            MySubscriptionsItem(
                                subscriptions: logic.subscriptions?[index]),
                      ),
                    ),
                  ),
                ],

          ],
        );
      }),
    );
  }

  _onItemBtnClick(ProfileViewModle logic) {
    Logger().d("_onItemBtnClick");
    Get.back();
    logic.filterSubscriptions(LocalConstance.itemConst);
  }

  _onQtyBtnClick(ProfileViewModle logic) {
    Logger().d("_onQtyBtnClick");
    Get.back();
    logic.filterSubscriptions(LocalConstance.quantityConst);
  }

  _onSpaceBtnClick(ProfileViewModle logic) {
    Logger().d("_onSpaceBtnClick");
    Get.back();
    logic.filterSubscriptions(LocalConstance.spaceConst);
  }

  _onClearBtnClick(ProfileViewModle logic) {
    Logger().d("_onClearBtnClick");
    Get.back();
    logic.filterSubscriptions("");
  }

  Future<void> _onRefresh(ProfileViewModle logic) async{
    logic.filterSubscriptions("");
    await Future.delayed(Duration(seconds: 0));
  }
}
