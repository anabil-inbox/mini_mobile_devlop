import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/subscription_data.dart';
import 'package:inbox_clients/feature/view/screens/home/home_page_holder.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/widgets/my_order_address_widget.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/widgets/my_order_box_item.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/widgets/my_order_time_widget.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/widgets/new_order_item.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/widgets/status_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/price_bottom_sheet_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view_model/my_order_view_modle/my_order_view_modle.dart';
import 'package:inbox_clients/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';


class SubscriptionsDetailsView extends StatelessWidget {
  const SubscriptionsDetailsView(
      {Key? key, this.subscriptions, })
      : super(key: key);

  final SubscriptionData? subscriptions;



  Widget get bodyOrderDetailes {
    //to do this when The Status Is An Task :
    if(subscriptions?.plans != null && subscriptions!.plans!.isNotEmpty)
      return  ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: subscriptions?.plans?.length,
        itemBuilder: (context, index) {
          var plan = subscriptions?.plans?[index];
          return Text("${plan?.plan.toString()}");
        },
      );
    return const SizedBox.shrink();
     }


  // Future<bool> onWillPop() async {
  //   if (widget.isFromPayment) {
  //     Get.off(() => HomePageHolder());
  //   } else {
  //     Get.back();
  //   }
  //   return true;
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: GetBuilder<ProfileViewModle>(
                builder: (builder) {
                  // if (OrderDetailesScreen
                  //     .myOrderViewModle.newOrderSales.totalPrice ==
                  //     null) {
                  //   return const Center(
                  //     child: CircularProgressIndicator(),
                  //   );
                  // }
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding20!),
                    child: Column(
                      children: [
                        SizedBox(
                          height: sizeH20,
                        ),
                        SizedBox(
                          height: sizeH10,
                        ),
                        GetBuilder<ProfileViewModle>(
                          builder: (build) {
                            return StatusWidget(
                              status: "${subscriptions?.status}",
                            );
                          },
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
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
