import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/home/home_page_holder.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/widgets/my_order_address_widget.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/widgets/my_order_box_item.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/price_bottom_sheet_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view_model/my_order_view_modle/my_order_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

import 'widgets/my_order_time_widget.dart';
import 'widgets/status_widget.dart';

class OrderDetailesScreen extends StatefulWidget {
  const OrderDetailesScreen(
      {Key? key, required this.orderId, required this.isFromPayment})
      : super(key: key);

  final String orderId;
  final bool isFromPayment;
  static MyOrderViewModle myOrderViewModle =
      Get.put(MyOrderViewModle(), permanent: true);

  @override
  State<OrderDetailesScreen> createState() => _OrderDetailesScreenState();
}

class _OrderDetailesScreenState extends State<OrderDetailesScreen> {
  Widget get bodyOrderDetailes {
    //to do this when The Status Is An Task :
    if (GetUtils.isNull(
            OrderDetailesScreen.myOrderViewModle.newOrderSales.orderItems) ||
        OrderDetailesScreen.myOrderViewModle.newOrderSales.orderItems?.length ==
            0 ||
        GetUtils.isNull(OrderDetailesScreen.myOrderViewModle.newOrderSales)) {
      return const SizedBox();
    } else {
      return GetBuilder<MyOrderViewModle>(
        builder: (myOrder) {
          return ListView(
            primary: false,
            shrinkWrap: true,
            children: myOrder.newOrderSales.orderItems!
                .map((e) => GetBuilder<MyOrderViewModle>(
                      builder: (controller) {
                        return MyOrderBoxItem(
                          orderItem: e,
                        );
                      },
                    ))
                .toList(),
          );
        },
      );
    }
  }

  Future<bool> onWillPop() async {
    if (widget.isFromPayment) {
      Get.off(HomePageHolder());
    } else {
      Get.back();
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await OrderDetailesScreen.myOrderViewModle
          .getOrderDetaile(orderId: widget.orderId);
      OrderDetailesScreen.myOrderViewModle.update();
      setState(() {});
      // Future.delayed(Duration(milliseconds: 1000)).then(
      //     (value) async => {
      //       // OrderDetailesScreen.myOrderViewModle.update(),

      //       });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: Scaffold(
        appBar: CustomAppBarWidget(
          elevation: 0,
          titleWidget: Text(
            "${widget.orderId}",
            style: textStyleAppBarTitle(),
          ),
          isCenterTitle: true,
          onBackBtnClick: () => onWillPop(),
        ),
        body: GetBuilder<MyOrderViewModle>(
          builder: (myOrders) {
            if (myOrders.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                primary: true,
                child: GetBuilder<MyOrderViewModle>(
                  builder: (builder) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: padding20!),
                      child: Column(
                        children: [
                          SizedBox(
                            height: sizeH20,
                          ),
                          GetBuilder<MyOrderViewModle>(
                            builder: (cont) {
                              return PriceBottomSheetWidget(
                                backGroundColor: colorBackground,
                                priceTitle: "Total Price",
                                totalPalance: cont.newOrderSales.totalPrice,
                              );
                            },
                          ),
                          SizedBox(
                            height: sizeH10,
                          ),
                          GetBuilder<MyOrderViewModle>(
                            builder: (build) {
                              return StatusWidget(
                                status: build.newOrderSales.status,
                              );
                            },
                          ),
                          SizedBox(
                            height: sizeH10,
                          ),
                          GetBuilder<MyOrderViewModle>(
                            builder: (controller) {
                              return MyOrderAddressWidget(
                                address: controller
                                        .newOrderSales.orderShippingAddress ??
                                    controller
                                        .newOrderSales.orderWarehouseAddress ??
                                    "",
                              );
                            },
                          ),
                          SizedBox(
                            height: sizeH10,
                          ),
                          GetBuilder<MyOrderViewModle>(
                            builder: (order) {
                              return OrderDateWidget(
                                date:
                                    order.newOrderSales.deliveryDate.toString(),
                              );
                            },
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
      ),
    );
  }
}
