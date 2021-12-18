import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_clients/feature/view/screens/my_orders/widgets/my_order_search.dart';
import 'package:inbox_clients/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_clients/feature/view/widgets/icon_btn.dart';
import 'package:inbox_clients/feature/view_model/my_order_view_modle/my_order_view_modle.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';

class MyOrderAppBar extends StatelessWidget {
  const MyOrderAppBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
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
                  onPressed: () {},
                  borderColor: colorTrans,
                ),
              ],
            ),
          ),
        );
      });

;
  }
}