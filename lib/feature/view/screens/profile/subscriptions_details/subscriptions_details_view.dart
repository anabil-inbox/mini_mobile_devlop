import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/profile/invoices_model.dart';
import 'package:inbox_clients/feature/model/subscription_data.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/widgets/my_order_time_widget.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/widgets/status_widget.dart';
import 'package:inbox_clients/feature/view/screens/profile/invoice/widget/my_invoices_item.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_clients/feature/view/widgets/primary_button.dart';
import 'package:inbox_clients/feature/view/widgets/secondery_button.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/constance/constance.dart';
import 'package:logger/logger.dart';

import '../../../../../util/font_dimne.dart';
import '../../../../view_model/home_view_model/home_view_model.dart';
import '../../../../view_model/item_view_modle/item_view_modle.dart';
import '../../../widgets/bottom_sheet_widget/gloable_bottom_sheet.dart';
import '../../items/item_screen.dart';
import '../../items/widgets/notifay_for_new_storage.dart';

class SubscriptionsDetailsView extends StatelessWidget {
  const SubscriptionsDetailsView({
    Key? key,
    this.subscriptions,
  }) : super(key: key);

  final SubscriptionData? subscriptions;
  HomeViewModel get homeViewModel =>  Get.find<HomeViewModel>();
  ItemViewModle get itemViewModle =>  Get.find<ItemViewModle>();

  Widget get bodyOrderDetailes {
    //to do this when The Status Is An Task :
    if (subscriptions?.plans != null && subscriptions!.plans!.isNotEmpty)
      return ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: subscriptions?.plans?.length,
        itemBuilder: (context, index) {
          var plan = subscriptions?.plans?[index];
          return InkWell(
            onTap: (){
              var firstWhere = homeViewModel.userBoxess.toList().firstWhere((element) => element.id == subscriptions?.serialNo);
              var index =homeViewModel.userBoxess.toList().indexOf(firstWhere);
              if (homeViewModel.userBoxess.toList()[index].storageStatus ==  LocalConstance.boxOnTheWay &&
                  !homeViewModel.userBoxess.toList()[index].isPickup!) {
                Get.bottomSheet(
                    NotifayForNewStorage(
                        box: homeViewModel.userBoxess.toList()[index],
                        showQrScanner: true,
                        index: index),
                    isScrollControlled: true);
                homeViewModel.update();
              } else {
                Get.to(() => ItemScreen(
                  box: homeViewModel.userBoxess.toList()[index],
                  getBoxDataMethod: () async {
                    await itemViewModle.getBoxBySerial(
                        serial: homeViewModel.userBoxess
                            .toList()[index]
                            .serialNo!);
                  },
                ));
                homeViewModel.update();
                itemViewModle.update();
              }
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(sizeRadius16!),
              margin: EdgeInsets.only(bottom: sizeH10!),
              decoration: BoxDecoration(
                  color: colorBackground,
                  borderRadius: BorderRadius.circular(padding6!)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "${plan?.plan != null ? plan?.plan.toString().replaceAll("_", " ").toString().replaceAll("-", " ") : ""}"),
                  SizedBox(
                    height: sizeH12,
                  ),
                  Text(
                    "${tr.box_name} : ${subscriptions?.serialNo ?? ""}",
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: colorInWarehouse,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize14),
                  ),
                ],
              ),
            ),
          );
        },
      );
    return const SizedBox.shrink();
  }

  ProfileViewModle get viewModel => Get.put(ProfileViewModle());

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      bottomSheet: GetBuilder<ProfileViewModle>(builder: (logic) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: subscriptions?.status != LocalConstance.subscriptionActive
              ? const SizedBox.shrink()
              : PrimaryButton(
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
        onBackBtnClick: () {
          viewModel.invoicesSelectedId.clear();
          viewModel.update();
          Get.back();
        },
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

                    if((subscriptions!.paidInvoices != null &&
                        subscriptions!.paidInvoices!.isNotEmpty))...[
                      SizedBox(
                        height: sizeH10,
                      ),
                      Row(
                        children: [
                          Text(tr.paid_invoices ,textAlign: TextAlign.start,),
                        ],
                      ),
                      SizedBox(
                        height: sizeH10,
                      ),
                      ListView.separated(
                        // padding: EdgeInsets.only(
                        //     left: sizeW10!, top: sizeH20!, right: sizeW10!),
                        itemCount: subscriptions!.paidInvoices!.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return MyInvoicesItem(
                            isPadInv:true,
                            invoices: InvoicesData(
                                name: subscriptions!.paidInvoices![index].name,
                                total: subscriptions!.paidInvoices![index].total,
                                paymentEntryId: subscriptions!
                                    .paidInvoices![index].paymentEntryId),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                      ),
                      SizedBox(
                        height: sizeH10,
                      ),
                    ],

                    if (subscriptions!.invoices != null &&
                        subscriptions!.invoices!.isNotEmpty) ...[
                      SizedBox(
                        height: sizeH10,
                      ),

                      Row(
                        children: [
                          Text(tr.unpaid_invoices ,textAlign: TextAlign.start,),
                        ],
                      ),
                      SizedBox(
                        height: sizeH10,
                      ),
                      ListView.separated(
                        // padding: EdgeInsets.only(
                        //     left: sizeW10!, top: sizeH20!, right: sizeW10!),
                        itemCount: subscriptions!.invoices!.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return MyInvoicesItem(
                            invoices: InvoicesData(
                                name: subscriptions!.invoices![index].name,
                                total: subscriptions!.invoices![index].total,
                                paymentEntryId: subscriptions!
                                    .invoices![index].paymentEntryId),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                      ),
                      SizedBox(
                        height: sizeH10,
                      ),
                      PrimaryButton(
                        colorBtn: colorBtnGray,
                        colorText: colorBlack,
                        textButton:
                            "${tr.ok} (${myOrders.getTotalInvoiceSubPrice(subscriptions!.invoices!)})",
                        onClicked: onClicked,
                        isExpanded: true,
                        isLoading: myOrders.isLoading,
                      )
                    ],
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
      onCancelBtnClick: () => Get.back(),
      onOkBtnClick: () {
        Get.back();
        logic.onTerminateSubscriptions(subscriptions);
      },
      isDelete: false,
    ));
  }

  onClicked() {
    if (viewModel.invoicesSelectedId.isNotEmpty) {
      viewModel.getInvoiceUrlPayment(subscriptions!.invoices!);
    }
  }
}
