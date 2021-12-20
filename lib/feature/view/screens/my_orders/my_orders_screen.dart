import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/widgets/my_order_app_bar.dart';
import 'package:inbox_clients/feature/view_model/my_order_view_modle/my_order_view_modle.dart';

import 'widgets/my_order_item.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  static MyOrderViewModle myOrderViewModle = Get.find<MyOrderViewModle>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MyOrderAppBar(),
          Expanded(
            child: GetBuilder<MyOrderViewModle>(
              init: MyOrderViewModle(),
              initState: (_) {
                myOrderViewModle.getOrdres();
                myOrderViewModle.scrollcontroller.addListener(() {
                  myOrderViewModle.pagination();
                });
              },
              builder: (_) {
                return ListView(
                  controller: myOrderViewModle.scrollcontroller,
                  shrinkWrap: true,
                  children: myOrderViewModle.userOrderSales
                      .map((e) => MyOrderItem(
                            orderSales: e,
                          ))
                      .toList(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
