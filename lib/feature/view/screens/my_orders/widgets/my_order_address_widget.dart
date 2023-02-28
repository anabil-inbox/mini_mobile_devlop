import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_clients/feature/model/my_order/order_sales.dart';
import 'package:inbox_clients/feature/view/widgets/bottom_sheet_widget/map_bottom_sheet.dart';
import 'package:inbox_clients/util/app_color.dart';
import 'package:inbox_clients/util/app_dimen.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/app_style.dart';
import 'package:inbox_clients/util/font_dimne.dart';
import 'package:logger/logger.dart';

import '../../../../view_model/map_view_model/map_view_model.dart';

class MyOrderAddressWidget extends StatelessWidget {
  const MyOrderAddressWidget({Key? key, this.newOrderSales, })
      : super(key: key);
  final OrderSales? newOrderSales;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return InkWell(
      onTap: _onAddressClick,
      child: Container(
        width: double.infinity,
      //  margin: EdgeInsets.symmetric(horizontal: padding20!),
        decoration: BoxDecoration(
            color: colorBackground,
            borderRadius: BorderRadius.circular(padding6!)),
        child: Row(
          children: [
            SizedBox(
              width: sizeW15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: sizeH22,
                ),
                Text("${tr.address}"),
                SizedBox(
                  height: sizeH4,
                ),
                Text(
                  newOrderSales!.orderShippingAddress.toString().isNotEmpty ?newOrderSales?.orderShippingAddress :
                      newOrderSales?.orderWarehouseAddress ?? "",
                  style: textStyleHints()!.copyWith(fontSize: fontSize13),
                ),
                SizedBox(
                  height: sizeH22,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onAddressClick() async{
    Get.put(MapViewModel())..getMyCurrentMarkers()..getStreamLocation(newOrderSales!.orderId.toString());
    Get.bottomSheet(MapBottomSheet(salesOrder: newOrderSales!.orderId.toString() , newOrderSales:newOrderSales!),
        enableDrag: true,
        isScrollControlled: true,
        clipBehavior: Clip.hardEdge);
  }
}
