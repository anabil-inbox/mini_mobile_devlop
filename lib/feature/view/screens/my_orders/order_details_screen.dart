import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/model/my_order/order_sales.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/price_bottom_sheet_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

import 'widgets/order_address_widget.dart';
import 'widgets/status_widget.dart';

class OrderDetailesScreen extends StatelessWidget {
  const OrderDetailesScreen({Key? key , required this.orderSales}) : super(key: key);

  final OrderSales orderSales;

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
      body: Column(
        children: [
          SizedBox(
            height: sizeH20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding20!),
            child: PriceBottomSheetWidget(
              backGroundColor: colorBackground,
              priceTitle: "Total Price",
              totalPalance: orderSales.totalPrice,
            ),
          ),
          SizedBox(
            height: sizeH10,
          ),
          StatusWidget(status: orderSales.status,),
          SizedBox(
            height: sizeH10,
          ),
          OrderAddressWidget(date: orderSales.deliveryDate.toString(),),
          SizedBox(
            height: sizeH10,
          ),
          

        ],
      ),
    );
  }
}
