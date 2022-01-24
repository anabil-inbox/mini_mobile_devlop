import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/model/my_order/order_sales.dart';
import 'package:inbox_clients/network/api/feature/order_helper.dart';
import 'package:inbox_clients/util/base_controller.dart';
import 'package:logger/logger.dart';

class MyOrderViewModle extends BaseController {
// get user Orders Var And Functions ::
  Set<OrderSales> userOrderSales = <OrderSales>{};
  bool isLoading = false;

  Future<void> getOrdres() async {
    isLoading = true;
    update();
    await OrderHelper.getInstance
        .getCustomerBoxess(pageSize: 30, page: page)
        .then((value) => {
              userOrderSales.addAll(value),
              Logger().i("${userOrderSales.length}"),
            });
    isLoading = false;
    update();
  }

  // to do here for pagination :
  var scrollcontroller = ScrollController();
  int page = 1;

  void pagination() {
    try {
      if ((scrollcontroller.position.pixels ==
          scrollcontroller.position.maxScrollExtent)) {
        page += 1;
        getOrdres();
      }
    } catch (e) {}

    update();
  }


  

  @override
  void onInit() {
    super.onInit();
  }
}
