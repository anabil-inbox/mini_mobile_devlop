import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/subscription_data.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/widgets/my_order_time_widget.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/widgets/status_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance/constance.dart';

import '../../../widgets/bottom_sheet_widget/gloable_bottom_sheet.dart';

class SubscriptionsDetailsView extends StatelessWidget {
  const SubscriptionsDetailsView({
    Key? key,
    this.subscriptions,
  }) : super(key: key);

  final SubscriptionData? subscriptions;

  Widget get bodyOrderDetailes {
    //to do this when The Status Is An Task :
    if (subscriptions?.plans != null && subscriptions!.plans!.isNotEmpty)
      return ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: subscriptions?.plans?.length,
        itemBuilder: (context, index) {
          var plan = subscriptions?.plans?[index];
          return Container(
              width: double.infinity,
              padding: EdgeInsets.all(sizeRadius16!),
              margin: EdgeInsets.only(bottom: sizeH10!),
              decoration: BoxDecoration(
                  color: colorBackground,
                  borderRadius: BorderRadius.circular(padding6!)),
              child: Text("${plan?.plan != null ? plan?.plan.toString().replaceAll("_", " ").toString().replaceAll("-", " "): ""}"));
        },
      );
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      bottomSheet: GetBuilder<ProfileViewModle>(builder: (logic) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: subscriptions?.status  != LocalConstance.subscriptionActive ? const SizedBox.shrink() : PrimaryButton(
              textButton: tr.terminate,
              isLoading: logic.isLoading,
              onClicked: () => _onTerminateClick(logic),
              isExpanded: true),
        );
      }),
      appBar: CustomAppBarWidget(
        elevation: 0,
        titleWidget: Text(
          "${subscriptions?.id}",
          style: textStyleAppBarTitle(),
        ),
        isCenterTitle: true,
        onBackBtnClick: () => Get.back(),
      ),
      body: GetBuilder<ProfileViewModle>(
        builder: (myOrders) {
          if (myOrders.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              primary: true,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: padding20!),
                child: Column(
                  children: [
                    SizedBox(
                      height: sizeH20,
                    ),
                    SizedBox(
                      height: sizeH10,
                    ),
                    StatusWidget(
                      status: "${subscriptions?.status}",
                      statusOriginal: "${subscriptions?.status}",
                      child: TextButton(
                          clipBehavior: Clip.none,
                          style: subscriptions?.status !=
                                  LocalConstance.subscriptionActive
                              ? buttonStyleBackgroundClicable
                              : buttonStyleBackgroundGreen,
                          onPressed: () {},
                          child: CustomTextView(
                            txt: "${subscriptions?.status}",
                            textStyle: subscriptions?.status !=
                                    LocalConstance.subscriptionActive
                                ? textStyleSmall()
                                    ?.copyWith(color: colorPrimary)
                                : textStyleSmall()?.copyWith(color: colorGreen),
                          )),
                    ),
                    SizedBox(
                      height: sizeH10,
                    ),
                    SizedBox(
                      height: sizeH10,
                    ),
                    OrderDateWidget(
                      date: subscriptions?.endDate.toString(),
                    ),
                    SizedBox(
                      height: sizeH10,
                    ),
                    bodyOrderDetailes,
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  _onTerminateClick(ProfileViewModle logic) {
    Get.bottomSheet(GlobalBottomSheet(
      title: tr.subscriptions_terminate,
      subTitle: tr.subscriptions_terminate_message,
      isTwoBtn: true,
      onCancelBtnClick: ()=> Get.back(),
      onOkBtnClick: () {
        Get.back();
        logic.onTerminateSubscriptions(subscriptions);
      }, isDelete: false,
    ));

  }
}
