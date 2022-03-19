import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/widgets/my_order_app_bar.dart';
import 'package:inbox_clients/feature/view_model/my_order_view_modle/my_order_view_modle.dart';

import 'widgets/my_order_item.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  static MyOrderViewModle myOrderViewModle = Get.find<MyOrderViewModle>();

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      MyOrdersScreen.myOrderViewModle.getOrdres();
    });
    MyOrdersScreen.myOrderViewModle.scrollcontroller.addListener(() {
      MyOrdersScreen.myOrderViewModle.pagination();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          MyOrdersScreen.myOrderViewModle.userOrderSales.clear();
          MyOrdersScreen.myOrderViewModle.getOrdres();
        },
        child: Column(
          children: [
            MyOrderAppBar(),
            Expanded(
              child: GetBuilder<MyOrderViewModle>(
                builder: (logic) {
                  if (logic.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView(
                      shrinkWrap: true,
                      children: logic.userOrderSales
                          .map((e) => MyOrderItem(
                                orderSales: e,
                              ))
                          .toList(),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
