import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/widgets/order_address_widget.dart';
import 'package:inbox_clients/feature/view/screens/storage/new_storage/widgets/add_storage_widget/price_bottom_sheet_widget.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_style.dart';

import 'widgets/order_detailes/order_details_address.dart';

class OrderDerailesScreen extends StatelessWidget {
  const OrderDerailesScreen({Key? key}) : super(key: key);

  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        isCenterTitle: true,
        titleWidget: Text(
          "Order Details",
          style: textStyleAppBarTitle(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizeH16!),
        child: GetBuilder<StorageViewModel>(
          init: StorageViewModel(),
          builder: (_) {
            return Padding(
              padding:  EdgeInsets.symmetric(horizontal: sizeH20!),
              child: Column(
                children: [
                  SizedBox(
                    height: sizeH20,
                  ),
                  PriceWidget(
                    backGroundColor: colorBackground,
                    isTotalPalnce: true,
                    totalPalance:
                        storageViewModel.returnedOrderSales?.totalPrice ?? 1,
                  ),
                  SizedBox(
                    height: sizeH16,
                  ),
                  OrderDetailsAddress(
                    title: "Delivery Address",
                    deliveryAddress: storageViewModel
                            .returnedOrderSales?.orderShippingAddress ??
                        storageViewModel
                            .returnedOrderSales?.orderWarehouseAddress ??
                        "",
                  ),
                  SizedBox(
                    height: sizeH16,
                  ),
                  OrderDetailsAddress(
                    title: "Schedule Delivery",
                    deliveryAddress:
                        " ${storageViewModel.returnedOrderSales?.deliveryDate}",
                  ),
                  SizedBox(
                    height: sizeH16,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
