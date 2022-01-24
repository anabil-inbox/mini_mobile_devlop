import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/model/my_order/order_sales.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/widgets/my_order_address_widget.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/widgets/my_order_box_item.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/widgets/order_detailes_widgets/option_detailes.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/price_bottom_sheet_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

import 'widgets/my_order_time_widget.dart';
import 'widgets/status_widget.dart';

class OrderDetailesScreen extends StatelessWidget {
  const OrderDetailesScreen({Key? key, required this.orderSales})
      : super(key: key);

  final OrderSales orderSales;
  Widget get bodyOrderDetailes {
    //to do this when The Status Is An Task :
    if (orderSales.orderItems!.isNotEmpty) {
      // if (orderSales.orderItems![0].item == LocalConstance.fetchId ||
      //     orderSales.orderItems![0].item == LocalConstance.recallId ||
      //     orderSales.orderItems![0].item == LocalConstance.terminateId ||
      //     orderSales.orderItems![0].item == LocalConstance.pickupId ||
      //     orderSales.orderItems![0].item == LocalConstance.destroyId ||
      //     orderSales.orderItems![0].item == LocalConstance.giveawayId) {
      //   return MyOrderBoxItem();
      // }
      return MyOrderBoxItem(
        orderSales: orderSales,
      );
    }
    //to do else when the Status is An new Sale Order:
    else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        elevation: 0,
        titleWidget: Text(
          "${orderSales.orderId}",
          style: textStyleAppBarTitle(),
        ),
        isCenterTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding20!),
        child: Column(
          children: [
            SizedBox(
              height: sizeH20,
            ),
            PriceBottomSheetWidget(
              backGroundColor: colorBackground,
              priceTitle: "Total Price",
              totalPalance: orderSales.totalPrice,
            ),
            SizedBox(
              height: sizeH10,
            ),
            StatusWidget(
              status: orderSales.status,
            ),
            SizedBox(
              height: sizeH10,
            ),
            MyOrderAddressWidget(
              address: orderSales.orderShippingAddress ??
                  orderSales.orderWarehouseAddress ??
                  "",
            ),
            SizedBox(
              height: sizeH10,
            ),
            OrderDateWidget(
              date: orderSales.deliveryDate.toString(),
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
}
