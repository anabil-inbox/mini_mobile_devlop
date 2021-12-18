import 'package:flutter/material.dart';
import 'package:inbox_clients/feature/model/my_order/order_sales.dart';
import 'package:inbox_clients/util/base_controller.dart';

class MyOrderViewModle extends BaseController {
// get user Orders Var And Functions ::
  Set<OrderSales> userOrderSales = {};

  // Future<void> getOrdres() async {
  //   await OrderHelper.getInstance
  //       .getCustomerBoxess(pageSize: 10, page: page)
  //       .then((value) => {
  //             Logger().i("$value"),
  //             userOrderSales = value.toSet(),
  //           });
  //   update();
  // }

  // to do here for pagination :
  var scrollcontroller = ScrollController();
  int page = 1;

  void pagination() {
    if ((scrollcontroller.position.pixels ==
        scrollcontroller.position.maxScrollExtent)) {
      page += 1;
    //  getOrdres();
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
  //  getOrdres();
  }
}
