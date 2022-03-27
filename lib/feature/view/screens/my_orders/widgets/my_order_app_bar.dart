import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/widgets/my_order_search.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/icon_btn.dart';
import 'package:inbox_clients/feature/view_model/my_order_view_modle/my_order_view_modle.dart';
import 'package:inbox_clients/feature/view_model/storage_view_model/storage_view_model.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

import '../../../../../util/app_shaerd_data.dart';
import '../../cart/my_cart/cart_screen.dart';
import '../../items/qr_screen.dart';

class MyOrderAppBar extends StatelessWidget {
  const MyOrderAppBar({Key? key}) : super(key: key);
  static StorageViewModel storageViewModel = Get.find<StorageViewModel>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GetBuilder<MyOrderViewModle>(builder: (logic) {
      return Container(
        color: colorBackground,
        padding: EdgeInsets.symmetric(horizontal: sizeW20!, vertical: sizeH20!),
        child: SizedBox(
          height: sizeH80,
          child: CustomAppBarWidget(
            elevation: 0,
            isCenterTitle: true,
            titleWidget: MyOrderSearch(),
            leadingWidget: IconBtn(
              iconColor: colorTextWhite,
              width: sizeW48,
              height: sizeH48,
              backgroundColor: colorRed,
              onPressed: () {
                Get.to(() => QrScreen(
                      index: 0,
                      storageViewModel: storageViewModel,
                    ));
              },
              borderColor: colorTrans,
              icon: "assets/svgs/Scan.svg",
            ),
            leadingWidth: sizeW48,
            actionsWidgets: [
              IconBtn(
                icon: "assets/svgs/Buy.svg",
                iconColor: colorRed,
                width: sizeW48,
                height: sizeH48,
                backgroundColor: colorRedTrans,
                onPressed: () {
                  Get.to(() => CartScreen());
                },
                borderColor: colorTrans,
              ),
            ],
          ),
        ),
      );
    });
  }
}
